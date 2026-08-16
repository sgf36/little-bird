import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wren/main.dart';
import 'package:wren/src/entitlement.dart';
import 'package:wren/src/guide_link.dart';
import 'package:wren/src/resolver.dart';

import 'harness.dart';

/// Stands in for StoreKit. Records what was asked of it so the tests can check
/// the app did not, for instance, charge someone twice.
class FakeStore implements UnlockStore {
  FakeStore({this.buySucceeds = true, this.restoreSucceeds = false});

  final bool buySucceeds;
  final bool restoreSucceeds;
  int buyCalls = 0;
  int restoreCalls = 0;

  @override
  Future<String?> price() async => r'$4.99';

  @override
  Future<bool> buy() async {
    buyCalls++;
    return buySucceeds;
  }

  @override
  Future<bool> restore() async {
    restoreCalls++;
    return restoreSucceeds;
  }
}

Pending place(int i) => Pending(
  'read $i',
  PlaceMatch(
    id: PlaceId.parse('I43FA2531C5B5D63${i.toRadixString(16)}'),
    name: 'Place $i',
    address: '$i Somewhere Street',
    category: 'Restaurant',
    metresFromCentre: 0,
  ),
);

Future<void> pump(WidgetTester tester, FakeStore store, int count) async {
  await tester.pumpWidget(
    app(
      CapturePage(
        store: store,
        initialPending: List.generate(count, place),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('three places publish without ever mentioning money', (
    tester,
  ) async {
    final store = FakeStore();
    await pump(tester, store, freePlaceLimit);

    expect(find.text('Make a guide (3)'), findsOneWidget);
    // No nag banner while the user is inside the free allowance.
    expect(find.textContaining('over the free limit'), findsNothing);
    expect(store.buyCalls, 0);
  });

  testWidgets('a fourth place warns before the user commits to anything', (
    tester,
  ) async {
    await pump(tester, FakeStore(), 4);
    // Told in the list view, not sprung on them at the end.
    expect(find.textContaining('over the free limit'), findsOneWidget);
  });

  testWidgets('publishing over the limit offers the unlock and a way past it', (
    tester,
  ) async {
    final store = FakeStore();
    await pump(tester, store, 5);

    await tester.tap(find.text('Make a guide (5)'));
    await tester.pumpAndSettle();

    expect(find.text('Guides of any size'), findsOneWidget);
    expect(find.textContaining(r'Unlock for $4.99'), findsOneWidget);
    // The escape hatch matters: a paywall with no way forward is the wrong trade.
    expect(find.textContaining('Save the first 3 instead'), findsOneWidget);
    expect(find.text('Restore a previous purchase'), findsOneWidget);

    // Merely opening the sheet must not charge anybody.
    expect(store.buyCalls, 0);
  });

  testWidgets('restore is reachable without walking into the paywall', (
    tester,
  ) async {
    // Apple requires a discoverable restore path, and someone who already paid
    // should not have to trip the paywall to find it.
    final store = FakeStore(restoreSucceeds: true);
    await pump(tester, store, 1);

    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Restore purchase'));
    await tester.pumpAndSettle();

    expect(store.restoreCalls, 1);
    expect(find.textContaining('Restored'), findsOneWidget);
  });

  testWidgets('a failed restore says so plainly and stays locked', (
    tester,
  ) async {
    final store = FakeStore(restoreSucceeds: false);
    await pump(tester, store, 4);

    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Restore purchase'));
    await tester.pumpAndSettle();

    expect(find.textContaining('No previous purchase found'), findsOneWidget);
    // Still gated — a failed restore must not quietly unlock anything.
    expect(find.textContaining('over the free limit'), findsOneWidget);
  });
}
