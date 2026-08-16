import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wren/main.dart';
import 'package:wren/src/splash.dart';
import 'package:wren/src/wren_mark.dart';

import 'harness.dart';

void main() {
  group('empty state', () {
    testWidgets('opens with nothing to publish', (tester) async {
      await tester.pumpWidget(app(const CapturePage()));
      await tester.pump();

      expect(
        find.textContaining('Screenshot what people tell you about'),
        findsOneWidget,
      );
      expect(find.text('Add screenshots'), findsOneWidget);

      final publish = tester.widget<FilledButton>(
        find.ancestor(
          of: find.text('Make a guide (0)'),
          matching: find.byType(FilledButton),
        ),
      );
      expect(publish.onPressed, isNull);
    });

    testWidgets('warns that guides cannot be merged', (tester) async {
      // The user has to understand this before publishing, not after they end
      // up with four guides called the same thing.
      await tester.pumpWidget(app(const CapturePage()));
      await tester.pump();
      expect(find.textContaining('cannot merge guides'), findsOneWidget);
    });

    testWidgets('shows the bird rather than a stock icon', (tester) async {
      await tester.pumpWidget(app(const CapturePage()));
      await tester.pump();
      expect(find.byType(WrenMark), findsWidgets);
    });
  });

  group('splash', () {
    testWidgets('plays, then hands over to the app', (tester) async {
      await tester.pumpWidget(app(const SplashGate(child: Text('the app'))));

      // Present during the sequence, gone once it finishes.
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Wren'), findsOneWidget);
      expect(find.text('the app'), findsNothing);

      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(find.text('the app'), findsOneWidget);
    });

    testWidgets('can be tapped away', (tester) async {
      // A launch flourish should never be something to sit through twice.
      await tester.pumpWidget(app(const SplashGate(child: Text('the app'))));
      await tester.pump(const Duration(milliseconds: 150));
      await tester.tap(find.byType(SplashGate));
      await tester.pump();
      expect(find.text('the app'), findsOneWidget);
    });
  });
}
