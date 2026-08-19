package com.spencerfields.littlebird

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.provider.OpenableColumns
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

/**
 * Lets the user choose a place file to import.
 *
 * The Android half of the `littlebird/files` channel, which until now existed
 * only in Swift — so on Android every "From a file" tap raised
 * MissingPluginException and the app said it could not read the file. Nothing
 * caught that, because the Dart side handles the exception gracefully: the
 * feature failed politely rather than loudly.
 *
 * **Why the picker is unfiltered.** Android's MIME table has no entry for `gpx`
 * or `geojson`, so a picker filtered by MIME type renders exactly those
 * files unselectable — greyed out, with nothing to explain why. The name is what
 * Wren parses by anyway, so the filter would buy nothing and cost the two
 * formats OpenStreetMap apps export.
 *
 * **Why the display name is read separately.** A content URI carries no
 * extension: the last path segment is typically a document id like
 * `primary:Download/x`. Wren picks its parser from the file name, so a lost name
 * means a KML parsed as CSV. `OpenableColumns.DISPLAY_NAME` is the only reliable
 * source.
 */
class PickFilePlugin :
  FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler,
  PluginRegistry.ActivityResultListener {

  private lateinit var channel: MethodChannel
  private var activity: Activity? = null
  private var binding: ActivityPluginBinding? = null

  /**
   * The reply for the pick in flight, or null.
   *
   * Held because the answer arrives in onActivityResult, long after the method
   * call returns. Cleared before it is used: a MethodChannel.Result may be
   * replied to exactly once, and replying twice is a hard crash rather than a
   * warning — which is easy to cause here, since a picker can deliver a result
   * and then be re-entered.
   */
  private var pending: MethodChannel.Result? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "littlebird/files")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(b: ActivityPluginBinding) {
    activity = b.activity
    binding = b
    b.addActivityResultListener(this)
  }

  override fun onReattachedToActivityForConfigChanges(b: ActivityPluginBinding) =
    onAttachedToActivity(b)

  override fun onDetachedFromActivity() {
    binding?.removeActivityResultListener(this)
    binding = null
    activity = null
    // A picker that outlives its activity never reports back, so answer now
    // rather than leaving the Dart future hanging for the life of the app.
    pending?.success(null)
    pending = null
  }

  override fun onDetachedFromActivityForConfigChanges() = onDetachedFromActivity()

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method != "pick") {
      result.notImplemented()
      return
    }
    val act = activity ?: run {
      result.error("no_activity", "there is no activity to open a picker from", null)
      return
    }
    if (pending != null) {
      result.error("busy", "a file is already being chosen", null)
      return
    }
    pending = result
    val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
      addCategory(Intent.CATEGORY_OPENABLE)
      // Deliberately unfiltered: see the class comment. A MIME filter would grey
      // out every .gpx and .geojson on the device.
      type = "*/*"
    }
    try {
      act.startActivityForResult(intent, REQUEST)
    } catch (e: Exception) {
      pending = null
      result.error("no_picker", e.message, null)
    }
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (requestCode != REQUEST) return false
    val reply = pending ?: return true
    pending = null

    val uri = data?.data
    if (resultCode != Activity.RESULT_OK || uri == null) {
      reply.success(null) // cancelled, which is not an error
      return true
    }
    try {
      reply.success(mapOf("bytes" to read(uri), "name" to nameOf(uri)))
    } catch (e: Exception) {
      reply.error("read_failed", e.message, null)
    }
    return true
  }

  /**
   * The bytes, up to [MAX_BYTES].
   *
   * Capped because everything crosses the method channel into Dart memory, and
   * a Google Takeout archive can be enormous. A clear refusal beats an
   * out-of-memory kill that looks like a crash in the import.
   */
  private fun read(uri: Uri): ByteArray {
    val resolver = activity?.contentResolver
      ?: throw IllegalStateException("no content resolver")
    resolver.openInputStream(uri).use { stream ->
      if (stream == null) throw IllegalStateException("that file could not be opened")
      val bytes = stream.readBytes()
      if (bytes.size > MAX_BYTES) {
        throw IllegalStateException(
          "that file is ${bytes.size / 1024 / 1024} MB, larger than the " +
            "${MAX_BYTES / 1024 / 1024} MB Wren can read"
        )
      }
      return bytes
    }
  }

  /** The name the user sees, which is also the only clue to the format. */
  private fun nameOf(uri: Uri): String {
    val resolver = activity?.contentResolver ?: return ""
    resolver.query(uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)
      ?.use { c ->
        if (c.moveToFirst() && !c.isNull(0)) return c.getString(0)
      }
    // Last resort. Rarely useful — a document id has no extension — but better
    // than an empty name, which Wren cannot use to choose a parser at all.
    return uri.lastPathSegment?.substringAfterLast('/') ?: ""
  }

  private companion object {
    const val REQUEST = 0x77726E // "wrn"
    const val MAX_BYTES = 16 * 1024 * 1024
  }
}
