import 'package:flutter/services.dart';

import 'guide_link.dart';

/// A candidate match for a name read off a screenshot.
class PlaceMatch {
  final PlaceId id;
  final String name;
  final String address;
  final String? category;

  /// Metres from the search centre, when one was supplied.
  final double? metresFromCentre;

  const PlaceMatch({
    required this.id,
    required this.name,
    required this.address,
    this.category,
    this.metresFromCentre,
  });

  factory PlaceMatch.fromMap(Map<Object?, Object?> m) => PlaceMatch(
    id: PlaceId.parse(m['placeId'] as String),
    name: (m['name'] as String?) ?? '',
    address: ((m['address'] as String?) ?? '').replaceAll('\n', ', '),
    category: m['category'] as String?,
    metresFromCentre: (m['metresFromCentre'] as num?)?.toDouble(),
  );
}

class ResolverUnavailable implements Exception {
  final String message;
  final bool throttled;

  /// True when there is no MapKit at all, rather than a failure inside it. The
  /// UI replaces the message with a translated one; a message that came back
  /// from the OS is shown as the OS worded it.
  final bool unsupported;

  ResolverUnavailable(
    this.message, {
    this.throttled = false,
    this.unsupported = false,
  });
  @override
  String toString() => 'ResolverUnavailable: $message';
}

/// Where a batch of places is, once it has been confirmed.
class Region {
  final String name;
  final String? country;
  final double lat;
  final double lon;

  const Region({
    required this.name,
    required this.lat,
    required this.lon,
    this.country,
  });

  String get label => country == null ? name : '$name, $country';
}

abstract class PlaceResolver {
  /// Resolves a name to candidates, best first.
  ///
  /// [region], when known, both biases the search and bounds it: MapKit treats
  /// a region as a hint rather than a filter, so distance is enforced against
  /// its centre. Append facts, never guesses — adding a city rescued a failed
  /// lookup in testing, while adding an inferred "restaurant" returned a
  /// confidently wrong establishment with a perfectly valid id.
  Future<List<PlaceMatch>> resolve(String name, {Region? region});

  /// Turns a phrase like "London" into somewhere on the map, or null if it is
  /// not a place. Used to confirm where a batch of screenshots is talking about.
  Future<Region?> locate(String query);

  /// Names and addresses for places we have only identifiers for.
  ///
  /// A guide shared out of Apple Maps carries muids and nothing else, so an
  /// imported guide would otherwise show a row of blanks. iOS 18 can fetch a
  /// place from its identifier, which is the only way to put a name back.
  ///
  /// Returns three separate outcomes — see [PlaceLookup]. Only `gone` means
  /// Apple has no record; `failed` means the question could not be asked, and
  /// the difference matters because `gone` is used to prune a guide.
  ///
  /// Defaults to finding nothing, so a stub or a test resolver need not care.
  Future<PlaceLookup> lookup(List<PlaceId> ids) async => const PlaceLookup();
}

/// What came back from looking identifiers up against Apple Maps.
///
/// Three outcomes, kept apart deliberately. Before this existed the native side
/// discarded the error and simply omitted anything it could not return, so a
/// place Apple has dropped and a place we could not ask about were the same
/// answer. That is fine when names are cosmetic and fatal the moment the result
/// is used as evidence: pruning a guide on an omission would delete live places
/// every time the network hiccuped.
class PlaceLookup {
  const PlaceLookup({
    this.found = const {},
    this.gone = const {},
    this.failed = const {},
  });

  /// Resolved, with Apple's own name and address.
  final Map<PlaceId, PlaceMatch> found;

  /// Apple answered, and has no record. The place is already unreachable in any
  /// guide holding it, so it is safe to drop — and only these are.
  final Set<PlaceId> gone;

  /// The request did not complete. Says nothing about whether the place exists.
  final Set<PlaceId> failed;

  bool get isEmpty => found.isEmpty && gone.isEmpty && failed.isEmpty;
}

/// Resolution through MapKit on the device.
///
/// No API key, no account, no quota — and `MKMapItem.identifier` is the muid an
/// Apple Maps guide link needs, so this is the whole resolution story in one
/// call. Results with no identifier or no category are dropped natively: those
/// are geographic areas rather than businesses, and cannot go in a guide.
class MapKitResolver extends PlaceResolver {
  static const _channel = MethodChannel('littlebird/places');

  /// MapKit throttles bursts with `MKError.loadingThrottled`, so lookups are
  /// spaced out. That is code 3; this comment said 4 for a while, which is
  /// `.placemarkNotFound`, and the native side believed it.
  static const _gap = Duration(milliseconds: 350);
  DateTime _last = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  Future<Region?> locate(String query) async {
    try {
      final m = await _channel.invokeMapMethod<Object?, Object?>('geocode', {
        'query': query,
      });
      if (m == null) return null;
      return Region(
        name: (m['name'] as String?) ?? query,
        country: m['country'] as String?,
        lat: (m['lat'] as num).toDouble(),
        lon: (m['lon'] as num).toDouble(),
      );
    } on MissingPluginException {
      return null;
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<PlaceLookup> lookup(List<PlaceId> ids) async {
    if (ids.isEmpty) return const PlaceLookup();
    PlaceLookup allFailed() => PlaceLookup(failed: ids.toSet());
    try {
      final raw = await _channel.invokeMapMethod<String, Object?>('lookup', {
        'ids': ids.map((i) => i.toString()).toList(),
      });
      if (raw == null) return allFailed();
      final found = <PlaceId, PlaceMatch>{};
      for (final m
          in (raw['found'] as List<Object?>? ?? const [])
              .whereType<Map<Object?, Object?>>()) {
        try {
          final match = PlaceMatch.fromMap(m);
          found[match.id] = match;
        } on FormatException {
          // One unreadable id must not cost the whole batch its names.
          continue;
        }
      }
      Set<PlaceId> ofKey(String key) => {
        for (final s
            in (raw[key] as List<Object?>? ?? const []).whereType<String>())
          if (_parsed(s) != null) _parsed(s)!,
      };
      return PlaceLookup(
        found: found,
        gone: ofKey('gone'),
        failed: ofKey('failed'),
      );
    } on MissingPluginException {
      // No implementation is not evidence about any place.
      return allFailed();
    } on PlatformException {
      return allFailed();
    }
  }

  static PlaceId? _parsed(String raw) {
    try {
      return PlaceId.parse(raw);
    } on FormatException {
      return null;
    }
  }

  /// How long to wait after a throttle, and how many times to try again.
  ///
  /// Apple's throttle is brief, so backing off recovers where giving up does
  /// not. Before this existed a single `MKError.loadingThrottled` ended the whole
  /// import and told the user to "try the rest in a moment" — which is advice the
  /// app could have taken itself.
  static const _backoff = [
    Duration(seconds: 1),
    Duration(seconds: 3),
    Duration(seconds: 6),
  ];

  @override
  Future<List<PlaceMatch>> resolve(String name, {Region? region}) async {
    for (var attempt = 0; ; attempt++) {
      try {
        return await _searchOnce(name, region: region);
      } on ResolverUnavailable catch (e) {
        if (!e.throttled || attempt >= _backoff.length) rethrow;
        await Future<void>.delayed(_backoff[attempt]);
      }
    }
  }

  Future<List<PlaceMatch>> _searchOnce(String name, {Region? region}) async {
    final since = DateTime.now().difference(_last);
    if (since < _gap) await Future<void>.delayed(_gap - since);
    _last = DateTime.now();

    try {
      final raw = await _channel.invokeMethod<List<Object?>>('search', {
        'query': name,
        // A region imported from a file carries a coordinate and no name, and
        // an empty hint would be appended to the query as a trailing space.
        if (region != null && region.name.isNotEmpty) 'cityHint': region.name,
        if (region != null) 'lat': region.lat,
        if (region != null) 'lon': region.lon,
        // A city-sized net when we know where we are; a loose one when we do
        // not, since an unbounded search is how "Fuunji" became a city 114 km
        // away.
        'maxMetres': region == null ? 100000.0 : 40000.0,
      });
      if (raw == null) return const [];
      return raw
          .whereType<Map<Object?, Object?>>()
          .map(PlaceMatch.fromMap)
          .toList();
    } on MissingPluginException {
      throw ResolverUnavailable(
        'place lookup needs iOS — there is no implementation on this platform',
        unsupported: true,
      );
    } on PlatformException catch (e) {
      throw ResolverUnavailable(
        e.message ?? e.code,
        throttled: e.code == 'throttled',
      );
    } on FormatException catch (e) {
      // A result whose identifier is not in the "I"+hex form cannot go in a
      // guide, so treat the batch as unusable rather than guess.
      throw ResolverUnavailable('unexpected place id: ${e.message}');
    }
  }
}

/// Returns fixed, device-verified places regardless of the query, for tests and
/// for running the app on a platform with no MapKit.
class StubResolver extends PlaceResolver {
  static const _fixtures = [
    ('I43FA2531C5B5D635', 'Dishoom Shoreditch', '7 Boundary St, London E2 7JE'),
    ('I655EEDD5976A0811', 'Wright Brothers', '11 Stoney St, London SE1 9AD'),
    ('I94FE63725FB590E2', "Elliot's", '12 Stoney St, London SE1 9AD'),
    ('I52BEC654CD7F9E76', 'Arabica', '3 Rochester Walk, London SE1 9AF'),
    ('I137AF3B095BD9DE0', 'Black & Blue', 'Borough Market, London SE1'),
  ];

  @override
  Future<Region?> locate(String query) async => Region(
    name: query,
    country: 'United Kingdom',
    lat: 51.5074,
    lon: -0.1278,
  );

  @override
  Future<List<PlaceMatch>> resolve(String name, {Region? region}) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    final pick = _fixtures[name.hashCode.abs() % _fixtures.length];
    return [
      PlaceMatch(
        id: PlaceId.parse(pick.$1),
        name: pick.$2,
        address: pick.$3,
        category: 'Restaurant',
        metresFromCentre: 0,
      ),
    ];
  }
}

/// Rejects matches that cannot go in a guide, or are too far to be what was
/// meant. The native side already applies both, so this is a backstop for any
/// other resolver.
List<PlaceMatch> usable(List<PlaceMatch> matches, {double maxMetres = 30000}) =>
    matches
        .where((m) => m.category != null)
        .where(
          (m) => m.metresFromCentre == null || m.metresFromCentre! <= maxMetres,
        )
        .toList();
