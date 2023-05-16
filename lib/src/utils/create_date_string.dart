// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

String createDateString(
  Color color, {
  required bool babyMode,
  required bool enableAlpha,
}) {
  if (babyMode) {
    final hsvColor = HSVColor.fromColor(color);
    return (hsvColor.hue % 100).toStringAsFixed(0).padLeft(2, '0') +
        '-' +
        (hsvColor.saturation * 100).asTwoDigits() +
        '-' +
        (hsvColor.value * 100).asTwoDigits() +
        (hsvColor.alpha * 100).asTwoDigits(visible: enableAlpha);
  } else {
    return color.red.asTwoDigits() +
        '-' +
        color.green.asTwoDigits() +
        '-' +
        color.blue.asTwoDigits() +
        (color.alpha).asTwoDigits(visible: enableAlpha);
  }
}

extension on num {
  String asTwoDigits({bool visible = true}) {
    if (!visible) return '';

    return (this % 100).toStringAsFixed(0).padLeft(2, '0');
  }
}
