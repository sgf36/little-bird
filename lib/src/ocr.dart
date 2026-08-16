import 'package:flutter/services.dart';

/// One line of text Vision found, with the geometry that makes it possible to
/// guess which line matters.
class TextLine {
  final String text;
  final double confidence;

  /// Normalised glyph height — a proxy for type size, and the single most
  /// useful signal for separating a place name from interface furniture.
  final double height;

  /// Normalised centre. [midY] is 0 at the bottom of the frame, 1 at the top.
  final double midX;
  final double midY;

  const TextLine({
    required this.text,
    required this.confidence,
    required this.height,
    required this.midX,
    required this.midY,
  });

  factory TextLine.fromMap(Map<Object?, Object?> m) => TextLine(
    text: m['text'] as String? ?? '',
    confidence: (m['confidence'] as num?)?.toDouble() ?? 0,
    height: (m['height'] as num?)?.toDouble() ?? 0,
    midX: (m['midX'] as num?)?.toDouble() ?? 0,
    midY: (m['midY'] as num?)?.toDouble() ?? 0,
  );

  @override
  String toString() => '"$text" (h=${height.toStringAsFixed(3)})';
}

class OcrUnavailable implements Exception {
  final String message;

  /// True when there is no Vision framework at all, rather than a failure
  /// inside it. The UI replaces the message with a translated one; a message
  /// that came back from the OS is shown as the OS worded it.
  final bool unsupported;

  OcrUnavailable(this.message, {this.unsupported = false});
  @override
  String toString() => 'OcrUnavailable: $message';
}

class Ocr {
  static const _channel = MethodChannel('littlebird/ocr');

  /// Runs Apple's Vision over an image file. Returns lines ordered largest
  /// type first. iOS only — there is no Windows or Android implementation
  /// behind this channel yet.
  static Future<List<TextLine>> recognise(String path) async {
    try {
      final raw = await _channel.invokeMethod<List<Object?>>('recognise', {
        'path': path,
      });
      if (raw == null) return const [];
      return raw
          .whereType<Map<Object?, Object?>>()
          .map(TextLine.fromMap)
          .toList();
    } on MissingPluginException {
      throw OcrUnavailable(
        'no OCR on this platform — run on an iOS device or simulator',
        unsupported: true,
      );
    } on PlatformException catch (e) {
      throw OcrUnavailable(e.message ?? e.code);
    }
  }
}

/// Instagram furniture that turns up in almost every screenshot. Filtering it
/// is cheap and removes most of the noise before anything smarter runs.
final _chrome = RegExp(
  r'^(reels?|follow|following|liked by|view all|original audio|send|share|'
  r'add a comment|see translation|sponsored|paid partnership)\b',
  caseSensitive: false,
);

final _countLike = RegExp(r'^[\d.,]+\s*[kKmM]?$');

/// Drops the lines that are obviously not a place: handles, hashtags, counts,
/// UI labels and single characters.
///
/// This is deliberately conservative — it removes what is certainly noise and
/// leaves the judgement about what IS a place to the caller. Over-filtering
/// here would silently lose places, which is the expensive direction to err.
List<TextLine> stripChrome(List<TextLine> lines) => lines.where((l) {
  final t = l.text.trim();
  if (t.length < 2) return false;
  if (t.startsWith('@') || t.startsWith('#')) return false;
  if (_countLike.hasMatch(t)) return false;
  if (_chrome.hasMatch(t)) return false;
  return true;
}).toList();

/// Best guess at the place name: the largest surviving line.
///
/// Correct on every synthetic test frame, but those frames were authored with
/// the name as the biggest text, so treat this as a starting hypothesis to be
/// confirmed by the user rather than an answer.
TextLine? likeliestPlace(List<TextLine> lines) {
  final candidates = stripChrome(lines);
  if (candidates.isEmpty) return null;
  return candidates.reduce((a, b) => a.height >= b.height ? a : b);
}
