/// Prints the guide link used by the store screenshots.
///
///     dart run tool/guide_link.dart
///
/// The link is pasted into `store/shoot.py`, which opens it in a simulator's
/// Apple Maps to take the payoff screenshot. It is generated rather than typed
/// because it is a base64 protobuf: a hand-written one would be plausible,
/// wrong, and produce an empty guide that nobody would notice until the store
/// page was live. One was, during this work, which is why this file exists.
///
/// The places are the same fixtures the in-app scenes use — real muids from real
/// London businesses, verified to open on a device.
library;

import 'dart:io';

import 'package:wren/src/guide_link.dart';

void main() {
  const places = <(String, String)>[
    ('I43FA2531C5B5D635', 'Dishoom Shoreditch'),
    ('I655EEDD5976A0811', 'Wright Brothers'),
    ('I94FE63725FB590E2', "Elliot's"),
    ('I52BEC654CD7F9E76', 'Arabica'),
    ('I137AF3B095BD9DE0', 'Black & Blue'),
  ];

  final links = buildGuideLinks('London, October', [
    for (final p in places) GuidePlace(id: PlaceId.parse(p.$1), name: p.$2),
  ]);

  // More than one means the place count outgrew what fits in a single link, and
  // shoot.py has room for exactly one.
  if (links.length != 1) {
    stderr.writeln('expected one link, got ${links.length}');
    exit(1);
  }
  stdout.writeln(links.single);
}
