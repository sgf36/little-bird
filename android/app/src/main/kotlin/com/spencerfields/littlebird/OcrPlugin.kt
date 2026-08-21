package com.spencerfields.littlebird

import android.content.Context
import android.graphics.BitmapFactory
import android.net.Uri
import android.util.Log
import com.google.android.gms.tasks.Tasks
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.TextRecognizer
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.concurrent.Executors

/**
 * Reads the text off a screenshot.
 *
 * The Android half of the `littlebird/ocr` channel, which existed only in
 * Swift — so "Add screenshots" answered MissingPluginException and the app
 * said reading screenshots needs an iPhone. It does not: ML Kit's recogniser
 * runs on the device, from a model inside the APK, and needs no network and no
 * account.
 *
 * **The geometry is the point, not just the text.** Dart ranks candidates by
 * how large a line is and where it sits, because that separates a place name
 * from interface furniture in any language and in apps nobody has thought of.
 * So this reports the same three numbers Vision does, in the same convention:
 * height and centre normalised against the image, and `midY` measured from the
 * BOTTOM. ML Kit's boxes are top-down, so midY is inverted here. Get that
 * backwards and every heuristic silently reads the screen upside down —
 * captions score as titles and the ranking quietly inverts.
 *
 * **Latin script only, deliberately.** The Chinese, Devanagari, Japanese and
 * Korean models are separate downloads of comparable size, and bundling all
 * five would add tens of megabytes for scripts most users never photograph. A
 * screenshot in another script returns no lines, which the caller already
 * treats as "could not read this one" rather than as an error.
 */
class OcrPlugin(private val context: Context) :
  FlutterPlugin, MethodChannel.MethodCallHandler {

  private lateinit var channel: MethodChannel
  private var recognizer: TextRecognizer? = null

  /**
   * One thread, off the platform thread.
   *
   * `Tasks.await` blocks, and blocking Flutter's platform thread freezes the
   * whole interface — including the progress banner that exists to say a read
   * is happening. A batch of screenshots is read one at a time anyway, so a
   * single worker is the right size.
   */
  private val worker = Executors.newSingleThreadExecutor()

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "littlebird/ocr")
    channel.setMethodCallHandler(this)
    Log.i(TAG, "attached to littlebird/ocr")
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    recognizer?.close()
    recognizer = null
    worker.shutdown()
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method != "recognise") {
      result.notImplemented()
      return
    }
    val path = call.argument<String>("path")
    if (path.isNullOrEmpty()) {
      result.error("no-path", "recognise needs a path", null)
      return
    }
    worker.execute { recognise(path, result) }
  }

  private fun recognise(path: String, result: MethodChannel.Result) {
    val lines = try {
      read(path)
    } catch (e: Throwable) {
      // Reported on the platform thread: a MethodChannel.Result may only be
      // used there, and using it from the worker is a crash rather than a
      // warning.
      Log.e(TAG, "recognise failed for $path", e)
      reply(result) { it.error("ocr-failed", e.message ?: e.toString(), null) }
      return
    }
    reply(result) { it.success(lines) }
  }

  private fun reply(result: MethodChannel.Result, body: (MethodChannel.Result) -> Unit) {
    android.os.Handler(android.os.Looper.getMainLooper()).post { body(result) }
  }

  private fun read(path: String): List<Map<String, Any>> {
    val file = File(path)
    if (!file.exists()) throw IllegalArgumentException("no file at $path")

    // Bounds-only decode: the pixels are not wanted here, only the size to
    // normalise against, and a full decode of a screenshot is megabytes.
    val bounds = BitmapFactory.Options().apply { inJustDecodeBounds = true }
    BitmapFactory.decodeFile(path, bounds)
    val w = bounds.outWidth.toFloat()
    val h = bounds.outHeight.toFloat()
    if (w <= 0f || h <= 0f) throw IllegalArgumentException("not an image: $path")

    val image = InputImage.fromFilePath(context, Uri.fromFile(file))
    val engine = recognizer ?: TextRecognition
      .getClient(TextRecognizerOptions.DEFAULT_OPTIONS)
      .also { recognizer = it }

    val text = Tasks.await(engine.process(image))
    val out = ArrayList<Map<String, Any>>()
    for (block in text.textBlocks) {
      for (line in block.lines) {
        val box = line.boundingBox ?: continue
        val body = line.text.trim()
        if (body.isEmpty()) continue
        out.add(
          mapOf(
            "text" to body,
            "confidence" to (line.confidence?.toDouble() ?: 1.0),
            "height" to (box.height() / h).toDouble(),
            "midX" to (box.exactCenterX() / w).toDouble(),
            // Vision measures from the bottom; ML Kit's boxes are top-down.
            "midY" to (1f - box.exactCenterY() / h).toDouble(),
          ),
        )
      }
    }
    // Largest type first, which is the order the Swift side promises and the
    // Dart side's fallback logic assumes when scores tie.
    out.sortByDescending { it["height"] as Double }
    Log.i(TAG, "read ${out.size} lines from $path")
    return out
  }

  private companion object { const val TAG = "WrenOcr" }
}
