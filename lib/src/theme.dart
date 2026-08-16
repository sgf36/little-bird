import 'package:flutter/material.dart';

/// Wren's palette, stated rather than generated.
///
/// `ColorScheme.fromSeed` produced the pale mint that made the first build look
/// like a default Flutter app. These are the same colours as the website, so
/// the app and the site are recognisably one thing.
abstract final class Wren {
  static const ground = Color(0xFF12332F); // page
  static const raised = Color(0xFF1E4B45); // cards, app bar
  static const line = Color(0xFF2C5B54); // hairlines
  static const gold = Color(0xFFF2C879); // the bird, primary actions
  static const clay = Color(0xFFE08A4B); // beak, warnings
  static const text = Color(0xFFEFEAE0);
  static const muted = Color(0xFF9FB5B0);
  static const danger = Color(0xFFE8776B);

  /// Dimmer than [muted], for placeholder text that must not be mistaken for
  /// something the user typed.
  static const placeholder = Color(0xFF6E8781);

  /// Serif for names and headings — the website uses Georgia, and iOS resolves
  /// it. The body face stays the system sans, which is what people read fastest.
  static const serif = 'Georgia';

  static ThemeData get theme {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: gold,
      onPrimary: ground,
      secondary: clay,
      onSecondary: ground,
      error: danger,
      onError: ground,
      surface: ground,
      onSurface: text,
      surfaceContainerHighest: raised,
      outline: line,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: ground,
      splashFactory: InkSparkle.splashFactory,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: serif,
          fontSize: 26,
          height: 1.15,
          color: text,
        ),
        titleMedium: TextStyle(
          fontFamily: serif,
          fontSize: 19,
          height: 1.25,
          color: text,
        ),
        bodyMedium: TextStyle(fontSize: 15.5, height: 1.45, color: text),
        bodySmall: TextStyle(fontSize: 13.5, height: 1.4, color: muted),
        labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: muted),
      ),
      checkboxTheme: CheckboxThemeData(
        side: const BorderSide(color: muted, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? gold : Colors.transparent,
        ),
        checkColor: const WidgetStatePropertyAll(ground),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: gold,
          foregroundColor: ground,
          disabledBackgroundColor: raised,
          disabledForegroundColor: muted,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: text,
          side: const BorderSide(color: line),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: raised,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: gold, width: 1.6),
        ),
        labelStyle: const TextStyle(color: muted),
        // Dimmer and italic, so an example is never mistaken for a value the
        // user has already entered.
        hintStyle: const TextStyle(
          color: placeholder,
          fontStyle: FontStyle.italic,
        ),
        counterStyle: const TextStyle(color: placeholder, fontSize: 11),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: raised,
        surfaceTintColor: Colors.transparent,
        dragHandleColor: muted,
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: raised,
        surfaceTintColor: Colors.transparent,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: raised,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
