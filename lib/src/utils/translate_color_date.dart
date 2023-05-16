import 'package:flutter/material.dart';

extension Calendar on Color {
  DateTime toDate({
    required bool babyMode,
    required bool enableAlpha,
  }) {
    if (babyMode) {
      if (enableAlpha) {
        // HSVA -> DD-MM-YYYY
        final hsvColor = HSVColor.fromColor(this);
        return DateTime(
          hsvColor.value.translate(0, 1, 0, 20) * 100 +
              hsvColor.alpha.translate(0, 1, 0, 99),
          hsvColor.saturation.translate(0, 1, 1, 12),
          hsvColor.hue.translate(0, 360, 1, 31),
        );
      } else {
        // HSVA -> DD-MM-20YY
        final hsvColor = HSVColor.fromColor(this);
        return DateTime(
          (DateTime.now().year ~/ 100) * 100 +
              hsvColor.value.translate(0, 1, 0, 99),
          hsvColor.saturation.translate(0, 1, 1, 12),
          hsvColor.hue.translate(0, 360, 1, 31),
        );
      }
    } else {
      if (enableAlpha) {
        // RGBA -> DD-MM-YYYY
        return DateTime(
          blue.translate(0, 255, 0, 20) * 100 + alpha.translate(0, 255, 0, 99),
          green.translate(0, 255, 1, 12),
          red.translate(0, 255, 1, 31),
        );
      } else {
        // RGB -> DD-MM-20YY
        return DateTime(
          (DateTime.now().year ~/ 100) * 100 + blue.translate(0, 255, 0, 99),
          green.translate(0, 255, 1, 12),
          red.translate(0, 255, 1, 31),
        );
      }
    }
  }
}

extension Calendr on HSVColor {
  DateTime toDate({required bool babyMode, required bool enableAlpha}) =>
      toColor().toDate(babyMode: babyMode, enableAlpha: enableAlpha);
}

extension Palette on DateTime {
  Color toColor({
    required bool babyMode,
    required bool enableAlpha,
  }) {
    if (babyMode) {
      if (enableAlpha) {
        // DD-MM-YYYY -> HSVA
        return HSVColor.fromAHSV(
          (year % 100).interpolate(0, 99, 0, 1),
          day.interpolate(1, 31, 0, 360),
          month.interpolate(1, 12, 0, 1),
          (year ~/ 100).interpolate(0, 20, 0, 1),
        ).toColor();
      } else {
        // DD-MM-20YY -> HSV
        return HSVColor.fromAHSV(
          1,
          day.interpolate(1, 31, 0, 360),
          month.interpolate(1, 12, 0, 1),
          (year % 100).interpolate(0, 99, 0, 1),
        ).toColor();
      }
    } else {
      if (enableAlpha) {
        // DD-MM-YYYY -> RGBA
        return Color.fromARGB(
          (year % 100).interpolate(0, 99, 0, 255).floor(),
          day.interpolate(1, 31, 0, 255).floor(),
          month.interpolate(1, 12, 0, 255).floor(),
          (year ~/ 100).interpolate(0, 20, 0, 255).floor(),
        );
      } else {
        // DD-MM-20YY -> RGB
        return Color.fromARGB(
          255,
          day.interpolate(1, 31, 0, 255).floor(),
          month.interpolate(1, 12, 0, 255).floor(),
          (year % 100).interpolate(0, 99, 0, 255).floor(),
        );
      }
    }
  }
}

extension on num {
  /// Takes a value from the range ([fromStart], [fromEnd]) (both inclusive)
  /// and returns an integer in the range ([toStart], [toEnd]) (both inclusive)
  int translate(int fromStart, int fromEnd, int toStart, int toEnd) {
    if (this == fromStart) return toStart;
    if (this == fromEnd) return toEnd;
    return (toStart +
            (this - fromStart) * (1 + toEnd - toStart) / (fromEnd - fromStart))
        .floor();
  }

  /// Interpolates between ranges ([fromStart], [fromEnd]) (both inclusive)
  /// and ([toStart], [toEnd]) (both inclusive)
  double interpolate(int fromStart, int fromEnd, int toStart, int toEnd) {
    return toStart +
        (this - fromStart) * (toEnd - toStart) / (fromEnd - fromStart);
  }
}
