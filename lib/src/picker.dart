import 'package:awesome_datepicker/src/utils/translate_color_date.dart';
import 'package:flutter/material.dart';

import 'components/hue_ring.dart';
import 'components/output.dart';
import 'components/slider.dart';
import 'components/sv_rect.dart';

class AwesomeDatePicker extends StatefulWidget {
  AwesomeDatePicker({
    required DateTime initialDate,
    DateTime? currentDate,
    required this.onDateChanged,
    required this.babyMode,
    required this.useAlpha,
    required this.backgroundColor,
    this.pickerAreaBorderRadius = const BorderRadius.all(Radius.zero),
    required this.colorPickerHeight,
    required this.hueRingStrokeWidth,
    super.key,
  })  : initialDate = DateUtils.dateOnly(initialDate),
        currentDate = DateUtils.dateOnly(currentDate ?? DateTime.now()) {
    pickerColor = initialDate.toColor(
      babyMode: babyMode,
      enableAlpha: useAlpha,
    );
  }

  late final Color pickerColor;
  final double colorPickerHeight;
  final double hueRingStrokeWidth;
  final bool babyMode, useAlpha;
  final Color backgroundColor;
  final BorderRadius pickerAreaBorderRadius;

  /// The initially selected [DateTime] that the picker should display.
  final DateTime initialDate;

  /// The [DateTime] representing today. It will be highlighted in the day grid.
  final DateTime currentDate;

  /// Called when the user selects a date in the picker.
  final ValueChanged<DateTime> onDateChanged;

  @override
  State<AwesomeDatePicker> createState() => _AwesomeDatePickerState();
}

class _AwesomeDatePickerState extends State<AwesomeDatePicker> {
  HSVColor currentColor = const HSVColor.fromAHSV(0, 0, 0, 0);

  @override
  void initState() {
    currentColor = HSVColor.fromColor(widget.pickerColor);
    super.initState();
  }

  @override
  void didUpdateWidget(AwesomeDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentColor = HSVColor.fromColor(widget.pickerColor);
  }

  void onColorChanging(HSVColor color) {
    setState(() => currentColor = color);
    widget.onDateChanged(
      currentColor.toDate(
        babyMode: widget.babyMode,
        enableAlpha: widget.useAlpha,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
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
        if (widget.useAlpha)
          Positioned(
            bottom: widget.colorPickerHeight / 7,
            child: SizedBox(
              height: widget.hueRingStrokeWidth,
              width: widget.colorPickerHeight / 2,
              child: AlphaSlider(currentColor, onColorChanging),
            ),
          ),
        Positioned(
          top: widget.colorPickerHeight / 6.5,
          child: Output(
            currentColor.toColor(),
            babyMode: widget.babyMode,
            enableAlpha: widget.useAlpha,
            backgroundColor: widget.backgroundColor,
          ),
        ),
      ],
    );
  }
}
