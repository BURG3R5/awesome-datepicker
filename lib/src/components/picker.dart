import 'package:flutter/material.dart';

import 'hue_ring.dart';
import 'indicator.dart';
import 'output.dart';
import 'slider.dart';
import 'sv_rect.dart';

class Picker extends StatefulWidget {
  const Picker({
    Key? key,
    required this.pickerColor,
    required this.onChanged,
    required this.babyMode,
    this.colorPickerHeight = 250,
    this.hueRingStrokeWidth = 20,
    this.enableAlpha = false,
    this.pickerAreaBorderRadius = const BorderRadius.all(Radius.zero),
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onChanged;
  final bool babyMode;
  final double colorPickerHeight;
  final double hueRingStrokeWidth;
  final bool enableAlpha;
  final BorderRadius pickerAreaBorderRadius;

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  HSVColor currentColor = const HSVColor.fromAHSV(0, 0, 0, 0);

  @override
  void initState() {
    currentColor = HSVColor.fromColor(widget.pickerColor);
    super.initState();
  }

  @override
  void didUpdateWidget(Picker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentColor = HSVColor.fromColor(widget.pickerColor);
  }

  void onColorChanging(HSVColor color) {
    setState(() => currentColor = color);
    widget.onChanged(currentColor.toColor());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 15, 35, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ColorIndicator(currentColor),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.5),
                child: Output(
                  currentColor.toColor(),
                  babyMode: widget.babyMode,
                  enableAlpha: widget.enableAlpha,
                ),
              ),
            ],
          ),
        ),
        if (widget.enableAlpha)
          SizedBox(
            height: 40,
            width: widget.colorPickerHeight,
            child: AlphaSlider(currentColor, onColorChanging),
          ),
        ClipRRect(
          borderRadius: widget.pickerAreaBorderRadius,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                SizedBox(
                  width: widget.colorPickerHeight,
                  height: widget.colorPickerHeight,
                  child: HueRing(
                    currentColor,
                    onColorChanging,
                    strokeWidth: widget.hueRingStrokeWidth,
                  ),
                ),
                SizedBox(
                  width: widget.colorPickerHeight / 1.6,
                  height: widget.colorPickerHeight / 1.6,
                  child: SVRect(currentColor, onColorChanging),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
