package com.spencerfields.littlebird

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.ClipData
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import androidx.browser.customtabs.CustomTabsIntent
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

/**
 * Hands a generated place file to another app on the device.
 *
 * **Why a content:// URI and not a path.** A raw `file://` URI grants the
 * receiving app nothing, and the failure is not a refusal to launch — the other
 * app starts, matches the MIME type, tries to read, and dies with EACCES.
 * Measured on an emulator on 19 August 2026: Organic Maps launched from a
 * `file://` intent and showed "Failed to open file … open failed: EACCES
 * (Permission denied)". The intent was right and the transport was wrong, which
 * is the confusing way round. Everything goes out through [PlaceFileProvider]
 * with FLAG_GRANT_READ_URI_PERMISSION.
 *
 * **Why filesDir and not cacheDir.** The cache is reclaimable at any moment, and
 * a receiver that defers the import to a background worker can find the bytes
 * gone after the grant succeeded.
 *
 * **Why the file keeps a real extension.** Several map apps match on
 * `pathPattern` (`.*\\.gpx`) rather than on MIME, and OsmAnd chooses its import
 * branch from the provider's DISPLAY_NAME rather than from the bytes. A content
 * URI hides everything about a file except what the provider reports, so a file
 * called "places" with no suffix is invisible to those handlers even when the
 * MIME is perfect.
 *
 * **Why there is no `resolveActivity` pre-flight.** On API 30 and later it
 * returns null for a package that is merely filtered out by package visibility,
 * so guarding on it silently disables a hand-off that would have worked, with no
 * exception and nothing in the log. `startActivity` needs no visibility at all;
 * the correct guard is catching ActivityNotFoundException.
 *
 * **Why `grantUriPermission` is not called.** It looks like harmless insurance
 * and it is not: the grant it makes is revocable only by an explicit
 * `revokeUriPermission`, so it hands another package indefinite access to the
 * user's place list. The intent flag alone is the right scope.
 */
class ShareFilePlugin :
  FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var appContext: Context

  /**
   * Set while an activity is attached. Preferred for startActivity so the URI
   * grant is scoped to a real task rather than needing FLAG_ACTIVITY_NEW_TASK.
   */
  private var activity: Activity? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    appContext = binding.applicationContext
    channel = MethodChannel(binding.binaryMessenger, "littlebird/share_file")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "shareFile" -> shareFile(call, result)
      "firstInstalled" -> firstInstalled(call, result)
      "openTab" -> openTab(call, result)
      else -> result.notImplemented()
    }
  }

  private fun shareFile(call: MethodCall, result: MethodChannel.Result) {
    val bytes = call.argument<ByteArray>("bytes")
    val fileName = call.argument<String>("fileName")
    val mimeType = call.argument<String>("mimeType")
    if (bytes == null || fileName.isNullOrEmpty() || mimeType.isNullOrEmpty()) {
      result.error("bad_args", "expected bytes, fileName and mimeType", null)
      return
    }

    val uri = try {
      // A dedicated subdirectory, cleared each time: the previous export is of no
      // use to anybody, and a stale file with the same name is a confusing thing
      // for a receiving app to pick up.
      val dir = File(appContext.filesDir, "share").apply {
        deleteRecursively()
        mkdirs()
      }
      val file = File(dir, fileName).apply { writeBytes(bytes) }
      FileProvider.getUriForFile(
        appContext,
        "${appContext.packageName}.fileprovider",
        file,
      )
    } catch (e: Exception) {
      result.error("write_failed", e.message, null)
      return
    }

    // The extension is load-bearing for pathPattern handlers and for OsmAnd's
    // choice of import branch, so a URI that lost it is a silent failure waiting
    // to happen rather than something to hand over and hope about.
    if (uri.lastPathSegment?.contains('.') != true) {
      result.error("bad_uri", "the shared URI lost its file extension", null)
      return
    }

    val target = call.argument<String>("package")
    val action = call.argument<String>("action") ?: Intent.ACTION_SEND
    val context = activity ?: appContext

    val intent = Intent(action).apply {
      if (action == Intent.ACTION_VIEW) {
        // setDataAndType, never setData() then setType(): each of those clears
        // the other, so every filter declaring both a scheme and a mimeType —
        // which is all of them — fails to match while the intent still looks
        // perfectly correct in a debugger.
        setDataAndType(uri, mimeType)
      } else {
        type = mimeType
        putExtra(Intent.EXTRA_STREAM, uri)
      }
      putExtra(Intent.EXTRA_TITLE, fileName)
      call.argument<String>("subject")?.let { putExtra(Intent.EXTRA_SUBJECT, it) }
      call.argument<Map<String, Boolean>>("extras")?.forEach { (k, v) ->
        putExtra(k, v)
      }
      // ClipData as well as EXTRA_STREAM: some receivers read the URI from the
      // clip, and the grant travels with it.
      clipData = ClipData.newUri(context.contentResolver, fileName, uri)
      addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
      if (activity == null) addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    }

    if (target.isNullOrEmpty()) {
      // The chooser. Needs no <queries> declaration and works on every version,
      // because the system resolves on the user's behalf rather than ours. Never
      // called on an intent that already has setPackage — a one-item chooser
      // reads as broken.
      val chooser = Intent.createChooser(intent, null).apply {
        addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        if (activity == null) addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      }
      context.startActivity(chooser)
      result.success("sent")
      return
    }

    // Straight to one app, which is what makes a single labelled button possible.
    intent.setPackage(target)
    try {
      context.startActivity(intent)
      result.success("sent")
    } catch (e: ActivityNotFoundException) {
      result.success("noHandler")
    }
  }

  /**
   * The first of [packages] that is installed *and visible*.
   *
   * Visibility is the trap: from Android 11 a package not named in `<queries>`
   * throws NameNotFoundException exactly as if it were not installed, so a
   * missing declaration looks like a missing app and the button silently never
   * appears. Every package offered to this method must be declared.
   */
  private fun firstInstalled(call: MethodCall, result: MethodChannel.Result) {
    val packages = call.argument<List<String>>("packages") ?: emptyList()
    for (name in packages) {
      try {
        appContext.packageManager.getPackageInfo(name, 0)
        result.success(name)
        return
      } catch (_: PackageManager.NameNotFoundException) {
        // Not installed, or not declared. Indistinguishable by design.
      }
    }
    result.success(null)
  }

  /**
   * Opens [url] in a Chrome Custom Tab.
   *
   * For the Google Maps route, which cannot be one tap: Google exposes no API
   * that writes a list or a My Map, and the internal /maps/d/mutate endpoint
   * authenticates a live browser session — cookies plus a page-embedded XSRF
   * token — which no app can hold. So the honest best is to land the user on the
   * import page already signed in, inside a tab styled like the app, and let
   * them finish. A Custom Tab is Chrome, so the session is already there.
   */
  private fun openTab(call: MethodCall, result: MethodChannel.Result) {
    val url = call.argument<String>("url")
    if (url.isNullOrEmpty()) {
      result.error("bad_args", "expected a url", null)
      return
    }
    val context = activity ?: appContext
    return try {
      CustomTabsIntent.Builder()
        .setShowTitle(true)
        .setUrlBarHidingEnabled(false)
        .build()
        .apply { if (activity == null) intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK) }
        .launchUrl(context, Uri.parse(url))
      result.success("sent")
    } catch (e: ActivityNotFoundException) {
      // No browser at all, which is rare but not impossible on a stripped ROM.
      result.success("noHandler")
    }
  }
}
