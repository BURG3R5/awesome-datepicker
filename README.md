# `awesome_datepicker`

Select dates by picking colors

<p align="center">
  <img src="https://github.com/BURG3R5/awesome-datepicker/assets/77491630/1feb14c6-958d-4e08-99eb-52dc9a16f258" alt="a screenshot of the AwesomeDatePicker widget against a black background"/>
</p>

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

For a more detailed example, explore the [sample app](https://github.com/BURG3R5/awesome-datepicker/blob/main/example/lib/main.dart). To test the limits of customization, check [dialog.dart](https://github.com/BURG3R5/awesome-datepicker/blob/main/lib/src/dialog.dart).

## Additional Information

1. This is bad UI. It's not intended for use.
2. There's a lot of stuff that can be added. I've left some TODOs for myself. I may or may not come around to them at an unknown time in the future.
3. You can report bugs... but I ain't resolvin' none of 'em

## License

Copyright (C) 2023 Aditya Rajput & other contributors

This software is licensed under the **Affero GPL v3**. You should have received [a copy](https://github.com/BURG3R5/awesome-datepicker/blob/main/LICENSE) of the Affero GPL v3 along with this program. If not, you can visit the original [here](https://www.gnu.org/licenses/agpl-3.0.html#license-text).
