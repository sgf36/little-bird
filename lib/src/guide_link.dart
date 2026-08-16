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
///  2. Keep each link to ~50 places. Above that the server returns HTTP 200 with
///     an empty guide — it fails silently, so callers must verify rather than
///     trust the status code.
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

/// Above this, Apple returns an empty guide without saying so.
const int maxPlacesPerLink = 50;

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

List<int> _encodeLocation(GuidePlace place) => [
  ..._vint(1, _lspAppleMaps),
  ..._vintBig(2, place.id.value),
  ..._string(3, ''), // address — the server supplies its own
  ..._string(5, place.name),
];

List<int> encodeCollection(String title, List<GuidePlace> places) => [
  ..._string(1, title),
  for (final p in places) ..._lenDelim(2, _encodeLocation(p)),
];

/// A single guide link. Throws if [places] exceeds [maxPlacesPerLink], because
/// the silent-empty-guide failure is worse than an exception.
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
  final payload = _base64(encodeCollection(title, places));
  return 'https://maps.apple.com/guide?_col=${Uri.encodeComponent(payload)}';
}

/// Splits a long list into as many links as it takes. Guides cannot be merged
/// afterwards, so each batch becomes its own guide in Maps — name them so that
/// is obvious to the user rather than a surprise.
List<String> buildGuideLinks(String title, List<GuidePlace> places) {
  if (places.length <= maxPlacesPerLink) {
    return [buildGuideLink(title, places)];
  }
  final links = <String>[];
  final batches = (places.length / maxPlacesPerLink).ceil();
  for (var i = 0; i < batches; i++) {
    final slice = places
        .skip(i * maxPlacesPerLink)
        .take(maxPlacesPerLink)
        .toList();
    links.add(buildGuideLink('$title (${i + 1}/$batches)', slice));
  }
  return links;
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
