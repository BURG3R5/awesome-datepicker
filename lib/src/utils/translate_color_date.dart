import 'package:flutter/material.dart';

import '../enums.dart';

extension Calendar on Color {
  HSVColor toHSVColor() => HSVColor.fromColor(this);

  DateTime toDate({
    required AwesomeDatePickerMode mode,
    required bool enableAlpha,
  }) {}
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
  }) {}

  Color toColor({
    required AwesomeDatePickerMode mode,
    required bool enableAlpha,
  }) =>
      toHSVColor(
        mode: mode,
        enableAlpha: enableAlpha,
      ).toColor();
}
