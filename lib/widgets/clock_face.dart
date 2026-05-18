import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../theme/app_colors.dart';

class ClockFace extends StatefulWidget {
  const ClockFace({super.key});

  @override
  State<ClockFace> createState() => _ClockFaceState();
}

class _ClockFaceState extends State<ClockFace>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) => setState(() {}))..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, constraints.maxHeight);
        return Center(
          child: SizedBox(
            width: size * 0.88,
            height: size * 0.88,
            child: CustomPaint(
              painter: _ClockPainter(now: DateTime.now()),
            ),
          ),
        );
      },
    );
  }
}

class _ClockPainter extends CustomPainter {
  _ClockPainter({required this.now});

  final DateTime now;

  static const _tickColor = AppColors.tickMark;
  static const _handColor = AppColors.hand;
  static const _secondColor = AppColors.secondHand;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final tickOuter = radius * 0.96;
    final tickInnerHour = radius * 0.82;
    final tickInnerMinute = radius * 0.90;

    final tickPaint = Paint()
      ..color = _tickColor
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final tickPaintThin = Paint()
      ..color = _tickColor.withValues(alpha: 0.55)
      ..strokeWidth = 0.75
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 60; i++) {
      final angle = (i * 6 - 90) * math.pi / 180;
      final isHour = i % 5 == 0;
      final inner = isHour ? tickInnerHour : tickInnerMinute;
      final paint = isHour ? tickPaint : tickPaintThin;
      final outer = isHour ? tickOuter : tickOuter * 0.99;

      final start = Offset(
        center.dx + inner * math.cos(angle),
        center.dy + inner * math.sin(angle),
      );
      final end = Offset(
        center.dx + outer * math.cos(angle),
        center.dy + outer * math.sin(angle),
      );
      canvas.drawLine(start, end, paint);
    }

    // Subtle center hub — mid-century dial detail
    canvas.drawCircle(
      center,
      radius * 0.028,
      Paint()..color = _handColor,
    );
    canvas.drawCircle(
      center,
      radius * 0.012,
      Paint()..color = _tickColor,
    );

    final secondFraction = now.second + now.millisecond / 1000 + now.microsecond / 1e6;
    final minuteFraction = now.minute + secondFraction / 60;
    final hourFraction = (now.hour % 12) + minuteFraction / 60;

    _drawHand(
      canvas,
      center,
      radius * 0.50,
      hourFraction * 30 - 90,
      radius * 0.045,
      _handColor,
    );
    _drawHand(
      canvas,
      center,
      radius * 0.72,
      minuteFraction * 6 - 90,
      radius * 0.028,
      _handColor,
    );
    _drawHand(
      canvas,
      center,
      radius * 0.78,
      secondFraction * 6 - 90,
      radius * 0.012,
      _secondColor,
      tailLength: radius * 0.18,
    );
  }

  void _drawHand(
    Canvas canvas,
    Offset center,
    double length,
    double degrees,
    double width,
    Color color, {
    double tailLength = 0,
  }) {
    final angle = degrees * math.pi / 180;
    final tip = Offset(
      center.dx + length * math.cos(angle),
      center.dy + length * math.sin(angle),
    );
    final tail = tailLength > 0
        ? Offset(
            center.dx - tailLength * math.cos(angle),
            center.dy - tailLength * math.sin(angle),
          )
        : center;

    canvas.drawLine(
      tail,
      tip,
      Paint()
        ..color = color
        ..strokeWidth = width
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _ClockPainter oldDelegate) => true;
}
