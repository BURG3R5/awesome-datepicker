import 'package:awesome_datepicker/awesome_datepicker.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Awesome DatePicker Example App',
      home: ExampleHome(),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Awesome DatePicker Demo')),
      body: Center(
        child: AwesomeDatePickerField(
          pickerHeight: 250,
          babyMode: true,
          useAlpha: true,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
