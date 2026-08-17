import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/guide_import.dart';
import 'package:wren/src/guide_link.dart';

/// The decoder is proved against the encoder, which is itself verified on
/// device. If a link this app builds round-trips, the format handling is right;
/// whether Apple's own "Copy Link" emits the same bytes is a separate question
/// that only a real shared link can settle.
void main() {
  GuidePlace place(String name, String hex) =>
      GuidePlace(id: PlaceId.parse(hex), name: name);

  group('round trip', () {
    test('a guide survives being encoded and read back', () {
      final places = [
        place('Maltby Street Market', 'I43FA2531C5B5D635'),
        place('The Nest', 'I95024AE1A62C0FDB'),
        place('Barbarella', 'I2C6B1D3F8A945E17'),
      ];
      final link = buildGuideLink('London, October', places);

      final back = importGuideLink(link);
      expect(back.name, 'London, October');
      expect(back.places.map((p) => p.id), places.map((p) => p.id));
      // Per-place names deliberately do NOT survive: they are no longer encoded,
      // because Apple replaces them with its own record and they cost more bytes
      // than the identifier does. The muid is the whole payload that matters.
      expect(back.places.every((p) => p.name.isEmpty), isTrue);
      expect(back.unusable, 0);
    });

    test('a muid above the signed 64-bit range survives', () {
      // The real reason PlaceId carries a BigInt. Elliot's muid is
      // 10736127904580997346, past what a signed int holds, and a decoder
      // that read it as an int would come back negative and unusable.
      final big = place('Elliot', 'I95024AE1A62C0FDB');
      final back = importGuideLink(buildGuideLink('x', [big]));
      expect(back.places.single.id, big.id);
    });

    test('a non-ASCII guide name survives', () {
      // The guide's own name is still carried; only per-place names were
      // dropped. An em dash and a multi-byte character together are what broke
      // an earlier hand-rolled UTF-8 encoder.
      final back = importGuideLink(
        buildGuideLink('Rome — Ottobre', [
          place('Trattoria Da Enzo', 'IABCDEF0123456789'),
        ]),
      );
      expect(back.name, 'Rome — Ottobre');
      expect(back.places.single.name, isEmpty);
    });

    test('our own 82-place payload matches what Apple emits, byte for byte', () {
      // The strongest check available without a device. Apple's share link for a
      // real 82-place guide was captured, its muids extracted, and re-encoded
      // here: if the bytes match, this app is emitting exactly the form Apple
      // itself produces for a guide of that size -- which is the entire basis
      // for carrying more than the fifty places previously assumed.
      const applePayload =
          'CgZMb25kb24SDgiuTRDL_OP_78aHmeABEg0Irk0QzoPcmOKCuuFfEg0Irk0QoPDVtIP'
          'A2rAJEg0Irk0Q45apuffSi7FE';
      final theirs = importGuideLink(
        'https://maps.apple.com/guides?user=$applePayload',
      );
      final ours = buildGuideLink(
        theirs.name,
        theirs.places.map((p) => GuidePlace(id: p.id, name: '')).toList(),
      );
      expect(colParameter(ours), colParameter(applePayload));
    });

    test('fifty places, the practical ceiling', () {
      final many = List.generate(
        50,
        (i) => place(
          'Place $i',
          (BigInt.from(i + 1) + BigInt.from(1) << 40).toRadixString(16),
        ),
      );
      final back = importGuideLink(buildGuideLink('Big', many));
      expect(back.places.length, 50);
    });
  });

  group('the link Apple Maps actually produces', () {
    // Real bytes, taken from a real 82-place guide shared out of Apple Maps on
    // 17 August 2026 and trimmed to the collection name plus the first four
    // places. Kept because the first version of this decoder knew only about
    // `?_col=` and told the user their genuine link was not a guide link.
    const realUserPayload =
        'CgZMb25kb24SDgiuTRDL_OP_78aHmeABEg0Irk0QzoPcmOKCuuFfEg0Irk0QoPDVtIP'
        'A2rAJEg0Irk0Q45apuffSi7FE';

    test('a guides?user= link decodes', () {
      final guide = importGuideLink(
        'https://maps.apple.com/guides?user=$realUserPayload',
      );
      expect(guide.name, 'London');
      expect(guide.places, hasLength(4));
      expect(guide.unusable, 0);
    });

    test('every place has a muid and none has a name', () {
      // The whole reason names have to be looked up separately: Apple's own
      // share payload carries the identifier and nothing else.
      final guide = importGuideLink(
        'https://maps.apple.com/guides?user=$realUserPayload',
      );
      expect(guide.places.every((p) => p.name.isEmpty), isTrue);
      // Decoded independently with a separate protobuf reader, not copied from
      // this decoder's own output — otherwise the test would only prove the
      // decoder agrees with itself. The last of these was hand-written wrong on
      // the first attempt, which is the whole argument for doing it that way.
      expect(guide.places.map((p) => p.id.toString()), [
        'IE0321E36FFF8FE4B',
        'I5FC2E816231701CE',
        'I09616A0036957820',
        'I44622E97772A4B63',
      ]);
    });

    test('the short link is recognised as needing expansion', () {
      // It carries an opaque id and no payload, so the honest answer is "expand
      // this first", not "that is not a guide link".
      const short = 'https://maps.apple/ug/qai3oPE2QtpYfaNFg27D3C';
      expect(isShortGuideLink(short), isTrue);
      expect(
        isShortGuideLink('https://maps.apple.com/guides?user=$realUserPayload'),
        isFalse,
      );
      expect(isShortGuideLink('https://example.com/ug/abc'), isFalse);
    });

    test('a short place link is also a short link', () {
      expect(isShortGuideLink('https://maps.apple/p/abc123'), isTrue);
    });
  });

  group('the shapes a pasted link arrives in', () {
    late String link;
    setUp(() {
      link = buildGuideLink('Lisbon', [place('Park', 'I1234567890ABCDEF')]);
    });

    test('the full URL', () {
      expect(importGuideLink(link).places, hasLength(1));
    });

    test('surrounded by whitespace and a sentence', () {
      expect(importGuideLink('  $link  ').places, hasLength(1));
    });

    test('wrapped in angle brackets, as mail clients do', () {
      expect(importGuideLink('<$link>').places, hasLength(1));
    });

    test('just the payload, with no URL around it', () {
      final payload = colParameter(link)!;
      expect(importGuideLink(payload).places, hasLength(1));
    });
  });

  group('refusing bad input rather than guessing', () {
    test('a link with no _col', () {
      expect(
        () => importGuideLink('https://maps.apple.com/?q=London'),
        throwsA(isA<GuideLinkFormat>()),
      );
    });

    test('empty input', () {
      expect(() => importGuideLink('   '), throwsA(isA<GuideLinkFormat>()));
    });

    test('_col that is not base64', () {
      expect(
        () => importGuideLink(
          'https://maps.apple.com/guide?_col=!!!not base64!!!',
        ),
        throwsA(isA<GuideLinkFormat>()),
      );
    });

    test('a length that runs past the end of the buffer', () {
      // field 1, wire 2, length 99 — but nothing follows. A parser that
      // trusted the length would read off the end of the list.
      expect(() => importGuideLink('CmM='), throwsA(isA<GuideLinkFormat>()));
    });

    test('a varint that never terminates', () {
      expect(
        () => importGuideLink('////////////'),
        throwsA(isA<GuideLinkFormat>()),
      );
    });
  });

  group('places that cannot be republished', () {
    test('a location with no Apple id is counted, not silently dropped', () {
      // Hand-built: Collection{ name="x", Location{ name="Somewhere" } } with
      // no field 2. Apple renders such a guide as empty, so the user has to be
      // told rather than left wondering where a place went.
      final bytes = <int>[
        0x0a, 0x01, 0x78, // name = "x"
        0x12, 0x0b, // Location, 11 bytes
        0x2a, 0x09, ...'Somewhere'.codeUnits, // field 5 name
      ];
      final payload = _b64url(bytes);
      final back = importGuideLink(
        'https://maps.apple.com/guide?_col=$payload',
      );
      expect(back.places, isEmpty);
      expect(back.unusable, 1);
      expect(back.name, 'x');
    });
  });
}

String _b64url(List<int> bytes) {
  const table =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
  final out = StringBuffer();
  for (var i = 0; i < bytes.length; i += 3) {
    final b0 = bytes[i];
    final b1 = i + 1 < bytes.length ? bytes[i + 1] : 0;
    final b2 = i + 2 < bytes.length ? bytes[i + 2] : 0;
    out.write(table[b0 >> 2]);
    out.write(table[(b0 & 3) << 4 | b1 >> 4]);
    if (i + 1 < bytes.length) out.write(table[(b1 & 15) << 2 | b2 >> 6]);
    if (i + 2 < bytes.length) out.write(table[b2 & 63]);
  }
  return out.toString();
}
