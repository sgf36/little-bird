import 'package:flutter/material.dart';
import 'package:wren/l10n/app_localizations.dart';
import 'package:wren/src/theme.dart';

/// The app shell the tests run widgets inside.
///
/// It carries the localisation delegates because every screen now reads its
/// text through `L.of(context)`, and a MaterialApp without them throws the
/// moment a widget asks. Kept in one place so a new test cannot quietly build a
/// shell that differs from the real one.
Widget app(Widget home) => MaterialApp(
  theme: Wren.theme,
  localizationsDelegates: L.localizationsDelegates,
  supportedLocales: L.supportedLocales,
  home: home,
);
