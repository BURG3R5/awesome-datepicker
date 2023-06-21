import 'dart:math';

import 'package:flutter/material.dart';

import '../enums.dart';

extension Calendar on Color {
  HSVColor toHSVColor() => HSVColor.fromColor(this);

  DateTime toDate({
    required AwesomeDatePickerMode mode,
    required bool enableAlpha,
  }) {
    switch (mode) {
      case AwesomeDatePickerMode.hex:
        return DateTime.fromMillisecondsSinceEpoch(
          value * DateTime(2100).millisecondsSinceEpoch ~/ 0xFFFFFFFF,
        );
      case AwesomeDatePickerMode.hsv:
      case AwesomeDatePickerMode.rgb:
      case AwesomeDatePickerMode.hsva:
      case AwesomeDatePickerMode.rgba:
        // TODO: Handle these cases
        return DateTime(2002);
    }
  }
}

extension Calendr on HSVColor {
  DateTime toDate({
    required AwesomeDatePickerMode mode,
    required bool enableAlpha,
  }) =>
      toColor().toDate(
        mode: mode,
        enableAlpha: enableAlpha,
      );
}

extension Theme on Color {
  Color getForeground({double bias = 0}) {
    final v = sqrt(
      pow(red, 2) * 0.299 + pow(green, 2) * 0.587 + pow(blue, 2) * 0.114,
    );

    return v < 130 + bias ? Colors.white : Colors.black;
  }
}
