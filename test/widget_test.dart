import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_bird/main.dart';

void main() {
  testWidgets('opens on the empty state with publishing disabled', (
    tester,
  ) async {
    await tester.pumpWidget(const LittleBirdApp());

    expect(find.textContaining('Screenshot the places'), findsOneWidget);
    expect(find.text('Add screenshots'), findsOneWidget);

    // Nothing confirmed yet, so there is nothing to publish.
    final publish = tester.widget<FilledButton>(
      find.ancestor(
        of: find.text('Make a guide (0)'),
        matching: find.byType(FilledButton),
      ),
    );
    expect(publish.onPressed, isNull);
  });

  testWidgets('warns that guides cannot be merged', (tester) async {
    // The user has to understand this before they publish, not after they end
    // up with four guides called the same thing.
    await tester.pumpWidget(const LittleBirdApp());
    expect(find.textContaining('cannot merge guides'), findsOneWidget);
  });
}
