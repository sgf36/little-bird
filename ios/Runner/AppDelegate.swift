import Flutter
import UIKit
import Vision

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Registered through the registrar rather than by reaching into
    // window?.rootViewController.
    //
    // This project uses the UIScene lifecycle — UIApplicationSceneManifest is in
    // Info.plist — so `window` is nil here: it belongs to the scene and has not
    // been created yet. The previous version force-cast that nil and the app
    // died on launch, before Flutter started. CI never caught it because CI
    // compiles the app and never runs it.
    if let registrar = registrar(forPlugin: "OcrPlugin") {
      OcrPlugin.register(with: registrar)
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

/// Vision text recognition, exposed to Dart over a method channel.
///
/// Lives in this file rather than its own because there is no Xcode here to add
/// a new source file to the target, and hand-editing project.pbxproj to do it is
/// a worse risk than a slightly long file.
///
/// Vision's `.accurate` mode recovered the place name in 25 of 25 graded test
/// frames, including motion-blurred and low-contrast ones. `.fast` returned
/// things like "Plzzarfium" on the same images. Do not switch it.
///
/// Bounding boxes come back with the text because type size is the cheapest
/// signal for telling a place name apart from the username, hashtags and music
/// credit — OCR finds roughly nine lines per reel screenshot and says nothing
/// about which one matters.
public class OcrPlugin: NSObject, FlutterPlugin {
  private static let channelName = "littlebird/ocr"

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: channelName,
                                       binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(OcrPlugin(), channel: channel)
  }

  public func handle(_ call: FlutterMethodCall,
                     result: @escaping FlutterResult) {
    guard call.method == "recognise" else {
      result(FlutterMethodNotImplemented)
      return
    }
    guard let args = call.arguments as? [String: Any],
          let path = args["path"] as? String else {
      result(FlutterError(code: "bad_args",
                          message: "expected a 'path' string", details: nil))
      return
    }
    OcrPlugin.recognise(path: path, result: result)
  }

  private static func recognise(path: String,
                                result: @escaping FlutterResult) {
    DispatchQueue.global(qos: .userInitiated).async {
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
        try VNImageRequestHandler(url: URL(fileURLWithPath: path),
                                  options: [:]).perform([request])
      } catch {
        DispatchQueue.main.async {
          result(FlutterError(code: "vision_failed",
                              message: error.localizedDescription, details: nil))
        }
        return
      }

      let lines: [[String: Any]] = (request.results ?? [])
        .compactMap { obs -> [String: Any]? in
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
        .sorted { a, b in
          let ha = a["height"] as? Double ?? 0
          let hb = b["height"] as? Double ?? 0
          return ha > hb
        }

      DispatchQueue.main.async { result(lines) }
    }
  }
}
