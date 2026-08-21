package com.spencerfields.littlebird

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    // Registered explicitly rather than through reflection, so a rename of the
    // plugin is a compile error instead of a channel that silently answers
    // MissingPluginException at runtime.
    flutterEngine.plugins.add(ShareFilePlugin())
    flutterEngine.plugins.add(PickFilePlugin())
    flutterEngine.plugins.add(OcrPlugin(applicationContext))
    flutterEngine.plugins.add(PlacesPlugin(applicationContext))
    flutterEngine.plugins.add(IdentityPlugin(applicationContext))
  }
}
