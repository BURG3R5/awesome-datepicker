import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../enums.dart';

/// Displays a Toast with help text for the relevant picker mode
void displayHelpTextFor(AwesomeDatePickerMode mode) {
  String helpText;

  switch (mode) {
    case AwesomeDatePickerMode.hex:
      helpText = "Select a color: use the ring for Hue, the slider for Alpha\n"
          "and the square for Saturation and Value. Your chosen\n"
          "color's hexcode will be treated as UNIX time after 1970.";
      break;
    case AwesomeDatePickerMode.hsv:
    case AwesomeDatePickerMode.rgb:
    case AwesomeDatePickerMode.hsva:
    case AwesomeDatePickerMode.rgba:
      // TODO: Handle these cases
      helpText = "The developer hasn't yet implemented this mode.\n"
          "Please complain loudly and frequently. Force him to\n"
          "get off his arse and finishes his work on this package.";
  }

  Fluttertoast.showToast(
    msg: helpText,
    webBgColor: "#000000",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    timeInSecForIosWeb: 5,
  );
}
