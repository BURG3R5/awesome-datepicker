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
