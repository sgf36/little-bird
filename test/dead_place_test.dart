import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/guide_link.dart';
import 'package:wren/src/resolver.dart';

/// Pruning a guide of places Apple no longer serves — and, more importantly, not
/// pruning it on anything weaker than that.
///
/// A real 82-place guide republished as 80, consistently and silently: Apple
/// drops a place whose identifier it no longer has, with no error and no gap in
/// the payload. The user sees 82 go in and 80 come out.
///
/// Fixing that needs the app to know WHICH two, and the honest answer was that it
/// could not: the native lookup discarded the error — `getMapItem { item, _ in }`
/// — and simply omitted anything it failed to return. A place Apple had dropped
/// and a place we could not ask about arrived as the same answer, an absent id.
/// That is harmless while names are cosmetic and dangerous the moment the result
/// is used to delete things.
///
/// So [PlaceLookup] keeps three outcomes apart, and only `gone` may prune. The
/// last test here is the one worth keeping: a lookup that fails must leave every
/// place alone, because a network hiccup is not evidence of death.
void main() {
  PlaceId id(String hex) => PlaceId.parse(hex);

  final dishoom = id('I43FA2531C5B5D635');
  final wright = id('I655EEDD5976A0811');
  final elliots = id('I94FE63725FB590E2');

  test('a default resolver claims nothing about any place', () {
    // The base class must not imply death by silence either.
    const empty = PlaceLookup();
    expect(empty.found, isEmpty);
    expect(empty.gone, isEmpty);
    expect(empty.failed, isEmpty);
    expect(empty.isEmpty, isTrue);
  });

  test('found, gone and failed do not overlap or collapse', () {
    final r = PlaceLookup(
      found: {
        dishoom: PlaceMatch(
          id: dishoom,
          name: 'Dishoom Shoreditch',
          address: '7 Boundary St',
        ),
      },
      gone: {wright},
      failed: {elliots},
    );
    expect(r.found.keys, [dishoom]);
    expect(r.gone, {wright});
    expect(r.failed, {elliots});
    // The distinction the whole change exists to preserve.
    expect(
      r.gone.contains(elliots),
      isFalse,
      reason: 'a failed request must never be reported as gone',
    );
    expect(r.isEmpty, isFalse);
  });

  test('an unreachable service reports every id as failed, none as gone', () {
    // What MapKitResolver does when the channel throws or is missing. If this
    // ever returns `gone` instead, a guide gets pruned to nothing the first time
    // someone imports one on a train.
    final ids = [dishoom, wright, elliots];
    final offline = PlaceLookup(failed: ids.toSet());
    expect(offline.gone, isEmpty);
    expect(offline.failed.length, 3);
    expect(offline.found, isEmpty);
  });
}
