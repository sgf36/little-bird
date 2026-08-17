import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/ocr.dart';

TextLine line(String text, double height) =>
    TextLine(text: text, confidence: 1, height: height, midX: .5, midY: .5);

/// Roughly what Vision returns for one reel screenshot: nine lines, of which
/// one is the place. Heights are taken from the measured fixtures — the place
/// name is set in much larger type than the interface furniture around it.
final _typicalFrame = [
  line('Otaleg Trastevere', 0.042),
  line('5 places you HAVE to eat at in Rome', 0.016),
  line('@romefoodguide', 0.015),
  line('#rome #romefood #italy #pasta #travelreels', 0.014),
  line('original audio · romefoodguide', 0.013),
  line('Reels', 0.019),
  line('12.4K', 0.012),
  line('318', 0.012),
  line('1,204', 0.012),
];

void main() {
  group('stripChrome', () {
    test('drops handles, hashtags and counts', () {
      final kept = stripChrome(_typicalFrame).map((l) => l.text).toList();
      expect(kept, contains('Otaleg Trastevere'));
      expect(kept, isNot(contains('@romefoodguide')));
      expect(
        kept,
        isNot(contains('#rome #romefood #italy #pasta #travelreels')),
      );
      expect(kept, isNot(contains('12.4K')));
      expect(kept, isNot(contains('1,204')));
    });

    test('keeps interface labels, and leaves them to the ranking', () {
      // A deliberate change of contract, made on 17 August 2026. This used to
      // delete anything matching a list of English interface labels, and that
      // list was the whole mechanism — so a TikTok screenshot, whose labels
      // differ, walked straight through it, and a screenshot in German or
      // Japanese always would.
      //
      // Deleting the wrong line loses a place silently; demoting it costs one
      // search. So the word list is now a scoring nudge and the real work is
      // done by position and by repetition across a batch, which hold in any
      // language. "Reels" survives here and loses in placeCandidates.
      final kept = stripChrome(_typicalFrame).map((l) => l.text).toList();
      expect(kept, contains('Reels'));
      expect(placeCandidates(_typicalFrame).first.text, 'Otaleg Trastevere');
      final ranked = placeCandidates(_typicalFrame).map((l) => l.text).toList();
      expect(
        ranked.indexOf('Otaleg Trastevere'),
        lessThan(ranked.indexOf('Reels')),
        reason: 'the place must be tried before the interface label',
      );
    });

    test('keeps a caption, because captions sometimes name the place', () {
      // Over-filtering loses places silently, which is the expensive direction
      // to err. The caption survives and the ranking sorts it out.
      final kept = stripChrome(_typicalFrame).map((l) => l.text).toList();
      expect(kept, contains('5 places you HAVE to eat at in Rome'));
    });

    test('drops stray single characters', () {
      expect(stripChrome([line('x', 0.05)]), isEmpty);
    });
  });

  group('likeliestPlace', () {
    test('picks the largest non-chrome line', () {
      expect(likeliestPlace(_typicalFrame)?.text, 'Otaleg Trastevere');
    });

    test('is not fooled by chrome that happens to be large', () {
      // "Reels" sits top-left in reasonably big type on every frame.
      final frame = [line('Reels', 0.09), line('Bonci Pizzarium', 0.04)];
      expect(likeliestPlace(frame)?.text, 'Bonci Pizzarium');
    });

    test('returns null rather than guessing when nothing survives', () {
      final frame = [line('@someone', 0.05), line('318', 0.04)];
      expect(likeliestPlace(frame), isNull);
    });

    test('handles an empty read', () {
      expect(likeliestPlace([]), isNull);
    });
  });
}
