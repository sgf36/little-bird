import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'theme.dart';
import 'wren_mark.dart';

/// The opening sequence: the bird settles, flicks its tail twice, and the name
/// arrives underneath.
///
/// A cocked tail flicking is what a real wren does constantly, and it is the
/// one movement that reads as *this* bird rather than any bird — which is why
/// the animation is a tail flick and not a generic fade.
///
/// Kept to roughly 1.6 seconds, and skippable by tapping. Respects
/// `disableAnimations`, so a launch sequence never stands between someone with
/// motion sensitivity and their app.
class SplashGate extends StatefulWidget {
  const SplashGate({super.key, required this.child});

  final Widget child;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  bool _done = false;

  // Arrival.
  late final Animation<double> _markIn = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.00, 0.28, curve: Curves.easeOutBack),
  );
  // Two flicks, then still.
  late final Animation<double> _flick = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween(0), weight: 30),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.0,
        end: -16.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 9,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: -16.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 11,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.0,
        end: -11.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 8,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: -11.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 10,
    ),
    TweenSequenceItem(tween: ConstantTween(0), weight: 32),
  ]).animate(_c);
  // The body dips a little as the tail goes up, the way a perched bird does.
  late final Animation<double> _bob = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween(0), weight: 30),
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.6), weight: 9),
    TweenSequenceItem(tween: Tween(begin: 1.6, end: 0.0), weight: 11),
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.1), weight: 8),
    TweenSequenceItem(tween: Tween(begin: 1.1, end: 0.0), weight: 10),
    TweenSequenceItem(tween: ConstantTween(0), weight: 32),
  ]).animate(_c);
  late final Animation<double> _wordIn = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.55, 0.80, curve: Curves.easeOut),
  );
  late final Animation<double> _fadeOut = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.88, 1.00, curve: Curves.easeIn),
  );

  @override
  void initState() {
    super.initState();
    _c.addStatusListener((s) {
      if (s == AnimationStatus.completed && mounted) {
        setState(() => _done = true);
      }
    });
    // Honour the system setting rather than insisting on the flourish.
    final reduced = SchedulerBinding
        .instance
        .platformDispatcher
        .accessibilityFeatures
        .disableAnimations;
    if (reduced) {
      _done = true;
    } else {
      _c.forward();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _skip() {
    if (!_done) setState(() => _done = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return widget.child;

    return GestureDetector(
      onTap: _skip,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) => Opacity(
          opacity: 1 - _fadeOut.value,
          child: ColoredBox(
            color: Wren.ground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: 0.82 + 0.18 * _markIn.value,
                    child: Opacity(
                      opacity: _markIn.value.clamp(0, 1),
                      child: SizedBox(
                        width: 132,
                        height: 132,
                        child: CustomPaint(
                          painter: WrenPainter(
                            tailFlick: _flick.value,
                            bob: _bob.value,
                            body: Wren.gold,
                            beak: Wren.clay,
                            eye: Wren.ground,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Opacity(
                    opacity: _wordIn.value,
                    child: Transform.translate(
                      offset: Offset(0, 8 * (1 - _wordIn.value)),
                      child: const Text(
                        'Wren',
                        style: TextStyle(
                          fontFamily: Wren.serif,
                          fontSize: 34,
                          color: Wren.text,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Opacity(
                    opacity: _wordIn.value * 0.85,
                    child: const Text(
                      'A little bird told me.',
                      style: TextStyle(
                        fontFamily: Wren.serif,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        color: Wren.gold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
