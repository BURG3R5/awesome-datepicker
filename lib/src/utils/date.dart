import 'package:flutter/material.dart';

import '../enums.dart';
import 'color.dart';

extension Palette on DateTime {
  HSVColor toHSVColor({
    required AwesomeDatePickerMode mode,
    required bool enableAlpha,
  }) {
    switch (mode) {
      case AwesomeDatePickerMode.hex:
        return Color(
          millisecondsSinceEpoch *
              0xFFFFFFFF ~/
              DateTime(2100).millisecondsSinceEpoch,
        ).toHSVColor();
      case AwesomeDatePickerMode.hsv:
      case AwesomeDatePickerMode.rgb:
      case AwesomeDatePickerMode.hsva:
      case AwesomeDatePickerMode.rgba:
        // TODO: Handle these cases
        return HSVColor.fromColor(Colors.cyan);
    }
  }

  Color toColor({
    required AwesomeDatePickerMode mode,
    required bool enableAlpha,
  }) =>
      toHSVColor(
        mode: mode,
        enableAlpha: enableAlpha,
      ).toColor();
}

extension Utils on DateTime {
  DateTime dateOnly() => DateTime(year, month, day, 12, 0, 0);
}
