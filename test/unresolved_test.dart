import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wren/main.dart';
import 'package:wren/src/guide_link.dart';
import 'package:wren/src/resolver.dart';

import 'harness.dart';
import 'paywall_test.dart' show FakeStore;

PlaceMatch match(String name, String hex) => PlaceMatch(
  id: PlaceId.parse(hex),
  name: name,
  address: '$name Street',
  category: 'Restaurant',
  metresFromCentre: 0,
);

/// Deterministic stand-in for MapKit. The real one is unavailable in a test,
/// and its failure path leaves a spinner running, which `pumpAndSettle` can
/// never settle.
class FakeResolver implements PlaceResolver {
  final List<PlaceMatch> results;
  FakeResolver([this.results = const []]);

  @override
  Future<Region?> locate(String query) async =>
      Region(name: query, lat: 51.5, lon: -0.12);

  @override
  Future<List<PlaceMatch>> resolve(String name, {Region? region}) async =>
      results;
}

Future<void> pump(
  WidgetTester tester,
  List<Pending> pending, {
  PlaceResolver? resolver,
}) async {
  await tester.pumpWidget(
    app(
      CapturePage(
        store: FakeStore(),
        resolver: resolver ?? FakeResolver(),
        initialPending: pending,
      ),
    ),
  );
  await tester.pump();
}

/// Opens a row's lookup sheet without waiting on the debounce or the spinner.
Future<void> openSheet(WidgetTester tester, Finder row) async {
  await tester.tap(row);
  await tester.pump(); // start the route
  await tester.pump(const Duration(milliseconds: 400)); // sheet animates in
}

void main() {
  testWidgets('a reading that never matched is kept, not thrown away', (
    tester,
  ) async {
    await pump(tester, [Pending("Mr Fogg's Botanical Tavern", null)]);

    expect(find.text('Not found on the map'), findsOneWidget);
    expect(find.textContaining('read as'), findsOneWidget);
    // It is visible, but it cannot go in a guide without an Apple place id.
    expect(find.text('Make a guide (0)'), findsOneWidget);
  });

  testWidgets('the reading is shown on matched places too', (tester) async {
    // Always visible now: it is the only way to tell a correct match from a
    // confident wrong one.
    await pump(tester, [
      Pending('Dishoom Shoreditch', match('Dishoom', 'I43FA2531C5B5D635')),
    ]);
    expect(find.textContaining('read as “Dishoom Shoreditch”'), findsOneWidget);
    expect(find.text('Dishoom'), findsOneWidget);
  });

  testWidgets('unresolved rows are counted out of the publish total', (
    tester,
  ) async {
    await pump(tester, [
      Pending('One', match('One', 'I43FA2531C5B5D635')),
      Pending('Two', match('Two', 'I655EEDD5976A0811')),
      Pending('Unfindable', null),
    ]);
    expect(find.text('Make a guide (2)'), findsOneWidget);
    expect(find.textContaining('1 place was not found'), findsOneWidget);
  });

  testWidgets('tapping a row opens the lookup, pre-filled', (tester) async {
    await pump(tester, [Pending('Barbarella', null)]);

    await openSheet(tester, find.text('Not found on the map'));

    expect(find.text('Find this place'), findsOneWidget);
    // What the screenshot said travels into the sheet, so nobody has to
    // remember it or retype it from the photo.
    expect(find.textContaining('read as “Barbarella”'), findsWidgets);
    expect(find.widgetWithText(TextField, 'Barbarella'), findsOneWidget);
  });

  testWidgets('a matched row opens the same lookup to be corrected', (
    tester,
  ) async {
    await pump(tester, [
      Pending('The V&A Cafe', match('Arabica', 'I52BEC654CD7F9E76')),
    ]);

    await openSheet(tester, find.text('Arabica'));

    expect(find.text('Find this place'), findsOneWidget);
    // Pre-filled with what Apple chose, so a correction starts from the current
    // answer rather than from nothing.
    expect(find.widgetWithText(TextField, 'Arabica'), findsOneWidget);
  });
}
