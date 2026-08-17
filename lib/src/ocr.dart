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

/// A word list of app furniture — a cheap bonus signal, and **not** the
/// mechanism.
///
/// It cannot be the mechanism, for two reasons that no amount of additions
/// fixes. It is English, and the app ships in 47 languages: a German user's
/// screenshot says "Kommentar hinzufügen" and a Japanese one "コメントを追加". And
/// it is per-app, so every app anyone screenshots needs its own entries —
/// TikTok says "Add comment" where Instagram says "Add a comment", which is how
/// a tester's first photo failed completely.
///
/// The real work is done by [_furnitureScore] and [repeatedLines], which use
/// where text sits on the screen and whether it recurs across screenshots. Both
/// hold in any language and in apps nobody has thought of. This list just nudges
/// the obvious cases when the screenshot happens to be in English.
final _chrome = RegExp(
  r'^('
  r'reels?|follow(ing)?|liked by|view all( \d+)?( comments?)?|original audio|'
  r'send|share|add a comment|see translation|sponsored|paid partnership|'
  r'add comment|find related content|see original|see more|creator|'
  r'related searches|search|book now|shop now|learn more|watch now|'
  r'log in|sign up|for you|live|discover|profile|inbox|'
  r'add to|save|saved|comments?|likes?|views?|repost|download|copy link|'
  r'report|not interested|read more|show less|translate|subscribe'
  r')\b',
  caseSensitive: false,
);

/// A URL, which is furniture in any language.
final _url = RegExp(r'^(https?://|www\.)', caseSensitive: false);

/// How much a line looks like interface furniture rather than a place, judged on
/// where it sits rather than what it says.
///
/// Every social app puts its controls in the same places, because the hardware
/// dictates it: a status bar and a title or search field along the top, a
/// comment box and navigation along the bottom, and a column of action buttons
/// and counts down one side. The content — including the place anyone cares
/// about — sits in the middle. That is true of TikTok, Instagram, Threads,
/// YouTube Shorts, Pinterest, Reddit, X, a WhatsApp forward, a Safari page and
/// apps that do not exist yet, and it is true in every language.
double _furnitureScore(TextLine l) {
  var penalty = 0.0;
  // midY is 1 at the top of the frame and 0 at the bottom.
  if (l.midY > 0.94) penalty += 0.5; // status bar, clock, carrier
  if (l.midY > 0.88) penalty += 0.3; // search field, back button
  if (l.midY < 0.06) penalty += 0.5; // home indicator, tab bar
  if (l.midY < 0.12) penalty += 0.3; // comment box
  // The action rail: hearts, counts, share, down either edge.
  if (l.midX > 0.88 || l.midX < 0.06) penalty += 0.35;
  return penalty;
}

/// Lines that appear in most of a set of screenshots.
///
/// The strongest app-agnostic signal there is, and free: furniture repeats
/// because it is drawn by the app, and places do not, because they are why the
/// screenshots differ. "Add comment", "コメントを追加" and the name of a creator
/// somebody follows all fall out of this without being listed anywhere.
///
/// Only meaningful from three screenshots up — with two, a repeated line is as
/// likely to be a genuinely recurring place — so it returns empty below that.
Set<String> repeatedLines(
  List<List<TextLine>> perScreenshot, {
  double threshold = 0.6,
}) {
  if (perScreenshot.length < 3) return const {};
  final counts = <String, int>{};
  for (final shot in perScreenshot) {
    for (final text in {for (final l in shot) l.text.trim().toLowerCase()}) {
      counts[text] = (counts[text] ?? 0) + 1;
    }
  }
  final needed = perScreenshot.length * threshold;
  return {
    for (final e in counts.entries)
      if (e.value >= needed) e.key,
  };
}

/// A count, a timestamp, a date, or a duration — never a place.
///
/// The old form only caught bare counts like `1,611`, so TikTok's `2025-8-20`
/// and the `15m` call timer both survived as searchable "places".
final _countLike = RegExp(
  r'^('
  r'[\d.,]+\s*[kKmMbB]?|' // 909, 2,156, 1.2k
  r'\d{1,2}:\d{2}(:\d{2})?|' // 2:09
  r'\d+\s*[smhdwy]|' // 15m, 3d
  r'\d{4}-\d{1,2}-\d{1,2}|' // 2025-8-20
  r'\d{1,2}/\d{1,2}(/\d{2,4})?' // 8/20
  r')$',
  caseSensitive: false,
);

/// Trailing truncation, which social apps apply to the very label worth reading.
///
/// TikTok showed the place as "InterContinental Bangkok Su…". Searching that
/// verbatim is better than not searching it, and MapKit matches the prefix, so
/// the marker is stripped rather than the line dropped.
final _truncated = RegExp(r'\s*(…|\.\.\.)\s*$');

/// Prose rather than a name, ending in a sentence's punctuation.
///
/// The terminators cover Latin, CJK and Arabic scripts, so this is not an
/// English-only test. "Good one to three." and "A view like no other!" are
/// captions; they rank below anything that reads like a name but are not
/// rejected, because occasionally a caption is the only mention of a place.
final _sentenceLike = RegExp(r'[.!?。！？؟]\s*$');

/// An English sentence opening, which a place name almost never has.
///
/// The same class of signal as [_chrome]: English-only, therefore a nudge rather
/// than a mechanism. It exists because the caption that beat the place on the
/// reported screenshot carried no full stop for [_sentenceLike] to catch —
/// "The most stunning rooftop views".
final _captionStart = RegExp(
  r'^(the|a|an|this|that|these|those|my|our|his|her|their|your|its|'
  r'best|top|most|when|where|how|why|what|if|you|we|i)\s',
  caseSensitive: false,
);

/// Drops the lines that are obviously not a place: handles, hashtags, counts,
/// UI labels and single characters.
///
/// This is deliberately conservative — it removes what is certainly noise and
/// leaves the judgement about what IS a place to the caller. Over-filtering
/// here would silently lose places, which is the expensive direction to err.
/// Removes only what cannot be a place under any circumstances.
///
/// Deliberately narrow. Everything judgemental — position, prose, word lists —
/// is scoring in [placeCandidates] rather than deletion here, because deleting
/// the wrong line loses a place silently and demoting it merely costs a search.
List<TextLine> stripChrome(List<TextLine> lines) => lines.where((l) {
  final t = l.text.replaceAll(_truncated, '').trim();
  // Two, not three. 成澤 (Narisawa) is a two-character restaurant name, and a
  // three-character minimum silently deletes a whole class of Japanese and
  // Chinese places — which a test caught only because it was written in the
  // script rather than about it.
  if (t.length < 2) return false;
  if (t.startsWith('@') || t.startsWith('#')) return false;
  if (_countLike.hasMatch(t)) return false;
  if (_url.hasMatch(t)) return false;
  // No letter in any script: a count, a clock, a row of icons read as symbols.
  if (!RegExp(r'\p{L}', unicode: true).hasMatch(t)) return false;
  return true;
}).toList();

/// Every line that might name a place, best first.
///
/// Size alone decided this before, which is why a tester's TikTok screenshot
/// resolved nothing: the biggest text was the caption sticker "The most stunning
/// rooftop views", and the actual place sat in a small truncated label. Size
/// still counts — a place name usually is prominent — but prose is ranked below
/// anything that reads like a name, so the caption loses to the label.
///
/// Returned as a ranked list rather than one guess so that a miss can fall
/// through to the next candidate instead of costing the screenshot entirely.
List<TextLine> placeCandidates(
  List<TextLine> lines, {

  /// Lines seen across the other screenshots in the same batch, from
  /// [repeatedLines]. Anything in here is furniture in whatever language and
  /// whatever app the screenshot came from.
  Set<String> repeated = const {},
}) {
  final kept = stripChrome(lines);
  if (kept.isEmpty) return const [];
  final tallest = kept.map((l) => l.height).reduce((a, b) => a > b ? a : b);

  double score(TextLine l) {
    final t = l.text.replaceAll(_truncated, '').trim();
    // Prominence, which is a real signal: a place is usually drawn large.
    var s = tallest == 0 ? 0.0 : l.height / tallest;
    // Where it sits, which is a better one and holds in any language.
    s -= _furnitureScore(l);
    if (repeated.contains(t.toLowerCase())) s -= 1.0;
    if (_sentenceLike.hasMatch(t)) s -= 0.5;
    // Long strings are captions, in any script. CJK has no spaces, so length
    // does the work there where word count cannot.
    final words = t.split(RegExp(r'\s+')).length;
    if (words > 4 || t.length > 40) s -= 0.3;
    // An English caption that carries no full stop — "The most stunning rooftop
    // views", which is exactly what beat the place on the reported screenshot.
    // A nudge in the same class as the word list: English-only, so it can only
    // help English screenshots and never penalises any other language.
    if (_captionStart.hasMatch(t)) s -= 0.4;
    // A capital inside the string reads like a name — "InterContinental
    // Bangkok", "Wright Brothers". Absent from most scripts, so it only ever
    // adds, never penalises.
    if (t.length > 1 &&
        RegExp(r'\p{Lu}', unicode: true).hasMatch(t.substring(1))) {
      s += 0.2;
    }
    // The English word list, worth a nudge and no more.
    if (_chrome.hasMatch(t)) s -= 0.8;
    // Vision's own confidence, which drops on stylised and overlaid type.
    s += (l.confidence - 0.5) * 0.2;
    return s;
  }

  final scored = [for (final l in kept) (line: l, s: score(l))]
    ..sort((a, b) => b.s.compareTo(a.s));
  return [for (final e in scored) e.line];
}

/// Best guess at the place name, or null if nothing survived the filter.
///
/// A thin wrapper over [placeCandidates] — kept because most callers want one
/// answer, and because the confirmation screen is what actually decides.
TextLine? likeliestPlace(List<TextLine> lines) {
  final candidates = placeCandidates(lines);
  return candidates.isEmpty ? null : candidates.first;
}
