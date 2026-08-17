/// The store screenshots, defined as scenes the real app can be put into.
///
/// Screenshots used to be taken by hand on a phone, which meant they were in
/// one language, at whatever size that phone happens to be — an iPhone 16 Pro
/// shoots 1206x2622 and the App Store wants 1290x2796 — and had to be retaken
/// from scratch for a one-word change. All three problems are the same problem:
/// a person in the loop.
///
/// So a scene is a set of fixtures plus, sometimes, one of the app's own
/// overlays to open. Everything below builds the **real** [CapturePage]; nothing
/// here reimplements a card, a dialog or a sheet. That is the whole point. A
/// harness that drew its own version of the paywall would keep producing
/// handsome screenshots of a paywall the app no longer has.
///
/// Driven from `store/shoot.py`, which boots a simulator of exactly the right
/// size, sets the device language, and launches this build once per scene with
/// `SIMCTL_CHILD_WREN_SCENE` naming the one it wants.
library;

import 'dart:io' show Directory, File, Platform;

import 'package:flutter/material.dart';

import '../main.dart';
import 'entitlement.dart';
import 'file_source.dart';
import 'guide_link.dart';
import 'resolver.dart';
import 'theme.dart';

/// Fixed, device-verified places. Real muids from real London businesses, so a
/// screenshot shows what the app actually produces; and real addresses, because
/// invented ones look invented.
const _fixtures = <(String, String, String)>[
  ('I43FA2531C5B5D635', 'Dishoom Shoreditch', '7 Boundary St, London E2 7JE'),
  ('I655EEDD5976A0811', 'Wright Brothers', '11 Stoney St, London SE1 9AD'),
  ('I94FE63725FB590E2', "Elliot's", '12 Stoney St, London SE1 9AD'),
  ('I52BEC654CD7F9E76', 'Arabica', '3 Rochester Walk, London SE1 9AF'),
  ('I137AF3B095BD9DE0', 'Black & Blue', 'Borough Market, London SE1'),
  ('I2C6B1D3F8A945E17', 'Padella', '6 Southwark St, London SE1 1TQ'),
];

/// What the screenshot claims OCR read. Deliberately *not* the same string as
/// the resolved name: the app's whole argument is that it shows you what it read
/// beside what it found, and a screenshot where the two match hides that.
const _readAs = <String>[
  'DISHOOM',
  'wright bros oyster',
  'elliots',
  'Arabica Bar & Kitchen',
  'black + blue',
  'PADELLA',
];

Pending _place(int i, {Origin origin = Origin.screenshot}) => Pending(
  _readAs[i].trim(),
  PlaceMatch(
    id: PlaceId.parse(_fixtures[i].$1),
    name: _fixtures[i].$2,
    address: origin == Origin.guide ? '' : _fixtures[i].$3,
    category: 'Restaurant',
    metresFromCentre: 0,
  ),
  origin: origin,
);

/// A resolver that answers instantly and always. MapKit works in a simulator,
/// but it is a network call: it rate-limits, it can fail, and a screenshot run
/// that half-fails produces images nobody notices are wrong until the store
/// page is live.
class _SceneResolver extends PlaceResolver {
  @override
  Future<Region?> locate(String query) async => Region(
    name: 'London',
    country: 'United Kingdom',
    lat: 51.505,
    lon: -0.09,
  );

  @override
  Future<List<PlaceMatch>> resolve(String name, {Region? region}) async => [
    for (var i = 0; i < 3; i++)
      PlaceMatch(
        id: PlaceId.parse(_fixtures[i].$1),
        name: _fixtures[i].$2,
        address: _fixtures[i].$3,
        category: 'Restaurant',
        metresFromCentre: 120.0 * (i + 1),
      ),
  ];
}

/// A store whose price is supplied rather than read.
///
/// The real one reads StoreKit, which in a simulator with no signed-in account
/// returns nothing, so the paywall fell back to its advertised dollar figure and
/// the screenshot advertised `$4.99` in all ten languages — wrong on every
/// storefront but the American one.
///
/// The price now comes from `store/shot_prices.json`, which `store/iap_prices.py`
/// reads out of Apple's own price schedule, and arrives per launch alongside the
/// scene name. It is never assembled or converted here: Apple's price points are
/// set per market, so a dollar figure multiplied by a rate would be a
/// fabrication that looks like a fact.
class _SceneStore implements UnlockStore {
  @override
  Future<String?> price() async => SceneRequest.scenePrice;
  @override
  Future<bool> buy() async => false;
  @override
  Future<bool> restore() async => false;
}

/// The scenes, keyed by the name `shoot.py` passes in.
///
/// Numbered to match the filenames the store expects, so the order on the
/// product page is the order of this map.
Widget? sceneFor(String name) {
  switch (name) {
    // The core claim: a list of places, each showing what was read beside what
    // was found.
    case '01-the-list':
      return CapturePage(
        store: _SceneStore(),
        resolver: _SceneResolver(),
        files: StubFileSource(''),
        initialPending: [for (var i = 0; i < 5; i++) _place(i)],
      );

    // The new one: places carried over from a guide the user already has,
    // collapsed into a group, with two freshly added underneath.
    case '02-add-to-a-guide':
      return CapturePage(
        store: _SceneStore(),
        resolver: _SceneResolver(),
        files: StubFileSource(''),
        initialGuideName: 'London, October',
        initialPending: [
          for (var i = 0; i < 4; i++) _place(i, origin: Origin.guide),
          _place(4),
          _place(5),
        ],
      );

    // A name the map did not recognise, and the lookup opened on it. Shows the
    // app admitting a miss, which matters more in a store listing than it
    // looks: it is the difference between a tool and a magic trick.
    case '03-correct-a-place':
      return CapturePage(
        store: _SceneStore(),
        resolver: _SceneResolver(),
        files: StubFileSource(''),
        initialPending: [Pending('Mr Foggs Botanical', null), _place(0)],
        initialOverlay: ScreenshotOverlay.search,
      );

    // Where the batch is. The question that makes the difference between
    // "Fuunji" resolving in Tokyo and resolving 114 km away.
    case '04-which-city':
      return CapturePage(
        store: _SceneStore(),
        resolver: _SceneResolver(),
        files: StubFileSource(''),
        initialPending: [for (var i = 0; i < 3; i++) _place(i)],
        initialOverlay: ScreenshotOverlay.region,
      );

    // The purchase. Apple requires the price and the terms be honest on the
    // page as well as in the app.
    case '05-places-kept':
      return CapturePage(
        store: _SceneStore(),
        resolver: _SceneResolver(),
        files: StubFileSource(''),
        initialPending: [for (var i = 0; i < 6; i++) _place(i)],
        initialOverlay: ScreenshotOverlay.paywall,
      );

    // The empty state, which is also the app's pitch in one sentence.
    case '06-a-little-bird':
      return CapturePage(
        store: _SceneStore(),
        resolver: _SceneResolver(),
        files: StubFileSource(''),
      );

    default:
      return null;
  }
}

/// Every scene name, in page order. Cross-checked against the same list in
/// `store/shoot.py`, and rendered in every shot language by scene_render_test.
const sceneNames = <String>[
  '01-the-list',
  '02-add-to-a-guide',
  '03-correct-a-place',
  '04-which-city',
  '05-places-kept',
  '06-a-little-bird',
];

/// The file shoot.py writes into the app's own tmp directory to name the scene.
///
/// The second of two routes, and it exists because the first one silently
/// delivered nothing. `simctl launch` is documented to hand `SIMCTL_CHILD_*`
/// variables to the app with the prefix stripped, and on the run of 17 August
/// 2026 all sixty-four screenshots came out as [UnknownScene] with an **empty**
/// name: the variable never arrived, on a freshly-created iOS 26 simulator.
///
/// This route depends on nothing being passed in. `Directory.systemTemp` on iOS
/// is `TMPDIR`, which the system sets to the app's own tmp directory, and
/// shoot.py reaches the same directory on the host through
/// `simctl get_app_container <udid> <bundle> data`. Both routes are still tried,
/// and [SceneRequest.sources] records what each one held so a failure says which
/// mechanism broke instead of leaving it to be guessed at again.
const sceneFileName = 'wren-scene.txt';

/// Which scene the app was asked for, and what every route to that answer held.
class SceneRequest {
  const SceneRequest({required this.name, required this.sources});

  /// The scene to render. Empty when no route produced one.
  final String name;

  /// Every route consulted, in order, with what it contained. Rendered on screen
  /// by [UnknownScene], so a bad run is diagnosable from the screenshot itself
  /// rather than from a log that may not have been kept.
  final List<(String, String)> sources;

  static String _show(String? v) => v == null
      ? 'not set'
      : v.trim().isEmpty
      ? 'set but empty (${v.length} chars)'
      : '"${v.trim()}"';

  static SceneRequest resolve() {
    final sources = <(String, String)>[];
    String? found;
    String? price;

    final env = Platform.environment['WREN_SCENE'];
    sources.add(('env WREN_SCENE', _show(env)));
    if (env != null && env.trim().isNotEmpty) found = env.trim();

    final path = '${Directory.systemTemp.path}/$sceneFileName';
    try {
      final file = File(path);
      final text = file.existsSync() ? file.readAsStringSync() : null;
      sources.add(('file $path', _show(text)));
      // First line names the scene; an optional `price=` line carries the real
      // storefront price for the language being shot. See [scenePrice].
      for (final line in (text ?? '').split('\n')) {
        final trimmed = line.trim();
        if (trimmed.isEmpty) continue;
        if (trimmed.startsWith('price=')) {
          price = trimmed.substring('price='.length).trim();
        } else {
          found ??= trimmed;
        }
      }
      if (price != null) sources.add(('price', '"$price"'));
    } catch (e) {
      sources.add(('file $path', 'unreadable: $e'));
    }
    _price = price;

    // Separates "dart:io saw no environment at all" from "the variable
    // specifically was not passed" — the same empty string, two different bugs.
    sources.add((
      'env vars visible',
      '${Platform.environment.length}'
          '${Platform.environment.containsKey('TMPDIR') ? ' (TMPDIR present)' : ''}',
    ));

    return SceneRequest(name: found ?? '', sources: sources);
  }

  static String? _price;

  /// The real storefront price for the language being shot, or null.
  ///
  /// Null means the paywall shows the app's own fallback, which is a dollar
  /// figure — correct in the United States and nowhere else. Read by
  /// [_SceneStore] in place of a StoreKit call a simulator cannot make.
  static String? get scenePrice => _price;

  /// One line for the device log, which shoot.py reads back after each launch.
  String get logLine =>
      'WREN-SHOTS scene="$name" '
      '${sources.map((s) => '${s.$1}=${s.$2}').join(' | ')}';
}

/// Shown when a scene name is not recognised, instead of a blank screen.
///
/// A run that quietly photographed six identical empty screens, uploaded them,
/// and reported success is a specific failure worth designing against. It then
/// happened in the other direction: the screen worked, was photographed
/// sixty-four times, and said only `no scene called ""` — correct, and not
/// enough to act on. So it now prints every route and what each held.
class UnknownScene extends StatelessWidget {
  const UnknownScene(this.name, {super.key, this.sources = const []});

  UnknownScene.from(SceneRequest request, {super.key})
    : name = request.name,
      sources = request.sources;

  final String name;
  final List<(String, String)> sources;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Wren.clay,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name.isEmpty ? 'no scene was named' : 'no scene called "$name"',
              style: const TextStyle(color: Colors.white, fontSize: 26),
            ),
            const SizedBox(height: 20),
            for (final (route, value) in sources)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  '$route\n  $value',
                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
