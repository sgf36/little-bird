import 'package:flutter_test/flutter_test.dart';
import 'package:reel_places/src/ocr.dart';

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
    test('drops handles, hashtags, counts and UI labels', () {
      final kept = stripChrome(_typicalFrame).map((l) => l.text).toList();
      expect(kept, contains('Otaleg Trastevere'));
      expect(kept, isNot(contains('@romefoodguide')));
      expect(
        kept,
        isNot(contains('#rome #romefood #italy #pasta #travelreels')),
      );
      expect(kept, isNot(contains('12.4K')));
      expect(kept, isNot(contains('1,204')));
      expect(kept, isNot(contains('Reels')));
      expect(kept, isNot(contains('original audio · romefoodguide')));
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
