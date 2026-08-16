import Flutter
import MapKit
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
    if let registrar = registrar(forPlugin: "PlacesPlugin") {
      PlacesPlugin.register(with: registrar)
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

/// Place lookup via MapKit, exposed to Dart.
///
/// This is why the app needs no Maps API key: `MKMapItem.identifier.rawValue`
/// is the letter "I" followed by the place's muid in uppercase hex, and that
/// muid is exactly what an Apple Maps guide link requires. Verified against
/// five known places — see the mapkit-muid-probe repo.
///
/// Rules learned from measuring resolution quality across Rome and Tokyo:
///   - When MapKit cannot find a business it returns a geographic AREA instead,
///     with no identifier and no point-of-interest category. Both are free
///     signals, and results failing either are dropped rather than guessed at.
///   - The search region is a hint, not a filter — a Tokyo query once returned
///     a city 114 km away — so distance is enforced here.
///   - Never append an invented category to the query. Adding "restaurant"
///     turned one lookup into a confidently wrong restaurant with a valid id.
///     Only the caller's own context is appended.
public class PlacesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "littlebird/places",
                                       binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(PlacesPlugin(), channel: channel)
  }

  public func handle(_ call: FlutterMethodCall,
                     result: @escaping FlutterResult) {
    guard call.method == "search" else {
      result(FlutterMethodNotImplemented); return
    }
    guard let args = call.arguments as? [String: Any],
          let query = args["query"] as? String, !query.isEmpty else {
      result(FlutterError(code: "bad_args",
                          message: "expected a non-empty 'query'", details: nil))
      return
    }
    let hint = args["cityHint"] as? String
    let maxMetres = (args["maxMetres"] as? NSNumber)?.doubleValue ?? 30_000

    let request = MKLocalSearch.Request()
    // Facts only. A guessed category produces confident wrong answers.
    request.naturalLanguageQuery = [query, hint]
      .compactMap { $0 }.joined(separator: " ")
    request.resultTypes = .pointOfInterest

    if let lat = (args["lat"] as? NSNumber)?.doubleValue,
       let lon = (args["lon"] as? NSNumber)?.doubleValue {
      request.region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
        latitudinalMeters: maxMetres, longitudinalMeters: maxMetres)
    }

    MKLocalSearch(request: request).start { response, error in
      if let error = error as NSError? {
        // MKError 4 is throttling. Surfaced so the caller can back off rather
        // than mistake it for "no such place".
        let throttled = error.domain == MKErrorDomain && error.code == 4
        result(FlutterError(code: throttled ? "throttled" : "search_failed",
                            message: error.localizedDescription, details: nil))
        return
      }

      let centre: CLLocation? = {
        guard let lat = (args["lat"] as? NSNumber)?.doubleValue,
              let lon = (args["lon"] as? NSNumber)?.doubleValue else { return nil }
        return CLLocation(latitude: lat, longitude: lon)
      }()

      var out: [[String: Any]] = []
      for item in response?.mapItems ?? [] {
        guard #available(iOS 18.0, *),
              let raw = item.identifier?.rawValue,
              raw.hasPrefix("I") else { continue }        // no id → not a business
        guard let category = item.pointOfInterestCategory?.rawValue
        else { continue }                                  // no category → an area

        let coord = item.placemark.coordinate
        var metres: Double? = nil
        if let centre = centre {
          metres = CLLocation(latitude: coord.latitude,
                              longitude: coord.longitude).distance(from: centre)
          if metres! > maxMetres { continue }              // region is only a hint
        }

        out.append([
          "placeId": raw,
          "name": item.name ?? "",
          "address": item.placemark.title ?? "",
          "category": category.replacingOccurrences(of: "MKPOICategory", with: ""),
          "lat": coord.latitude,
          "lon": coord.longitude,
          "metresFromCentre": metres as Any,
        ])
      }
      result(out)
    }
  }
}
