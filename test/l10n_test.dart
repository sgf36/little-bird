import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Checks every translation against the English template.
///
/// With fifty languages nobody reads them all, and the failures are quiet ones:
/// a dropped key falls back to English without a word, and a placeholder
/// renamed by a translator — `{count}` becoming `{anzahl}` — is a crash at
/// runtime in exactly one locale, which is the one nobody tests in.
void main() {
  final dir = Directory('lib/l10n');
  final template = jsonDecode(
    File('${dir.path}/app_en.arb').readAsStringSync(),
  );

  /// The translatable keys: everything not starting with @.
  Set<String> messages(Map<String, dynamic> arb) =>
      arb.keys.where((k) => !k.startsWith('@')).toSet();

  /// Placeholder names as they appear in the message itself, which is what
  /// matters — the generator reads the braces, not the metadata.
  Set<String> braces(String value) => RegExp(r'\{(\w+)')
      .allMatches(value)
      .map((m) => m.group(1)!)
      .toSet();

  final expected = messages(template);

  final translations = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.arb') && !f.path.endsWith('app_en.arb'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  test('the template itself describes every message', () {
    final undescribed = expected
        .where((k) => template['@$k'] == null)
        .toList();
    expect(
      undescribed,
      isEmpty,
      reason: 'a translator cannot do anything sensible with a bare string',
    );
  });

  for (final file in translations) {
    final locale = file.uri.pathSegments.last
        .replaceFirst('app_', '')
        .replaceFirst('.arb', '');

    group(locale, () {
      final arb =
          jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

      test('declares its own locale', () {
        expect(arb['@@locale'], locale.replaceAll('_', '-'));
      });

      test('translates every message and invents none', () {
        expect(messages(arb), expected);
      });

      test('keeps the placeholders the code passes in', () {
        for (final key in expected) {
          final mine = arb[key];
          if (mine is! String) continue;
          expect(
            braces(mine),
            braces(template[key] as String),
            reason: '$locale/$key changed the placeholder names',
          );
        }
      });

      test('leaves nothing in English that should have moved', () {
        // The app's own name is the deliberate exception: it is a bird, and it
        // stays "Wren" everywhere.
        final same = expected
            .where((k) => arb[k] == template[k])
            .where((k) => (template[k] as String).length > 24)
            .toList();
        expect(same, isEmpty, reason: 'untranslated strings in $locale');
      });
    });
  }
}
