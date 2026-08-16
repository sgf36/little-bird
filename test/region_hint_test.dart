import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/region_hint.dart';

/// The caption from the real batch that prompted this: eighteen screenshots
/// that all resolved badly because nothing told the lookup they were in London.
const realCaption =
    '18 must-visit places in London that feel like a '
    'different world';

void main() {
  group('candidatesIn', () {
    test('reads the city out of the caption that started all this', () {
      expect(candidatesIn(realCaption), contains('London'));
    });

    test('handles two-word and three-word cities', () {
      expect(
        candidatesIn('Best tacos in Mexico City'),
        contains('Mexico City'),
      );
      expect(
        candidatesIn('Hidden gems in New York City you have to see'),
        contains('New York City'),
      );
    });

    test('reads a possessive', () {
      expect(candidatesIn("Tokyo's best ramen"), contains('Tokyo'));
    });

    test('reads a labelled guide', () {
      expect(candidatesIn('Lisbon travel guide'), contains('Lisbon'));
    });

    test('handles accented names', () {
      expect(candidatesIn('Where to eat in Málaga'), contains('Málaga'));
    });

    test('ignores phrases that are not places', () {
      // "in the mood", "in a hurry" — capitalised only by sentence case.
      expect(candidatesIn('Order in The Best Way'), isEmpty);
      expect(candidatesIn('Save this for later'), isEmpty);
      expect(candidatesIn('Coming in August'), isEmpty);
    });
  });

  group('regionHint', () {
    test('picks the city repeated across a batch', () {
      final batch = List.filled(18, realCaption);
      expect(regionHint(batch), 'London');
    });

    test('a single stray mention in a large batch is not a hint', () {
      // One screenshot mentions Paris; the rest say nothing. Acting on that
      // would drag every lookup to the wrong country.
      final batch = <String>[
        ...List.filled(10, 'Dishoom Shoreditch'),
        'A photo taken in Paris',
      ];
      expect(regionHint(batch), isNull);
    });

    test('a single screenshot may still offer its own hint', () {
      expect(regionHint(['Best coffee in Copenhagen']), 'Copenhagen');
    });

    test('the most repeated city wins', () {
      final batch = <String>[
        'Great bars in Rome',
        'Where to eat in Rome',
        'Rooftops in Rome',
        'Once went to a place in Naples',
      ];
      expect(regionHint(batch), 'Rome');
    });

    test('does not adopt a place name as the region', () {
      // "Rome" here is the restaurant already picked out, not the city.
      final batch = List.filled(4, 'Rome, an Italian place in Manchester');
      expect(regionHint(batch, exclude: ['Rome']), 'Manchester');
    });

    test('prefers the longer name on a tie', () {
      final batch = <String>['Tacos in Mexico City', 'Bars in Mexico City'];
      expect(regionHint(batch), 'Mexico City');
    });

    test('returns null when there is nothing to go on', () {
      expect(regionHint(['Dishoom', 'Borough Market', '12.4K']), isNull);
      expect(regionHint(const []), isNull);
    });
  });
}
