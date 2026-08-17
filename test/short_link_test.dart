import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wren/main.dart';
import 'package:wren/src/guide_expand.dart';
import 'package:wren/src/guide_import.dart';
import 'package:wren/src/guide_link.dart';

import 'harness.dart';
import 'paywall_test.dart' show FakeStore;
import 'unresolved_test.dart' show FakeResolver, match;

/// The short link Apple's share sheet actually produces, and what the app does
/// with it.
///
/// This is the path that was broken on a real user's real guide: Wren told them
/// their link was not a guide link, because the decoder knew only about the
/// `?_col=` form this app writes and not the `guides?user=` form Apple redirects
/// to. Every case here exists so that cannot happen quietly again.
void main() {
  // Real bytes from a real 82-place guide, trimmed to the name and four places.
  const applePayload =
      'CgZMb25kb24SDgiuTRDL_OP_78aHmeABEg0Irk0QzoPcmOKCuuFfEg0Irk0QoPDVtIP'
      'A2rAJEg0Irk0Q45apuffSi7FE';
  const shortLink = 'https://maps.apple/ug/qai3oPE2QtpYfaNFg27D3C';
  const expanded = 'https://maps.apple.com/guides?user=$applePayload';

  Future<void> pump(WidgetTester tester, LinkExpander expander) async {
    await tester.pumpWidget(
      app(
        CapturePage(
          store: FakeStore(),
          resolver: FakeResolver([match('X', 'I43FA2531C5B5D635')]),
          expander: expander,
        ),
      ),
    );
    await tester.pump();
  }

  Future<void> paste(WidgetTester tester, String text) async {
    await tester.tap(find.widgetWithText(OutlinedButton, 'Add'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('From an existing guide'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), text);
    await tester.tap(find.text('Read guide'));
    await tester.pumpAndSettle();
  }

  testWidgets('a short link is expanded and its places imported', (
    tester,
  ) async {
    await pump(tester, StubLinkExpander(expanded));
    await paste(tester, shortLink);

    expect(find.textContaining('Read 4 places from that guide'), findsOne);
    expect(find.text('4 places already in this guide'), findsOne);
    expect(find.text('From “London”'), findsOne);
  });

  testWidgets('the expanded form works when pasted directly', (tester) async {
    // Someone who copies the URL out of a browser after the redirect gets this
    // form, and it must not need expanding.
    await pump(tester, StubLinkExpander(null));
    await paste(tester, expanded);

    expect(find.text('4 places already in this guide'), findsOne);
  });

  testWidgets('no network says so, and does not blame the link', (
    tester,
  ) async {
    // The distinction that matters: the link was fine, the connection was not.
    // Reporting "that is not a guide link" here sent a user hunting for a
    // different link that did not exist.
    await pump(tester, StubLinkExpander(null));
    await paste(tester, shortLink);

    expect(find.textContaining('Could not reach Apple'), findsOne);
    expect(find.textContaining('not an Apple Maps guide link'), findsNothing);
  });

  testWidgets('something that is not a link is still refused', (tester) async {
    await pump(tester, StubLinkExpander(expanded));
    await paste(tester, 'a note to self');

    expect(find.textContaining('not an Apple Maps guide link'), findsOne);
  });

  group('the expander refuses to fetch anything but Apple', () {
    test('an arbitrary host is rejected before any request', () async {
      // A pasted link decides what this app fetches, so the host is checked
      // first. Without this, pasting a link would make Wren a fetch-anything
      // tool for whoever wrote the link.
      await expectLater(
        HttpLinkExpander().expand('https://example.com/ug/abc'),
        throwsA(isA<LinkExpandFailed>()),
      );
    });

    test('a non-URL is rejected', () async {
      await expectLater(
        HttpLinkExpander().expand('not a url at all'),
        throwsA(isA<LinkExpandFailed>()),
      );
    });
  });

  group('a guide the size of a real one', () {
    test('82 places make one link, not two', () {
      final places = List.generate(
        82,
        (i) => GuidePlace(
          id: PlaceId.parse((BigInt.from(i + 1) << 40).toRadixString(16)),
          name: '',
        ),
      );
      final links = buildGuideLinks('London', places);
      expect(links, hasLength(1));
      // And every one of them survives the round trip, which is the property
      // that actually matters to someone with an 82-place guide.
      expect(importGuideLink(links.single).places, hasLength(82));
    });
  });
}
