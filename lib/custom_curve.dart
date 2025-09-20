import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class CustomCurve extends CustomPainter {
  final List<Offset> curveStops;
  final Color backgroundColor;
  final Color axisColor;
  final Color curveColor;
  final double curveWidth;
  final Color pointsColor;
  final double pointsWidth;
  final Gradient shadeGradient;
  final List<String> toolTipTexts;
  final TextStyle toolTipTextStyle;
  CustomCurve({
    required this.curveStops,
    required this.backgroundColor,
    required this.axisColor,
    required this.curveColor,
    required this.curveWidth,
    required this.pointsColor,
    required this.pointsWidth,
    required this.shadeGradient,
    required this.toolTipTexts,
    required this.toolTipTextStyle,
  });

  late final List<Offset> scaledPoints;

  @override
  void paint(Canvas canvas, Size size) {
    final Size(:width, :height) = size;
    final paintBg = Paint()..color = backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paintBg);

    final axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      axisPaint,
    );

    canvas.drawLine(Offset(0, size.height), Offset(0, 0), axisPaint);

    canvas.drawLine(Offset(0, 0), Offset(-4, 8), axisPaint);
    canvas.drawLine(Offset(0, 0), Offset(4, 8), axisPaint);

    canvas.drawLine(
      Offset(width, height),
      Offset(width - 8, height - 4),
      axisPaint,
    );
    canvas.drawLine(
      Offset(width, height),
      Offset(width - 8, height + 4),
      axisPaint,
    );

    final maxX = curveStops.map((e) => e.dx).reduce(max);
    final maxY = curveStops.map((e) => e.dy).reduce(max);

    List<Offset> scaledPoints = curveStops.map((p) {
      final x = (p.dx / maxX) * size.width;
      final y = size.height - (p.dy / maxY) * size.height;
      return Offset(x, y);
    }).toList();

    final curvePaint = Paint()
      ..color = curveColor
      ..strokeWidth = curveWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()..moveTo(scaledPoints[0].dx, scaledPoints[0].dy);

    for (int i = 0; i < scaledPoints.length - 1; i++) {
      final p0 = i > 0 ? scaledPoints[i - 1] : scaledPoints[i];
      final p1 = scaledPoints[i];
      final p2 = scaledPoints[i + 1];
      final p3 = i != scaledPoints.length - 2 ? scaledPoints[i + 2] : p2;

      final cp1 = Offset(
        p1.dx + (p2.dx - p0.dx) / 6,
        p1.dy + (p2.dy - p0.dy) / 6,
      );
      final cp2 = Offset(
        p2.dx - (p3.dx - p1.dx) / 6,
        p2.dy - (p3.dy - p1.dy) / 6,
      );
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
    }
    canvas.drawPath(path, curvePaint);

    final fillPaint = Paint()
      ..shader = shadeGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    final fillPath = Path.from(path)
      ..lineTo(scaledPoints.last.dx, size.height)
      ..lineTo(scaledPoints.first.dx, size.height)
      ..close();
    canvas.drawPath(fillPath, fillPaint);

    canvas.drawPoints(
      PointMode.points,
      scaledPoints,
      Paint()
        ..color = pointsColor
        ..strokeWidth = pointsWidth
        ..strokeCap = StrokeCap.round,
    );

    for (int i = 0; i < scaledPoints.length; i++) {
      final point = scaledPoints[i];
      final label = toolTipTexts[i];

      final textPainter = TextPainter(
        text: TextSpan(text: label, style: toolTipTextStyle),
        textDirection: TextDirection.ltr,
      )..layout(minWidth: 0, maxWidth: size.width);

      final offset = Offset(point.dx + 5, point.dy - 20);
      textPainter.paint(canvas, offset);
      canvas.drawColor(Colors.purple, BlendMode.dstATop);
    }
  }

  @override
  bool shouldRepaint(covariant CustomCurve oldDelegate) {
    return oldDelegate.curveStops != curveStops ||
        oldDelegate.curveColor != curveColor ||
        oldDelegate.axisColor != axisColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.curveWidth != curveWidth ||
        oldDelegate.pointsColor != pointsColor ||
        oldDelegate.pointsWidth != pointsWidth ||
        oldDelegate.shadeGradient != shadeGradient ||
        oldDelegate.toolTipTexts != toolTipTexts ||
        oldDelegate.toolTipTextStyle != toolTipTextStyle;
  }
}
