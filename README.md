# `awesome_datepicker`

Select dates by picking colors

## Features

This package can:

1. Display a color picker that outputs dates
2. That's it

## Usage

You can use the async function `showAwesomeDatePicker` to trigger the picker dialog:

```dart
var selectedDate = DateTime.now();

await showAwesomeDatePicker(
  context: context,
  mode: AwesomeDatePickerMode.hex,
  useAlpha: true,
  initialDate: DateTime.now(),
  backgroundColor: Colors.transparent,
  onChanged: (date) {
    if (kDebugMode) print('changed to $date');
    selectedDate = date;
  },
);
```

Alternatively, you can directly use the `AwesomeDatePicker` widget in your form or dialog:

```dart
// ...
  child: AwesomeDatePicker(
    initialDate: DateTime.now(),
    mode: AwesomeDatePickerMode.hex,
    colorPickerHeight: 250,
    hueRingStrokeWidth: 20,
    onDateChanged: (date) {
      if (kDebugMode) print('changed to $date');
      selectedDate = date;
    },
  ),
// ...
```

For a more detailed example, explore the [sample app](/example/lib/main.dart). To test the limits of customization, check [dialog.dart](/lib/src/dialog.dart).

## Additional information

1. This is bad UI. It's not intended for use.
2. There's a lot of stuff that can be added. I've left some TODOs for myself. I may or may not come around to them at an unknown time in the future.
3. You can report bugs... but I ain't resolvin' none of 'em
