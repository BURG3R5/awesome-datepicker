import 'package:awesome_datepicker/awesome_datepicker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'results.dart';
import 'widgets/glow_text.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome DatePicker Example App',
      home: const Home(),
      theme: appTheme,
      themeMode: ThemeMode.dark,
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  void _selectBirthdate(BuildContext context) async {
    DateTime? selectedDate;
    final navigator = Navigator.of(context);

    await showAwesomeDatePicker(
      context: context,
      mode: AwesomeDatePickerMode.hex,
      useAlpha: true,
      initialDate: DateTime.now(),
      onChanged: (date) {
        if (kDebugMode) print('changed to $date');

        selectedDate = date;
      },
    );

    navigator.pushReplacement(MaterialPageRoute(
      builder: (_) => Results(birthdate: selectedDate ?? DateTime.now()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => _selectBirthdate(context),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GlowText(
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                  glowColor: primary,
                  textSpan: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "Click here and "),
                      TextSpan(
                        text: "select your date of birth",
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          inherit: true,
                        ),
                      ),
                      TextSpan(text: " to\nunlock the secrets of the universe"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
