import 'dart:math';

import 'package:flutter/material.dart';

bool useWhiteForeground(Color backgroundColor, {double bias = 0.0}) {
  int v = sqrt(pow(backgroundColor.red, 2) * 0.299 +
          pow(backgroundColor.green, 2) * 0.587 +
          pow(backgroundColor.blue, 2) * 0.114)
      .round();

  return v < 130 + bias ? true : false;
}
