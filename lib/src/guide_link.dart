/// Builds Apple Maps guide links.
///
/// A whole guide encodes into one URL as a base64 protocol buffer. The schema is
/// reverse-engineered and undocumented, but the behaviour is verified on device:
///
///   Collection { string name = 1; repeated Location location = 2; }
///   Location   { int32 lsp = 1; uint64 appleMapsId = 2; string address = 3;
///                Coordinates coordinates = 4; string name = 5; }
///
/// Two rules, both learned the hard way:
///
///  1. Every place MUST carry an Apple place ID. A payload describing places by
///     coordinate renders perfectly on maps.apple.com and opens with ZERO places
///     in the Maps app. Browser testing gives a false pass.
///  2. The limit is the URL's length, not a count of places. Past roughly 8,000
///     characters the server returns HTTP 200 with an empty guide — it fails
///     silently, so callers must verify rather than trust the status code. A
///     previous version of this file capped links at 50 places, which was
///     measuring the cost of encoding a name with each one rather than any limit
///     on guide size; see [_encodeLocation].
library;

/// An Apple place identifier, as returned by MapKit's `MKMapItem.identifier`
/// or the Maps Server API: the letter `I` followed by 16 hex digits.
///
/// The hex is a uint64 that exceeds Dart's signed int range, so it is carried
/// as a [BigInt] rather than an int.
class PlaceId {
  final BigInt value;

  const PlaceId._(this.value);

  /// Parses `I43FA2531C5B5D635`. The leading `I` is optional.
  factory PlaceId.parse(String raw) {
    final hex = raw.startsWith('I') || raw.startsWith('i')
        ? raw.substring(1)
        : raw;
    final parsed = BigInt.tryParse(hex, radix: 16);
    if (parsed == null || parsed <= BigInt.zero) {
      throw FormatException('not an Apple place id: "$raw"');
    }
    return PlaceId._(parsed);
  }

  @override
  String toString() =>
      'I${value.toRadixString(16).toUpperCase().padLeft(16, '0')}';

  @override
  bool operator ==(Object other) => other is PlaceId && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

class GuidePlace {
  final PlaceId id;

  /// A label. Apple overrides it with its own canonical record, so this is a
  /// hint for debugging rather than something the user will see.
  final String name;

  const GuidePlace({required this.id, required this.name});
}

/// How long a guide URL may get before Apple refuses it outright.
///
/// The real constraint is the URL, not the number of places. Past roughly 8,000
/// characters Apple answers 400 or 414; 6,500 leaves room for a long guide name
/// and for percent-encoding to expand more than expected.
const int maxUrlChars = 6500;

/// A ceiling on places per link, kept only as a backstop.
///
/// It used to be 50, from a device test where 60 places produced an empty guide.
/// That test encoded a name and an empty address with every place. Apple's own
/// share link for an 82-place guide encodes **neither** — only the result
/// provider and the muid — and this file now reproduces such a payload
/// byte-for-byte, verified against a real 82-place guide. So the old figure was
/// measuring our own encoding, not a limit on guide size.
///
/// 300 places is about 6,500 characters, so this and [maxUrlChars] bite at
/// roughly the same point and either one alone would do.
const int maxPlacesPerLink = 300;

/// Apple's own place database, as a "result provider". Every real place the
/// Maps client resolves comes back tagged with this.
const int _lspAppleMaps = 9902;

List<int> _varintBig(BigInt value) {
  final out = <int>[];
  final mask = BigInt.from(0x7F);
  var v = value;
  do {
    var byte = (v & mask).toInt();
    v = v >> 7;
    if (v != BigInt.zero) byte |= 0x80;
    out.add(byte);
  } while (v != BigInt.zero);
  return out;
}

List<int> _varint(int value) => _varintBig(BigInt.from(value));

List<int> _tag(int field, int wire) => _varint(field << 3 | wire);

List<int> _lenDelim(int field, List<int> body) => [
  ..._tag(field, 2),
  ..._varint(body.length),
  ...body,
];

List<int> _string(int field, String s) {
  final bytes = _utf8(s);
  return _lenDelim(field, bytes);
}

List<int> _utf8(String s) => const _Utf8Encoder().convert(s);

List<int> _vint(int field, int value) => [..._tag(field, 0), ..._varint(value)];

List<int> _vintBig(int field, BigInt value) => [
  ..._tag(field, 0),
  ..._varintBig(value),
];

/// The result provider and the muid, and nothing else.
///
/// Apple's server replaces any name or address supplied here with its own
/// canonical record, so both were only ever decoration — and they were expensive
/// decoration: a name plus an empty address is roughly 24 bytes a place, which
/// is more than the identifier itself. Dropping them takes an 82-place link from
/// 4,430 characters to 1,806.
///
/// It also makes this function's output **byte-identical** to what Apple Maps
/// itself puts in a share link, checked against a real 82-place guide. That is
/// the strongest evidence available off-device that a link of this shape holds
/// far more than the fifty places previously assumed.
List<int> _encodeLocation(GuidePlace place, {required bool withNames}) => [
  ..._vint(1, _lspAppleMaps),
  ..._vintBig(2, place.id.value),
  if (withNames) ..._string(3, ''), // address — the server supplies its own
  if (withNames) ..._string(5, place.name),
];

List<int> encodeCollection(
  String title,
  List<GuidePlace> places, {
  bool withNames = false,
}) => [
  ..._string(1, title),
  for (final p in places)
    ..._lenDelim(2, _encodeLocation(p, withNames: withNames)),
];

/// The older `guide?_col=` form, names and all.
///
/// Kept because a link from this function was opened on a physical iPhone during
/// the feasibility work and confirmed to populate a guide correctly — that is
/// evidence, and deleting it to make a newer form look tidy would be throwing
/// away the only device-verified thing in this file. `guide_link_test.dart`
/// still checks it byte-for-byte.
///
/// Not the default any more, because it is the form that produced an empty guide
/// at sixty places. Use [buildGuideLink] unless that turns out to fail on a
/// device, in which case this is the fallback for small guides.
String buildLegacyColLink(String title, List<GuidePlace> places) {
  if (places.isEmpty) {
    throw ArgumentError('a guide needs at least one place');
  }
  final payload = _base64(encodeCollection(title, places, withNames: true));
  return 'https://maps.apple.com/guide?_col=${Uri.encodeComponent(payload)}';
}

/// A single guide link, in the form Apple Maps itself produces.
///
/// `guides?user=` rather than the older `guide?_col=`: sharing a guide out of
/// Apple Maps today gives a short link that redirects to exactly this, and the
/// payload is the same protobuf. Emitting what Apple emits is the whole reason a
/// guide of eighty places can go in one link.
///
/// Throws if the result would be too long, because the silent-empty-guide
/// failure is far worse than an exception — a link past Apple's limit comes back
/// HTTP 200 with nothing in it.
String buildGuideLink(String title, List<GuidePlace> places) {
  if (places.isEmpty) {
    throw ArgumentError('a guide needs at least one place');
  }
  if (places.length > maxPlacesPerLink) {
    throw ArgumentError(
      '${places.length} places exceeds the $maxPlacesPerLink limit — '
      'use buildGuideLinks() to split into batches',
    );
  }
  // Already URL-safe, so no percent-encoding: `-` and `_` are legal in a query
  // value, and encoding them would produce a string Apple's own links never do.
  final payload = _base64Url(encodeCollection(title, places));
  final url = 'https://maps.apple.com/guides?user=$payload';
  if (url.length > maxUrlChars) {
    throw ArgumentError(
      '${places.length} places makes a ${url.length}-character URL, over the '
      '$maxUrlChars limit — use buildGuideLinks() to split into batches',
    );
  }
  return url;
}

/// Splits a long list into as many links as it takes — usually one.
///
/// Packs by measured URL length rather than by a fixed count, because the
/// constraint is the URL and a long guide name eats into it. In practice one
/// link now holds every list a person is likely to build: an 82-place guide is
/// about 1,800 characters against a 6,500 budget.
///
/// Guides cannot be merged afterwards, so if it genuinely does not fit, each
/// batch becomes its own guide in Maps — numbered, so that is visible rather
/// than a surprise.
List<String> buildGuideLinks(String title, List<GuidePlace> places) {
  if (places.isEmpty) {
    throw ArgumentError('a guide needs at least one place');
  }
  // The overwhelmingly common case, and worth trying whole before doing any
  // arithmetic about batches.
  if (places.length <= maxPlacesPerLink) {
    final whole = _tryBuild(title, places);
    if (whole != null) return [whole];
  }

  // Pack greedily. The suffix is added before measuring, since "(10/12)" is
  // longer than "(1/2)" and a batch that fitted without it could overflow with
  // it — which would throw at the end of an otherwise successful split.
  final links = <String>[];
  var remaining = places;
  while (remaining.isNotEmpty) {
    var take = remaining.length < maxPlacesPerLink
        ? remaining.length
        : maxPlacesPerLink;
    String? built;
    while (take > 0) {
      // A guess at the final count, deliberately generous: the suffix only ever
      // gets shorter than this once the real total is known.
      built = _tryBuild('$title (00/00)', remaining.take(take).toList());
      if (built != null) break;
      take = take > 10 ? take - 10 : take - 1;
    }
    if (take <= 0) {
      throw ArgumentError(
        'cannot fit even one place under $maxUrlChars characters — the guide '
        'name is ${title.length} characters and must be shorter',
      );
    }
    links.add('');
    remaining = remaining.skip(take).toList();
    // Record the slice size; the links themselves are rebuilt below with the
    // real numbering now that the batch count is known.
    links[links.length - 1] = take.toString();
  }

  final batches = links.length;
  final out = <String>[];
  var offset = 0;
  for (var i = 0; i < batches; i++) {
    final take = int.parse(links[i]);
    final slice = places.skip(offset).take(take).toList();
    offset += take;
    out.add(
      buildGuideLink(
        batches == 1 ? title : '$title (${i + 1}/$batches)',
        slice,
      ),
    );
  }
  return out;
}

/// Builds a link, or returns null if it would be too long. Used while packing,
/// where an over-long candidate is an expected answer rather than an error.
String? _tryBuild(String title, List<GuidePlace> places) {
  try {
    return buildGuideLink(title, places);
  } on ArgumentError {
    return null;
  }
}

/// A link to one place's native card, where "Add to Guide" can append it to a
/// guide that already exists. The only route to appending — a guide link always
/// creates a new guide, even when the name matches one already saved.
String buildPlaceLink(PlaceId id) =>
    'https://maps.apple.com/place?auid=${id.value}&lsp=$_lspAppleMaps';

// --- small helpers, kept local so this file has no dependencies -------------

class _Utf8Encoder {
  const _Utf8Encoder();
  List<int> convert(String s) {
    final out = <int>[];
    for (final rune in s.runes) {
      if (rune < 0x80) {
        out.add(rune);
      } else if (rune < 0x800) {
        out.add(0xC0 | (rune >> 6));
        out.add(0x80 | (rune & 0x3F));
      } else if (rune < 0x10000) {
        out.add(0xE0 | (rune >> 12));
        out.add(0x80 | ((rune >> 6) & 0x3F));
        out.add(0x80 | (rune & 0x3F));
      } else {
        out.add(0xF0 | (rune >> 18));
        out.add(0x80 | ((rune >> 12) & 0x3F));
        out.add(0x80 | ((rune >> 6) & 0x3F));
        out.add(0x80 | (rune & 0x3F));
      }
    }
    return out;
  }
}

const String _b64Alphabet =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

/// URL-safe base64, unpadded — exactly what Apple's own share links carry.
///
/// Apple uses `-` and `_` where standard base64 uses `+` and `/`, and no `=`
/// padding. This was found by comparing a real share payload against ours: the
/// bytes matched and the text did not. Both decode to the same thing under a
/// lenient parser, but matching Apple removes the question, and as a bonus
/// nothing needs percent-encoding afterwards, which makes the URL shorter.
String _base64Url(List<int> bytes) => _base64(
  bytes,
).replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');

String _base64(List<int> bytes) {
  final sb = StringBuffer();
  for (var i = 0; i < bytes.length; i += 3) {
    final b0 = bytes[i];
    final b1 = i + 1 < bytes.length ? bytes[i + 1] : 0;
    final b2 = i + 2 < bytes.length ? bytes[i + 2] : 0;
    sb.write(_b64Alphabet[b0 >> 2]);
    sb.write(_b64Alphabet[((b0 & 0x03) << 4) | (b1 >> 4)]);
    sb.write(
      i + 1 < bytes.length ? _b64Alphabet[((b1 & 0x0F) << 2) | (b2 >> 6)] : '=',
    );
    sb.write(i + 2 < bytes.length ? _b64Alphabet[b2 & 0x3F] : '=');
  }
  return sb.toString();
}
