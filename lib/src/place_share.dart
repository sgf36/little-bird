/// Handing an exported place file to another app on the device.
///
/// Two shapes, deliberately:
///
///   * [PlaceSharer.share] opens the system chooser. Needs no knowledge of what
///     is installed, no manifest declarations, and works on every Android
///     version, because the chooser runs in the system process rather than ours.
///     This is the safe default and the one that cannot break.
///   * [PlaceSharer.shareTo] targets one app directly, which is what makes a
///     single labelled button — "Send to Organic Maps" — possible.
///
/// [PlaceSharer.firstInstalled] exists so the UI can offer a button only for apps
/// that are actually there. On Android 11 and later it answers null for an app
/// that is installed but not declared in the manifest's `<queries>`, which is a
/// distinction the caller cannot recover — hence the rule that every package
/// offered here is declared, and the rule that a null answer means "offer the
/// chooser instead", never "this app does not exist".
library;

import 'package:flutter/services.dart';

import 'place_export.dart';

/// Which kind of intent an app wants.
///
/// Not a detail. The two are not interchangeable and picking the wrong one fails
/// in the way that is hardest to diagnose: the app launches and does nothing.
enum HandoffAction {
  /// `ACTION_SEND` with the file in `EXTRA_STREAM`. What a share-sheet handler
  /// registers for.
  send,

  /// `ACTION_VIEW` with the file as the intent's data. What an "open with"
  /// handler registers for, and the only route some apps document at all — Gaia
  /// GPS among them, where nothing shows that its activity reads `EXTRA_STREAM`.
  view;

  /// The Android action string. Kept here rather than in Kotlin so the two sides
  /// cannot drift.
  String get intentAction => switch (this) {
    HandoffAction.send => 'android.intent.action.SEND',
    HandoffAction.view => 'android.intent.action.VIEW',
  };
}

/// A map app Wren can hand places to.
class MapTarget {
  const MapTarget({
    required this.id,
    required this.name,
    required this.packages,
    required this.format,
    this.action = HandoffAction.send,
    this.mimeType,
    this.extras = const {},
    this.note = '',
  });

  /// Stable key, used for bookkeeping and tests.
  final String id;

  /// What to call it in the interface. Not translated: these are product names.
  final String name;

  /// Every package id this app ships under. The first one found installed wins,
  /// so the order is the preference.
  final List<String> packages;

  /// The format this app takes most reliably.
  final PlaceFormat format;

  /// Whether the file arrives as a share or as something to open.
  final HandoffAction action;

  /// A type to send instead of the format's registered one.
  ///
  /// Exists for exactly one app: Locus Map's own client code sends the
  /// nonstandard `application/gpx`, and matching the vendor is safer than being
  /// correct at it.
  final String? mimeType;

  /// Boolean intent extras this app needs.
  ///
  /// Also for Locus Map, where `INTENT_EXTRA_CALL_IMPORT` is the whole feature:
  /// without it the places draw on the map as temporary objects and are gone on
  /// restart, having never entered the points database.
  final Map<String, bool> extras;

  /// Anything the user needs told, such as an import that is not one tap.
  final String note;

  /// What to tell Android the bytes are.
  String get sendMimeType => mimeType ?? format.mimeType;
}

/// The result of trying to hand a file over.
enum ShareOutcome {
  /// Handed off. Whether the other app did anything sensible with it is beyond
  /// what the sender can observe — no target gives a trustworthy success signal,
  /// so this never means "imported".
  sent,

  /// No app on the device claimed the type, or the target is not installed.
  noHandler,

  /// The platform refused, or there is no implementation here.
  unavailable,
}

abstract class PlaceSharer {
  /// Opens the system chooser for [file].
  Future<ShareOutcome> share(ExportResult file, {String? subject});

  /// Sends [file] straight to [package], as [target] wants to receive it.
  Future<ShareOutcome> shareTo(
    ExportResult file,
    MapTarget target,
    String package,
  );

  /// Whether any of [packages] is installed *and* visible to this app.
  Future<String?> firstInstalled(List<String> packages);

  /// Opens [url] in a Chrome Custom Tab: the browser, drawn over the app.
  ///
  /// Used for the Google Maps route only. A Custom Tab rather than a WebView
  /// because Google blocks sign-in inside a WebView, and this needs the session
  /// the user already has in Chrome.
  Future<ShareOutcome> openTab(String url);
}

class MethodChannelPlaceSharer implements PlaceSharer {
  const MethodChannelPlaceSharer();

  static const _channel = MethodChannel('littlebird/share_file');

  @override
  Future<ShareOutcome> share(ExportResult file, {String? subject}) =>
      _send('shareFile', {
        'bytes': file.bytes,
        'fileName': file.fileName,
        'mimeType': file.format.mimeType,
        'action': HandoffAction.send.intentAction,
        'subject': ?subject,
      });

  @override
  Future<ShareOutcome> shareTo(
    ExportResult file,
    MapTarget target,
    String package,
  ) => _send('shareFile', {
    'bytes': file.bytes,
    'fileName': file.fileName,
    'mimeType': target.sendMimeType,
    'action': target.action.intentAction,
    'extras': target.extras,
    'package': package,
  });

  Future<ShareOutcome> _send(String method, Map<String, Object?> args) async {
    try {
      final ok = await _channel.invokeMethod<String>(method, args);
      return switch (ok) {
        'sent' => ShareOutcome.sent,
        'noHandler' => ShareOutcome.noHandler,
        _ => ShareOutcome.unavailable,
      };
    } on MissingPluginException {
      // iOS, or a build without the bridge. Not an error worth showing.
      return ShareOutcome.unavailable;
    } on PlatformException {
      return ShareOutcome.unavailable;
    }
  }

  @override
  Future<String?> firstInstalled(List<String> packages) async {
    try {
      return await _channel.invokeMethod<String>('firstInstalled', {
        'packages': packages,
      });
    } on MissingPluginException {
      return null;
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<ShareOutcome> openTab(String url) => _send('openTab', {'url': url});
}

/// Records what it was asked to do and claims nothing is installed.
///
/// Used in tests and on platforms with no share sheet, so a caller can be
/// exercised without a device.
class StubPlaceSharer implements PlaceSharer {
  StubPlaceSharer({this.installed = const []});

  final List<String> installed;
  final List<({String? package, MapTarget? target, ExportResult file})> sent =
      [];

  @override
  Future<ShareOutcome> share(ExportResult file, {String? subject}) async {
    sent.add((package: null, target: null, file: file));
    return ShareOutcome.sent;
  }

  @override
  Future<ShareOutcome> shareTo(
    ExportResult file,
    MapTarget target,
    String package,
  ) async {
    sent.add((package: package, target: target, file: file));
    return installed.contains(package)
        ? ShareOutcome.sent
        : ShareOutcome.noHandler;
  }

  @override
  Future<String?> firstInstalled(List<String> packages) async {
    for (final p in packages) {
      if (installed.contains(p)) return p;
    }
    return null;
  }

  /// Every url this was asked to open, so a test can assert the Google Maps
  /// route landed on the right page — including whether it used a remembered
  /// map id rather than the list.
  final List<String> opened = [];

  @override
  Future<ShareOutcome> openTab(String url) async {
    opened.add(url);
    return ShareOutcome.sent;
  }
}
