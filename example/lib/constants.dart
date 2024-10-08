import 'package:flutter/material.dart';

const Color primary = Color(0xFF7C70FF);
const Color white = Color(0xFFE0FDFF);
const Color background = Colors.black;

final appTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primary,
    onPrimary: Colors.black,
    brightness: Brightness.dark,
    surface: Colors.black,
    onSurface: white,
  ),
);
