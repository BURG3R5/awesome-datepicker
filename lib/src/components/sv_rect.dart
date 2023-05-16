import 'package:flutter/material.dart';

import '../painters/all.dart';
import '../utils/gesture.dart';

class SVRect extends StatelessWidget {
  const SVRect(
    this.color,
    this.onChanged, {
    Key? key,
  }) : super(key: key);

  final HSVColor color;
  final ValueChanged<HSVColor> onChanged;

  void _handleGesture(
    Offset position,
    BuildContext context,
    double height,
    double width,
  ) {
    RenderBox? getBox = context.findRenderObject() as RenderBox?;
    if (getBox == null) return;

    Offset localOffset = getBox.globalToLocal(position);
    double horizontal = localOffset.dx.clamp(0.0, width);
    double vertical = localOffset.dy.clamp(0.0, height);

    onChanged(color
        .withSaturation(horizontal / width)
        .withValue(1 - vertical / height));
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
          child: Builder(
            builder: (_) => CustomPaint(painter: SVRectPainter(color)),
          ),
        );
      },
    );
  }
}
