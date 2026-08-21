/// Reads places out of the files other map apps export.
///
/// This is the input GoToAppleMaps has and Wren did not: a Google Takeout
/// archive, a My Maps CSV, a KML from a walking route, a GPX from a bike
/// computer. Same destination as a screenshot — a name and, where the file
/// offers one, a location to search near.
///
/// What comes out is deliberately *not* a publishable place. These files carry
/// names and coordinates; Apple Maps guides need Apple's own place id, and a
/// coordinate-only guide opens empty on the device. So every row here still has
/// to go through MapKit resolution like any OCR reading, and the coordinate is
/// used only to aim that search.
///
/// Written to be forgiving about shape and strict about meaning. These files
/// come from a dozen tools that each interpret the format slightly differently,
/// so the parsers sniff rather than assume; but a row that yields no usable
/// name is dropped rather than turned into a search for "".
library;

import 'dart:convert';

/// One row of a file: what to search for, and roughly where.
class FilePlace {
  /// The name to search Apple Maps for. Never empty.
  final String name;

  /// Where the file said it was, if it said. Used to aim the search, not to
  /// publish — Apple supplies its own coordinates from its own record.
  final double? lat;
  final double? lon;

  /// A street address if the file had one. Appended to the query when present,
  /// because "Barbarella, Mackenzie Walk" resolves where "Barbarella" alone is
  /// ambiguous.
  final String? address;

  const FilePlace({required this.name, this.lat, this.lon, this.address});

  /// What to hand MapKit. The address helps; the coordinate is passed
  /// separately as a search region.
  String get query =>
      address == null || address!.isEmpty ? name : '$name, $address';

  @override
  String toString() =>
      'FilePlace($name'
      '${lat != null ? ' @$lat,$lon' : ''})';
}

class PlaceFileFormat implements Exception {
  final String message;
  const PlaceFileFormat(this.message);
  @override
  String toString() => 'PlaceFileFormat: $message';
}

/// What was found, and what could not be.
class PlaceFileResult {
  final List<FilePlace> places;

  /// Rows that parsed but had nothing to search for. Reported rather than
  /// hidden: "imported 40 of 60" needs the other twenty explained.
  final int skipped;

  /// A label for the collection, when the file carries one — a KML document
  /// name, a Takeout list title. Offered as the default guide name.
  final String? title;

  const PlaceFileResult({required this.places, this.skipped = 0, this.title});
}

// ---------------------------------------------------------------- dispatch

/// Picks a parser by looking at the content, not the file extension.
///
/// Extensions lie: Google Takeout ships `.json` files that are GeoJSON, `.csv`
/// files with three different column sets, and users rename things. Sniffing
/// the first non-blank characters is more reliable than trusting the name.
PlaceFileResult readPlaceFile(String text, {String? filename}) {
  final trimmed = text.trimLeft();
  if (trimmed.isEmpty) throw const PlaceFileFormat('the file is empty');

  if (trimmed.startsWith('<')) return _readXml(trimmed);
  if (trimmed.startsWith('{') || trimmed.startsWith('[')) {
    return _readJson(trimmed);
  }
  return _readCsv(text);
}

// ---------------------------------------------------------------- CSV

/// Splits one CSV line, honouring quotes and doubled quotes inside them.
///
/// Hand-rolled rather than pulled from a package: these files routinely
/// contain commas inside quoted place names ("Nando's, Soho") and a naive
/// split on comma silently shifts every later column.
List<String> splitCsvLine(String line) {
  final out = <String>[];
  final field = StringBuffer();
  var quoted = false;
  for (var i = 0; i < line.length; i++) {
    final c = line[i];
    if (quoted) {
      if (c == '"') {
        if (i + 1 < line.length && line[i + 1] == '"') {
          field.write('"');
          i++;
        } else {
          quoted = false;
        }
      } else {
        field.write(c);
      }
    } else if (c == '"') {
      quoted = true;
    } else if (c == ',') {
      out.add(field.toString().trim());
      field.clear();
    } else {
      field.write(c);
    }
  }
  out.add(field.toString().trim());
  return out;
}

/// Rows can span lines when a quoted field contains a newline, which Google
/// My Maps descriptions frequently do.
List<List<String>> _csvRows(String text) {
  final rows = <List<String>>[];
  final current = StringBuffer();
  var quotes = 0;
  for (final line in const LineSplitter().convert(text)) {
    current.write(current.isEmpty ? line : '\n$line');
    quotes += line.split('"').length - 1;
    if (quotes.isEven) {
      final row = splitCsvLine(current.toString());
      if (row.any((c) => c.isNotEmpty)) rows.add(row);
      current.clear();
      quotes = 0;
    }
  }
  if (current.isNotEmpty) rows.add(splitCsvLine(current.toString()));
  return rows;
}

/// Header names each exporter uses for the same thing.
const _nameHeaders = ['title', 'name', 'place', 'location name', 'label'];
const _latHeaders = ['latitude', 'lat', 'y'];
const _lonHeaders = ['longitude', 'lon', 'lng', 'long', 'x'];
const _addressHeaders = ['address', 'formatted address', 'vicinity', 'street'];
const _urlHeaders = ['url', 'google maps url', 'link'];

int _indexOf(List<String> header, List<String> candidates) {
  for (final want in candidates) {
    final i = header.indexWhere((h) => h.toLowerCase().trim() == want);
    if (i >= 0) return i;
  }
  return -1;
}

/// Google Takeout's saved-place CSVs give a Maps URL and no coordinates.
/// The URL often carries `!3dLAT!4dLON` or `@LAT,LON`, which is worth mining
/// because it turns a bare name into an aimed search.
({double lat, double lon})? _coordsFromUrl(String url) {
  final bang = RegExp(r'!3d(-?\d+\.\d+)!4d(-?\d+\.\d+)').firstMatch(url);
  if (bang != null) {
    return (
      lat: double.parse(bang.group(1)!),
      lon: double.parse(bang.group(2)!),
    );
  }
  final at = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)').firstMatch(url);
  if (at != null) {
    return (lat: double.parse(at.group(1)!), lon: double.parse(at.group(2)!));
  }
  final q = RegExp(r'[?&]q=(-?\d+\.\d+),(-?\d+\.\d+)').firstMatch(url);
  if (q != null) {
    return (lat: double.parse(q.group(1)!), lon: double.parse(q.group(2)!));
  }
  return null;
}

double? _coord(String? raw, {required double limit}) {
  if (raw == null || raw.isEmpty) return null;
  final v = double.tryParse(raw);
  if (v == null || v.isNaN || v.abs() > limit) return null;
  return v;
}

PlaceFileResult _readCsv(String text) {
  final rows = _csvRows(text);
  if (rows.isEmpty) throw const PlaceFileFormat('no rows in that file');

  // Takeout prefixes some exports with a comment line before the header.
  var start = 0;
  while (start < rows.length && _indexOf(rows[start], _nameHeaders) < 0) {
    start++;
    if (start > 5) break;
  }
  if (start >= rows.length || _indexOf(rows[start], _nameHeaders) < 0) {
    throw const PlaceFileFormat(
      'no column that looks like a place name — expected one called '
      'Title, Name or Place',
    );
  }

  final header = rows[start];
  final iName = _indexOf(header, _nameHeaders);
  final iLat = _indexOf(header, _latHeaders);
  final iLon = _indexOf(header, _lonHeaders);
  final iAddr = _indexOf(header, _addressHeaders);
  final iUrl = _indexOf(header, _urlHeaders);

  String? cell(List<String> row, int i) =>
      i >= 0 && i < row.length && row[i].isNotEmpty ? row[i] : null;

  final places = <FilePlace>[];
  var skipped = 0;
  for (final row in rows.skip(start + 1)) {
    final name = cell(row, iName);
    if (name == null) {
      skipped++;
      continue;
    }
    var lat = _coord(cell(row, iLat), limit: 90);
    var lon = _coord(cell(row, iLon), limit: 180);
    if (lat == null || lon == null) {
      final url = cell(row, iUrl);
      final fromUrl = url == null ? null : _coordsFromUrl(url);
      lat ??= fromUrl?.lat;
      lon ??= fromUrl?.lon;
    }
    places.add(
      FilePlace(name: name, lat: lat, lon: lon, address: cell(row, iAddr)),
    );
  }
  return PlaceFileResult(places: places, skipped: skipped);
}

// ---------------------------------------------------------------- JSON

PlaceFileResult _readJson(String text) {
  final Object? doc;
  try {
    doc = jsonDecode(text);
  } on FormatException catch (e) {
    throw PlaceFileFormat('not valid JSON: ${e.message}');
  }

  final places = <FilePlace>[];
  var skipped = 0;
  String? title;

  void addFeature(Map<Object?, Object?> f) {
    final props = (f['properties'] as Map?) ?? const {};
    final geom = (f['geometry'] as Map?) ?? const {};
    final coords = geom['coordinates'];
    double? lat, lon;
    // GeoJSON is [longitude, latitude] — the reverse of how everyone says it,
    // and swapping them puts London in the Indian Ocean.
    if (coords is List && coords.length >= 2) {
      lon = (coords[0] as num?)?.toDouble();
      lat = (coords[1] as num?)?.toDouble();
    }
    final name =
        [
          props['name'],
          props['Title'],
          props['title'],
          props['location'] is Map ? (props['location'] as Map)['name'] : null,
        ].whereType<String>().firstWhere(
          (s) => s.trim().isNotEmpty,
          orElse: () => '',
        );
    final address =
        [
          props['address'],
          props['Address'],
          props['location'] is Map
              ? (props['location'] as Map)['address']
              : null,
        ].whereType<String>().firstWhere(
          (s) => s.trim().isNotEmpty,
          orElse: () => '',
        );

    if (name.isEmpty) {
      skipped++;
      return;
    }
    places.add(
      FilePlace(
        name: name,
        lat: lat,
        lon: lon,
        address: address.isEmpty ? null : address,
      ),
    );
  }

  if (doc is Map) {
    title = doc['name'] as String?;
    final features = doc['features'];
    if (features is List) {
      for (final f in features) {
        if (f is Map<Object?, Object?>) addFeature(f);
      }
    } else {
      throw const PlaceFileFormat(
        'JSON with no "features" list — expected GeoJSON or a Google '
        'Takeout saved-places export',
      );
    }
  } else if (doc is List) {
    for (final f in doc) {
      if (f is Map<Object?, Object?>) addFeature(f);
    }
  }

  if (places.isEmpty && skipped == 0) {
    throw const PlaceFileFormat('no places in that JSON');
  }
  return PlaceFileResult(places: places, skipped: skipped, title: title);
}

// ---------------------------------------------------------------- KML / GPX

/// Deliberately a small tag scanner rather than a full XML parser.
///
/// KML and GPX from real exporters contain CDATA, HTML inside descriptions,
/// namespaces, and extension elements nobody documents. Pulling out the three
/// element types that matter is more robust here than modelling the schema,
/// and cannot throw on an element it has never seen.
String? _tagText(String xml, String tag) {
  final m = RegExp(
    '<$tag\\b[^>]*>(.*?)</$tag>',
    dotAll: true,
    caseSensitive: false,
  ).firstMatch(xml);
  if (m == null) return null;
  var text = m.group(1)!;
  final cdata = RegExp(r'<!\[CDATA\[(.*?)\]\]>', dotAll: true).firstMatch(text);
  if (cdata != null) text = cdata.group(1)!;
  text = text.replaceAll(RegExp('<[^>]*>'), ' ');
  return _unescape(text).replaceAll(RegExp(r'\s+'), ' ').trim();
}

String _unescape(String s) => s
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll('&quot;', '"')
    .replaceAll('&apos;', "'")
    .replaceAll('&#39;', "'")
    .replaceAll('&amp;', '&');

PlaceFileResult _readXml(String xml) {
  final places = <FilePlace>[];
  var skipped = 0;

  // KML placemarks.
  for (final m in RegExp(
    r'<Placemark\b[^>]*>(.*?)</Placemark>',
    dotAll: true,
    caseSensitive: false,
  ).allMatches(xml)) {
    final body = m.group(1)!;
    final name = _tagText(body, 'name') ?? '';
    if (name.isEmpty) {
      skipped++;
      continue;
    }
    double? lat, lon;
    final coordText = _tagText(body, 'coordinates');
    if (coordText != null && coordText.isNotEmpty) {
      // KML is longitude,latitude[,altitude] — same trap as GeoJSON. A
      // LineString carries many; the first is the right anchor for a search.
      final parts = coordText.split(RegExp(r'\s+')).first.split(',');
      if (parts.length >= 2) {
        lon = double.tryParse(parts[0]);
        lat = double.tryParse(parts[1]);
      }
    }
    final address = _tagText(body, 'address');
    places.add(FilePlace(name: name, lat: lat, lon: lon, address: address));
  }

  // GPX waypoints, where the coordinates are attributes rather than text.
  for (final m in RegExp(
    r'<(wpt|trkpt|rtept)\b([^>]*)>(.*?)</\1>',
    dotAll: true,
    caseSensitive: false,
  ).allMatches(xml)) {
    final attrs = m.group(2)!;
    final body = m.group(3)!;
    final name = _tagText(body, 'name') ?? '';
    if (name.isEmpty) {
      skipped++;
      continue;
    }
    double? attr(String key) => double.tryParse(
      RegExp(
            '$key\\s*=\\s*"([^"]*)"',
            caseSensitive: false,
          ).firstMatch(attrs)?.group(1) ??
          '',
    );
    // GPX 1.1 has no address element, so an address travels in <cmt> and
    // <desc> -- which is where Wren's own writer puts it. Reading neither meant
    // a file Wren wrote came back with no addresses at all, and the Google Maps
    // route then handed Google a restaurant name to geocode instead of a street.
    //
    // <cmt> first: the writer puts the bare address there, while <desc> may also
    // carry the note about what a screenshot was read as.
    final said = _tagText(body, 'cmt') ?? _tagText(body, 'desc');
    places.add(
      FilePlace(name: name, lat: attr('lat'), lon: attr('lon'), address: said),
    );
  }

  if (places.isEmpty && skipped == 0) {
    throw const PlaceFileFormat(
      'no placemarks or waypoints in that file — expected KML or GPX',
    );
  }

  // KML keeps the list name in <Document><name>, before the first Placemark --
  // searching the whole document would find the first place's name instead.
  final kmlTitle = _tagText(xml, 'Document') == null
      ? null
      : _tagText(
          RegExp(
                r'<Document\b[^>]*>(.*?)(<Placemark|\Z)',
                dotAll: true,
                caseSensitive: false,
              ).firstMatch(xml)?.group(1) ??
              '',
          'name',
        );

  // GPX keeps it in <metadata><name>, which this reader ignored -- so a file
  // Wren had written itself came back untitled, and a list name survived the
  // trip out to another app and was lost on the way back in.
  final gpxTitle = _tagText(
    RegExp(
          r'<metadata\b[^>]*>(.*?)</metadata>',
          dotAll: true,
          caseSensitive: false,
        ).firstMatch(xml)?.group(1) ??
        '',
    'name',
  );

  return PlaceFileResult(
    places: places,
    skipped: skipped,
    title: kmlTitle ?? gpxTitle,
  );
}
