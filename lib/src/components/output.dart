import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../enums.dart';
import '../utils/color.dart';

class Output extends StatelessWidget {
  const Output(
    this.color, {
    required this.mode,
    required this.enableAlpha,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final Color color;
  final AwesomeDatePickerMode mode;
  final bool enableAlpha;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat("d MMM y").format(color.toDate(
        mode: mode,
        enableAlpha: enableAlpha,
      )),
      style: TextStyle(color: backgroundColor.getForeground()),
    );
  }
}
