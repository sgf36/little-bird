/// Builds guide links for subsets of a muid list, to find which ones Apple has
/// stopped serving.
///
///     dart run tool/prune_probe.dart <muids.json> [start] [count]
///
/// Why this exists. Apple silently drops a place whose muid it no longer serves:
/// a real 82-place guide republishes as 80, consistently. The payload is correct
/// and there is no error — Apple simply has no record any more, so those two
/// places are already unreachable in the guide they sit in.
///
/// Which two cannot be worked out from the payload. `MKMapItemRequest` returning
/// nil identifies one, but that needs a device. The other way is to ask Apple:
/// maps.apple.com renders a `?_col=` link and lists the places it recognised, so
/// a subset that comes back short contains a dead muid, and bisection finds it.
/// That is what this prints links for.
///
/// Uses the app's own encoder rather than a second implementation, because a
/// hand-rolled payload would be plausible, wrong, and open as an empty guide.
library;


import 'dart:io';

import 'package:wren/src/guide_link.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('usage: prune_probe.dart <muids.json> [start] [count]');
    exit(2);
  }
  // Read the digits as text, never through jsonDecode. A muid is a uint64 and
  // most of these exceed 2^63, so Dart parses them as doubles and
  // 16155008034902965835 arrives as 1.6155008034902966e+19 — a different place,
  // silently. Exactly the class of error this whole file exists to catch.
  final text = File(args[0]).readAsStringSync();
  final all = [
    for (final m in RegExp(r'\d{6,}').allMatches(text))
      PlaceId.parse(BigInt.parse(m.group(0)!).toRadixString(16)),
  ];

  final start = args.length > 1 ? int.parse(args[1]) : 0;
  final count = args.length > 2 ? int.parse(args[2]) : all.length - start;
  final slice = all.sublist(start, (start + count).clamp(0, all.length));

  // No names: Apple overrides them from its own record anyway, and leaving them
  // out is what keeps 82 places inside one link.
  final links = buildGuideLinks('Pruned', [
    for (final id in slice) GuidePlace(id: id, name: ''),
  ]);
  if (links.length != 1) {
    stderr.writeln('${slice.length} places needs ${links.length} links — '
        'probe a smaller range');
    exit(1);
  }
  stdout.writeln('places: ${slice.length}  (index $start..${start + slice.length - 1})');
  stdout.writeln('chars: ${links.single.length}');
  stdout.writeln(links.single);
}
