/// Reads an Apple Maps guide back out of a shared link.
///
/// **Three shapes, and the first version of this file only knew about one.**
/// Sharing a guide from Apple Maps today gives a short link,
/// `maps.apple/ug/<opaque id>`, which carries no payload and cannot be decoded
/// at all. It 301-redirects to `maps.apple.com/guides?user=<payload>` — a
/// different path and a different parameter from the
/// `maps.apple.com/guide?_col=<payload>` that [buildGuideLink] writes. All three
/// were wrongly assumed to be one thing, and the app told a user their perfectly
/// good link was not a guide link.
///
/// Inside, `user` and `_col` are the same protobuf, so one reader serves both.
/// Verified against a real 82-place guide.
///
/// **A `user` payload carries muids and nothing else** — no place names, no
/// addresses. So a guide imported this way decodes into places that can be
/// republished but cannot be *shown*, which is why [GuidePlace.name] may be
/// empty here and why the caller has to look names up if it wants to display
/// them.
///
/// **What this does not do.** It does not append. The payload carries no guide
/// identity, so there is no way to say "add to that one" — publishing again
/// always creates a guide, and publishing under the same name creates a
/// duplicate rather than merging (verified on device). Importing then
/// republishing therefore produces a *new, larger* guide that the user has to
/// keep instead of the old one. The only true append Apple offers is a
/// single-place `maps.apple.com/place?auid=…` link, where Maps itself asks
/// which guide to add it to.
///
/// Being decoded from a URL means this parser is reading input from outside the
/// app, so it is written to fail rather than to guess: every length is checked
/// against what remains, unknown fields are skipped by wire type instead of
/// assumed, and a place without an Apple id is dropped — the same rule the
/// encoder enforces, because such a place would publish into an empty guide.
library;

import 'dart:convert';

import 'guide_link.dart';

/// A guide read out of a shared link.
class ImportedGuide {
  /// The name Apple had for it. May be empty — the field is optional.
  final String name;

  final List<GuidePlace> places;

  /// Entries that carried no Apple place id and so cannot be republished.
  /// Surfaced rather than silently dropped: a count that does not match what
  /// the user seesated in Maps needs explaining, not hiding.
  final int unusable;

  const ImportedGuide({
    required this.name,
    required this.places,
    this.unusable = 0,
  });
}

class GuideLinkFormat implements Exception {
  final String message;
  const GuideLinkFormat(this.message);
  @override
  String toString() => 'GuideLinkFormat: $message';
}

/// The two parameters Apple puts a guide payload in.
///
/// `_col` is what [buildGuideLink] writes and what older shared links used.
/// `user` is what Apple Maps produces today: sharing a guide gives a short
/// `maps.apple/ug/…` link which redirects to `maps.apple.com/guides?user=…`.
/// Same protobuf inside, different path and parameter — verified against a real
/// 82-place guide, whose `user` payload decoded with this same reader.
const _payloadParameters = ['_col', 'user'];

/// True for the short link Apple's share sheet actually produces.
///
/// These carry no payload at all, only an opaque id, so they cannot be decoded —
/// they have to be expanded by following the redirect first. Recognising them
/// specifically is the difference between "that is not a guide link" (wrong, and
/// what the user was told) and "let me expand that".
bool isShortGuideLink(String input) {
  final uri = Uri.tryParse(input.trim());
  if (uri == null) return false;
  final host = uri.host.toLowerCase();
  if (host != 'maps.apple' && host != 'maps.apple.com') return false;
  // /ug/<id> for a guide, /p/<id> for a place. Only the first is a guide, but
  // both are short links and both need expanding before anything can be said
  // about them.
  final segments = uri.pathSegments;
  return segments.length >= 2 && (segments[0] == 'ug' || segments[0] == 'p');
}

/// Pulls the payload out of any shape of Apple Maps guide URL.
///
/// Accepts a bare payload too, so a user who pasted only the parameter is not
/// told their link is invalid.
String? colParameter(String input) {
  final text = input.trim();
  if (text.isEmpty) return null;
  final uri = Uri.tryParse(text);
  if (uri != null) {
    for (final key in _payloadParameters) {
      final value = uri.queryParameters[key];
      if (value != null && value.isNotEmpty) return value;
    }
  }
  // A link pasted out of a mail client can arrive percent-encoded twice, or
  // wrapped in angle brackets.
  for (final key in _payloadParameters) {
    final match = RegExp('[?&]$key=([^&\\s>]+)').firstMatch(text);
    if (match != null) return Uri.decodeComponent(match.group(1)!);
  }
  if (uri == null || !uri.hasScheme) return text; // bare payload
  return null;
}

List<int> _base64Bytes(String raw) {
  var s = raw.replaceAll('-', '+').replaceAll('_', '/').trim();
  s = s.padRight((s.length + 3) & ~3, '=');
  try {
    return base64.decode(s);
  } on FormatException catch (e) {
    throw GuideLinkFormat('not base64: ${e.message}');
  }
}

/// A cursor over the bytes that refuses to read past the end.
class _Reader {
  final List<int> bytes;
  int pos = 0;
  _Reader(this.bytes);

  bool get done => pos >= bytes.length;

  int _byte() {
    if (pos >= bytes.length) throw const GuideLinkFormat('truncated');
    return bytes[pos++];
  }

  /// Protobuf varints are little-endian base-128. Capped at ten bytes, which
  /// is the most a 64-bit value can occupy — without the cap, a malformed
  /// payload of 0xFF spins until the buffer ends.
  BigInt varint() {
    var result = BigInt.zero;
    var shift = 0;
    for (var i = 0; i < 10; i++) {
      final b = _byte();
      result |= BigInt.from(b & 0x7f) << shift;
      if (b & 0x80 == 0) return result;
      shift += 7;
    }
    throw const GuideLinkFormat('varint too long');
  }

  List<int> lengthDelimited() {
    final len = varint().toInt();
    if (len < 0 || pos + len > bytes.length) {
      throw const GuideLinkFormat('field runs past the end');
    }
    final out = bytes.sublist(pos, pos + len);
    pos += len;
    return out;
  }

  void skip(int wireType) {
    switch (wireType) {
      case 0:
        varint();
      case 1:
        pos += 8;
      case 2:
        lengthDelimited();
      case 5:
        pos += 4;
      default:
        throw GuideLinkFormat('unknown wire type $wireType');
    }
    if (pos > bytes.length) throw const GuideLinkFormat('truncated');
  }
}

({PlaceId? id, String name})? _decodeLocation(List<int> body) {
  final r = _Reader(body);
  BigInt? auid;
  var name = '';
  while (!r.done) {
    final tag = r.varint().toInt();
    final field = tag >> 3;
    final wire = tag & 7;
    switch (field) {
      case 2 when wire == 0:
        auid = r.varint();
      case 5 when wire == 2:
        name = utf8.decode(r.lengthDelimited(), allowMalformed: true);
      default:
        r.skip(wire);
    }
  }
  if (auid == null || auid == BigInt.zero) return (id: null, name: name);
  return (id: PlaceId.parse(auid.toRadixString(16)), name: name);
}

/// Decodes a shared guide link into its places.
///
/// Throws [GuideLinkFormat] when the input is not a guide link. Returns a
/// guide with no places when it is one but contains nothing usable — the
/// caller can tell those apart and say something useful either way.
ImportedGuide importGuideLink(String input) {
  final col = colParameter(input);
  if (col == null || col.isEmpty) {
    throw const GuideLinkFormat('no _col payload in that link');
  }
  final r = _Reader(_base64Bytes(col));
  var name = '';
  final places = <GuidePlace>[];
  var unusable = 0;

  while (!r.done) {
    final tag = r.varint().toInt();
    final field = tag >> 3;
    final wire = tag & 7;
    switch (field) {
      case 1 when wire == 2:
        name = utf8.decode(r.lengthDelimited(), allowMalformed: true);
      case 2 when wire == 2:
        final loc = _decodeLocation(r.lengthDelimited());
        if (loc == null || loc.id == null) {
          unusable++;
        } else {
          places.add(GuidePlace(id: loc.id!, name: loc.name));
        }
      default:
        r.skip(wire);
    }
  }

  return ImportedGuide(name: name, places: places, unusable: unusable);
}
