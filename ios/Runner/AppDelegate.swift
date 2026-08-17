import Flutter
import MapKit
import UIKit
import UniformTypeIdentifiers
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
    if let registrar = registrar(forPlugin: "IdentityPlugin") {
      IdentityPlugin.register(with: registrar)
    }
    if let registrar = registrar(forPlugin: "FilesPlugin") {
      FilesPlugin.register(with: registrar)
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
    switch call.method {
    case "search": break
    case "geocode":
      guard let args = call.arguments as? [String: Any],
            let query = args["query"] as? String, !query.isEmpty else {
        result(FlutterError(code: "bad_args",
                            message: "expected a non-empty 'query'", details: nil))
        return
      }
      PlacesPlugin.geocode(query: query, result: result)
      return
    default:
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
        // `MKMapItem.identifier` is iOS 18 and up, and it is the muid an Apple
      // Maps guide link requires — without it this app has nothing to publish.
      // That is why the deployment target is 18.0: on iOS 17 this guard would
      // skip every result, every lookup would come back empty, and the app
      // would install and then do nothing. Better to be unavailable than
      // present and useless, and a reviewer on an older device would rightly
      // have failed it.
      guard let raw = item.identifier?.rawValue,
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

  /// Turns a place-context phrase ("London", "Mexico City") into a coordinate,
  /// so every subsequent lookup can be centred there.
  ///
  /// Uses CLGeocoder rather than MKLocalSearch because a city is not a point of
  /// interest — the POI search deliberately filters those out, and it is the
  /// administrative area we want here.
  private static func geocode(query: String,
                              result: @escaping FlutterResult) {
    CLGeocoder().geocodeAddressString(query) { marks, error in
      guard let m = marks?.first, let loc = m.location else {
        // Not knowing where somewhere is is a normal answer, not a failure.
        result(nil)
        return
      }
      result([
        "name": m.locality ?? m.administrativeArea ?? m.name ?? query,
        "country": m.country as Any,
        "lat": loc.coordinate.latitude,
        "lon": loc.coordinate.longitude,
      ])
    }
  }
}
/// A stable identifier for this device, kept in the keychain.
///
/// It exists so a complimentary unlock code can be spent once. The server
/// records which device redeemed which code; without something stable to
/// record, "used once" would mean "used once per install".
///
/// The keychain rather than UserDefaults, because UserDefaults is deleted with
/// the app and a friend who reinstalls would find their one-use code already
/// spent — by themselves. Keychain items survive deletion, so re-entering the
/// same code on the same phone is recognised as the same redemption.
///
/// Not identifierForVendor: that resets once the last app from this vendor is
/// removed, which is exactly the case that matters here. And it is a random
/// UUID, not anything derived from the hardware — it identifies an install of
/// Wren, and is of no use to anyone for anything else.
class IdentityPlugin: NSObject, FlutterPlugin {
  private static let service = "com.spencerfields.littlebird.identity"
  private static let account = "device"

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "littlebird/identity",
                                       binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(IdentityPlugin(), channel: channel)
  }

  public func handle(_ call: FlutterMethodCall,
                     result: @escaping FlutterResult) {
    guard call.method == "deviceId" else {
      result(FlutterMethodNotImplemented)
      return
    }
    if let existing = IdentityPlugin.read() {
      result(existing)
      return
    }
    let fresh = UUID().uuidString
    if IdentityPlugin.write(fresh) {
      result(fresh)
    } else {
      result(FlutterError(code: "keychain",
                          message: "could not store a device identifier",
                          details: nil))
    }
  }

  private static func read() -> String? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: account,
      kSecReturnData as String: true,
      kSecMatchLimit as String: kSecMatchLimitOne,
    ]
    var item: CFTypeRef?
    guard SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess,
          let data = item as? Data,
          let value = String(data: data, encoding: .utf8),
          !value.isEmpty
    else { return nil }
    return value
  }

  private static func write(_ value: String) -> Bool {
    // ThisDeviceOnly, and so deliberately not carried into an iCloud or
    // encrypted backup: a device identifier restored onto a second phone would
    // let one redemption unlock both.
    let attributes: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: account,
      kSecValueData as String: Data(value.utf8),
      kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
    ]
    SecItemDelete(attributes as CFDictionary)
    return SecItemAdd(attributes as CFDictionary, nil) == errSecSuccess
  }
}

/// The document picker, for importing a list exported from another app.
///
/// Returns raw bytes rather than a decoded string. Dart decides what they are,
/// because a KMZ is a zip and a CSV out of Excel is often UTF-16 — decisions
/// that are cheap while the bytes are intact and impossible to undo once a
/// wrong decode has turned the file into rubbish.
///
/// The picker is asked for `.item` rather than a list of content types. Exported
/// place files are a moving target — GeoJSON has no registered type, `.kmz` is
/// declared by Google Earth and so is absent on a phone without it, and a type
/// the system does not know silently greys out the file the user came to pick.
/// Sniffing the content in Dart is the check that actually holds; refusing at
/// the picker would only refuse files this app can read.
class FilesPlugin: NSObject, FlutterPlugin, UIDocumentPickerDelegate,
                   UIAdaptivePresentationControllerDelegate {
  private var pending: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "littlebird/files",
                                       binaryMessenger: registrar.messenger())
    // Held by the registrar for the life of the engine, so the delegate
    // survives until the user finishes with the picker.
    registrar.addMethodCallDelegate(FilesPlugin(), channel: channel)
  }

  public func handle(_ call: FlutterMethodCall,
                     result: @escaping FlutterResult) {
    guard call.method == "pick" else {
      result(FlutterMethodNotImplemented)
      return
    }
    // A second picker while one is open would leave the first result unanswered
    // and hang that call for ever.
    if pending != nil {
      result(FlutterError(code: "busy",
                          message: "a file is already being chosen", details: nil))
      return
    }
    guard let host = FilesPlugin.topViewController() else {
      result(FlutterError(code: "no_window",
                          message: "no view controller to present from", details: nil))
      return
    }

    pending = result
    let picker = UIDocumentPickerViewController(
      forOpeningContentTypes: [UTType.item], asCopy: true)
    picker.allowsMultipleSelection = false
    picker.delegate = self
    // Swiping the sheet away calls neither delegate method on its own, and the
    // Dart side would await for ever.
    picker.presentationController?.delegate = self
    host.present(picker, animated: true)
  }

  public func documentPicker(_ controller: UIDocumentPickerViewController,
                             didPickDocumentsAt urls: [URL]) {
    guard let result = pending else { return }
    pending = nil
    guard let url = urls.first else {
      result(nil)
      return
    }
    // asCopy: true put the file in this app's temporary directory, so it is
    // readable without a security-scoped resource — but it is worth removing,
    // since an imported archive can be large.
    defer { try? FileManager.default.removeItem(at: url) }
    do {
      let data = try Data(contentsOf: url)
      result([
        "name": url.lastPathComponent,
        "bytes": FlutterStandardTypedData(bytes: data),
      ])
    } catch {
      result(FlutterError(code: "unreadable",
                          message: error.localizedDescription, details: nil))
    }
  }

  public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    finishCancelled()
  }

  public func presentationControllerDidDismiss(_ controller: UIPresentationController) {
    finishCancelled()
  }

  /// Nil, not an error: backing out of the picker is a normal thing to do and
  /// must not put a failure message on screen.
  private func finishCancelled() {
    guard let result = pending else { return }
    pending = nil
    result(nil)
  }

  /// Walks the scene graph rather than reaching for `self.window`.
  ///
  /// This project uses the UIScene lifecycle, so the app delegate's `window` is
  /// nil — it belongs to the scene. Force-unwrapping it is what killed the app
  /// on launch once before, and CI did not catch it because CI compiles the app
  /// and never runs it. `UIWindowScene.keyWindow` rather than `.windows`, which
  /// is deprecated.
  private static func topViewController() -> UIViewController? {
    let scenes = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
    let scene = scenes.first { $0.activationState == .foregroundActive }
      ?? scenes.first
    var top = scene?.keyWindow?.rootViewController
    while let presented = top?.presentedViewController { top = presented }
    return top
  }
}
