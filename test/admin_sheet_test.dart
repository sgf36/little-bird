import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wren/l10n/app_localizations.dart';
import 'package:wren/main.dart';
import 'package:wren/src/admin_codes.dart';
import 'package:wren/src/admin_sheet.dart';
import 'package:wren/src/comp_unlock.dart';

import 'harness.dart';

/// The console, and the door it is behind.
///
/// Two separate claims, and the first is the one that matters most. A device
/// without an admin code must find nothing — not a locked control, not a
/// greyed-out row, not a second dialog asking for a password. The long press
/// that has always opened the code box must go on opening the code box.
///
/// The other direction cannot be pumped here: reaching the console requires a
/// token signed by the Worker's private key, which is the point of it and is
/// not in this repository. So the gate is proved shut here, proved to open only
/// for a valid signature in `comp_unlock_test.dart`, and the console itself is
/// exercised directly below with the network injected.
void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  /// A Worker that answers reading and writing separately, as the real one
  /// does — the console lists after every change, so a stub that returns one
  /// shape to both would fail the reload rather than the thing under test.
  AdminCodes codesReplying(
    int status,
    String body, {
    String? onWrite,
    List<String>? calls,
  }) => AdminCodes(
    'tok',
    transport: (method, url, headers, requestBody) async {
      calls?.add('$method ${url.path} $requestBody');
      return method == 'GET' || onWrite == null
          ? (status: status, body: body)
          : (status: 200, body: onWrite);
    },
  );

  const listing =
      '{"codes":[{"code":"AAAA-BBBB-CCCC-DDDD","note":"App Review",'
      '"role":"unlock","uses":3,"maxUses":500,"revoked":false,"spent":false},'
      '{"code":"EEEE-FFFF-GGGG-HHHH","note":"me","role":"admin","uses":1,'
      '"maxUses":1,"revoked":false,"spent":true}]}';

  group('the door', () {
    testWidgets('a device with no code finds the code box, not the console', (
      tester,
    ) async {
      await tester.pumpWidget(app(const CapturePage()));
      await tester.pumpAndSettle();

      await tester.longPress(find.text('Wren'));
      await tester.pumpAndSettle();

      final l = await L.delegate.load(const Locale('en'));
      expect(find.text(l.compAccess), findsOneWidget);
      expect(find.text('Codes'), findsNothing);
      expect(find.text('New code'), findsNothing);
    });

    testWidgets('nothing on the ordinary screen mentions issuing codes', (
      tester,
    ) async {
      await tester.pumpWidget(app(const CapturePage()));
      await tester.pumpAndSettle();

      // Including behind the menu, which is where a hidden feature usually
      // stops being hidden.
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      for (final word in ['Codes', 'Admin', 'New code', 'Withdraw']) {
        expect(find.text(word), findsNothing, reason: '"$word" is on screen');
      }
    });
  });

  group('the console', () {
    testWidgets('lists what has been issued, and badges only administrators', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(AdminSheet(codes: codesReplying(200, listing))),
      );
      await tester.pumpAndSettle();

      expect(find.text('AAAA-BBBB-CCCC-DDDD'), findsOneWidget);
      expect(find.text('EEEE-FFFF-GGGG-HHHH'), findsOneWidget);
      expect(find.text('ADMIN'), findsOneWidget);
      expect(find.text('3 of 500 used · App Review'), findsOneWidget);
      expect(find.text('Spent · me'), findsOneWidget);
    });

    testWidgets('withdrawing asks first, and says what it will not undo', (
      tester,
    ) async {
      final calls = <String>[];
      await tester.pumpWidget(
        app(AdminSheet(codes: codesReplying(200, listing, calls: calls))),
      );
      await tester.pumpAndSettle();
      calls.clear();

      await tester.tap(find.byIcon(Icons.block).first);
      await tester.pumpAndSettle();

      expect(find.text('Withdraw this code?'), findsOneWidget);
      expect(find.textContaining('keeps their access'), findsOneWidget);

      // Cancelling has to reach nothing at all.
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(calls, isEmpty);

      await tester.tap(find.byIcon(Icons.block).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Withdraw'));
      await tester.pumpAndSettle();
      expect(calls.first, startsWith('POST /admin/revoke'));
      expect(calls.first, contains('AAAA-BBBB-CCCC-DDDD'));
    });

    testWidgets(
      'issuing shows the codes, because this is the only sight of them',
      (tester) async {
        final calls = <String>[];
        await tester.pumpWidget(
          app(
            AdminSheet(
              codes: codesReplying(
                200,
                listing,
                onWrite: '{"codes":["JJJJ-KKKK-MMMM-NNNN"]}',
                calls: calls,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
        expect(find.text('Unlocks the app. Nothing else.'), findsOneWidget);

        // An admin code says plainly what it hands over before it is issued.
        await tester.tap(find.text('Admin'));
        await tester.pumpAndSettle();
        expect(find.textContaining('issue codes of their own'), findsOneWidget);

        await tester.tap(find.text('Create'));
        // Twice: the first settles the dialog closing, and only then does the
        // request that follows it resolve and schedule the frame that shows what
        // came back.
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();

        expect(calls.any((c) => c.contains('"role":"admin"')), isTrue);
        expect(find.text('Code issued'), findsOneWidget);
        expect(find.text('JJJJ-KKKK-MMMM-NNNN'), findsOneWidget);
      },
    );

    testWidgets('a withdrawn administrator is told, not left staring', (
      tester,
    ) async {
      // The console is authorised per request, so this is what somebody whose
      // own code was withdrawn sees the next time they open it.
      await tester.pumpWidget(
        app(AdminSheet(codes: codesReplying(403, '{"error":"forbidden"}'))),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('This device is no longer permitted to issue codes.'),
        findsOneWidget,
      );
    });
  });

  group('CompRole', () {
    test('is the only thing that opens the console', () {
      // Guards the enum itself: a third granting role added without a decision
      // about the console would otherwise be silently admitted or silently
      // refused, depending on how the switch was written.
      expect(CompRole.values, [CompRole.none, CompRole.unlock, CompRole.admin]);
    });
  });
}
