# debounce_widget

A package for debouncing callbacks for certain amount of time.

## Installation

```yaml
debounce_widget:1.0.0
```

## Import

```dart
import 'package:debounce_widget/debounce_widget.dart';
```

## Usage 

```dart

DebounceWidget(
  debouncer: Debouncer(Duration(milliseconds: 500)),
  builder: (context, debouncer) => TextField(
    onChanged: (text) async {
      if (await debouncer.wait) contrller.add(text);
    },
  ),
),

```
