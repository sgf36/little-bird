import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:characters/characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/place_export.dart';
import 'package:wren/src/guide_link.dart';
import 'package:wren/src/place_files.dart';
import 'package:wren/src/resolver.dart';

/// Writing place files that other map apps can actually read.
///
/// The failures worth designing against here are all silent. A KML with the
/// coordinate axes swapped is valid KML: it imports cleanly and puts London in
/// the Gulf of Guinea. A KMZ with the wrong internal filename opens to an empty
/// list in some apps and works in others. A place with no coordinate vanishes
/// from an OpenStreetMap app without complaint, because those apps do not
/// geocode an incoming file.
///
/// So the central test is a **round trip**: write a file, then read it back with
/// this codebase's own parser and check the places land where they started. That
/// catches an axis swap in a way that eyeballing the output never does — the
/// reader already knows KML is longitude-first, so agreement between the two is
/// meaningful rather than circular.
void main() {
  // Real London coordinates, chosen because the swap is unmistakable: latitude
  // 51.5 with longitude -0.1 is Southwark; reversed it is open ocean.
  const dishoom = ExportPlace(
    name: 'Dishoom Shoreditch',
    address: '7 Boundary St, London E2 7JE',
    lat: 51.5241,
    lon: -0.0759,
    note: 'Read as "DISHOOM"',
  );
  const padella = ExportPlace(
    name: 'Padella',
    address: '6 Southwark St, London SE1 1TQ',
    lat: 51.5055,
    lon: -0.0911,
  );
  const nameOnly = ExportPlace(name: 'Bacchanalia', address: 'Mayfair, London');

  group('the axis trap', () {
    test('KML round-trips through our own reader at the right place', () {
      final out = exportPlaces([dishoom, padella], PlaceFormat.kml);
      final back = readPlaceFile(utf8.decode(out.bytes));

      expect(back.places.length, 2);
      final first = back.places.first;
      expect(first.name, 'Dishoom Shoreditch');
      // Latitude must come back as latitude. If the writer emitted "lat,lon"
      // instead of KML's required "lon,lat", these two assertions swap and the
      // place is in the sea.
      expect(first.lat, closeTo(51.5241, 0.0001));
      expect(first.lon, closeTo(-0.0759, 0.0001));
    });

    test('the KML text really is longitude first', () {
      final kml = utf8.decode(exportPlaces([dishoom], PlaceFormat.kml).bytes);
      // Belt and braces on the round trip: assert the literal order, so a reader
      // and writer that were BOTH wrong in the same direction still fails.
      expect(kml, contains('<coordinates>-0.0759,51.5241,0</coordinates>'));
    });

    test('GeoJSON is longitude first too', () {
      final json =
          jsonDecode(
                utf8.decode(exportPlaces([dishoom], PlaceFormat.geojson).bytes),
              )
              as Map<String, dynamic>;
      final coords =
          ((json['features'] as List).first as Map)['geometry']['coordinates']
              as List;
      expect(coords.first, closeTo(-0.0759, 0.0001), reason: 'longitude first');
      expect(coords.last, closeTo(51.5241, 0.0001));
    });

    test('GPX names its axes, so it cannot be got wrong', () {
      final gpx = utf8.decode(exportPlaces([dishoom], PlaceFormat.gpx).bytes);
      // Six decimal places, always, and a full stop for the separator whatever
      // the device's locale would prefer — a comma decimal writes "51,524100",
      // which is a parse failure or a wrong point depending on the reader.
      expect(gpx, contains('lat="51.524100"'));
      expect(gpx, contains('lon="-0.075900"'));
      expect(gpx, isNot(contains('e-')), reason: 'no exponent notation');
    });

    test('the address survives a GPX round trip', () {
      // GPX has no address element, so the writer puts it in <cmt> and <desc>.
      // The reader ignored both, which mattered most on the Google Maps route:
      // Google geocodes the address column, and it was being handed the place
      // name instead of a street.
      final out = exportPlaces([dishoom], PlaceFormat.gpx);
      final back = readPlaceFile(utf8.decode(out.bytes)).places.single;
      expect(back.address, '7 Boundary St, London E2 7JE');
      expect(back.name, 'Dishoom Shoreditch');
    });

    test('the list name survives a GPX round trip', () {
      // The writer puts it in <metadata><name> and the reader used to ignore it,
      // so a file Wren had written came back as an untitled list -- and a name
      // the user had given a guide was lost the moment it left the app.
      final out = exportPlaces(
        [dishoom],
        PlaceFormat.gpx,
        title: 'London bars',
      );
      expect(readPlaceFile(utf8.decode(out.bytes)).title, 'London bars');
    });

    test('GPX round-trips through our own reader', () {
      final back = readPlaceFile(
        utf8.decode(exportPlaces([dishoom, padella], PlaceFormat.gpx).bytes),
      );
      expect(back.places.map((p) => p.name), ['Dishoom Shoreditch', 'Padella']);
      expect(back.places.first.lat, closeTo(51.5241, 0.0001));
      expect(back.places.first.lon, closeTo(-0.0759, 0.0001));
    });
  });

  group('GPX, which is the format Android map apps are handed', () {
    String gpx(List<ExportPlace> places, {String title = 'London'}) =>
        utf8.decode(exportPlaces(places, PlaceFormat.gpx, title: title).bytes);

    test('carries the two root attributes the schema requires', () {
      // Both are mandatory in gpx.xsd, and a validating importer rejects the
      // whole document rather than the attribute — so this is a zero-places
      // import, not a cosmetic complaint.
      final out = gpx([dishoom]);
      expect(out, contains('version="1.1"'));
      expect(out, contains('creator="Wren"'));
      expect(out, contains('xmlns="http://www.topografix.com/GPX/1/1"'));
    });

    test('holds no track or route element whatsoever', () {
      // The behavioural trap rather than a schema one. OsmAnd asks whether the
      // file has any tracks before it asks anything else, so one empty <trk>
      // turns a list of places into a route with no dialog and nothing to
      // correct. Checked on an empty export too, where a stray wrapper would be
      // easiest to leave behind.
      for (final places in [
        <ExportPlace>[],
        [dishoom, padella],
      ]) {
        final out = gpx(places);
        for (final tag in ['<trk', '<rte', '<trkseg', '<trkpt', '<rtept']) {
          expect(out, isNot(contains(tag)), reason: tag);
        }
      }
    });

    test('puts the waypoint children in the order the schema fixes', () {
      // wptType's children are order-sensitive: name, then cmt, then desc, then
      // type. desc before name is invalid, and invalid here means nothing
      // imports at all.
      final out = gpx([dishoom]);
      final order = [
        '<name>',
        '<cmt>',
        '<desc>',
        '<type>',
      ].map(out.indexOf).toList();
      expect(order.every((i) => i > 0), isTrue, reason: 'all four present');
      expect(order, orderedEquals(List.of(order)..sort()));
    });

    test('writes the address into cmt as well as desc', () {
      // Some readers surface only <cmt>, and Mapy discards <desc> entirely, so
      // one string in both places is the difference between a pin that knows its
      // address and a bare name.
      final out = gpx([padella]);
      expect(out, contains('<cmt>6 Southwark St, London SE1 1TQ</cmt>'));
      expect(out, contains('<desc>6 Southwark St, London SE1 1TQ</desc>'));
    });

    test('files every place under the list name as its category', () {
      // OsmAnd's bottom-sheet route passes an empty default category, so without
      // a per-place <type> the places land in the undifferentiated Favorites
      // group, mixed in with whatever the user had saved already.
      expect(
        gpx([dishoom], title: 'London bars'),
        contains('<type>London bars</type>'),
      );
    });
  });

  group('KMZ container', () {
    test('is a zip holding exactly one doc.kml at the root', () {
      final out = exportPlaces([dishoom, padella], PlaceFormat.kmz);
      final archive = ZipDecoder().decodeBytes(out.bytes);

      expect(archive.files.length, 1);
      // Not "places.kml", not "kml/doc.kml". Readers look for doc.kml at the
      // root, and a nested path opens to nothing in some apps while working in
      // others — which is worse than failing outright.
      expect(archive.files.single.name, 'doc.kml');
    });

    test('the KML inside survives the zip intact', () {
      final out = exportPlaces([padella], PlaceFormat.kmz);
      final inner = ZipDecoder().decodeBytes(out.bytes).files.single;
      final back = readPlaceFile(utf8.decode(inner.content as List<int>));
      expect(back.places.single.name, 'Padella');
      expect(back.places.single.lat, closeTo(51.5055, 0.0001));
    });
  });

  group('coordinates that are present but useless', () {
    test('exactly 0, 0 counts as no location', () {
      // OsmAnd's own hasLocation() is `lat != 0 && lon != 0`, so Null Island is
      // "no location" there and a stack of pins in the Gulf of Guinea
      // everywhere else. Either way the export reads as corrupt.
      const nullIsland = ExportPlace(name: 'Nowhere', lat: 0, lon: 0);
      expect(nullIsland.hasCoordinate, isFalse);
      final out = exportPlaces([dishoom, nullIsland], PlaceFormat.gpx);
      expect(out.written, 1);
      expect(out.droppedForNoCoordinate, 1);
    });

    test('out of range and not-a-number are dropped too', () {
      for (final p in const [
        ExportPlace(name: 'Too far north', lat: 91, lon: 0.1),
        ExportPlace(name: 'Off the edge', lat: 51.5, lon: 181),
        ExportPlace(name: 'Nowhere at all', lat: double.nan, lon: 0.1),
        ExportPlace(name: 'Infinitely lost', lat: 51.5, lon: double.infinity),
      ]) {
        expect(p.hasCoordinate, isFalse, reason: p.name);
      }
    });
  });

  group('text that would fail the whole import', () {
    test('a control character is stripped rather than written', () {
      // OCR is where these come from, and Organic Maps' parser dies on one,
      // losing every place in the file for a character nobody can see.
      final out = utf8.decode(
        exportPlaces([
          const ExportPlace(
            name: 'Dishoom\u0001 Shoreditch',
            lat: 51.5241,
            lon: -0.0759,
          ),
        ], PlaceFormat.gpx).bytes,
      );
      expect(out, contains('<name>Dishoom Shoreditch</name>'));
      expect(out.codeUnits, isNot(contains(1)));
    });

    test('a very long name is cut on a grapheme boundary', () {
      // Mapy fails the entire import above two hundred characters, with an error
      // that blames the network. Cutting on code units instead would leave half
      // an emoji at the end, which is malformed text rather than a short name.
      final long = 'Café${'👩‍👩‍👧 ' * 120}';
      final out = utf8.decode(
        exportPlaces([
          ExportPlace(name: long, lat: 51.5241, lon: -0.0759),
        ], PlaceFormat.gpx).bytes,
      );
      final name = RegExp(r'<name>(.*?)</name>').allMatches(out).last.group(1)!;
      expect(name.characters.length, maxPlaceNameLength);
      expect(name, startsWith('Café'));
      // The last family emoji is whole, not a lone zero-width joiner or a
      // stranded woman.
      expect(name.characters.last, anyOf('👩‍👩‍👧', ' '));
    });

    test('places past the cap are dropped and counted', () {
      // Mapy ignores everything after the thousandth point without a word and
      // Gaia documents the same number, so a longer file imports as a success
      // with places missing off the end.
      final many = List.generate(
        maxPlacesPerFile + 5,
        (i) => ExportPlace(name: 'Place $i', lat: 51.5 + i / 10000, lon: -0.1),
      );
      final out = exportPlaces(many, PlaceFormat.gpx);
      expect(out.written, maxPlacesPerFile);
      expect(out.droppedOverCap, 5);
      expect(utf8.decode(out.bytes), isNot(contains('Place 1002')));
    });
  });

  group('places with no coordinate', () {
    test('are dropped from KML, and counted rather than hidden', () {
      // An OpenStreetMap app does not geocode: this place would vanish without
      // a word, so the count is the only honest thing to show the user.
      final out = exportPlaces([dishoom, nameOnly], PlaceFormat.kml);
      expect(out.written, 1);
      expect(out.droppedForNoCoordinate, 1);
      expect(utf8.decode(out.bytes), isNot(contains('Bacchanalia')));
    });

    test('survive in CSV, because Google geocodes that on import', () {
      final out = exportPlaces([dishoom, nameOnly], PlaceFormat.csv);
      expect(out.written, 2);
      expect(out.droppedForNoCoordinate, 0);
      final csv = utf8.decode(out.bytes);
      expect(csv, contains('Bacchanalia'));
      // With no address of its own a place falls back to its name, which is what
      // Google's importer geocodes.
      expect(csv, contains('Mayfair, London'));
    });

    test('only CSV claims to geocode', () {
      expect(PlaceFormat.csv.geocodesOnImport, isTrue);
      for (final f in [
        PlaceFormat.kml,
        PlaceFormat.kmz,
        PlaceFormat.gpx,
        PlaceFormat.geojson,
      ]) {
        expect(f.geocodesOnImport, isFalse, reason: '$f cannot geocode');
      }
    });
  });

  group('files that other apps have to accept', () {
    test('every format ends in a real extension', () {
      // Handlers that match on pathPattern never see a file called "places", and
      // a content:// URI hides everything else about it.
      for (final f in PlaceFormat.values) {
        expect(
          exportFileName('London, October', f),
          endsWith('.${f.extension}'),
        );
      }
    });

    test('a title with punctuation still makes a safe filename', () {
      // "&" is stripped, leaving a double space, which collapses to a single
      // hyphen — not two. Asserting the real output rather than the one I
      // guessed at first.
      expect(
        exportFileName('London: bars & bakeries!', PlaceFormat.kmz),
        'london-bars-bakeries.kmz',
      );
      expect(exportFileName('   ', PlaceFormat.kml), 'places.kml');
    });

    test('MIME types are the registered ones', () {
      expect(PlaceFormat.kmz.mimeType, 'application/vnd.google-earth.kmz');
      expect(PlaceFormat.kml.mimeType, 'application/vnd.google-earth.kml+xml');
      expect(PlaceFormat.gpx.mimeType, 'application/gpx+xml');
    });

    test('an ampersand in a name does not produce broken XML', () {
      const black = ExportPlace(
        name: 'Black & Blue',
        address: 'Borough Market',
        lat: 51.5054,
        lon: -0.0903,
      );
      final kml = utf8.decode(exportPlaces([black], PlaceFormat.kml).bytes);
      expect(kml, contains('Black &amp; Blue'));
      // And it must survive a parse, not merely look escaped.
      expect(readPlaceFile(kml).places.single.name, 'Black & Blue');
    });

    test('an empty list writes a valid file rather than throwing', () {
      for (final f in PlaceFormat.values) {
        final out = exportPlaces(const [], f, title: 'Empty');
        expect(out.written, 0);
        expect(out.isEmpty, isTrue);
        expect(out.bytes, isNotEmpty, reason: '$f still needs a valid wrapper');
      }
      // The wrapper is valid XML, but our own reader rightly refuses a file
      // with nothing in it — "imported 0 places" should be an error the user
      // sees, not a silent success. Both halves behaving that way is the point.
      final kml = utf8.decode(exportPlaces(const [], PlaceFormat.kml).bytes);
      expect(kml, contains('<Document>'));
      expect(() => readPlaceFile(kml), throwsA(isA<PlaceFileFormat>()));
    });
  });

  group('building from a resolved place', () {
    PlaceMatch match(String name, {double? lat, double? lon}) => PlaceMatch(
      id: PlaceId.parse('I43FA2531C5B5D635'),
      name: name,
      address: '7 Boundary St',
      lat: lat,
      lon: lon,
    );

    test('carries the reading across when it differs from the match', () {
      final p = ExportPlace.from(
        match('Dishoom Shoreditch', lat: 51.5241, lon: -0.0759),
        readAs: 'DISHOOM',
      );
      expect(p!.note, 'Read as "DISHOOM"');
      expect(p.lat, closeTo(51.5241, 0.0001));
    });

    test('adds no note when the reading matched exactly', () {
      final p = ExportPlace.from(
        match('Padella', lat: 51.5, lon: -0.09),
        readAs: 'Padella',
      );
      expect(p!.note, isEmpty);
    });

    test('an unresolved place is not exportable', () {
      expect(ExportPlace.from(null), isNull);
    });

    test('a match with no coordinate still exports, and CSV keeps it', () {
      // This is the case that used to be impossible to detect: PlaceMatch threw
      // lat/lon away, so every export looked coordinate-less.
      final p = ExportPlace.from(match('Somewhere'))!;
      expect(p.hasCoordinate, isFalse);
      expect(exportPlaces([p], PlaceFormat.csv).written, 1);
      expect(exportPlaces([p], PlaceFormat.kml).written, 0);
    });
  });
}
