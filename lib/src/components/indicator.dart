import 'package:flutter/material.dart';

import '../painters/all.dart';

class ColorIndicator extends StatelessWidget {
  const ColorIndicator(this.color, {Key? key}) : super(key: key);

  final HSVColor color;
  final double width = 50;
  final double height = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(1000.0)),
        border: Border.all(color: const Color(0xffdddddd)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(1000.0)),
        child: CustomPaint(painter: IndicatorPainter(color.toColor())),
      ),
    );
  }
}
