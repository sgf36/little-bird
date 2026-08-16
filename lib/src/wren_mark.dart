import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'theme.dart';

/// The wren, drawn rather than shipped as an image, so the tail can move.
///
/// Geometry is the same 100x100 grid as `tool/make_icon.py` and the favicon —
/// one definition of the bird, three renderings of it. A wren is identifiable
/// from two things and not much else: the tail held cocked, and a thin
/// slightly downcurved beak.
class WrenPainter extends CustomPainter {
  /// Extra tail rotation in degrees, positive meaning cocked further forward.
  final double tailFlick;

  /// Vertical bob in grid units, positive meaning lower.
  final double bob;

  final Color body;
  final Color beak;
  final Color eye;

  const WrenPainter({
    this.tailFlick = 0,
    this.bob = 0,
    required this.body,
    required this.beak,
    required this.eye,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final k = size.shortestSide / 100.0;
    Offset p(double x, double y) => Offset(x * k, (y + bob) * k);

    final bodyPaint = Paint()..color = body;

    // Tail — pivots at the rump so a flick rotates the blade, not the bird.
    final pivot = p(31, 53);
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(tailFlick * math.pi / 180);
    canvas.translate(-pivot.dx, -pivot.dy);
    canvas.drawPath(
      Path()
        ..moveTo(p(22, 62).dx, p(22, 62).dy)
        ..lineTo(p(12, 29).dx, p(12, 29).dy)
        ..lineTo(p(24, 23).dx, p(24, 23).dy)
        ..lineTo(p(31, 50).dx, p(31, 50).dy)
        ..close(),
      bodyPaint,
    );
    canvas.restore();

    canvas.drawOval(
      Rect.fromCenter(center: p(42, 60), width: 46 * k, height: 34 * k),
      bodyPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: p(63, 44), width: 24 * k, height: 23 * k),
      bodyPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(p(74, 42).dx, p(74, 42).dy)
        ..lineTo(p(89, 46).dx, p(89, 46).dy)
        ..lineTo(p(74, 48).dx, p(74, 48).dy)
        ..close(),
      Paint()..color = beak,
    );
    canvas.drawCircle(p(67, 41), 2.3 * k, Paint()..color = eye);
  }

  @override
  bool shouldRepaint(WrenPainter old) =>
      old.tailFlick != tailFlick ||
      old.bob != bob ||
      old.body != body ||
      old.beak != beak ||
      old.eye != eye;
}

/// A static wren on the brand ground, rounded like an app icon.
class WrenMark extends StatelessWidget {
  const WrenMark({super.key, this.size = 40, this.onGround = true});

  final double size;
  final bool onGround;

  @override
  Widget build(BuildContext context) {
    final painter = CustomPaint(
      size: Size.square(size),
      painter: WrenPainter(
        body: Wren.gold,
        beak: Wren.clay,
        eye: onGround ? Wren.ground : Wren.raised,
      ),
    );
    if (!onGround) return painter;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Wren.raised,
        borderRadius: BorderRadius.circular(size * 0.23),
      ),
      child: painter,
    );
  }
}
