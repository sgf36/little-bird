/// A way for App Review and the developer to reach the paid features without
/// paying, without giving ordinary users one.
///
/// Why it exists at all: App Review does not strictly need it, because
/// reviewers buy in-app purchases in Apple's sandbox where they are free. It is
/// insurance against sandbox flakiness — a purchase that fails during review
/// gets the build rejected — and it is how the developer tests a paid path on a
/// real device without buying the product repeatedly.
///
/// Why it is built like this:
///
///   - **The code is never in the repository.** It arrives at build time via
///     `--dart-define=WREN_REVIEW_CODE=…` from a CI secret. This repository is
///     public, so a hardcoded code would be a published one.
///   - **Absent by default.** With no code compiled in, [available] is false
///     and the entry point does not exist. A local build has no back door.
///   - **Not discoverable.** No button, no field on any screen. Reaching it
///     takes a long press on the title, which nobody does by accident.
///   - **Disclosed, not hidden.** It goes in the App Review notes. Guideline
///     3.1.1 objects to unlocking paid features by routes users can take
///     instead of buying; a documented review credential is ordinary practice,
///     and concealing it from Apple is what turns it into a problem.
library;

import 'package:shared_preferences/shared_preferences.dart';

const String _code = String.fromEnvironment('WREN_REVIEW_CODE');

/// Whether this build carries a review code at all.
bool get available => _code.isNotEmpty;

const _key = 'review_unlocked';

/// True when [entered] matches the code compiled into this build.
///
/// Comparison is length-independent and constant-ish rather than an early-exit
/// `==`, which is cheap insurance and costs nothing here.
bool matches(String entered) {
  if (!available) return false;
  final a = entered.trim();
  if (a.length != _code.length) return false;
  var diff = 0;
  for (var i = 0; i < a.length; i++) {
    diff |= a.codeUnitAt(i) ^ _code.codeUnitAt(i);
  }
  return diff == 0;
}

/// Kept separate from the purchase flag so a support question can always be
/// answered honestly: this is a review unlock, not a sale.
Future<void> remember() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_key, true);
}

Future<bool> wasUnlocked() async {
  if (!available) return false;
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_key) ?? false;
}
