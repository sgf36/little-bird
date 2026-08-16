/// Working out *where* a batch of screenshots is talking about.
///
/// A reel caption almost always says it — "18 must-visit places in London that
/// feel like…" — and without that context a place name alone resolves badly:
/// a bare "Fuunji" once returned a city 114 km away, and half the world has a
/// restaurant called Arabica. The caption is right there in the OCR output;
/// it was simply being thrown away.
///
/// Deliberately conservative. A wrong hint is worse than none, because it drags
/// every lookup toward the wrong city, so a candidate has to appear in a
/// recognisable phrase and win on frequency across the batch.
library;

/// Words that follow "in" but never name a place.
const _stop = {
  'a',
  'an',
  'the',
  'this',
  'that',
  'these',
  'those',
  'my',
  'your',
  'our',
  'their',
  'his',
  'her',
  'its',
  'one',
  'two',
  'three',
  'under',
  'over',
  'just',
  'only',
  'real',
  'true',
  'love',
  'fact',
  'case',
  'order',
  'time',
  'town',
  'city',
  'europe',
  'asia',
  'africa',
  'america',
  'general',
  'january',
  'february',
  'march',
  'april',
  'may',
  'june',
  'july',
  'august',
  'september',
  'october',
  'november',
  'december',
  'monday',
  'tuesday',
  'wednesday',
  'thursday',
  'friday',
  'saturday',
  'sunday',
  'reels',
  'follow',
  'following',
  'instagram',
  'tiktok',
  'part',
  'no',
};

/// "…places in London that feel…" → London
/// "…to eat at in Mexico City" → Mexico City
final _inPhrase = RegExp(
  r'\bin\s+([A-Z][A-Za-zÀ-ɏ'
  "'"
  r'’-]+(?:\s+[A-Z][A-Za-zÀ-ɏ'
  "'"
  r'’-]+){0,2})',
);

/// "Tokyo's best ramen" → Tokyo
final _possessive = RegExp(
  r'\b([A-Z][A-Za-zÀ-ɏ-]+(?:\s+[A-Z][A-Za-zÀ-ɏ-]+){0,2})['
  "'"
  r'’]s\b',
);

/// "London guide", "Rome itinerary"
///
/// Case-sensitive on purpose: matching case-insensitively let the capture group
/// swallow the label itself, so "Lisbon travel guide" yielded "Lisbon travel".
final _labelled = RegExp(
  r'\b([A-Z][A-Za-zÀ-ɏ-]+(?:\s+[A-Z][A-Za-zÀ-ɏ-]+){0,2})\s+'
  r'(?:[Tt]ravel\s+)?(?:[Gg]uide|[Ii]tinerary|[Bb]ucket\s?[Ll]ist)\b',
);

bool _plausible(String candidate) {
  final trimmed = candidate.trim();
  if (trimmed.length < 3) return false;
  final words = trimmed.split(RegExp(r'\s+'));
  if (words.length > 3) return false;
  // Every word being a stopword means it is a phrase, not a place.
  return !words.every((w) => _stop.contains(w.toLowerCase())) &&
      !_stop.contains(words.first.toLowerCase());
}

/// Candidate place-context phrases found in one piece of text.
Iterable<String> candidatesIn(String text) sync* {
  for (final re in [_inPhrase, _possessive, _labelled]) {
    for (final m in re.allMatches(text)) {
      final c = m.group(1)?.trim();
      if (c != null && _plausible(c)) yield c;
    }
  }
}

/// The likeliest region for a whole batch.
///
/// Frequency across screenshots is the signal that matters: a reel's caption
/// repeats on every frame, so the real city appears many times while a stray
/// capitalised word appears once. [exclude] holds the names already chosen as
/// places, so a restaurant called "Rome" in the title does not become the
/// region.
String? regionHint(
  Iterable<String> texts, {
  Iterable<String> exclude = const [],
}) {
  final skip = exclude.map((e) => e.trim().toLowerCase()).toSet();
  final counts = <String, int>{};
  final display = <String, String>{};

  for (final text in texts) {
    // Count each candidate once per screenshot, so one chatty caption cannot
    // outvote the other seventeen.
    final seen = <String>{};
    for (final c in candidatesIn(text)) {
      final key = c.toLowerCase();
      if (skip.contains(key) || !seen.add(key)) continue;
      counts[key] = (counts[key] ?? 0) + 1;
      display.putIfAbsent(key, () => c);
    }
  }

  if (counts.isEmpty) return null;

  final best = counts.entries.reduce((a, b) {
    if (a.value != b.value) return a.value > b.value ? a : b;
    // Tie: prefer the longer name, so "Mexico City" beats "Mexico".
    return a.key.length >= b.key.length ? a : b;
  });

  // A single mention across a whole batch is a coincidence, not a hint —
  // unless the batch itself is a single screenshot.
  final total = texts.length;
  if (total > 2 && best.value < 2) return null;

  return display[best.key];
}
