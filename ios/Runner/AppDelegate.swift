import Flutter
import UIKit
import Vision

// The only Swift in the project, and the only part that cannot be exercised on
// Windows. It has no interface, so it never needs a simulator — it compiles in
// CI and is verified on a device through the app above it.
//
// Vision's .accurate mode recovered the place name in 25 of 25 graded test
// frames, including motion-blurred and low-contrast ones. .fast mode returned
// things like "Plzzarfium" on the same images. Do not switch it.
//
// Bounding boxes are returned alongside the text because type size is the
// cheapest signal for telling the place name apart from the username, hashtags
// and music credit — OCR finds roughly nine lines per reel screenshot and says
// nothing about which one matters.

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "reel_places/ocr",
      binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { call, result in
      guard call.method == "recognise" else {
        result(FlutterMethodNotImplemented); return
      }
      guard let args = call.arguments as? [String: Any],
            let path = args["path"] as? String else {
        result(FlutterError(code: "bad_args",
                            message: "expected a 'path' string", details: nil))
        return
      }
      AppDelegate.recognise(path: path, result: result)
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private static func recognise(path: String, result: @escaping FlutterResult) {
    DispatchQueue.global(qos: .userInitiated).async {
      let url = URL(fileURLWithPath: path)
      guard FileManager.default.fileExists(atPath: path) else {
        DispatchQueue.main.async {
          result(FlutterError(code: "not_found",
                              message: "no file at \(path)", details: nil))
        }
        return
      }

      let request = VNRecognizeTextRequest()
      request.recognitionLevel = .accurate
      request.usesLanguageCorrection = true
      request.recognitionLanguages = ["en-GB", "en-US", "it-IT", "fr-FR", "es-ES"]

      do {
        try VNImageRequestHandler(url: url, options: [:]).perform([request])
      } catch {
        DispatchQueue.main.async {
          result(FlutterError(code: "vision_failed",
                              message: error.localizedDescription, details: nil))
        }
        return
      }

      let lines: [[String: Any]] = (request.results ?? []).compactMap { obs in
        guard let candidate = obs.topCandidates(1).first else { return nil }
        let box = obs.boundingBox
        return [
          "text": candidate.string,
          "confidence": Double(candidate.confidence),
          "height": Double(box.height),   // normalised — a proxy for type size
          "midX": Double(box.midX),
          "midY": Double(box.midY),       // 0 = bottom of frame, 1 = top
        ]
      }
      // Largest first: on a reel frame the place name is usually the biggest
      // text and the chrome is usually the smallest.
      .sorted { ($0["height"] as! Double) > ($1["height"] as! Double) }

      DispatchQueue.main.async { result(lines) }
    }
  }
}
