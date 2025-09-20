import 'dart:math';

import 'package:custom_line_chart_widget/custom_curve.dart';
import 'package:flutter/material.dart';

class CurvedLineGraph extends StatefulWidget {
  final List<Offset> curveStops;
  final Color backgroundColor;
  final Color axisColor;
  final Color curveColor;
  final double curveWidth;
  final double height;
  final double width;
  final String horizontalAxisText;
  final String verticalAxisText;
  final Color axesFontColor;
  final FontWeight axesFontWeight;
  final FontStyle axesFontStyle;
  final double fontSize;
  final double pointsWidth;
  final Color pointsColor;
  final Gradient shadeGradient;
  final double calibrationLength;
  final List<String> toolTipTexts;
  final TextStyle toolTipTextStyle;
  const CurvedLineGraph({
    super.key,
    required this.curveStops,
    this.height = 200,
    this.width = 250,
    this.fontSize = 18,
    this.pointsWidth = 6,
    this.calibrationLength = 3,
    this.shadeGradient = const LinearGradient(
      colors: [
        Colors.greenAccent,

        Color.fromARGB(255, 187, 61, 52),
        Colors.transparent,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    this.axesFontColor = Colors.black,
    this.axesFontStyle = FontStyle.normal,
    this.axesFontWeight = FontWeight.w500,
    this.horizontalAxisText = "x-axis",
    this.verticalAxisText = "y-axis",
    this.toolTipTexts = const ["x,y", "x,y", "x,y", "x,y", "x,y"],
    this.toolTipTextStyle = const TextStyle(
      color: Color.fromARGB(255, 11, 97, 88),
    ),
    this.backgroundColor = Colors.transparent,
    this.axisColor = Colors.red,
    this.pointsColor = Colors.black,
    this.curveColor = Colors.black,
    this.curveWidth = 2,
  });

  @override
  State<CurvedLineGraph> createState() => __CurvedLineGraphState();
}

class __CurvedLineGraphState extends State<CurvedLineGraph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<Offset> oldStops;
  late List<Offset> newStops;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    oldStops = newStops = widget.curveStops;
  }

  @override
  void didUpdateWidget(covariant CurvedLineGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.curveStops != widget.curveStops) {
      oldStops = newStops;
      newStops = widget.curveStops;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<Offset> lerpOffsetList(
    List<Offset> oldStops,
    List<Offset> newStops,
    double t,
  ) {
    final length = min(oldStops.length, newStops.length);

    return List.generate(length, (i) {
      return Offset.lerp(oldStops[i], newStops[i], t)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height + 80,
      width: widget.width + 80,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Stack(
        children: [
          Positioned(
            left: 40,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final t = _controller.value;
                final currentStops = lerpOffsetList(oldStops, newStops, t);
                final painter = CustomCurve(
                  curveStops: currentStops,
                  backgroundColor: widget.backgroundColor,
                  axisColor: widget.axisColor,
                  curveColor: widget.curveColor,
                  curveWidth: widget.curveWidth,
                  pointsColor: widget.pointsColor,
                  pointsWidth: widget.pointsWidth,
                  toolTipTexts: widget.toolTipTexts,
                  toolTipTextStyle: widget.toolTipTextStyle,
                  shadeGradient: widget.shadeGradient,
                );
                return CustomPaint(
                  painter: painter,
                  size: Size(widget.width, widget.height),
                );
              },
            ),
          ),
          Positioned(
            top: widget.height + 2,
            left: widget.width * 0.5,
            child: Text(
              widget.horizontalAxisText,
              style: TextStyle(
                color: widget.axesFontColor,
                fontSize: widget.fontSize <= 32 ? widget.fontSize : 20,
                fontWeight: widget.axesFontWeight,
                fontStyle: widget.axesFontStyle,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: widget.height * 0.4,
            child: Transform.rotate(
              angle: 3 * pi / 2,
              child: Text(
                widget.verticalAxisText,
                style: TextStyle(
                  color: widget.axesFontColor,
                  fontSize: widget.fontSize <= 32 ? widget.fontSize : 20,
                  fontWeight: widget.axesFontWeight,
                  fontStyle: widget.axesFontStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
