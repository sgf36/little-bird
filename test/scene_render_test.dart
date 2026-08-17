import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wren/l10n/app_localizations.dart';
import 'package:wren/main.dart';
import 'package:wren/src/screenshots.dart';

/// Renders every store-screenshot scene in every language the screenshots are
/// taken in.
///
/// This is the check the old process could not have: screenshots were taken by
/// hand in English, so a German dialog that overflows its box, or a scene that
/// silently renders as nothing, would have reached the store page and stayed
/// there. `takeException` catches a RenderFlex overflow, which is the failure
/// these scenes are actually prone to — a fixed-height dialog holding a
/// sentence that is half again as long in Finnish.
///
/// Fonts are not loaded in a widget test, so this proves layout and not glyphs.
/// Whether Devanagari renders is the simulator's business, and the simulator has
/// the fonts.
void main() {
  // The ten languages with the most speakers worldwide, as App Store Connect
  // locales: en-GB, zh-Hans, hi, es-ES, fr-FR, ar-SA, bn-BD, pt-BR, ru, id.
  const shot = [
    Locale('en'),
    Locale('zh'),
    Locale('hi'),
    Locale('es'),
    Locale('fr'),
    Locale('ar'),
    Locale('bn'),
    Locale('pt'),
    Locale('ru'),
    Locale('id'),
    // Not shot, but included because they are the longest-string languages in
    // the set and so the ones a dialog overflows in first.
    Locale('de'),
    Locale('fi'),
  ];

  for (final name in sceneNames) {
    for (final locale in shot) {
      testWidgets('$name renders in ${locale.languageCode}', (tester) async {
        // A 6.7-inch iPhone: 1290x2796 physical, which is what the App Store
        // slot wants and what the simulator in shoot.sh is chosen to match.
        tester.view.physicalSize = const Size(1290, 2796);
        tester.view.devicePixelRatio = 3.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final scene = sceneFor(name);
        expect(scene, isNotNull, reason: 'no scene built for $name');

        await tester.pumpWidget(
          MaterialApp(
            locale: locale,
            localizationsDelegates: L.localizationsDelegates,
            supportedLocales: L.supportedLocales,
            home: scene,
          ),
        );
        // Long enough for the post-frame overlay to open and animate in.
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        expect(tester.takeException(), isNull);
        // The specific failure worth designing against: a run that photographs
        // six identical placeholder screens and reports success.
        expect(find.byType(UnknownScene), findsNothing);
      });
    }
  }

  testWidgets('an unknown scene is loud rather than blank', (tester) async {
    expect(sceneFor('nope'), isNull);
    await tester.pumpWidget(const WrenApp(home: UnknownScene('nope')));
    await tester.pump();
    expect(find.textContaining('no scene called'), findsOne);
  });
}
