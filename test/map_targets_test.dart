import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/map_targets.dart';
import 'package:wren/src/place_export.dart';

/// The target list, and the one way it can rot.
///
/// From Android 11 a package that is not named in the manifest's `<queries>` is
/// invisible: `getPackageInfo` throws `NameNotFoundException` exactly as if the
/// app were not installed. So adding an app to [namedTargets] and forgetting the
/// manifest produces a button that never appears on a phone that has the app,
/// with no exception, no log line and nothing on screen to explain it. It is the
/// only bug here that no amount of testing on a device with the app *absent*
/// would ever surface.
///
/// This test reads the real manifest off disk. That is unusual for a Dart test
/// and it is the point — the two lists cannot be kept in step by intention.
void main() {
  final manifest = File(
    'android/app/src/main/AndroidManifest.xml',
  ).readAsStringSync();

  group('the manifest and the target list agree', () {
    test('every package Wren offers by name is declared', () {
      for (final t in namedTargets) {
        for (final pkg in t.packages) {
          expect(
            manifest,
            contains('<package android:name="$pkg" />'),
            reason:
                '${t.name} offers $pkg, which is not in <queries>. On Android '
                '11+ that package is invisible, so the button silently never '
                'appears on a device that has the app.',
          );
        }
      }
    });

    test('the provider is the subclass that knows what a GPX is', () {
      // Android's own mime.types table has entries for kml and kmz and none for
      // gpx, so androidx's FileProvider answers application/octet-stream and a
      // receiver that asks the resolver rather than trusting the intent refuses
      // the file.
      expect(manifest, contains('android:name=".PlaceFileProvider"'));
      expect(manifest, contains('android:grantUriPermissions="true"'));
      expect(manifest, contains('android:exported="false"'));
    });

    test('no QUERY_ALL_PACKAGES', () {
      // A restricted permission needing a Play declaration, whose own
      // documentation names package visibility filtering as the thing to do
      // instead. Seven declared packages need neither.
      //
      // Matched as a declaration rather than as a word, because the comment above
      // the <queries> block names the permission it exists to avoid.
      expect(
        RegExp('uses-permission[^>]*QUERY_ALL_PACKAGES').hasMatch(manifest),
        isFalse,
      );
    });
  });

  group('what the list claims about effort', () {
    test('every target has an honest effort recorded', () {
      for (final t in namedTargets) {
        expect(targetEffort[t.id], isNotNull, reason: t.id);
      }
      expect(targetEffort.length, namedTargets.length);
    });

    test('anything that is not one tap says so in its note', () {
      // The rule that keeps this list honest: an app promised as a button and
      // silently needing four more taps is worse than an app left out.
      for (final t in namedTargets) {
        if (targetEffort[t.id] != TargetEffort.oneTap) {
          expect(t.note, isNotEmpty, reason: '${t.name} is not one tap');
        }
      }
    });

    test('the refuted apps are absent, not quietly included', () {
      // Each of these was surveyed and then attacked: Guru Maps caps the free
      // tier at fifteen pinned places, MAPS.ME registers no ACTION_SEND at all,
      // Komoot imports GPX as a route, HERE WeGo can only import through a picker
      // it opens itself, and AllTrails has no place entity.
      final ids = namedTargets.map((t) => t.id).toSet();
      for (final gone in ['gurumaps', 'mapsme', 'komoot', 'herewego']) {
        expect(ids, isNot(contains(gone)));
      }
    });
  });

  group('the Google Maps route', () {
    test('is a CSV, because that is the only thing Google geocodes', () {
      // Google's importer positions from a name or address column, so a place
      // Apple could not position still arrives. Every other format would need a
      // coordinate Wren may not have.
      expect(googleMapsTarget.format, PlaceFormat.csv);
      expect(googleMapsTarget.format.geocodesOnImport, isTrue);
    });

    test('claims no installed package', () {
      // The route is a web page in a Custom Tab, not the Google Maps app: there
      // is no API that writes a saved list, and /maps/d/mutate authenticates a
      // live browser session no app can hold.
      expect(googleMapsTarget.packages, isEmpty);
    });

    test('a remembered map id skips the create step', () {
      expect(myMapsUrl(), 'https://www.google.com/maps/d/');
      expect(
        myMapsUrl(mapId: '1a-B_c3'),
        'https://www.google.com/maps/d/edit?mid=1a-B_c3',
      );
      // An empty id must behave as no id, not produce edit?mid=.
      expect(myMapsUrl(mapId: ''), 'https://www.google.com/maps/d/');
    });

    test('reads the map id back out of either link form', () {
      expect(
        mapIdFrom('https://www.google.com/maps/d/edit?mid=1a-B_c3&usp=sharing'),
        '1a-B_c3',
      );
      expect(
        mapIdFrom('https://www.google.com/maps/d/viewer?mid=1a-B_c3'),
        '1a-B_c3',
      );
      expect(mapIdFrom('https://www.google.com/maps/d/'), isNull);
    });
  });
}
