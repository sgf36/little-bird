/// Where a curated list of places can be sent, and how many taps it really is.
///
/// The honest finding behind this file: **there are not ten Android map apps that
/// take a place list in one tap.** The ten most-installed were surveyed, every
/// claim was then attacked rather than accepted, and most fell over:
///
///   * Komoot (10M+) imports GPX as a *route*, never as named places.
///   * MAPS.ME (50M+) has no `ACTION_SEND` filter at all, so it can never be a
///     share target; the only route depends on evidence from a source tree
///     abandoned in 2020, and there is a free-tier bookmark cap of an
///     unpublished size.
///   * HERE WeGo (10M+) imports only through a picker it opens itself, which a
///     sending app structurally cannot reach — eight to twelve taps.
///   * AllTrails (50M+) has no place entity: a saved item must be a trail or an
///     activity.
///   * Guru Maps caps the free tier at fifteen pinned places and does not
///     document what a longer import does, so a twenty-place list could silently
///     arrive as fifteen and look like a success.
///
/// Five survived, and they are below. Everything else reaches the same file
/// through the system chooser, which needs no per-app knowledge and cannot go
/// stale — the long tail is served without anybody claiming to have tested it.
///
/// One format for all five, and it is **GPX**, not KML. KML is the more widely
/// registered type and it is required by none of the five, while being actively
/// fatal to two: OsmAnd routes an arriving `.kml` or `.kmz` down its track import
/// path, which can never reach favourites, and Mapy does not accept KML at all.
/// What differs per app is the intent, not the bytes.
library;

import 'place_export.dart';
import 'place_share.dart';

/// How much work the user still has to do after tapping Wren's button.
enum TargetEffort {
  /// The file goes straight in. One tap and the places are saved.
  oneTap,

  /// A confirm or a picker inside the other app. Still quick, still honest.
  aFewTaps,

  /// Google Maps, and Mapy. Several taps through a web page or an account,
  /// because neither exposes anything better.
  severalTaps,
}

/// The apps Wren offers by name, most-installed first.
///
/// Every package here is also declared in `<queries>` in AndroidManifest.xml. It
/// has to be: from Android 11 an undeclared package is invisible to
/// `getPackageInfo`, which throws exactly as if the app were not installed — so a
/// missing declaration is a button that never appears on a phone that has the
/// app, with no error anywhere to explain it.
const namedTargets = <MapTarget>[
  MapTarget(
    id: 'organicmaps',
    name: 'Organic Maps',
    // Not app.organicmaps.beta: the beta build type applies no
    // applicationIdSuffix, so beta installs are still app.organicmaps and the
    // suffixed id belongs to nothing.
    packages: ['app.organicmaps', 'app.organicmaps.web'],
    format: PlaceFormat.gpx,
  ),
  MapTarget(
    id: 'osmand',
    name: 'OsmAnd',
    // Free build first: it is the one with 10M+ installs. The paid build is a
    // separate package, and net.osmand.plus covers both OsmAnd+ and the F-Droid
    // build — which does not matter, because the hand-off is identical.
    packages: ['net.osmand', 'net.osmand.plus'],
    format: PlaceFormat.gpx,
    note: 'Then tap "Import as favorites" in OsmAnd',
  ),
  MapTarget(
    id: 'locus',
    name: 'Locus Map',
    // Never menion.android.locus.pro: its listing is gone and the vendor plans
    // to discontinue it.
    packages: ['menion.android.locus'],
    format: PlaceFormat.gpx,
    action: HandoffAction.view,
    // The vendor's own client code sends this nonstandard type. Matching what
    // Locus sends itself is safer than being correct at it.
    mimeType: 'application/gpx',
    // The whole feature. Without this extra the places draw as temporary map
    // objects, never enter the points database, and are gone on restart.
    extras: {'locus.api.android.INTENT_EXTRA_CALL_IMPORT': true},
    note: 'Confirm the import in Locus Map',
  ),
  MapTarget(
    id: 'gaiagps',
    name: 'Gaia GPS',
    packages: ['com.trailbehind.android.gaiagps.pro'],
    format: PlaceFormat.gpx,
    // Open-with is the only route Gaia documents, and nothing shows that its
    // activity reads EXTRA_STREAM — so a share would appear in the sheet and
    // then do nothing, which is the worst of the available failures.
    action: HandoffAction.view,
    note: 'Needs a Gaia account, and the Waypoints layer switched on',
  ),
  MapTarget(
    id: 'mapy',
    name: 'Mapy.com',
    packages: ['cz.seznam.mapy'],
    format: PlaceFormat.gpx,
    action: HandoffAction.view,
    // Offered last and labelled honestly: the import is server-side, so there is
    // no success or failure signal to relay, a Seznam account is officially
    // required, and Wren can neither detect nor satisfy that.
    note: 'Needs a Seznam account, and a few taps to save',
  ),
];

/// Effort per named target. Kept beside the list rather than inside it so the
/// honest answer is visible in one place.
const targetEffort = <String, TargetEffort>{
  'organicmaps': TargetEffort.oneTap,
  'osmand': TargetEffort.aFewTaps,
  'locus': TargetEffort.aFewTaps,
  'gaiagps': TargetEffort.oneTap,
  'mapy': TargetEffort.severalTaps,
};

/// Google Maps, which cannot be one tap and is offered anyway.
///
/// There is no API that writes a Google Maps saved list. The internal endpoint
/// the web page uses, `/maps/d/mutate`, authenticates a live browser session —
/// cookies plus an XSRF token embedded in the page — which no app can hold, and
/// Google blocks sign-in inside a WebView precisely so that no app can try. So
/// the best available route is My Maps in a Custom Tab: a real Chrome, already
/// carrying the session the user signed into once, opened over the app.
///
/// The file is a CSV rather than a GPX on purpose. Google geocodes a name or
/// address column itself on import — proven on a device — so the places need no
/// coordinates at all, and a place Apple could not position still arrives.
const googleMapsTarget = MapTarget(
  id: 'googlemaps',
  name: 'Google Maps',
  packages: [],
  format: PlaceFormat.csv,
  note: 'Opens My Maps — a few taps, and it appears in Maps under You → Maps',
);

/// Where the Custom Tab lands.
///
/// With a remembered map id it goes straight to that map's edit page, skipping
/// the create step. Without one it goes to the list, where the user makes a map
/// once and Wren can remember it afterwards.
String myMapsUrl({String? mapId}) => mapId == null || mapId.isEmpty
    ? 'https://www.google.com/maps/d/'
    : 'https://www.google.com/maps/d/edit?mid=$mapId';

/// Pulls the map id out of a My Maps link the user pastes back.
///
/// Both the edit and view forms carry `mid=`, which is the whole reason the
/// remembered-map shortcut is possible at all.
String? mapIdFrom(String url) =>
    RegExp(r'[?&]mid=([\w-]+)').firstMatch(url)?.group(1);
