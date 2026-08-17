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
///  2. The limit is the URL's length — about 3,500 characters — and not a count
///     of places. Over it the server returns HTTP 200 with an empty guide, so
///     callers must verify rather than trust the status code. Bisected against
///     the live service; see [maxUrlChars] for the measurements. This file used
///     to cap links at 50 places, which was measuring the cost of encoding a
///     name with each one rather than any limit on guide size.
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

/// How long a guide URL may get before Apple returns an empty guide.
///
/// **Measured, not guessed.** maps.apple.com renders these links server-side and
/// reports the number of places it parsed, so the ceiling was found by bisection
/// against the live service on 17 August 2026, using real muids from a real
/// guide:
///
///     159 places bare      3,504 chars   parsed all 159
///     160 places bare      3,534 chars   EMPTY
///     40 places padded     3,420 chars   parsed all 40
///     40 places padded     3,550 chars   EMPTY
///
/// One threshold, between 3,504 and 3,534 characters, and it does not care how
/// those characters are made up — 40 places with a padded title fails at the same
/// length as 160 lean ones. So this is a URL-length limit, and the "50 places"
/// figure this file used to carry was never a limit on places at all: it was the
/// cost of encoding a name with every one of them.
///
/// **Confirmed on a device**, 17 August 2026, which is what the server could not
/// settle: a 5-place lean link opened with all five places, names, addresses and
/// categories filled in from Apple's own record; a 150-place lean link opened
/// with 148; a 160-place one opened Apple's "Coming Soon" page. The device
/// boundary is exactly where the bisection put it.
///
/// 3,400 leaves margin for a long guide name and for percent-encoding expanding
/// more than expected.
const int maxUrlChars = 3400;

/// A ceiling on places per link, kept only as a backstop.
///
/// It used to be 50, from a device test where 60 places produced an empty guide.
/// That test encoded a name and an empty address with every place. Apple's own
/// share link for an 82-place guide encodes **neither** — only the result
/// provider and the muid — and this file now reproduces such a payload
/// byte-for-byte, verified against a real 82-place guide. So the old figure was
/// measuring our own encoding, not a limit on guide size.
///
/// A count backstop, well inside the measured URL ceiling.
///
/// 159 places is the most that ever fitted (3,504 characters); 150 is that with
/// margin, and [maxUrlChars] is the constraint that actually binds. Kept as a
/// second guard because a silently empty guide is the worst failure this file
/// can produce, and two independent checks are cheap.
const int maxPlacesPerLink = 150;

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
/// Confirmed on a device: a link built this way opens with every place present
/// and with the name, address, category, opening hours and photo all supplied by
/// Apple. Sending our own names changed nothing, which is what makes them
/// decoration rather than data.
///
/// **Apple silently drops a place whose muid it no longer serves.** An 82-place
/// payload built from a real guide opened as 80, and a 150-place one as 148 —
/// consistently two short, on a set drawn from one real guide. Nothing here can
/// prevent it: the payload is correct and Apple simply has no record to resolve.
/// Worth knowing because a republished guide can come back smaller than the one
/// it replaced, and the missing places were already unreachable.
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

/// The exact encoding confirmed working on a physical iPhone.
///
/// `guide?_col=` with a name and an empty address on every place. Publishing no
/// longer includes those fields — they cost three quarters of a link's capacity
/// for values Apple overwrites — but this is the only byte sequence ever opened
/// on a device and seen to build a correct guide, so it is kept and pinned
/// byte-for-byte by `guide_link_test.dart`. If the leaner encoding ever turns
/// out to misbehave on a device, this is what to fall back to.
String buildLegacyVerifiedLink(String title, List<GuidePlace> places) {
  if (places.isEmpty) {
    throw ArgumentError('a guide needs at least one place');
  }
  final payload = _base64(encodeCollection(title, places, withNames: true));
  return 'https://maps.apple.com/guide?_col=${Uri.encodeComponent(payload)}';
}

/// The `guides?user=` form Apple emits when a guide is SHARED.
///
/// Reproduces Apple's own share payload byte-for-byte, verified against a real
/// 82-place guide, and it decodes perfectly — [importGuideLink] reads it.
///
/// **It does not create a guide.** A link built by this function arrives empty in
/// Apple Maps, confirmed on a device on 17 August 2026. Being byte-identical to a
/// working share link was not sufficient: `user=` evidently asks Maps to render a
/// guide that already exists somewhere, not to build one from the payload. Kept
/// only so the distinction is recorded in code rather than rediscovered, and so
/// the decoder has something to round-trip against.
///
/// Publish with [buildGuideLink].
String buildUserFormLink(String title, List<GuidePlace> places) {
  if (places.isEmpty) {
    throw ArgumentError('a guide needs at least one place');
  }
  return 'https://maps.apple.com/guides?user='
      '${_base64Url(encodeCollection(title, places))}';
}

/// A single guide link, in the only form known to create a populated guide.
///
/// `guide?_col=` with a name and an address on every place. That exact encoding
/// was opened on a physical iPhone and confirmed to build a guide with the right
/// places in it, and `guide_link_test.dart` pins it byte-for-byte.
///
/// It is tempting to switch to `guides?user=`, which is what Apple's own share
/// sheet produces and which this file can reproduce byte-for-byte. That was
/// tried, and the resulting guide **arrived empty on the device** — see
/// [buildUserFormLink]. Structural identity with a working link is not evidence
/// that a synthesised one works, because the two URLs mean different things:
/// one creates, the other renders something that already exists.
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
  // No per-place name or address. Apple overwrites both from its own record, so
  // they were decoration that cost roughly 24 bytes each -- three quarters of
  // the capacity of a link. Omitting them is what takes one guide from 50 places
  // to about 150. The URL form is unchanged, which is the part that decides
  // whether a guide is created at all.
  final payload = _base64(encodeCollection(title, places));
  final url =
      'https://maps.apple.com/guide?_col=${Uri.encodeComponent(payload)}';
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
