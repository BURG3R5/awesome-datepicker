import 'dart:math';

import 'package:flutter/material.dart';

Future<DateTime?> showAwesomeDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  // TODO: required bool babyMode,
  // TODO: required bool useAlphaForCentury,
  DateTime? currentDate,
  String? helpText,
  Locale? locale,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  TransitionBuilder? builder,
  String? errorInvalidText,
  Offset? anchorPoint,
}) async {
  initialDate = DateUtils.dateOnly(initialDate);
  firstDate = DateUtils.dateOnly(firstDate);
  lastDate = DateUtils.dateOnly(lastDate);
  assert(
    !lastDate.isBefore(firstDate),
    'lastDate $lastDate must be on or after firstDate $firstDate.',
  );
  assert(
    !initialDate.isBefore(firstDate),
    'initialDate $initialDate must be on or after firstDate $firstDate.',
  );
  assert(
    !initialDate.isAfter(lastDate),
    'initialDate $initialDate must be on or before lastDate $lastDate.',
  );
  assert(debugCheckHasMaterialLocalizations(context));

  Widget dialog = _AwesomeDatePickerDialog(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    currentDate: currentDate,
    helpText: helpText,
    errorInvalidText: errorInvalidText,
  );

  if (locale != null) {
    dialog = Localizations.override(
      context: context,
      locale: locale,
      child: dialog,
    );
  }

  return showDialog<DateTime>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    builder: (context) => builder == null ? dialog : builder(context, dialog),
  );
}

class _AwesomeDatePickerDialog extends StatefulWidget {
  /// A Material-style date picker dialog.
  _AwesomeDatePickerDialog({
    // TODO: required this.babyMode,
    // TODO: required this.useAlphaForCentury,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    this.helpText,
    this.errorInvalidText,
    Key? key,
  })  : initialDate = DateUtils.dateOnly(initialDate),
        firstDate = DateUtils.dateOnly(firstDate),
        lastDate = DateUtils.dateOnly(lastDate),
        currentDate = DateUtils.dateOnly(currentDate ?? DateTime.now()),
        super(key: key);

  /// The initially selected [DateTime] that the picker should display.
  final DateTime initialDate;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime firstDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime lastDate;

  /// The [DateTime] representing today. It will be highlighted in the day grid.
  final DateTime currentDate;

  /// The text that is displayed at the top of the header.
  ///
  /// This is used to indicate to the user what they are selecting a date for.
  final String? helpText;

  /// The error text displayed if the date is not valid.
  ///
  /// A date is not valid if it is earlier than [firstDate], later than
  /// [lastDate], or doesn't pass the [selectableDayPredicate].
  final String? errorInvalidText;

  @override
  State<_AwesomeDatePickerDialog> createState() =>
      _AwesomeDatePickerDialogState();
}

class _AwesomeDatePickerDialogState extends State<_AwesomeDatePickerDialog> {
  late DateTime _selectedDate = widget.initialDate;

  final GlobalKey _pickerKey = GlobalKey();

  void _handleDateChanged(DateTime date) =>
      setState(() => _selectedDate = date);

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor =
        min(MediaQuery.of(context).textScaleFactor, 1.3);

    final Widget actions = Container(
      alignment: AlignmentDirectional.centerEnd,
      constraints: const BoxConstraints(minHeight: 52),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: OverflowBar(
        spacing: 8,
        children: <IconButton>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.cancel_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context, _selectedDate),
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
    );

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      clipBehavior: Clip.antiAlias,
      child: AnimatedContainer(
        width: 330 * textScaleFactor,
        height: 350 * textScaleFactor,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: textScaleFactor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: CalendarDatePicker(
                  key: _pickerKey,
                  initialDate: _selectedDate,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  currentDate: widget.currentDate,
                  onDateChanged: _handleDateChanged,
                ),
              ),
              actions,
            ],
          ),
        ),
      ),
    );
  }
}
