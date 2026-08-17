import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/ocr.dart';

/// Ranking place names out of a real screenshot, from any app and any language.
///
/// The fixture is the frame a tester actually sent on 17 August 2026, which
/// failed completely and reported "Apple Maps is rate-limiting lookups — added 0
/// so far". Neither half of that was true. Three things were wrong:
///
///   * the furniture filter was a list of **Instagram** button labels, and this
///     was TikTok, which says "Add comment" where Instagram says "Add a
///     comment", and adds "Find related content", "See original" and "Book now";
///   * the place was chosen by size alone, and on TikTok the biggest text is the
///     caption sticker while the place is a small, truncated location label;
///   * MapKit's "no such place" was misread as throttling, which aborted the
///     whole import instead of marking one reading unmatched.
///
/// A longer word list would have fixed this screenshot and not the next one, in
/// another app or another language. So the tests below check the signals that
/// generalise: **where** text sits, and whether it **repeats** across a batch.
/// `midY` is 1 at the top of the frame and 0 at the bottom.
TextLine line(
  String text,
  double height, {
  double midX = 0.5,
  double midY = 0.5,
  double confidence = 0.9,
}) => TextLine(
  text: text,
  height: height,
  midX: midX,
  midY: midY,
  confidence: confidence,
);

/// The tester's TikTok frame, with the geometry it actually had.
List<TextLine> tiktok() => [
  line('2:09', 0.012, midY: 0.985, midX: 0.14), // status bar
  line('15m', 0.012, midY: 0.985, midX: 0.32),
  line('Find related content', 0.014, midY: 0.947), // search field
  line('Search', 0.014, midY: 0.947, midX: 0.9),
  line('The most stunning rooftop views', 0.026, midY: 0.335), // caption
  line('Good one to three.', 0.016, midY: 0.31),
  line('Bangkok, Thailand', 0.017, midY: 0.29),
  line('InterContinental Bangkok Su…', 0.013, midY: 0.265, midX: 0.3), // place
  line('Book now', 0.013, midY: 0.265, midX: 0.62),
  line('Luxury Tramps', 0.015, midY: 0.235),
  line('2025-8-20', 0.012, midY: 0.235, midX: 0.42),
  line(
    'A view like no other! Intercontinental Hotel Bangkok',
    0.014,
    midY: 0.205,
  ),
  line('#rooftopviews', 0.013, midY: 0.19),
  line('See original', 0.012, midY: 0.165),
  line('1,611', 0.012, midX: 0.93, midY: 0.46), // action rail
  line('14', 0.012, midX: 0.93, midY: 0.40),
  line('2,156', 0.012, midX: 0.93, midY: 0.335),
  line('909', 0.012, midX: 0.93, midY: 0.275),
  line('Add comment...', 0.014, midY: 0.03), // comment box
];

void main() {
  group('the screenshot that failed', () {
    test('the caption does not win, despite being the biggest text', () {
      // The regression in one line: size alone chose "The most stunning rooftop
      // views", which Apple Maps has never heard of.
      expect(
        likeliestPlace(tiktok())!.text,
        isNot('The most stunning rooftop views'),
      );
    });

    test('the truncated place is reachable within the three tried', () {
      final tried = placeCandidates(
        tiktok(),
      ).take(3).map((l) => l.text).join(' | ');
      expect(tried, contains('InterContinental Bangkok'));
    });

    test('counts, clocks and dates are dropped outright', () {
      final kept = stripChrome(tiktok()).map((l) => l.text);
      for (final junk in ['2:09', '15m', '1,611', '909', '2025-8-20']) {
        expect(kept, isNot(contains(junk)), reason: '$junk survived');
      }
    });

    test('handles and hashtags go, as they always did', () {
      expect(
        stripChrome(tiktok()).map((l) => l.text),
        isNot(contains('#rooftopviews')),
      );
    });
  });

  group('signals that hold in any app and any language', () {
    test('edge furniture ranks below content of the same size', () {
      // Identical text and size; only position differs. Nothing here is in any
      // word list, and nothing is in English by accident — this is the test that
      // has to keep working for apps nobody has thought of.
      final lines = [
        line('Bar Trigona', 0.02, midY: 0.5),
        line('Bar Trigona', 0.02, midY: 0.985), // status bar
        line('Bar Trigona', 0.02, midY: 0.02), // tab bar
        line('Bar Trigona', 0.02, midX: 0.95), // action rail
      ];
      final ranked = placeCandidates(lines);
      expect(
        ranked.first.midY,
        closeTo(0.5, 0.001),
        reason: 'the line in the content area must rank first',
      );
    });

    test('German furniture is demoted with no German in the code', () {
      // "Kommentar hinzufügen" appears in no word list anywhere in this app. It
      // loses because of where it sits, which is the entire point.
      final lines = [
        line('Kommentar hinzufügen', 0.02, midY: 0.03),
        line('Sonnenberg', 0.018, midY: 0.5),
      ];
      expect(placeCandidates(lines).first.text, 'Sonnenberg');
    });

    test('a line repeated across a batch is furniture, whatever it says', () {
      // Three screenshots from the same unknown app. The recurring line is
      // drawn by the app; the places are why the screenshots differ.
      final shots = [
        [line('コメントを追加', 0.02, midY: 0.5), line('Narisawa', 0.018)],
        [line('コメントを追加', 0.02, midY: 0.5), line('Den', 0.018)],
        [line('コメントを追加', 0.02, midY: 0.5), line('Florilège', 0.018)],
      ];
      final furniture = repeatedLines(shots);
      expect(furniture, contains('コメントを追加'));
      final ranked = placeCandidates(shots.first, repeated: furniture);
      expect(ranked.first.text, 'Narisawa');
    });

    test('two screenshots are too few to call anything repeated', () {
      // With two, a recurring line is as likely to be a place worth keeping.
      final shots = [
        [line('Padella', 0.02)],
        [line('Padella', 0.02)],
      ];
      expect(repeatedLines(shots), isEmpty);
    });

    test('a sentence ranks below a name in Latin, CJK and Arabic', () {
      for (final pair in [
        ('What a view.', 'Sky Bar'),
        ('景色が最高。', '成澤'),
        ('منظر رائع.', 'مقهى الرياض'),
      ]) {
        final ranked = placeCandidates([
          line(pair.$1, 0.024),
          line(pair.$2, 0.020),
        ]);
        expect(
          ranked.first.text,
          pair.$2,
          reason: '${pair.$1} outranked ${pair.$2}',
        );
      }
    });
  });

  test('Instagram furniture still goes, since that part worked', () {
    final insta = [
      line('Reels', 0.014, midY: 0.96),
      line('Add a comment', 0.014, midY: 0.04),
      line('View all 42 comments', 0.014, midY: 0.12),
      line('Original audio', 0.013, midY: 0.1),
      line('Dishoom Shoreditch', 0.024, midY: 0.5),
    ];
    expect(placeCandidates(insta).first.text, 'Dishoom Shoreditch');
  });
}
