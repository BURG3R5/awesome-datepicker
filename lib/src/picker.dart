import 'package:flutter/material.dart';

import 'components/hue_ring.dart';
import 'components/output.dart';
import 'components/slider.dart';
import 'components/sv_rect.dart';
import 'enums.dart';
import 'utils/get_foreground_theme.dart';
import 'utils/translate_color_date.dart';

class AwesomeDatePicker extends StatefulWidget {
  AwesomeDatePicker({
    required DateTime initialDate,
    DateTime? currentDate,
    required this.onDateChanged,
    required this.mode,
    required this.useAlpha,
    required this.backgroundColor,
    this.pickerAreaBorderRadius = const BorderRadius.all(Radius.zero),
    required this.colorPickerHeight,
    required this.hueRingStrokeWidth,
    super.key,
  })  : initialDate = DateUtils.dateOnly(initialDate),
        currentDate = DateUtils.dateOnly(currentDate ?? DateTime.now()) {
    pickerColor = initialDate.toColor(
      mode: mode,
      enableAlpha: useAlpha,
    );
  }

  late final Color pickerColor;
  final double colorPickerHeight;
  final double hueRingStrokeWidth;
  final AwesomeDatePickerMode mode;
  final bool useAlpha;
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
    currentColor = widget.pickerColor.toHSVColor();
    super.initState();
  }

  @override
  void didUpdateWidget(AwesomeDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentColor = widget.pickerColor.toHSVColor();
  }

  void onColorChanging(HSVColor color) {
    setState(() => currentColor = color);
    widget.onDateChanged(
      currentColor.toDate(
        mode: widget.mode,
        enableAlpha: widget.useAlpha,
      ),
    );
  }

  void _timeTravel({required int days}) {
    final nextDay = currentColor
        .toDate(mode: widget.mode, enableAlpha: widget.useAlpha)
        .add(Duration(days: days));

    setState(() {
      currentColor = nextDay.toHSVColor(
        mode: widget.mode,
        enableAlpha: widget.useAlpha,
      );
    });
    widget.onDateChanged(nextDay);
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
          left: widget.colorPickerHeight / 7.5,
          child: InkWell(
            borderRadius: BorderRadius.circular(
              widget.hueRingStrokeWidth * 4,
            ),
            onTap: () => _timeTravel(days: -1),
            child: Icon(
              Icons.arrow_left,
              size: widget.hueRingStrokeWidth * 2,
              color: useWhiteForeground(widget.backgroundColor)
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        Positioned(
          right: widget.colorPickerHeight / 7.5,
          child: InkWell(
            borderRadius: BorderRadius.circular(
              widget.hueRingStrokeWidth * 4,
            ),
            onTap: () => _timeTravel(days: 1),
            child: Icon(
              Icons.arrow_right,
              size: widget.hueRingStrokeWidth * 2,
              color: useWhiteForeground(widget.backgroundColor)
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        Positioned(
          top: widget.colorPickerHeight / 6.5,
          child: Output(
            currentColor.toColor(),
            mode: widget.mode,
            enableAlpha: widget.useAlpha,
            backgroundColor: widget.backgroundColor,
          ),
        ),
      ],
    );
  }
}
