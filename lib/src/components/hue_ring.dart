import 'dart:math';

import 'package:flutter/material.dart';

import '../painters/all.dart';
import '../utils/gesture.dart';

class HueRing extends StatelessWidget {
  const HueRing(
    this.color,
    this.onChanged, {
    Key? key,
    this.displayThumbColor = true,
    this.strokeWidth = 5.0,
  }) : super(key: key);

  final HSVColor color;
  final ValueChanged<HSVColor> onChanged;
  final bool displayThumbColor;
  final double strokeWidth;

  void _handleGesture(
      Offset position, BuildContext context, double height, double width) {
    RenderBox? getBox = context.findRenderObject() as RenderBox?;
    if (getBox == null) return;

    Offset localOffset = getBox.globalToLocal(position);
    double horizontal = localOffset.dx.clamp(0.0, width);
    double vertical = localOffset.dy.clamp(0.0, height);

    Offset center = Offset(width / 2, height / 2);
    double radio = width <= height ? width / 2 : height / 2;
    double dist =
        sqrt(pow(horizontal - center.dx, 2) + pow(vertical - center.dy, 2)) /
            radio;
    double rad =
        (atan2(horizontal - center.dx, vertical - center.dy) / pi + 1) /
            2 *
            360;

    if (dist > 0.7 && dist < 1.3) {
      onChanged(color.withHue(((rad + 90) % 360).clamp(0, 360)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        return RawGestureDetector(
          gestures: {
            AlwaysWinPanGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                AlwaysWinPanGestureRecognizer>(
              () => AlwaysWinPanGestureRecognizer(),
              (AlwaysWinPanGestureRecognizer instance) {
                instance
                  ..onDown = ((details) => _handleGesture(
                      details.globalPosition, context, height, width))
                  ..onUpdate = ((details) => _handleGesture(
                      details.globalPosition, context, height, width));
              },
            ),
          },
          child: CustomPaint(
            painter: HueRingPainter(
              color,
              displayThumbColor: displayThumbColor,
              strokeWidth: strokeWidth,
            ),
          ),
        );
      },
    );
  }
}
