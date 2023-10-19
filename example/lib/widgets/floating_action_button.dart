import 'package:flutter/material.dart';

import '../constants.dart';

FloatingActionButton fab(VoidCallback onPressed) =>
    FloatingActionButton.extended(
      backgroundColor: primary,
      onPressed: onPressed,
      icon: const Icon(Icons.calendar_month, color: white),
      label: const Text('Pick again', style: TextStyle(color: white)),
    );
