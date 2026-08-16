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
  ResolverUnavailable(this.message, {this.throttled = false});
  @override
  String toString() => 'ResolverUnavailable: $message';
}

abstract class PlaceResolver {
  /// Resolves a name to candidates, best first.
  ///
  /// [cityHint] should be whatever context actually exists — a city or a
  /// district. Append facts, never guesses: adding a city rescued a failed
  /// lookup in testing, while adding an inferred "restaurant" returned a
  /// confidently wrong establishment with a perfectly valid id.
  Future<List<PlaceMatch>> resolve(String name, {String? cityHint});
}

/// Resolution through MapKit on the device.
///
/// No API key, no account, no quota — and `MKMapItem.identifier` is the muid an
/// Apple Maps guide link needs, so this is the whole resolution story in one
/// call. Results with no identifier or no category are dropped natively: those
/// are geographic areas rather than businesses, and cannot go in a guide.
class MapKitResolver implements PlaceResolver {
  static const _channel = MethodChannel('littlebird/places');

  /// MapKit throttles bursts with MKError 4, so lookups are spaced out.
  static const _gap = Duration(milliseconds: 350);
  DateTime _last = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  Future<List<PlaceMatch>> resolve(String name, {String? cityHint}) async {
    final since = DateTime.now().difference(_last);
    if (since < _gap) await Future<void>.delayed(_gap - since);
    _last = DateTime.now();

    try {
      final raw = await _channel.invokeMethod<List<Object?>>('search', {
        'query': name,
        if (cityHint != null && cityHint.isNotEmpty) 'cityHint': cityHint,
        'maxMetres': 30000.0,
      });
      if (raw == null) return const [];
      return raw
          .whereType<Map<Object?, Object?>>()
          .map(PlaceMatch.fromMap)
          .toList();
    } on MissingPluginException {
      throw ResolverUnavailable(
        'place lookup needs iOS — there is no implementation on this platform',
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
class StubResolver implements PlaceResolver {
  static const _fixtures = [
    ('I43FA2531C5B5D635', 'Dishoom Shoreditch', '7 Boundary St, London E2 7JE'),
    ('I655EEDD5976A0811', 'Wright Brothers', '11 Stoney St, London SE1 9AD'),
    ('I94FE63725FB590E2', "Elliot's", '12 Stoney St, London SE1 9AD'),
    ('I52BEC654CD7F9E76', 'Arabica', '3 Rochester Walk, London SE1 9AF'),
    ('I137AF3B095BD9DE0', 'Black & Blue', 'Borough Market, London SE1'),
  ];

  @override
  Future<List<PlaceMatch>> resolve(String name, {String? cityHint}) async {
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
