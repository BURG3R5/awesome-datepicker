import 'package:flutter/material.dart';

const Color blue = Color(0xFF37B7D8);
const Color orange = Color(0xFFD95736);
const Color green = Color(0xFF67D936);
const Color purple = Color(0xFFA836D9);
const Color white = Color(0xFFE0FDFF);
const Color pink = Color(0xFFE055B6);

final appTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    seedColor: blue,
    onPrimary: Colors.black,
    brightness: Brightness.dark,
    surface: Colors.black,
    onSurface: white,
    background: Colors.black,
  ),
);
