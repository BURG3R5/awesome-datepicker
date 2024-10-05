import 'package:flutter/material.dart';
import 'package:get/get.dart';

int _calculateDaysLeft(DateTime birthdate) {
  final expectedDeath =
      birthdate.add(Duration(hours: (72.27 * 365.2425 * 24).floor()));

  final expectedDaysLeft = (expectedDeath.millisecondsSinceEpoch -
          DateTime.now().millisecondsSinceEpoch) ~/
      Duration.millisecondsPerDay;

  return expectedDaysLeft;
}

int calculateFullMoons(DateTime birthdate) =>
    _calculateDaysLeft(birthdate) ~/ 29.5;

int calculateTotalSolarEclipses(DateTime birthdate) =>
    (0.66 * _calculateDaysLeft(birthdate)) ~/ 365.2425;

bool isPortrait(BuildContext context) {
  return context.width < context.height;
}

TextStyle? buttonTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontSize: isPortrait(context) ? 15 * context.width / 375 : null,
      );
}

double pickerHeight(BuildContext context) {
  return isPortrait(context) ? 250 * 0.7 * context.width / 375 : 250;
}

double ringWidth(BuildContext context) {
  return isPortrait(context) ? 20 * 0.7 * context.width / 375 : 20;
}
