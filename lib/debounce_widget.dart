library debounce_widget;

import 'dart:async';

import 'package:flutter/material.dart';

class DebounceWidget extends StatefulWidget {
  final Debouncer debouncer;
  final Function(BuildContext context, Debouncer debouncer) builder;

  const DebounceWidget({Key key, this.builder, this.debouncer})
      : super(key: key);

  @override
  _DebounceWidgetState createState() => _DebounceWidgetState();
}

class _DebounceWidgetState extends State<DebounceWidget> {
  @override
  void dispose() {
    super.dispose();
    if (widget.debouncer.timer?.isActive ?? false)
      widget.debouncer.timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.debouncer);
  }
}

class Debouncer {
  final Duration duration;
  Completer<bool> completer;
  Timer timer;

  Debouncer(this.duration);

  Future<bool> get wait {
    if (timer?.isActive ?? false) {
      timer.cancel();
      completer?.complete(false);
    }
    completer = Completer<bool>();
    timer = Timer(duration, () {
      completer.complete(true);
    });
    return completer.future;
  }
}

