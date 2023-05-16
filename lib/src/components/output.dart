import 'package:awesome_datepicker/src/utils/create_date_string.dart';
import 'package:flutter/material.dart';

class Output extends StatelessWidget {
  const Output(
    this.color, {
    required this.babyMode,
    this.enableAlpha = true,
    Key? key,
  }) : super(key: key);

  final Color color;
  final bool babyMode;
  final bool enableAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: (Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14) * 6.5,
      child: Text(createDateString(
        color,
        babyMode: babyMode,
        enableAlpha: enableAlpha,
      )),
    );
  }
}
