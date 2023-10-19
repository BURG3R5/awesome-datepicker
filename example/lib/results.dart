import 'package:awesome_datepicker/awesome_datepicker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../utils.dart';
import 'widgets/floating_action_button.dart';
import 'widgets/glow_text.dart';

class Results extends StatefulWidget {
  const Results({required this.birthdate, Key? key}) : super(key: key);

  final DateTime birthdate;

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  DateTime? birthdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: fab(_selectBirthdate),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 4),
            GlowText(
              text: DateFormat('d MMM y').format(birthdate ?? widget.birthdate),
              glowColor: primary,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: primary),
            ),
            const Spacer(flex: 2),
            GlowText(
              glowColor: primary,
              textSpan: TextSpan(
                children: <TextSpan>[
                  const TextSpan(text: "You have "),
                  TextSpan(
                    text: calculateFullMoons(
                      birthdate ?? widget.birthdate,
                    ).toString(),
                    style: const TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      inherit: true,
                    ),
                  ),
                  const TextSpan(text: " full moons left in your life"),
                ],
              ),
            ),
            const Spacer(),
            GlowText(
              glowColor: primary,
              textSpan: TextSpan(
                children: <TextSpan>[
                  const TextSpan(text: "You have "),
                  TextSpan(
                    text: calculateTotalSolarEclipses(
                      birthdate ?? widget.birthdate,
                    ).toString(),
                    style: const TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      inherit: true,
                    ),
                  ),
                  const TextSpan(
                      text: " total solar eclipses left in your life"),
                ],
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  void _selectBirthdate() async {
    await showAwesomeDatePicker(
      context: context,
      mode: AwesomeDatePickerMode.hex,
      useAlpha: true,
      initialDate: DateTime.now(),
      backgroundColor: Colors.transparent,
      onChanged: (date) {
        if (kDebugMode) print('changed to $date');

        birthdate = date;
      },
    );

    setState(() {});
  }
}
