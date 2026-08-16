import 'guide_link.dart';

/// A candidate match for a name read off a screenshot.
class PlaceMatch {
  final PlaceId id;
  final String name;
  final String address;
  final String? category;

  /// Metres from the search centre. Apple's search region is a hint rather
  /// than a filter — a query for a Tokyo ramen shop returned a city 114 km
  /// away — so distance has to be enforced by the caller.
  final double? metresFromCentre;

  const PlaceMatch({
    required this.id,
    required this.name,
    required this.address,
    this.category,
    this.metresFromCentre,
  });
}

abstract class PlaceResolver {
  /// Resolves a name to candidates, best first.
  ///
  /// [cityHint] should be whatever the reel actually said — a city, a district,
  /// a dish. Append facts, never guesses: adding the city rescued a failed
  /// lookup in testing, while adding an inferred "restaurant" returned a
  /// confidently wrong establishment with a perfectly valid id.
  Future<List<PlaceMatch>> resolve(String name, {String? cityHint});
}

/// Talks to the Cloudflare Worker, which holds the Maps Server API key and
/// signs the ES256 JWT. The key must not ship in the app.
///
/// Not implemented yet: it needs a Maps identifier and a .p8 private key from
/// the developer portal, and confirmation that /v1/search returns place ids in
/// the `I`+hex form. Both are Windows-friendly — no Apple hardware involved.
class MapsServerResolver implements PlaceResolver {
  final Uri endpoint;
  MapsServerResolver(this.endpoint);

  @override
  Future<List<PlaceMatch>> resolve(String name, {String? cityHint}) async {
    throw UnimplementedError(
      'wire this to the Worker once a Maps Server API key exists',
    );
  }
}

/// Returns real, verified places regardless of the query, so the rest of the
/// app can be built and demonstrated before any API key exists.
///
/// Every id here was confirmed to populate a guide on a physical iPhone.
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
    await Future<void>.delayed(const Duration(milliseconds: 250));
    // Deterministic pick, so the same query always yields the same stub.
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

/// Rejects matches that cannot go in a guide, or that are too far away to be
/// what the reel meant.
///
/// When Apple cannot find a business it returns a geographic area instead —
/// no identifier and no category. That makes the unusable results detectable
/// for free, which is the one piece of luck in the whole resolution story.
List<PlaceMatch> usable(List<PlaceMatch> matches, {double maxMetres = 30000}) =>
    matches
        .where((m) => m.category != null)
        .where(
          (m) => m.metresFromCentre == null || m.metresFromCentre! <= maxMetres,
        )
        .toList();
