import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/place_files.dart';

/// Fixtures are shaped like what the real exporters produce, quirks included,
/// because that is where these parsers actually fail: a comma inside a quoted
/// name, coordinates in the opposite order to how people say them, a Takeout
/// CSV that gives a URL and no latitude at all.
void main() {
  group('CSV', () {
    test('Google My Maps, with a comma inside a quoted name', () {
      const csv = '''
name,description,latitude,longitude
"Nando's, Soho",lunch,51.5136,-0.1365
Maltby Street Market,,51.4989,-0.0787
''';
      final r = readPlaceFile(csv);
      expect(r.places, hasLength(2));
      // The naive split-on-comma bug shifts every later column, so the
      // coordinate is the thing that proves quoting was handled.
      expect(r.places.first.name, "Nando's, Soho");
      expect(r.places.first.lat, closeTo(51.5136, 1e-9));
      expect(r.places.first.lon, closeTo(-0.1365, 1e-9));
    });

    test('Google Takeout saved places: a URL and no coordinates', () {
      const csv = '''
Title,Note,URL,Comment
Barbarella,,https://www.google.com/maps/place/data=!4m2!3m1!1s0x0:0x0!3d51.5033!4d-0.0195,
''';
      final r = readPlaceFile(csv);
      expect(r.places.single.name, 'Barbarella');
      // Mined out of the URL, which is the only place Takeout puts them.
      expect(r.places.single.lat, closeTo(51.5033, 1e-9));
      expect(r.places.single.lon, closeTo(-0.0195, 1e-9));
    });

    test('an @lat,lon URL is also understood', () {
      // Quoted, because an @lat,lon URL contains commas and a real exporter
      // quotes it. Unquoted it is genuinely ambiguous CSV — the parser is
      // right to split it, and the first fixture written here was wrong
      // rather than the code.
      const csv =
          'name,url\nThe Nest,'
          '"https://maps.google.com/@51.5175,-0.1449,17z"\n';
      expect(readPlaceFile(csv).places.single.lat, closeTo(51.5175, 1e-9));
      expect(readPlaceFile(csv).places.single.lon, closeTo(-0.1449, 1e-9));
    });

    test(
      'an unquoted URL with commas loses its tail, and says nothing false',
      () {
        // Worth pinning: the row still imports under its name, just unaimed.
        // Silently inventing a coordinate from a mangled cell would be worse.
        const csv =
            'name,url\nThe Nest,'
            'https://maps.google.com/@51.5175,-0.1449,17z\n';
        final p = readPlaceFile(csv).places.single;
        expect(p.name, 'The Nest');
        expect(p.lat, isNull);
      },
    );

    test('a header preceded by a comment line is still found', () {
      const csv =
          'Saved places from Google Maps\n'
          'Title,Latitude,Longitude\nThe Nest,51.5,-0.14\n';
      expect(readPlaceFile(csv).places.single.name, 'The Nest');
    });

    test('alternative header spellings', () {
      const csv = 'Place,Lat,Lng,Street\nBao,51.51,-0.13,Lexington St\n';
      final p = readPlaceFile(csv).places.single;
      expect(p.name, 'Bao');
      expect(p.address, 'Lexington St');
      expect(p.query, 'Bao, Lexington St');
    });

    test('a row with no name is counted rather than searched for ""', () {
      const csv = 'name,latitude,longitude\n,51.5,-0.1\nReal,51.5,-0.1\n';
      final r = readPlaceFile(csv);
      expect(r.places, hasLength(1));
      expect(r.skipped, 1);
    });

    test('nonsense coordinates are dropped, not passed on', () {
      // A search aimed at latitude 900 is worse than an unaimed one.
      const csv = 'name,latitude,longitude\nX,900,-0.1\n';
      final p = readPlaceFile(csv).places.single;
      expect(p.lat, isNull);
    });

    test('a quoted field spanning two lines', () {
      const csv = 'name,description\n"Two\nlines",note\n';
      expect(readPlaceFile(csv).places.single.name, 'Two\nlines');
    });

    test('a CSV with no name-like column is refused', () {
      expect(
        () => readPlaceFile('a,b\n1,2\n'),
        throwsA(isA<PlaceFileFormat>()),
      );
    });
  });

  group('KML', () {
    test('placemarks, with longitude first as KML requires', () {
      const kml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"><Document>
<name>Lisbon trip</name>
<Placemark><name>Time Out Market</name>
  <address>Av. 24 de Julho</address>
  <Point><coordinates>-9.1459,38.7071,0</coordinates></Point>
</Placemark>
<Placemark><name>Park Bar</name>
  <Point><coordinates>-9.1441,38.7108</coordinates></Point>
</Placemark>
</Document></kml>''';
      final r = readPlaceFile(kml);
      expect(r.places, hasLength(2));
      final first = r.places.first;
      expect(first.name, 'Time Out Market');
      // If these were swapped the place would be in the Indian Ocean.
      expect(first.lat, closeTo(38.7071, 1e-9));
      expect(first.lon, closeTo(-9.1459, 1e-9));
      expect(first.address, 'Av. 24 de Julho');
    });

    test('CDATA and HTML inside a name are unwrapped', () {
      const kml =
          '<kml><Placemark>'
          '<name><![CDATA[<b>Bar &amp; Grill</b>]]></name>'
          '<Point><coordinates>-0.1,51.5</coordinates></Point>'
          '</Placemark></kml>';
      expect(readPlaceFile(kml).places.single.name, 'Bar & Grill');
    });

    test('a LineString anchors on its first coordinate', () {
      const kml =
          '<kml><Placemark><name>Walk</name><LineString>'
          '<coordinates>-0.10,51.50 -0.11,51.51 -0.12,51.52</coordinates>'
          '</LineString></Placemark></kml>';
      final p = readPlaceFile(kml).places.single;
      expect(p.lat, closeTo(51.50, 1e-9));
    });

    test('a placemark with no name is counted', () {
      const kml =
          '<kml><Placemark>'
          '<Point><coordinates>-0.1,51.5</coordinates></Point>'
          '</Placemark></kml>';
      final r = readPlaceFile(kml);
      expect(r.places, isEmpty);
      expect(r.skipped, 1);
    });
  });

  group('GPX', () {
    test('waypoints carry coordinates as attributes', () {
      const gpx = '''
<?xml version="1.0"?>
<gpx version="1.1"><wpt lat="45.4408" lon="12.3155">
<name>Venice viewpoint</name></wpt>
<wpt lat="45.4340" lon="12.3388"><name>Rialto</name></wpt>
</gpx>''';
      final r = readPlaceFile(gpx);
      expect(r.places.map((p) => p.name), ['Venice viewpoint', 'Rialto']);
      expect(r.places.first.lat, closeTo(45.4408, 1e-9));
    });
  });

  group('GeoJSON and Takeout JSON', () {
    test('GeoJSON features, longitude first', () {
      const json = '''
{"type":"FeatureCollection","name":"Tokyo",
 "features":[
  {"type":"Feature","properties":{"name":"Fuunji"},
   "geometry":{"type":"Point","coordinates":[139.6917,35.6895]}}]}''';
      final r = readPlaceFile(json);
      expect(r.title, 'Tokyo');
      expect(r.places.single.name, 'Fuunji');
      expect(r.places.single.lat, closeTo(35.6895, 1e-9));
      expect(r.places.single.lon, closeTo(139.6917, 1e-9));
    });

    test('Takeout nests name and address under location', () {
      const json = '''
{"features":[{"type":"Feature",
  "properties":{"location":{"name":"Den","address":"Jingumae, Tokyo"}},
  "geometry":{"coordinates":[139.71,35.67]}}]}''';
      final p = readPlaceFile(json).places.single;
      expect(p.name, 'Den');
      expect(p.address, 'Jingumae, Tokyo');
      expect(p.query, 'Den, Jingumae, Tokyo');
    });

    test('a bare array of features', () {
      const json =
          '[{"properties":{"name":"A"},'
          '"geometry":{"coordinates":[1,2]}}]';
      expect(readPlaceFile(json).places.single.name, 'A');
    });

    test('JSON with no features is refused with a useful message', () {
      expect(
        () => readPlaceFile('{"hello":"world"}'),
        throwsA(
          predicate(
            (e) => e is PlaceFileFormat && e.message.contains('features'),
          ),
        ),
      );
    });
  });

  group('dispatch and refusal', () {
    test('the parser is chosen by content, not by extension', () {
      // Takeout ships GeoJSON in files named .csv often enough to matter.
      const json =
          '{"features":[{"properties":{"name":"Z"},'
          '"geometry":{"coordinates":[1,2]}}]}';
      expect(readPlaceFile(json, filename: 'saved.csv').places, hasLength(1));
    });

    test('an empty file', () {
      expect(() => readPlaceFile('   '), throwsA(isA<PlaceFileFormat>()));
    });

    test('malformed JSON says so rather than crashing', () {
      expect(
        () => readPlaceFile('{"features":['),
        throwsA(isA<PlaceFileFormat>()),
      );
    });

    test('XML that is not KML or GPX', () {
      expect(
        () => readPlaceFile('<html><body>no</body></html>'),
        throwsA(isA<PlaceFileFormat>()),
      );
    });
  });

  group('splitCsvLine', () {
    test('doubled quotes are one literal quote', () {
      expect(splitCsvLine('"say ""hi""",b'), ['say "hi"', 'b']);
    });

    test('empty trailing field is kept', () {
      expect(splitCsvLine('a,b,'), ['a', 'b', '']);
    });
  });
}
