/// Writing a curated list of places out to a file another map app can read.
///
/// The mirror of `place_files.dart`, which reads these formats. Reading was the
/// easy direction: a parser that misunderstands a file produces a visible error.
/// Writing is where the silent failures live — a file that imports as an empty
/// list, or drops every place in the sea off West Africa, looks like a working
/// export until somebody opens it.
///
/// Why this exists at all. On iOS, publishing needs no coordinates: an Apple
/// Maps guide link carries identifiers and Apple supplies the position from its
/// own record. Every other map app is the opposite — an OpenStreetMap app does
/// not geocode an incoming file, so a placemark with no coordinate is a
/// placemark it silently discards. That asymmetry is the whole reason
/// [PlaceMatch] had to start carrying lat/lon.
library;

import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:characters/characters.dart';

import 'resolver.dart';

/// The formats worth writing, in order of how widely they are accepted.
enum PlaceFormat {
  /// KML zipped into a single file. What most map apps register a handler for,
  /// and the smallest thing to send.
  kmz,

  /// Plain KML 2.2. Identical content, unzipped — useful when an app matches on
  /// the `.kml` extension only, and for reading the output during a test.
  kml,

  /// GPX 1.1 waypoints. **The format to hand to an Android map app**, and the
  /// only one all the named targets accept as individual named places.
  ///
  /// KML looks like the safer choice — wider ecosystem, an `<address>` element,
  /// what most handlers register for — and it is actively wrong for two of the
  /// five. OsmAnd routes a `.kml` or `.kmz` arriving by intent down its *track*
  /// import path, which can never reach favourites, and Mapy does not accept KML
  /// at all. One format that works everywhere beats two and a per-app branch.
  ///
  /// The price is that GPX 1.1 has no address element, so the address is written
  /// into both `<cmt>` and `<desc>` — some readers surface only the former.
  gpx,

  /// For a spreadsheet, or for Google My Maps, which geocodes a name or address
  /// column itself and therefore does not need the coordinates at all.
  csv,

  /// For anything that speaks GeoJSON, including most web tooling.
  geojson;

  String get extension => switch (this) {
    PlaceFormat.kmz => 'kmz',
    PlaceFormat.kml => 'kml',
    PlaceFormat.gpx => 'gpx',
    PlaceFormat.csv => 'csv',
    PlaceFormat.geojson => 'geojson',
  };

  /// What to tell Android the bytes are.
  ///
  /// `application/vnd.google-earth.kmz` and `.kml+xml` are the registered types
  /// and what handlers filter on. Several apps match the file *extension*
  /// instead, which is why [exportFileName] always ends in a real one.
  String get mimeType => switch (this) {
    PlaceFormat.kmz => 'application/vnd.google-earth.kmz',
    PlaceFormat.kml => 'application/vnd.google-earth.kml+xml',
    PlaceFormat.gpx => 'application/gpx+xml',
    PlaceFormat.csv => 'text/csv',
    PlaceFormat.geojson => 'application/geo+json',
  };

  /// Whether a place with no coordinate can survive this format.
  ///
  /// Only CSV can: Google My Maps geocodes a name or address column on import.
  /// Everything else positions from the coordinate and drops what has none.
  bool get geocodesOnImport => this == PlaceFormat.csv;
}

/// One place, reduced to what a file can carry.
class ExportPlace {
  const ExportPlace({
    required this.name,
    this.address = '',
    this.lat,
    this.lon,
    this.note = '',
  });

  final String name;
  final String address;
  final double? lat;
  final double? lon;

  /// What the screenshot said, when it differs from the matched name. Carried as
  /// a description so the export keeps the same evidence the app shows.
  final String note;

  /// Whether this place can be positioned in a file at all.
  ///
  /// Stricter than a null check, because three kinds of nonsense coordinate all
  /// import without complaint and all look like a working export:
  ///
  ///   * Out of range or non-finite, which some readers clamp and others reject.
  ///   * Exactly 0, 0. OsmAnd's own `hasLocation()` is `lat != 0 && lon != 0`,
  ///     so it treats Null Island as "no location"; everything else stacks the
  ///     pins in the Gulf of Guinea and the export reads as corrupt.
  bool get hasCoordinate {
    final a = lat, o = lon;
    if (a == null || o == null) return false;
    if (!a.isFinite || !o.isFinite) return false;
    if (a.abs() > 90 || o.abs() > 180) return false;
    return !(a == 0 && o == 0);
  }

  /// Built from a resolved place. Returns null for anything unresolved, since a
  /// name with no match is not a place any other app could find.
  static ExportPlace? from(PlaceMatch? match, {String readAs = ''}) {
    if (match == null || match.name.isEmpty) return null;
    return ExportPlace(
      name: match.name,
      address: match.address,
      lat: match.lat,
      lon: match.lon,
      note: readAs.isEmpty || readAs == match.name ? '' : 'Read as "$readAs"',
    );
  }
}

/// What came out, and what could not be written.
class ExportResult {
  const ExportResult({
    required this.bytes,
    required this.fileName,
    required this.format,
    required this.written,
    required this.droppedForNoCoordinate,
    this.droppedOverCap = 0,
  });

  final List<int> bytes;
  final String fileName;
  final PlaceFormat format;

  /// How many places are actually in the file.
  final int written;

  /// Places left out because they had no coordinate and the format cannot
  /// geocode. Reported rather than hidden — a file that quietly contains
  /// fourteen of twenty places is the failure this field exists to prevent.
  final int droppedForNoCoordinate;

  /// Places past [maxPlacesPerFile]. Mapy silently ignores everything after the
  /// thousandth point and Gaia documents the same cap, so the file would import
  /// as a success with places missing off the end.
  final int droppedOverCap;

  bool get isEmpty => written == 0;
}

/// Writes [places] in [format].
///
/// Anything without a coordinate is dropped for every format except CSV, and
/// counted in [ExportResult.droppedForNoCoordinate] so the caller can say so.
ExportResult exportPlaces(
  Iterable<ExportPlace> places,
  PlaceFormat format, {
  String title = 'Places',
}) {
  final all = places.toList();
  final positioned = format.geocodesOnImport
      ? all
      : all.where((p) => p.hasCoordinate).toList();
  final dropped = all.length - positioned.length;

  final overCap = positioned.length > maxPlacesPerFile
      ? positioned.length - maxPlacesPerFile
      : 0;
  final usable = overCap == 0
      ? positioned
      : positioned.take(maxPlacesPerFile).toList();

  final bytes = switch (format) {
    PlaceFormat.kml => utf8.encode(_kml(usable, title)),
    PlaceFormat.kmz => _kmz(usable, title),
    PlaceFormat.gpx => utf8.encode(_gpx(usable, title)),
    PlaceFormat.csv => utf8.encode(_csv(usable)),
    PlaceFormat.geojson => utf8.encode(_geojson(usable, title)),
  };

  return ExportResult(
    bytes: bytes,
    fileName: exportFileName(title, format),
    format: format,
    written: usable.length,
    droppedForNoCoordinate: dropped,
    droppedOverCap: overCap,
  );
}

/// A filename that is safe on every filesystem and still ends in a real
/// extension.
///
/// The extension is not decoration. Handlers that match on `pathPattern` rather
/// than MIME will not see a file called `places`, and a `content://` URI hides
/// everything else about it.
String exportFileName(String title, PlaceFormat format) {
  final stem = title
      .replaceAll(RegExp(r'[^\w\s-]', unicode: true), '')
      .trim()
      .replaceAll(RegExp(r'\s+'), '-')
      .toLowerCase();
  return '${stem.isEmpty ? 'places' : stem}.${format.extension}';
}

/// The most places one file may carry.
///
/// Not a limit of the format. Mapy ignores everything past the thousandth point
/// without a word and Gaia documents the same number, so a longer file is an
/// import that reports success and quietly stops early.
const maxPlacesPerFile = 1000;

/// The longest name one place may carry.
///
/// Mapy fails the *entire* import above two hundred characters, with an error
/// that blames the network rather than the name.
const maxPlaceNameLength = 200;

// ------------------------------------------------------------------ XML/CSV

/// XML text escaping, plus the characters that are not merely awkward but
/// illegal in XML 1.0 at all.
///
/// Both halves are load-bearing and both fail whole-file. One unescaped
/// ampersand makes the document malformed, so every place vanishes rather than
/// just the one with the ampersand in its name. And a stray control byte — which
/// arrives from OCR more often than from anywhere else — kills Organic Maps'
/// parser outright, losing the same import for a character nobody can see.
String _x(String s) => s
    .replaceAll(RegExp('[\u0000-\u0008\u000B\u000C\u000E-\u001F]'), '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;');

/// A name short enough for every importer, cut on a grapheme boundary.
///
/// Cutting on code units would split a family emoji or separate an accent from
/// its letter, which is malformed text rather than a shortened name.
String _name(String s) => s.characters.length <= maxPlaceNameLength
    ? s
    : s.characters.take(maxPlaceNameLength).toString();

/// A coordinate as every importer expects to read it: a plain decimal, six
/// places, no exponent, and a full stop whatever the device's locale prefers.
///
/// `toStringAsFixed` is locale-independent in Dart, which is exactly why it is
/// used here rather than anything from `intl`. A device set to a comma decimal
/// separator would otherwise write `51,5132`, which is either a parse failure or
/// a wrong point depending on who reads it.
String _deg(double v) => v.toStringAsFixed(6);

/// Coordinates for KML, which are **longitude first**.
///
/// This one line is the difference between a working export and every place
/// appearing in the Gulf of Guinea, because 51.5,-0.1 and -0.1,51.5 are both
/// perfectly valid coordinates and only one of them is London. The reading side
/// of this codebase carries the same warning; it is the most common mistake in
/// the format and it fails silently.
String _kmlCoord(ExportPlace p) => '${p.lon},${p.lat},0';

String _kml(List<ExportPlace> places, String title) {
  final marks = places
      .map((p) {
        final address = p.address.isEmpty
            ? ''
            : '      <address>${_x(p.address)}</address>\n';
        final note = p.note.isEmpty
            ? ''
            : '      <description>${_x(p.note)}</description>\n';
        // <address> is written even when a coordinate is present: it costs nothing,
        // and it is what lets the same file work in Google My Maps, which geocodes
        // an address and ignores it otherwise.
        return '    <Placemark>\n'
            '      <name>${_x(p.name)}</name>\n'
            '$address'
            '$note'
            '      <Point><coordinates>${_kmlCoord(p)}</coordinates></Point>\n'
            '    </Placemark>';
      })
      .join('\n');

  return '<?xml version="1.0" encoding="UTF-8"?>\n'
      '<kml xmlns="http://www.opengis.net/kml/2.2">\n'
      '  <Document>\n'
      '    <name>${_x(title)}</name>\n'
      '${marks.isEmpty ? '' : '$marks\n'}'
      '  </Document>\n'
      '</kml>\n';
}

/// KMZ: a zip holding exactly one KML at the root.
///
/// The internal name matters. The convention every reader follows is a single
/// `doc.kml` at the archive root; a nested path or a different name is a file
/// that opens to nothing in some apps and works in others, which is worse than
/// failing outright.
List<int> _kmz(List<ExportPlace> places, String title) {
  final archive = Archive()
    ..addFile(ArchiveFile.string('doc.kml', _kml(places, title)));
  return ZipEncoder().encode(archive);
}

/// GPX 1.1, waypoints only.
///
/// Three things here are schema requirements rather than preferences, and each
/// one fails the whole file rather than the part that broke it:
///
///   * `version` and `creator` on the root element. A validating importer
///     rejects the document without them.
///   * Child order under `<gpx>`: metadata, then waypoints. Nothing else.
///   * Child order inside `<wpt>`: name, cmt, desc, type. `desc` before `name`
///     is invalid, and invalid here means zero places imported.
///
/// And one thing is behavioural: **not one `<trk>`, `<trkseg>`, `<rte>` or
/// `<rtept>` element, not even an empty one.** OsmAnd asks whether the file has
/// any tracks before it asks anything else, so a single empty track turns a list
/// of places into a route, with no dialog and nothing to correct.
String _gpx(List<ExportPlace> places, String title, {String creator = 'Wren'}) {
  final group = _x(title);
  final points = places
      .map((p) {
        // The address goes in both. Some readers surface only <cmt>, and Mapy
        // discards <desc> entirely, so duplicating one string is the difference
        // between a pin that knows its address and a bare name.
        final address = p.address.isEmpty ? '' : _x(p.address);
        final desc = [p.address, p.note].where((s) => s.isNotEmpty).join(' — ');
        // Latitude and longitude are named attributes, so GPX is the one format
        // where the axis order cannot be got wrong by a reader. It can still be
        // got wrong by a writer — hence naming them at the point of use rather
        // than handing two anonymous doubles to a helper.
        return '  <wpt lat="${_deg(p.lat!)}" lon="${_deg(p.lon!)}">\n'
            '    <name>${_x(_name(p.name))}</name>\n'
            '${address.isEmpty ? '' : '    <cmt>$address</cmt>\n'}'
            '${desc.isEmpty ? '' : '    <desc>${_x(desc)}</desc>\n'}'
            // <type> is the category, and OsmAnd files favourites by it. Without
            // it the places land in the undifferentiated default group, mixed in
            // with whatever the user had already saved.
            '    <type>$group</type>\n'
            '  </wpt>';
      })
      .join('\n');

  return '<?xml version="1.0" encoding="UTF-8"?>\n'
      '<gpx version="1.1" creator="${_x(creator)}" '
      'xmlns="http://www.topografix.com/GPX/1/1">\n'
      '  <metadata><name>$group</name></metadata>\n'
      '${points.isEmpty ? '' : '$points\n'}'
      '</gpx>\n';
}

/// One CSV field, quoted only when it has to be.
String _c(String s) =>
    RegExp(r'[",\n]').hasMatch(s) ? '"${s.replaceAll('"', '""')}"' : s;

String _csv(List<ExportPlace> places) {
  // Headers chosen for Google My Maps, which asks which column positions the
  // placemarks and which titles them. "Name" and "Address" are the two it
  // recognises on sight, which keeps that wizard to as few taps as possible.
  final rows = places.map(
    (p) => [
      _c(p.name),
      _c(p.address.isEmpty ? p.name : p.address),
      p.lat?.toString() ?? '',
      p.lon?.toString() ?? '',
      _c(p.note),
    ].join(','),
  );
  return ['Name,Address,Latitude,Longitude,Note', ...rows].join('\n');
}

String _geojson(List<ExportPlace> places, String title) {
  // GeoJSON coordinates are [longitude, latitude] — the same trap as KML, and
  // the reading side of this codebase notes it too.
  final features = places
      .map(
        (p) => {
          'type': 'Feature',
          'properties': {
            'name': p.name,
            if (p.address.isNotEmpty) 'address': p.address,
            if (p.note.isNotEmpty) 'note': p.note,
          },
          'geometry': {
            'type': 'Point',
            'coordinates': [p.lon, p.lat],
          },
        },
      )
      .toList();
  return const JsonEncoder.withIndent(
    '  ',
  ).convert({'type': 'FeatureCollection', 'name': title, 'features': features});
}
