import 'package:flutter/material.dart';

import 'enums.dart';
import 'picker.dart';
import 'utils/color.dart';
import 'utils/date.dart';
import 'utils/help_text.dart';

Future<DateTime?> showAwesomeDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required AwesomeDatePickerMode mode,
  required bool useAlpha,
  Color backgroundColor = Colors.transparent,
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
  initialDate = initialDate.dateOnly();
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
  })  : initialDate = initialDate.dateOnly(),
        currentDate = (currentDate ?? DateTime.now()).dateOnly(),
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
      backgroundColor: widget.backgroundColor,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SizedBox(
        width: widget.pickerHeight * 1.2,
        height: widget.pickerHeight * 1.2,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(widget.ringStrokeWidth * 4),
                onTap: () => displayHelpTextFor(widget.mode),
                child: Icon(
                  Icons.help_outline,
                  size: widget.ringStrokeWidth * 1.5,
                  color: widget.backgroundColor.getForeground(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(widget.ringStrokeWidth * 4),
                onTap: () => Navigator.of(context).pop<DateTime>(_selectedDate),
                child: Icon(
                  Icons.check_circle_outline,
                  size: widget.ringStrokeWidth * 1.5,
                  color: widget.backgroundColor.getForeground(),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.pickerHeight * 2),
                color: widget.backgroundColor,
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}
