import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wren/main.dart';
import 'package:wren/src/file_source.dart';
import 'package:wren/src/guide_link.dart';
import 'package:wren/src/resolver.dart';

import 'harness.dart';
import 'paywall_test.dart' show FakeStore;
import 'unresolved_test.dart' show match;

/// Answers each query with its own place, which the shared FakeResolver cannot
/// do — it returns one fixed match, and the list's duplicate check would then
/// collapse a whole imported file into a single row.
class QueryResolver extends PlaceResolver {
  QueryResolver(this.answers);

  /// Matched on the query *containing* the key, because a file row's query is
  /// "Name, Address" rather than the bare name.
  final Map<String, PlaceMatch> answers;

  /// Every query asked, in order. The point of several of these tests is what
  /// was searched for, not just what came back.
  final asked = <String>[];
  final regions = <Region?>[];

  /// Names to hand back for bare identifiers, standing in for the iOS 18 lookup
  /// that fills in an imported guide's blanks.
  final names = <PlaceId, PlaceMatch>{};

  @override
  Future<Map<PlaceId, PlaceMatch>> lookup(List<PlaceId> ids) async => {
    for (final id in ids)
      if (names.containsKey(id)) id: names[id]!,
  };

  @override
  Future<Region?> locate(String query) async =>
      Region(name: query, lat: 51.5, lon: -0.12);

  @override
  Future<List<PlaceMatch>> resolve(String name, {Region? region}) async {
    asked.add(name);
    regions.add(region);
    for (final e in answers.entries) {
      if (name.contains(e.key)) return [e.value];
    }
    return const [];
  }
}

class CancellingFileSource implements FileSource {
  @override
  Future<PickedFile?> pick() async => null;
}

Future<void> pump(
  WidgetTester tester, {
  List<Pending>? pending,
  String? guideName,
  PlaceResolver? resolver,
  FileSource? files,
  FakeStore? store,
}) async {
  await tester.pumpWidget(
    app(
      CapturePage(
        store: store ?? FakeStore(),
        resolver: resolver ?? QueryResolver(const {}),
        files: files,
        initialPending: pending,
        initialGuideName: guideName,
      ),
    ),
  );
  await tester.pump();
}

/// Buys the unlock through the real sheet, rather than reaching past it.
///
/// Combining is the paid feature, so every test about the combined guide has to
/// get through this first — which is itself worth exercising each time.
Future<void> buyUnlock(WidgetTester tester) async {
  expect(find.text('Add to a guide you already have'), findsOne);
  await tester.tap(find.textContaining('Unlock for'));
  await tester.pumpAndSettle();
}

/// Opens the add menu and picks one of the three sources.
Future<void> addFrom(WidgetTester tester, String item) async {
  await tester.tap(find.widgetWithText(OutlinedButton, 'Add'));
  await tester.pumpAndSettle();
  await tester.tap(find.text(item));
  await tester.pumpAndSettle();
}

List<Pending> carried(int n) => [
  for (var i = 0; i < n; i++)
    Pending(
      'Old $i',
      PlaceMatch(
        id: PlaceId.parse('I${(0xA0 + i).toRadixString(16)}0000000000000'),
        name: 'Old $i',
        address: '',
      ),
      origin: Origin.guide,
    ),
];

void main() {
  group('importing an existing guide', () {
    final link = buildGuideLink('London, October', [
      GuidePlace(id: PlaceId.parse('I43FA2531C5B5D635'), name: 'Dishoom'),
      GuidePlace(
        id: PlaceId.parse('I655EEDD5976A0811'),
        name: 'Wright Brothers',
      ),
      GuidePlace(id: PlaceId.parse('I94FE63725FB590E2'), name: "Elliot's"),
    ]);

    Future<void> paste(WidgetTester tester, String text) async {
      await addFrom(tester, 'From an existing guide');
      await tester.enterText(find.byType(TextField), text);
      await tester.tap(find.text('Read guide'));
      await tester.pumpAndSettle();
    }

    testWidgets('a pasted link becomes a collapsed group', (tester) async {
      await pump(tester);
      await paste(tester, link);

      expect(find.textContaining('Read 3 places from that guide'), findsOne);
      expect(find.text('3 places already in this guide'), findsOne);
      expect(find.text('From “London, October”'), findsOne);
      // Collapsed: the imported places are context the user has already seen in
      // Maps, and forty of them would bury whatever was just added.
      expect(find.text('Dishoom'), findsNothing);
    });

    testWidgets('a group with no names does not offer to expand', (
      tester,
    ) async {
      // Apple's payload carries identifiers only, so until the lookup answers
      // there is nothing behind the toggle. Opening onto blank cards would look
      // like a bug, so the toggle is not offered.
      await pump(tester);
      await paste(tester, link);

      await tester.tap(find.text('3 places already in this guide'));
      await tester.pumpAndSettle();
      expect(find.text('Dishoom'), findsNothing);
      expect(find.byIcon(Icons.expand_more), findsNothing);
    });

    testWidgets('the group expands and collapses once names arrive', (
      tester,
    ) async {
      final resolver = QueryResolver(const {});
      resolver.names.addAll({
        PlaceId.parse('I43FA2531C5B5D635'): match(
          'Dishoom',
          'I43FA2531C5B5D635',
        ),
        PlaceId.parse('I655EEDD5976A0811'): match(
          'Wright Brothers',
          'I655EEDD5976A0811',
        ),
        PlaceId.parse('I94FE63725FB590E2'): match(
          "Elliot's",
          'I94FE63725FB590E2',
        ),
      });
      await pump(tester, resolver: resolver);
      await paste(tester, link);

      await tester.tap(find.text('3 places already in this guide'));
      await tester.pumpAndSettle();
      expect(find.text('Dishoom'), findsOne);
      expect(find.text("Elliot's"), findsOne);
      // No "read as" line: the name came from Apple's own record, so repeating
      // it back says nothing about whether the match is right.
      expect(find.textContaining('read as'), findsNothing);

      await tester.tap(find.text('3 places already in this guide'));
      await tester.pumpAndSettle();
      expect(find.text('Dishoom'), findsNothing);
    });

    testWidgets('imported places count toward the guide, not the paywall', (
      tester,
    ) async {
      await pump(tester);
      await paste(tester, link);

      // Three places, and the free limit is three — but nothing is over it,
      // because the user already owned these.
      expect(find.text('Make a guide (3)'), findsOne);
      expect(find.textContaining('over the free limit'), findsNothing);
    });

    testWidgets('pasting something that is not a link says what to do', (
      tester,
    ) async {
      await pump(tester);
      await paste(tester, 'https://maps.apple.com/?q=London');

      expect(find.textContaining('not an Apple Maps guide link'), findsOne);
      // And nothing was added on the strength of a bad paste.
      expect(find.textContaining('already in this guide'), findsNothing);
    });

    testWidgets('pasting the same guide twice does not double it', (
      tester,
    ) async {
      await pump(tester);
      await paste(tester, link);
      await paste(tester, link);

      expect(find.text('3 places already in this guide'), findsOne);
    });
  });

  group('combining is the paid feature', () {
    List<Pending> mixed() => [
      ...carried(2),
      Pending('New', match('New', 'I43FA2531C5B5D635')),
    ];

    testWidgets('the unlock is asked for as soon as a guide is read in', (
      tester,
    ) async {
      await pump(tester, pending: mixed());

      // On the list, before any work is done — not discovered at the end after
      // choosing places and naming the guide.
      expect(find.textContaining('needs the unlock'), findsOne);
    });

    testWidgets('publishing a combined guide offers the purchase', (
      tester,
    ) async {
      await pump(tester, pending: mixed());

      await tester.tap(find.text('Make a guide (3)'));
      await tester.pumpAndSettle();

      // The sheet sells combining, not the size cap — three places is inside
      // the free limit of three, so the cap has nothing to say here.
      expect(find.text('Add to a guide you already have'), findsOne);
      expect(find.text('Guides of any size'), findsNothing);
    });

    testWidgets('the trim-to-the-cap option is withheld while combining', (
      tester,
    ) async {
      // It exists to trim what Wren found. Applied here it would publish a
      // guide missing places the user already had, so there is deliberately no
      // smaller version of combining to fall back to.
      await pump(tester, pending: mixed());
      await tester.tap(find.text('Make a guide (3)'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Save the first'), findsNothing);
      expect(find.textContaining('Unlock for'), findsOne);
      expect(find.text('Restore a previous purchase'), findsOne);
    });

    testWidgets('declining the purchase makes no guide', (tester) async {
      final store = FakeStore(buySucceeds: false);
      await pump(tester, pending: mixed(), store: store);

      await tester.tap(find.text('Make a guide (3)'));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Unlock for'));
      await tester.pumpAndSettle();

      expect(store.buyCalls, 1);
      expect(find.text('Maps makes a new guide'), findsNothing);
      expect(find.text('Name this guide'), findsNothing);
    });

    testWidgets('a restored purchase unlocks combining too', (tester) async {
      // Someone on a new phone must not be asked to pay twice for it.
      await pump(
        tester,
        pending: mixed(),
        store: FakeStore(restoreSucceeds: true),
      );

      await tester.tap(find.text('Make a guide (3)'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Restore a previous purchase'));
      await tester.pumpAndSettle();

      expect(find.text('Maps makes a new guide'), findsOne);
    });

    testWidgets('the banner goes once the unlock is bought', (tester) async {
      await pump(tester, pending: mixed());
      await tester.tap(find.text('Make a guide (3)'));
      await tester.pumpAndSettle();
      await buyUnlock(tester);
      // Past the warning, cancel out of naming so the list is visible again.
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.textContaining('needs the unlock'), findsNothing);
    });
  });

  group('publishing a combined guide', () {
    List<Pending> mixed() => [
      ...carried(2),
      Pending('New', match('New', 'I43FA2531C5B5D635')),
    ];

    testWidgets('the new-guide warning appears before anything is made', (
      tester,
    ) async {
      await pump(tester, pending: mixed(), guideName: 'London, October');

      await tester.tap(find.text('Make a guide (3)'));
      await tester.pumpAndSettle();
      await buyUnlock(tester);

      // Said before publishing, not discovered afterwards when a second guide
      // of the same name turns up in Maps.
      expect(find.text('Maps makes a new guide'), findsOne);
      expect(find.textContaining('no way to add to a guide'), findsOne);
      expect(find.textContaining('Wren keeps these places'), findsOne);
    });

    testWidgets('the combined guide is offered the old guide’s name', (
      tester,
    ) async {
      await pump(tester, pending: mixed(), guideName: 'London, October');

      await tester.tap(find.text('Make a guide (3)'));
      await tester.pumpAndSettle();
      await buyUnlock(tester);
      await tester.tap(find.text('Make the combined guide'));
      await tester.pumpAndSettle();

      expect(find.text('Name this guide'), findsOne);
      expect(find.widgetWithText(TextField, 'London, October'), findsOne);
    });

    testWidgets('cancelling the warning publishes nothing', (tester) async {
      await pump(tester, pending: mixed());

      await tester.tap(find.text('Make a guide (3)'));
      await tester.pumpAndSettle();
      await buyUnlock(tester);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Name this guide'), findsNothing);
    });

    testWidgets('one carried place and nothing new goes no further', (
      tester,
    ) async {
      // Republishing an unchanged guide would only produce a duplicate, and the
      // single-place shortcut must not fire for it either. Nor may the purchase
      // be offered: taking the money and then making a duplicate is the worst
      // ordering of these two checks, and it was the original one.
      final store = FakeStore();
      await pump(tester, pending: carried(1), store: store);

      await tester.tap(find.text('Add to a guide'));
      await tester.pumpAndSettle();

      expect(store.buyCalls, 0);
      expect(find.textContaining('Unlock for'), findsNothing);
      expect(find.text('Name this guide'), findsNothing);
      expect(find.text('Maps makes a new guide'), findsNothing);
    });

    testWidgets('the free cap counts new places, not carried ones', (
      tester,
    ) async {
      // Five carried plus five new, against a free limit of three. The cap
      // limits what Wren adds; it is not a count of the whole guide.
      await pump(
        tester,
        pending: [
          ...carried(5),
          for (var i = 0; i < 5; i++)
            Pending(
              'New $i',
              match('New $i', 'I${(0x5B + i).toRadixString(16)}0000000000000'),
            ),
        ],
      );

      expect(find.text('Make a guide (10)'), findsOne);
      // Two over, counted against the five new ones — not against all ten.
      expect(find.textContaining('2 over the free limit'), findsOne);
    });
  });

  group('importing a file', () {
    const csv = '''
name,latitude,longitude,address
Fuunji,35.6895,139.6917,Shibuya
Den,35.6700,139.7100,Jingumae
''';

    testWidgets('places from a file are looked up and listed', (tester) async {
      final resolver = QueryResolver({
        'Fuunji': match('Fuunji', 'I43FA2531C5B5D635'),
        'Den': match('Den', 'I655EEDD5976A0811'),
      });
      await pump(tester, resolver: resolver, files: StubFileSource(csv));

      await addFrom(tester, 'From a file');

      expect(find.textContaining('Read 2 places from that file'), findsOne);
      expect(find.text('Fuunji'), findsOne);
      expect(find.text('Den'), findsOne);
      // The file's own name for it is kept beside Apple's, same as a reading
      // off a screenshot — it is how a confident wrong match gets spotted.
      expect(find.textContaining('read as'), findsWidgets);
    });

    testWidgets('the address is searched with the name', (tester) async {
      final resolver = QueryResolver({
        'Fuunji': match('Fuunji', 'I43FA2531C5B5D635'),
      });
      await pump(tester, resolver: resolver, files: StubFileSource(csv));
      await addFrom(tester, 'From a file');

      expect(resolver.asked.first, 'Fuunji, Shibuya');
    });

    testWidgets('each row is aimed at its own coordinate', (tester) async {
      // The reason a file spanning three cities imports correctly where a batch
      // of screenshots shares one region.
      final resolver = QueryResolver({
        'Fuunji': match('Fuunji', 'I43FA2531C5B5D635'),
        'Den': match('Den', 'I655EEDD5976A0811'),
      });
      await pump(tester, resolver: resolver, files: StubFileSource(csv));
      await addFrom(tester, 'From a file');

      expect(resolver.regions[0]!.lat, closeTo(35.6895, 1e-9));
      expect(resolver.regions[1]!.lat, closeTo(35.6700, 1e-9));
      // No name, so nothing invented is appended to the query.
      expect(resolver.regions[0]!.name, isEmpty);
    });

    testWidgets('a row the map cannot find is kept for the user to search', (
      tester,
    ) async {
      final resolver = QueryResolver({
        'Fuunji': match('Fuunji', 'I43FA2531C5B5D635'),
      });
      await pump(tester, resolver: resolver, files: StubFileSource(csv));
      await addFrom(tester, 'From a file');

      expect(find.textContaining('Read 1 place from that file'), findsOne);
      expect(find.textContaining('1 needs a look'), findsOne);
      expect(find.text('Not found on the map'), findsOne);
    });

    testWidgets('rows with no name are reported rather than hidden', (
      tester,
    ) async {
      const gappy = 'name,latitude,longitude\n,1,2\n,3,4\nDen,35.67,139.71\n';
      await pump(
        tester,
        resolver: QueryResolver({'Den': match('Den', 'I655EEDD5976A0811')}),
        files: StubFileSource(gappy),
      );
      await addFrom(tester, 'From a file');

      expect(find.textContaining('2 rows had no name'), findsOne);
    });

    testWidgets('a file in no known format names the ones that work', (
      tester,
    ) async {
      await pump(
        tester,
        files: StubFileSource('this is just prose', name: 'notes.txt'),
      );
      await addFrom(tester, 'From a file');

      expect(find.textContaining('could not read that file'), findsOne);
      // Two, now: the refusal message and the hint on the empty screen, which
      // names the formats so they are discoverable before anyone tries a file.
      expect(find.textContaining('GeoJSON'), findsNWidgets(2));
    });

    testWidgets('backing out of the picker is not an error', (tester) async {
      await pump(tester, files: CancellingFileSource());
      await addFrom(tester, 'From a file');

      expect(find.textContaining('could not read'), findsNothing);
      // And the button is usable again rather than stuck reading.
      expect(find.widgetWithText(OutlinedButton, 'Add'), findsOne);
    });
  });
}
