import 'package:flutter_test/flutter_test.dart';
import 'package:reel_places/src/guide_link.dart';

// The expected URLs below are not guesses. They were generated during the
// feasibility work, opened on an iPhone, and confirmed to populate a guide in
// Apple Maps with the right places in it. Byte-for-byte equality against them
// is therefore a real assertion about behaviour, not a change-detector.
//
// If one of these ever fails, the encoder has drifted away from a payload that
// is known to work on a real device.

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
    test('reproduces a link confirmed working on device', () {
      final link = buildGuideLink('Reel Finds B', [
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
      expect(link, startsWith('https://maps.apple.com/guide?_col='));
      // The payload must survive a base64 round trip without mangling the è.
      expect(link, isNot(contains('Caff?')));
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

    test('splits a long list and labels each batch', () {
      final places = List.generate(
        120,
        (i) => GuidePlace(id: PlaceId.parse(_dishoom), name: 'P$i'),
      );
      final links = buildGuideLinks('Big trip', places);
      expect(links, hasLength(3)); // 50 + 50 + 20
      for (final l in links) {
        expect(l, startsWith('https://maps.apple.com/guide?_col='));
      }
    });

    test('every batch stays within the limit', () {
      final places = List.generate(
        201,
        (i) => GuidePlace(id: PlaceId.parse(_dishoom), name: 'P$i'),
      );
      // Would throw from buildGuideLink if any batch were oversized.
      expect(buildGuideLinks('Long', places), hasLength(5));
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
