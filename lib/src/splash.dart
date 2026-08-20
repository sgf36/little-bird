import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../l10n/app_localizations.dart';
import 'theme.dart';
import 'wren_mark.dart';

/// The opening sequence: the bird settles, flicks its tail twice, and the name
/// arrives underneath.
///
/// A cocked tail flicking is what a real wren does constantly, and it is the
/// one movement that reads as *this* bird rather than any bird — which is why
/// the animation is a tail flick and not a generic fade.
///
/// Four seconds, unhurried: each flick is quick, and the stillness between them
/// is what makes them read as a bird rather than a loading spinner.
///
/// Skippable by tap, and skipped outright when the system asks for reduced
/// motion — a launch flourish should never stand between someone with motion
/// sensitivity and their app.
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
    duration: const Duration(milliseconds: 4000),
  );

  bool _done = false;

  late final Animation<double> _markIn = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.00, 0.12, curve: Curves.easeOutBack),
  );

  // Weights are percentages of the four seconds. The flicks stay fast; the
  // holds around them do the lengthening.
  static const _stillBefore = 20.0;
  static const _outA = 6.0, _backA = 7.0, _between = 7.0;
  static const _outB = 5.0, _backB = 7.0, _stillAfter = 48.0;

  late final Animation<double> _flick = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween(0), weight: _stillBefore),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.0,
        end: -17.0,
      ).chain(CurveTween(curve: Curves.easeOutCubic)),
      weight: _outA,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: -17.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeInOutCubic)),
      weight: _backA,
    ),
    TweenSequenceItem(tween: ConstantTween(0), weight: _between),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.0,
        end: -11.0,
      ).chain(CurveTween(curve: Curves.easeOutCubic)),
      weight: _outB,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: -11.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeInOutCubic)),
      weight: _backB,
    ),
    TweenSequenceItem(tween: ConstantTween(0), weight: _stillAfter),
  ]).animate(_c);

  // The body dips as the tail goes up, the way a perched bird does.
  late final Animation<double> _bob = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween(0), weight: _stillBefore),
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.7), weight: _outA),
    TweenSequenceItem(tween: Tween(begin: 1.7, end: 0.0), weight: _backA),
    TweenSequenceItem(tween: ConstantTween(0), weight: _between),
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.1), weight: _outB),
    TweenSequenceItem(tween: Tween(begin: 1.1, end: 0.0), weight: _backB),
    TweenSequenceItem(tween: ConstantTween(0), weight: _stillAfter),
  ]).animate(_c);

  late final Animation<double> _wordIn = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.54, 0.70, curve: Curves.easeOut),
  );
  late final Animation<double> _fadeOut = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.93, 1.00, curve: Curves.easeIn),
  );

  @override
  void initState() {
    super.initState();
    _c.addStatusListener((s) {
      if (s == AnimationStatus.completed && mounted) {
        setState(() => _done = true);
      }
    });
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

    // Material, not a bare ColoredBox. Without a Material ancestor Flutter
    // falls back to its debug text style, which paints those yellow double
    // underlines under every Text.
    return Material(
      color: Wren.ground,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _skip,
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) => Opacity(
            opacity: 1 - _fadeOut.value,
            child: SplashFace(
              markIn: _markIn.value,
              wordIn: _wordIn.value,
              tailFlick: _flick.value,
              bob: _bob.value,
            ),
          ),
        ),
      ),
    );
  }
}

/// The splash itself, at whatever point of the animation it is asked for.
///
/// Pulled out of [SplashGate] so that one composition serves both the launch
/// animation and the App Store screenshot of it. The screenshot asks for the
/// resting values, which is the frame the animation ends on and the one a
/// person actually looks at — and because it is this widget rather than a
/// picture of it, the shot cannot drift away from what the app shows.
class SplashFace extends StatelessWidget {
  const SplashFace({
    super.key,
    this.markIn = 1,
    this.wordIn = 1,
    this.tailFlick = 0,
    this.bob = 0,
  });

  /// How far in the bird is: 0 before it arrives, 1 settled.
  final double markIn;

  /// How far in the name and the idiom beneath it are.
  final double wordIn;

  /// The tail flick, which is what makes it read as a wren rather than any bird.
  final double tailFlick;

  /// The small vertical bob that goes with a flick.
  final double bob;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 0.82 + 0.18 * markIn,
            child: Opacity(
              opacity: markIn.clamp(0, 1),
              child: SizedBox(
                width: 132,
                height: 132,
                child: CustomPaint(
                  painter: WrenPainter(
                    tailFlick: tailFlick,
                    bob: bob,
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
            opacity: wordIn,
            child: Transform.translate(
              offset: Offset(0, 8 * (1 - wordIn)),
              child: const Text(
                'Wren',
                style: TextStyle(
                  fontFamily: Wren.serif,
                  fontSize: 34,
                  color: Wren.text,
                  letterSpacing: 0.5,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Opacity(
            opacity: wordIn * 0.85,
            child: Padding(
              // The idiom is short in English and long in several other
              // languages, so it is given room rather than clipped.
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                L.of(context).tagline,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Wren.serif,
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  color: Wren.gold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
