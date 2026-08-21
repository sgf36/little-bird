import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/map_targets.dart';
import 'package:wren/src/place_export.dart';
import 'package:wren/src/place_share.dart';

/// Handing an export to another app.
///
/// Three failures are worth designing against, and all of them are invisible:
///
///   * **A raw file path.** A `file://` URI grants the receiving app nothing.
///     Measured against Organic Maps on an emulator: the app launched, matched
///     the MIME type, then died with `EACCES (Permission denied)`. The intent was
///     right and the transport was wrong. Everything must go out as a content URI
///     from a FileProvider, which is asserted in the Android job in CI rather
///     than here, because Dart cannot see a manifest.
///   * **Package visibility.** From Android 11, a package that is not declared in
///     `<queries>` throws exactly as if it were not installed. So "not installed"
///     and "not declared" are the same answer, and a button that should appear
///     silently does not. The only defence is that every package Wren offers is
///     declared — and that the UI treats a null answer as "offer the chooser
///     instead", never as "this app does not exist".
///   * **The wrong kind of intent.** A share and an open-with are not
///     interchangeable. Send a file to an app that only registered ACTION_VIEW
///     and it appears in the sheet and then does nothing at all, which is the
///     hardest failure of the three to attribute to the sender.
void main() {
  const file = ExportResult(
    bytes: [1, 2, 3],
    fileName: 'london.gpx',
    format: PlaceFormat.gpx,
    written: 5,
    droppedForNoCoordinate: 0,
  );

  MapTarget target(String id) =>
      namedTargets.firstWhere((t) => t.id == id, orElse: () => throw id);

  group('sending to a specific app', () {
    test('reports sent when the package is there', () async {
      final sharer = StubPlaceSharer(installed: ['app.organicmaps']);
      expect(
        await sharer.shareTo(file, target('organicmaps'), 'app.organicmaps'),
        ShareOutcome.sent,
      );
      expect(sharer.sent.single.package, 'app.organicmaps');
    });

    test('reports noHandler rather than throwing when it is not', () async {
      // An absent app must be an outcome the UI can render, not an exception.
      final sharer = StubPlaceSharer();
      expect(
        await sharer.shareTo(file, target('organicmaps'), 'app.organicmaps'),
        ShareOutcome.noHandler,
      );
    });
  });

  group('the chooser', () {
    test('needs no knowledge of what is installed', () async {
      // The path that cannot break: no package list, no <queries>, no version
      // gate. Whatever the device has, the system offers.
      final sharer = StubPlaceSharer();
      expect(await sharer.share(file), ShareOutcome.sent);
      expect(sharer.sent.single.package, isNull);
    });
  });

  group('detecting installed apps', () {
    test('returns the first present package, honouring order', () async {
      // OsmAnd ships free and paid. The order in the target list is the
      // preference, so the free build must be asked for first and the paid one
      // still found when only it is there.
      final both = StubPlaceSharer(
        installed: ['net.osmand', 'net.osmand.plus'],
      );
      expect(
        await both.firstInstalled(['net.osmand', 'net.osmand.plus']),
        'net.osmand',
      );

      final paidOnly = StubPlaceSharer(installed: ['net.osmand.plus']);
      expect(
        await paidOnly.firstInstalled(['net.osmand', 'net.osmand.plus']),
        'net.osmand.plus',
      );
    });

    test('answers null when none is present, and does not throw', () async {
      expect(await StubPlaceSharer().firstInstalled(['a', 'b']), isNull);
    });

    test(
      'null must mean "fall back to the chooser", not "no such app"',
      () async {
        // The distinction Dart cannot make: an undeclared package and an
        // uninstalled one are the same answer. So a null here is never evidence
        // that the app is missing, and the UI must keep a chooser available.
        final sharer = StubPlaceSharer();
        expect(await sharer.firstInstalled(['app.organicmaps']), isNull);
        expect(await sharer.share(file), ShareOutcome.sent);
      },
    );
  });

  group('every target asks for the intent its app actually registered', () {
    test('Organic Maps and OsmAnd take a share', () {
      // Both declare ACTION_SEND for application/gpx+xml on an exported
      // activity, and both read the file from EXTRA_STREAM.
      for (final id in ['organicmaps', 'osmand']) {
        expect(target(id).action, HandoffAction.send, reason: id);
      }
    });

    test('Gaia GPS, Locus Map and Mapy take an open-with', () {
      // Gaia documents only the open-with route and nothing shows its activity
      // reads EXTRA_STREAM; Locus's own client code sends ACTION_VIEW; Mapy
      // declares no ACTION_SEND filter at all, so a share can never reach it.
      for (final id in ['gaiagps', 'locus', 'mapy']) {
        expect(target(id).action, HandoffAction.view, reason: id);
      }
    });

    test('Locus Map carries the extra that makes it an import', () {
      // Without this the places render as temporary map objects, never enter the
      // points database, and are gone on restart — a hand-off that looks like it
      // worked and left nothing behind.
      expect(
        target('locus').extras['locus.api.android.INTENT_EXTRA_CALL_IMPORT'],
        isTrue,
      );
      // And the vendor's own nonstandard type, not the registered one.
      expect(target('locus').sendMimeType, 'application/gpx');
    });

    test('everything else sends the format\'s registered type', () {
      for (final t in namedTargets.where((t) => t.id != 'locus')) {
        expect(t.sendMimeType, 'application/gpx+xml', reason: t.id);
      }
    });

    test('the action strings are the real Android constants', () {
      expect(HandoffAction.send.intentAction, 'android.intent.action.SEND');
      expect(HandoffAction.view.intentAction, 'android.intent.action.VIEW');
    });
  });

  group('targets carry the format their app actually accepts', () {
    test('every named target is GPX', () {
      // One format for all of them, and it is deliberately not KML: OsmAnd
      // routes an arriving .kml down its track import path, which can never
      // reach favourites, and Mapy does not accept KML at all.
      for (final t in namedTargets) {
        expect(t.format, PlaceFormat.gpx, reason: t.name);
      }
    });

    test('the file name keeps the extension the format needs', () {
      expect(exportFileName('London', PlaceFormat.gpx), endsWith('.gpx'));
      // Exactly one dot, and lowercase. Mapy's manifest declares a lowercase
      // `.gpx` path pattern only, and the Android pattern matcher makes one
      // forward pass with no backtracking, so a second dot stops it matching.
      expect(
        exportFileName('London 2026. Bars', PlaceFormat.gpx),
        'london-2026-bars.gpx',
      );
    });
  });
}
