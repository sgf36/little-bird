import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wren/l10n/app_localizations.dart';
import 'package:wren/main.dart';
import 'package:wren/src/theme.dart';

/// Builds the main screen once in every language the app claims to speak.
///
/// Two failures only appear when the app is actually rendered in a locale, and
/// both of them reach the user rather than CI: Flutter asserts if a locale is
/// listed as supported but `GlobalMaterialLocalizations` has no translation for
/// it, and a string long enough in one language will overflow a row that fits
/// in English. Neither shows up in a test that only ever builds in English.
void main() {
  for (final locale in L.supportedLocales) {
    testWidgets('renders in $locale', (tester) async {
      // Roomy enough that ordinary wrapping is not called an overflow, small
      // enough to still catch a genuinely unbounded row.
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          locale: locale,
          theme: Wren.theme,
          localizationsDelegates: L.localizationsDelegates,
          supportedLocales: L.supportedLocales,
          home: const CapturePage(),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
      // The empty state's headline, whatever it says in this language.
      final l = L.of(tester.element(find.byType(CapturePage)));
      expect(find.text(l.emptyTitle), findsOneWidget);
    });
  }
}
