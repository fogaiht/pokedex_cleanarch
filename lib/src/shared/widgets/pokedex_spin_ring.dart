import 'dart:math';

import 'package:flutter/widgets.dart';

import '../theme/colors.dart';

class PokedexSpinRing extends StatefulWidget {
  final Color color;
  final double size;
  final double lineWidth;
  final Duration duration;
  final AnimationController? controller;

  const PokedexSpinRing({
    Key? key,
    this.color = ThemeColors.primaryColor,
    this.lineWidth = 3.0,
    this.size = 50,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  }) : super(key: key);

  @override
  _PokedexSpinRingState createState() => _PokedexSpinRingState();
}

class _PokedexSpinRingState extends State<PokedexSpinRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1, _animation2, _animation3;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..addListener(() => setState(() {}))
      ..repeat();
    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1.0)));
    _animation2 = Tween(begin: -2.0 / 3.0, end: 1 / 2).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)));
    _animation3 = Tween(begin: 0.25, end: 5 / 6).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: _PokedexSpinRingCurve())));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        transform: Matrix4.identity()
          ..rotateZ((_animation1.value) * 5 * pi / 6),
        alignment: FractionalOffset.center,
        child: SizedBox.fromSize(
          size: Size.square(widget.size),
          child: CustomPaint(
            foregroundPainter: _RingPainter(
              paintWidth: widget.lineWidth,
              trackColor: widget.color,
              progressPercent: _animation3.value,
              startAngle: pi * _animation2.value,
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.paintWidth,
    required this.progressPercent,
    required this.startAngle,
    required this.trackColor,
  }) : trackPaint = Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = paintWidth
          ..strokeCap = StrokeCap.square;

  final double paintWidth;
  final Paint trackPaint;
  final Color trackColor;
  final double progressPercent;
  final double startAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - paintWidth) / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * pi * progressPercent,
      false,
      trackPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _PokedexSpinRingCurve extends Curve {
  const _PokedexSpinRingCurve();

  @override
  double transform(double t) => (t <= 0.5) ? 2 * t : 2 * (1 - t);
}
