import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wren/main.dart';
import 'package:wren/src/entitlement.dart';
import 'package:wren/src/guide_link.dart';
import 'package:wren/src/file_source.dart';
import 'package:wren/src/place_export.dart';
import 'package:wren/src/place_share.dart';
import 'package:wren/src/resolver.dart';

import 'harness.dart';
import 'import_flow_test.dart' show NoMapResolver;
import 'paywall_test.dart' show FakeStore;

/// What Wren is on a phone with no Apple Maps.
///
/// Two things follow from that absence and neither is cosmetic. There is no
/// guide to publish, so the main button hands the list to another map app
/// instead. And the purchase sells guides of any size, so where there are no
/// guides there is nothing to sell — `com.spencerfields.littlebird.unlimited`
/// exists in App Store Connect and not in Play Console, so a paywall reached
/// here would quote a price Play never set and then fail to take the money.
/// Shipping that to Play would be a policy problem as well as a bad first
/// impression.
///
/// Every test below pins `canMakeGuides` rather than trusting the platform,
/// because the suite runs on a desktop where neither branch is the default.

/// A place with a coordinate, so it can be written into a file as well as
/// matched — the two are different questions, and only the first reaches
/// another map app.
Pending located(int i) => Pending(
  'read $i',
  PlaceMatch(
    id: PlaceId.parse('I43FA2531C5B5D63${i.toRadixString(16)}'),
    name: 'Place $i',
    address: '$i Somewhere Street',
    lat: 51.5 + i / 100,
    lon: -0.12,
  ),
);

Future<void> pumpAndroid(
  WidgetTester tester, {
  int count = 0,
  FakeStore? store,
  PlaceSharer? sharer,
  FileSource? files,
  PlaceResolver? resolver,
  List<Pending>? pending,
}) async {
  await tester.pumpWidget(
    app(
      CapturePage(
        store: store,
        sharer: sharer,
        files: files,
        resolver: resolver ?? NoMapResolver(),
        canMakeGuides: false,
        initialPending: pending ?? List.generate(count, located),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'the main button hands the list over rather than making a guide',
    (tester) async {
      await pumpAndroid(tester, count: 2);

      expect(
        find.widgetWithText(FilledButton, 'Send places to'),
        findsOne,
        reason: 'the hand-off is the Android product, so it is the button',
      );
      // It used to be an item in the overflow menu, behind the button that
      // opened Apple's website. App Review rejected the iOS build for hiding
      // the purchase in exactly that way; hiding the whole product is worse.
      expect(find.textContaining('Make a guide'), findsNothing);
      expect(find.text('Add to a guide'), findsNothing);
    },
  );

  testWidgets('an empty list disables the button rather than hiding it', (
    tester,
  ) async {
    await pumpAndroid(tester, count: 0);
    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Send places to'),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('nothing anywhere offers the purchase', (tester) async {
    // Well over the free cap, which on iOS would raise a banner and a paywall.
    final store = FakeStore();
    await pumpAndroid(tester, count: freePlaceLimit + 4, store: store);

    // The banner that sells the unlock.
    expect(find.textContaining('over the free limit'), findsNothing);

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.text('Clear the list'), findsOne);
    // Nothing to restore, and the copy behind it says "Apple account".
    expect(find.text('Restore purchase'), findsNothing);
    // Added by the App Store rejection fix, gated only on the entitlement.
    // On Play it would open a paywall that cannot complete.
    expect(find.text('Guides of any size'), findsNothing);

    expect(store.buyCalls, 0);
    expect(store.restoreCalls, 0);
  });

  testWidgets('the complimentary code is not offered either', (tester) async {
    // Long-pressing the title opens it. Undiscoverable, so no reviewer will
    // find it -- but it unlocks guides of any size, which is nothing here, and
    // it is the only thing in the app that would open a socket. It cannot even
    // do that: the device identifier a code is issued against comes from a
    // channel with no Android implementation. Leaving a dialog that can only
    // ever answer "could not be reached" is worse than not having one.
    await pumpAndroid(tester);
    await tester.longPress(find.text('Wren'));
    await tester.pumpAndSettle();
    expect(find.text('Complimentary access'), findsNothing);
  });

  testWidgets('a guide-making build keeps the complimentary code', (
    tester,
  ) async {
    await tester.pumpWidget(app(const CapturePage(canMakeGuides: true)));
    await tester.pumpAndSettle();
    await tester.longPress(find.text('Wren'));
    await tester.pumpAndSettle();
    expect(find.text('Complimentary access'), findsOne);
  });

  testWidgets('more places than the free cap all go across', (tester) async {
    // The cap limits the places in one guide. This makes no guide, so counting
    // against it would be charging for a feature the platform does not have.
    final sharer = StubPlaceSharer();
    final store = FakeStore();
    await pumpAndroid(
      tester,
      count: freePlaceLimit + 4,
      store: store,
      sharer: sharer,
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Send places to'));
    await tester.pumpAndSettle();
    // Straight to the system chooser: no paywall stood in the way.
    await tester.tap(find.text('Any other app'));
    await tester.pumpAndSettle();

    expect(store.buyCalls, 0);
    final file = sharer.sent.single.file;
    expect(file.written, freePlaceLimit + 4);
    expect(file.fileName, endsWith('.gpx'));
  });

  testWidgets('a guide-making build is unaffected', (tester) async {
    // The other half of the flag. Without this, inverting it would still pass
    // every test above.
    await tester.pumpWidget(
      app(
        CapturePage(
          store: FakeStore(),
          canMakeGuides: true,
          initialPending: List.generate(freePlaceLimit + 4, located),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Make a guide'), findsOne);
    expect(find.text('Send places to'), findsNothing);
    expect(find.textContaining('over the free limit'), findsOne);

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.text('Restore purchase'), findsOne);
  });

  group('the first screen describes the app that is installed', () {
    testWidgets('it says where the places end up, and names no Apple', (
      tester,
    ) async {
      await pumpAndroid(tester);
      // The same promise as iOS up to the destination: a screenshot is read
      // here too, by ML Kit rather than Vision. What differs is the last
      // clause -- a map app on the phone, not a guide that does not exist.
      expect(find.textContaining('Screenshot what people'), findsOne);
      expect(find.textContaining('sends them to the map app'), findsOne);
      expect(find.textContaining('Apple'), findsNothing);
      expect(find.textContaining('Also reads a list'), findsOne);
    });

    testWidgets('the guide-making build keeps its own words', (tester) async {
      await tester.pumpWidget(app(const CapturePage(canMakeGuides: true)));
      await tester.pumpAndSettle();
      expect(find.textContaining('Screenshot what people'), findsOne);
      expect(find.textContaining('Also reads a list'), findsOne);
      expect(find.textContaining('Open a list of places'), findsNothing);
    });
  });

  group('only the sources that work are offered', () {
    const csv = '''
name,latitude,longitude,address
Fuunji,35.6895,139.6917,Shibuya
''';

    testWidgets('a guide link is the only source left out', (tester) async {
      // Screenshots work here now. A guide link still does not: it is a list
      // of Apple identifiers and nothing else, and resolving one needs
      // Apple's own lookup, so it produces a list that looks imported and
      // cannot be sent. Measured, not assumed.
      await pumpAndroid(tester, files: StubFileSource(csv));
      await tester.tap(find.widgetWithText(OutlinedButton, 'Add'));
      await tester.pumpAndSettle();

      expect(find.text('Add screenshots'), findsOne);
      expect(find.text('From a file'), findsOne);
      expect(find.text('From an existing guide'), findsNothing);
    });

    testWidgets('the guide-making build still asks which source', (
      tester,
    ) async {
      await tester.pumpWidget(app(const CapturePage(canMakeGuides: true)));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Add'));
      await tester.pumpAndSettle();
      expect(find.text('Add screenshots'), findsOne);
      expect(find.text('From a file'), findsOne);
      expect(find.text('From an existing guide'), findsOne);
    });
  });

  group('the list arrives under a name somebody chose', () {
    const csv = '''
name,latitude,longitude,address
Padella,51.5055,-0.0911,Southwark
''';

    testWidgets('a CSV takes its title from the file name', (tester) async {
      // A CSV carries no title inside it. Without this the list landed in the
      // other map app called "Places" — and "Places1" once a second one
      // arrived, which is Organic Maps disambiguating a name Wren invented.
      final sharer = StubPlaceSharer();
      await pumpAndroid(
        tester,
        files: StubFileSource(csv, name: 'Saved places.csv'),
        sharer: sharer,
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Add'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('From a file'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Send places to'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Any other app'));
      await tester.pumpAndSettle();

      final gpx = utf8.decode(sharer.sent.single.file.bytes);
      expect(gpx, contains('<name>Saved places</name>'));
      expect(gpx, isNot(contains('<name>Places</name>')));
    });

    testWidgets('a title inside the file still wins', (tester) async {
      // The GPX says what it is called. That is a stronger claim than the
      // name of whatever the file happens to be saved as.
      const gpx = '''
<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" creator="test" xmlns="http://www.topografix.com/GPX/1/1">
  <metadata><name>Tokyo, March</name></metadata>
  <wpt lat="35.6895" lon="139.6917"><name>Fuunji</name></wpt>
</gpx>
''';
      final sharer = StubPlaceSharer();
      await pumpAndroid(
        tester,
        files: StubFileSource(gpx, name: 'export (3).gpx'),
        sharer: sharer,
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Add'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('From a file'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Send places to'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Any other app'));
      await tester.pumpAndSettle();

      final written = utf8.decode(sharer.sent.single.file.bytes);
      expect(written, contains('Tokyo, March'));
      expect(written, isNot(contains('export (3)')));
    });
  });

  group('a place with no Apple identifier is still a place', () {
    // Everything the Android lookup returns looks like this: a name, an
    // address and a coordinate, and no id, because a geocoder issues none.
    testWidgets('the same place twice is still one place', (tester) async {
      const m = PlaceMatch(
        name: 'Padella',
        address: '6 Southwark St',
        lat: 51.5052,
        lon: -0.0899,
      );
      const other = PlaceMatch(
        name: 'Padella',
        address: '6 Southwark St',
        lat: 51.5052,
        lon: -0.0899,
      );
      const elsewhere = PlaceMatch(
        name: 'Padella',
        address: 'Shoreditch',
        lat: 51.5245,
        lon: -0.0766,
      );
      expect(m.isSamePlaceAs(other), isTrue);
      // Same name, different place. Two branches of one restaurant are two
      // places, and without an identifier the coordinate is what says so.
      expect(m.isSamePlaceAs(elsewhere), isFalse);
      expect(m.isSamePlaceAs(null), isFalse);
      // One with an identifier and one without cannot be shown to be the
      // same, so they are not treated as the same.
      final appled = PlaceMatch(
        id: PlaceId.parse('I43FA2531C5B5D635'),
        name: 'Padella',
        address: '6 Southwark St',
        lat: 51.5052,
        lon: -0.0899,
      );
      expect(m.isSamePlaceAs(appled), isFalse);
    });

    testWidgets('it can be sent, and cannot be published', (tester) async {
      // The whole point of the id being optional: enough to write a file,
      // not enough to build a guide link.
      final p = Pending('read', geocoded('Padella', 51.5052, -0.0899));
      expect(p.exportable, isTrue);
      expect(p.publishable, isFalse);
    });
  });

  group('a row is what the file said', () {
    // A place a file positioned, which no map has ever identified. Normal on
    // Android, and the only kind of row there is.
    Pending fromFile(String name, {double? lat, double? lon}) => Pending(
      name,
      null,
      origin: Origin.file,
      fromFile: ExportPlace(name: name, address: '', lat: lat, lon: lon),
    );

    testWidgets('an unmatched row can be searched for', (tester) async {
      // There is a lookup on Android now -- the platform geocoder -- so a row
      // the reading got wrong is something the user can fix, exactly as on
      // iPhone. While there was no lookup this had to be hidden, because the
      // sheet could only ever answer "needs an iPhone".
      await pumpAndroid(tester, pending: [fromFile('Somewhere')]);
      // Nothing positions it: no match and no coordinate, so it cannot be
      // sent and the search is the only thing that would help.
      expect(find.byIcon(Icons.search), findsOne);

      await tester.tap(find.text('Somewhere'));
      await tester.pumpAndSettle();
      expect(find.text('Find this place'), findsOne);
    });

    testWidgets('a positioned row is ready to send, with no search', (
      tester,
    ) async {
      // The file gave it a coordinate, so nothing is missing and there is
      // nothing to correct: it gets a tick rather than a magnifying glass.
      await pumpAndroid(
        tester,
        pending: [fromFile('Fuunji', lat: 35.68, lon: 139.69)],
      );
      // A tick rather than a warning: the file positioned it, so there is
      // nothing missing and nothing to fix.
      expect(find.byIcon(Icons.search), findsNothing);
      expect(find.byType(Checkbox), findsOne);
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Send places to'),
            )
            .onPressed,
        isNotNull,
      );
      // Still correctable, though, because the reading may have been wrong.
      await tester.tap(find.text('Fuunji'));
      await tester.pumpAndSettle();
      expect(find.text('Find this place'), findsOne);
    });
  });
}

/// A resolver shaped like the Android one: it answers with a real place that
/// has a coordinate and no Apple identifier, because a geocoder issues no
/// identifiers.
class GeocoderLikeResolver extends PlaceResolver {
  GeocoderLikeResolver(this.answers);

  final Map<String, PlaceMatch> answers;

  @override
  Future<List<PlaceMatch>> resolve(String query, {Region? region}) async {
    for (final e in answers.entries) {
      if (query.contains(e.key)) return [e.value];
    }
    return const [];
  }

  @override
  Future<PlaceLookup> lookup(List<PlaceId> ids) async =>
      PlaceLookup(failed: ids.toSet());

  @override
  Future<Region?> locate(String query) async =>
      Region(name: query, lat: 51.5, lon: -0.12);
}

PlaceMatch geocoded(String name, double lat, double lon) => PlaceMatch(
  id: null,
  name: name,
  address: '$name Street',
  lat: lat,
  lon: lon,
);
