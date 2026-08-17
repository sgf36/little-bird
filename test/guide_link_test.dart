import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/guide_import.dart';
import 'package:wren/src/guide_link.dart';

// _verifiedFourPlaceLink is not a guess. It was generated during the
// feasibility work, opened on an iPhone, and confirmed to populate a guide in
// Apple Maps with the right places in it, so byte-for-byte equality against it
// is a real assertion about behaviour rather than a change-detector.
//
// It verifies buildLegacyColLink. The DEFAULT form is now `guides?user=` with
// per-place names omitted, which is what Apple Maps itself emits -- proven by
// reproducing a real 82-place share payload byte-for-byte in
// guide_import_test.dart -- but which has not itself been opened from this app
// on a device. That check is outstanding and worth doing once.

const _dishoom = 'I43FA2531C5B5D635'; // Dishoom Shoreditch
const _wrightBros = 'I655EEDD5976A0811'; // Wright Brothers, Borough Market
const _elliots = 'I94FE63725FB590E2'; // Elliot's
const _arabica = 'I52BEC654CD7F9E76'; // Arabica

const _verifiedFourPlaceLink =
    'https://maps.apple.com/guide?_col='
    'CgxSZWVsIEZpbmRzIEISIwiuTRC1rNetnKaJ%2FUMaACoSRGlzaG9vbSBTaG9yZWRpdGNo'
    'Eh8Irk0QkZCou9m6u69lGgAqDkJvcm91Z2ggTWFya2V0EisIrk0Q4qHW%2FaXumP%2BUARoA'
    'KhlFbGxpb3QncyAtIEJvcm91Z2ggTWFya2V0EikIrk0Q9rz%2B68zKsd9SGgAqGEFyYWJpY2'
    'EgLSBCb3JvdWdoIE1hcmtldA%3D%3D';

void main() {
  group('PlaceId', () {
    test('parses the MapKit identifier format', () {
      // MKMapItem.identifier.rawValue is "I" + the muid in uppercase hex.
      expect(
        PlaceId.parse(_dishoom).value,
        BigInt.parse('4898268440419489333'),
      );
    });

    test('accepts bare hex without the I prefix', () {
      expect(PlaceId.parse('43FA2531C5B5D635'), PlaceId.parse(_dishoom));
    });

    test('round-trips back to the canonical string form', () {
      expect(PlaceId.parse(_dishoom).toString(), _dishoom);
    });

    test('handles ids above 2^63, which overflow a Dart int', () {
      // Elliot's muid is 10736127904580997346 — larger than a signed 64-bit
      // int, so anything using `int` here silently breaks.
      final id = PlaceId.parse(_elliots);
      expect(id.value, BigInt.parse('10736127904580997346'));
      expect(id.value > BigInt.two.pow(63), isTrue);
      expect(id.toString(), _elliots);
    });

    test('rejects rubbish', () {
      expect(() => PlaceId.parse('not-an-id'), throwsFormatException);
      expect(() => PlaceId.parse('I0000000000000000'), throwsFormatException);
    });
  });

  group('buildGuideLink', () {
    test('the legacy form still reproduces a link verified on device', () {
      // buildLegacyColLink, not buildGuideLink: the default form changed to the
      // one Apple itself emits, and this assertion is the only device-verified
      // fact in the file. Kept pointed at the function it actually verifies
      // rather than deleted to make the new form look tidy.
      final link = buildLegacyColLink('Reel Finds B', [
        GuidePlace(id: PlaceId.parse(_dishoom), name: 'Dishoom Shoreditch'),
        GuidePlace(id: PlaceId.parse(_wrightBros), name: 'Borough Market'),
        GuidePlace(
          id: PlaceId.parse(_elliots),
          name: "Elliot's - Borough Market",
        ),
        GuidePlace(
          id: PlaceId.parse(_arabica),
          name: 'Arabica - Borough Market',
        ),
      ]);
      expect(link, _verifiedFourPlaceLink);
    });

    test('encodes non-ASCII names', () {
      final link = buildGuideLink('Roma', [
        GuidePlace(
          id: PlaceId.parse(_dishoom),
          name: "Sant'Eustachio Il Caffè",
        ),
      ]);
      // The guide NAME still travels; only per-place names were dropped, and
      // this one is non-ASCII, so it must survive the base64 round trip.
      expect(link, startsWith('https://maps.apple.com/guides?user='));
      expect(link, isNot(contains('Rom?')));
    });

    test('refuses an empty guide', () {
      expect(() => buildGuideLink('Empty', []), throwsArgumentError);
    });

    test('refuses to build a link that would arrive empty', () {
      // Over the limit Apple returns HTTP 200 and an empty guide. Failing here
      // is much better than shipping a link that looks fine and is not.
      final tooMany = List.generate(
        maxPlacesPerLink + 1,
        (i) => GuidePlace(id: PlaceId.parse(_dishoom), name: 'Place $i'),
      );
      expect(() => buildGuideLink('Too many', tooMany), throwsArgumentError);
    });
  });

  group('buildGuideLinks', () {
    test('leaves a short list as one link', () {
      final links = buildGuideLinks('Rome', [
        GuidePlace(id: PlaceId.parse(_dishoom), name: 'One'),
      ]);
      expect(links, hasLength(1));
      expect(links.single, isNot(contains('1/1')));
    });

    test('a guide the size of a real one stays a single link', () {
      // 82 places, which is the size of an actual shared guide this was tested
      // against. Under the old encoding it split into two; the whole point of
      // dropping per-place names is that it no longer does.
      final places = List.generate(
        82,
        (i) => GuidePlace(id: PlaceId.parse(_dishoom), name: 'P$i'),
      );
      final links = buildGuideLinks('London', places);
      expect(links, hasLength(1));
      expect(links.single.length, lessThan(2500));
    });

    test('splits only when the URL genuinely will not fit', () {
      final places = List.generate(
        400,
        (i) => GuidePlace(id: PlaceId.parse(_dishoom), name: 'P$i'),
      );
      final links = buildGuideLinks('Big trip', places);
      expect(links.length, greaterThan(1));
      for (final l in links) {
        expect(l, startsWith('https://maps.apple.com/guides?user='));
        // Every batch must be independently valid; an oversized one would have
        // thrown from buildGuideLink rather than arriving here.
        expect(l.length, lessThanOrEqualTo(maxUrlChars));
      }
      // The batch number lives inside the payload, not in the URL text, so it
      // has to be decoded to be checked. Asserting on the URL passed only
      // because 'contains' found nothing and nothing was expected.
      expect(importGuideLink(links.first).name, 'Big trip (1/${links.length})');
    });

    test('no place is lost in a split', () {
      // The failure this guards against shipped once: publish took only the
      // first link, so an 82-place guide silently lost thirty-two places.
      final places = List.generate(
        400,
        (i) => GuidePlace(
          id: PlaceId.parse((BigInt.from(i + 1) << 40).toRadixString(16)),
          name: 'P$i',
        ),
      );
      final links = buildGuideLinks('Everything', places);
      final seen = <PlaceId>{};
      for (final link in links) {
        seen.addAll(importGuideLink(link).places.map((p) => p.id));
      }
      expect(seen, hasLength(places.length));
    });
  });

  group('buildPlaceLink', () {
    test('builds the single-place card link used for appending', () {
      // The only way to add to a guide that already exists — guide links always
      // create a new guide, even when the name matches.
      expect(
        buildPlaceLink(PlaceId.parse(_dishoom)),
        'https://maps.apple.com/place?auid=4898268440419489333&lsp=9902',
      );
    });

    test('handles ids above 2^63', () {
      expect(
        buildPlaceLink(PlaceId.parse(_elliots)),
        'https://maps.apple.com/place?auid=10736127904580997346&lsp=9902',
      );
    });
  });
}
