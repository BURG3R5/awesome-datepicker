import 'package:flutter/material.dart';

import 'enums.dart';
import 'picker.dart';

Future<DateTime?> showAwesomeDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required AwesomeDatePickerMode mode,
  required bool useAlpha,
  required Color backgroundColor,
  ValueChanged<DateTime>? onChanged,
  DateTime? currentDate,
  String? helpText,
  Locale? locale,
  double pickerHeight = 250,
  double ringStrokeWidth = 20,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  TransitionBuilder? builder,
  String? errorInvalidText,
  Offset? anchorPoint,
}) async {
  initialDate = DateUtils.dateOnly(initialDate);
  assert(debugCheckHasMaterialLocalizations(context));

  Widget dialog = _AwesomeDatePickerDialog(
    initialDate: initialDate,
    currentDate: currentDate,
    onChanged: onChanged,
    helpText: helpText,
    errorInvalidText: errorInvalidText,
    mode: mode,
    useAlpha: useAlpha,
    backgroundColor: backgroundColor,
    pickerHeight: pickerHeight,
    ringStrokeWidth: ringStrokeWidth,
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
    required this.mode,
    required this.useAlpha,
    required DateTime initialDate,
    DateTime? currentDate,
    this.onChanged,
    this.helpText,
    this.errorInvalidText,
    required this.backgroundColor,
    this.pickerHeight = 250,
    this.ringStrokeWidth = 20,
    Key? key,
  })  : initialDate = DateUtils.dateOnly(initialDate),
        currentDate = DateUtils.dateOnly(currentDate ?? DateTime.now()),
        super(key: key);

  final double pickerHeight;

  final double ringStrokeWidth;

  final AwesomeDatePickerMode mode;

  final bool useAlpha;

  final Color backgroundColor;

  final ValueChanged<DateTime>? onChanged;

  /// The initially selected [DateTime] that the picker should display.
  final DateTime initialDate;

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

  void _handleDateChanged(DateTime date) {
    setState(() => _selectedDate = date);
    widget.onChanged?.call(date);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          widget.pickerHeight * 2,
        ),
      ),
      backgroundColor: widget.backgroundColor,
      child: SizedBox(
        width: widget.pickerHeight * 1.12,
        height: widget.pickerHeight * 1.12,
        child: AwesomeDatePicker(
          key: _pickerKey,
          initialDate: _selectedDate,
          mode: widget.mode,
          useAlpha: widget.useAlpha,
          backgroundColor: widget.backgroundColor,
          currentDate: widget.currentDate,
          onDateChanged: _handleDateChanged,
          colorPickerHeight: widget.pickerHeight,
          hueRingStrokeWidth: widget.ringStrokeWidth,
        ),
      ),
    );
  }
}
