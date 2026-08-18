import MobileCoreServices
import Social
import UIKit
import UniformTypeIdentifiers

/// Wren in the iOS share sheet.
///
/// Everything in that sheet's app row is an app shipping a share extension, which
/// is the only way in: an app cannot volunteer itself for URL sharing any other
/// way. Apple Maps shares a guide as a `maps.apple/ug/…` short link, and Wren
/// already expands and decodes exactly that, so this target is plumbing rather
/// than new capability. It replaces Share → Copy → open Wren → paste.
///
/// Deliberately silent. It takes the URL, writes it where the app will find it,
/// and completes — no interface of its own, because there is nothing to ask and a
/// sheet that lingers to say "done" is a sheet in the way. The reviewing and
/// confirming all happens in the app, where it already does.
///
/// Apple Maps only. A shared Google Maps list URL is opaque — no documented
/// format, nothing to decode — so `Info.plist` does not claim it, and Wren does
/// not appear in Google's share sheet promising something it cannot do.
class ShareViewController: UIViewController {
  /// Shared with the app through the App Group container. App Groups cannot be
  /// created through the App Store Connect API — it answers 404 for the resource
  /// — so this identifier must exist in the developer portal and be enabled on
  /// both this extension's App ID and the app's.
  static let appGroup = "group.com.spencerfields.littlebird"

  /// The app reads and deletes this on launch and on resume. A file rather than
  /// UserDefaults: a URL arriving while the app is already open has to be
  /// noticed, and a file's presence is unambiguous.
  static let handoffName = "shared-guide-link.txt"

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear

    guard let item = (extensionContext?.inputItems as? [NSExtensionItem])?.first,
          let providers = item.attachments else {
      return finish()
    }

    let wanted = UTType.url.identifier
    guard let provider = providers.first(where: {
      $0.hasItemConformingToTypeIdentifier(wanted)
    }) else {
      // Something that is not a URL. Nothing to do, and nothing to complain
      // about — the activation rule should have kept us out of this sheet.
      return finish()
    }

    provider.loadItem(forTypeIdentifier: wanted) { [weak self] value, _ in
      let url = (value as? URL) ?? (value as? String).flatMap(URL.init(string:))
      if let url = url { self?.hand(over: url) }
      self?.finish()
    }
  }

  private func hand(over url: URL) {
    guard let container = FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: Self.appGroup) else {
      // No App Group means no channel to the app. Failing quietly is right: the
      // paste route still works, and an alert here would be a dead end in a
      // sheet the user is trying to dismiss.
      NSLog("WREN-SHARE no container for \(Self.appGroup)")
      return
    }
    let target = container.appendingPathComponent(Self.handoffName)
    do {
      try url.absoluteString.write(to: target, atomically: true, encoding: .utf8)
    } catch {
      NSLog("WREN-SHARE could not write handoff: \(error.localizedDescription)")
    }
  }

  private func finish() {
    extensionContext?.completeRequest(returningItems: nil)
  }
}
