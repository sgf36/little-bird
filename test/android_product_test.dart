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
    testWidgets('it promises no screenshots and no guide', (tester) async {
      await pumpAndroid(tester);
      // emptyBody/emptyNote are about reading screenshots into Apple Maps.
      // Neither half exists here: no Vision framework, no Apple Maps.
      expect(find.textContaining('Screenshot what people'), findsNothing);
      expect(find.textContaining('Apple'), findsNothing);
      expect(find.textContaining('Open a list of places'), findsOne);
      // The formats chip opens with "Also", which is only true beside
      // screenshots. The Android body names them instead.
      expect(find.textContaining('Also reads a list'), findsNothing);
      expect(find.textContaining('GeoJSON'), findsOne);
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

    testWidgets('Add goes straight to the file picker', (tester) async {
      // No sheet at all. Screenshots need Apple's Vision framework, and a
      // guide read without MapKit arrives as identifiers with no coordinate,
      // so a three-item menu would offer one working source and two dead ones.
      await pumpAndroid(tester, files: StubFileSource(csv));
      await tester.tap(find.widgetWithText(OutlinedButton, 'Add'));
      await tester.pumpAndSettle();

      expect(find.text('Add screenshots'), findsNothing);
      expect(find.text('From an existing guide'), findsNothing);
      expect(find.text('From a file'), findsNothing);
      // The picker ran and its one row is on screen.
      expect(find.text('Fuunji'), findsOne);
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

  group('a row is what the file said', () {
    // A place a file positioned, which no map has ever identified. Normal on
    // Android, and the only kind of row there is.
    Pending fromFile(String name, {double? lat, double? lon}) => Pending(
      name,
      null,
      origin: Origin.file,
      fromFile: ExportPlace(name: name, address: '', lat: lat, lon: lon),
    );

    testWidgets('no search icon, because there is nothing to search', (
      tester,
    ) async {
      await pumpAndroid(
        tester,
        pending: [fromFile('Fuunji', lat: 35.68, lon: 139.69)],
      );
      // With a map this row would carry a magnifying glass and open a sheet.
      // Here that sheet can only ever answer "needs an iPhone", which turns
      // the normal case into an error nobody can clear.
      expect(find.byIcon(Icons.search), findsNothing);
      expect(find.byType(Checkbox), findsOne);

      await tester.tap(find.text('Fuunji'));
      await tester.pumpAndSettle();
      expect(find.text('Find this place'), findsNothing);
    });

    testWidgets('a row with no coordinate cannot be ticked', (tester) async {
      // It can never be sent, so a live checkbox would tick and then be
      // quietly ignored on the way out.
      await pumpAndroid(tester, pending: [fromFile('Somewhere')]);
      final box = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(box.onChanged, isNull);
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Send places to'),
            )
            .onPressed,
        isNull,
      );
    });
  });
}
