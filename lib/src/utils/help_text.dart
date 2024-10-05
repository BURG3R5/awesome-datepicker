import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../enums.dart';

/// Displays a Toast with help text for the relevant picker mode
void displayHelpTextFor(AwesomeDatePickerMode mode) {
  String helpText;

  switch (mode) {
    case AwesomeDatePickerMode.hex:
      helpText = "ring = Hue, slider = Alpha,\nsquare = Saturation & Value";
      break;
    case AwesomeDatePickerMode.hsv:
    case AwesomeDatePickerMode.rgb:
    case AwesomeDatePickerMode.hsva:
    case AwesomeDatePickerMode.rgba:
      // TODO: Handle these cases
      helpText = "The developer hasn't yet implemented this mode.\n"
          "Please complain!";
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
