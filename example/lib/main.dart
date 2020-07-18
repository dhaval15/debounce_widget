import 'dart:async';

import 'package:debounce_widget/debounce_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debounce Widget Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final contrller = StreamController<String>();

  @override
  void dispose() {
    super.dispose();
    contrller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debounce Widget Demo'),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DebounceWidget(
              debouncer: Debouncer(Duration(milliseconds: 500)),
              builder: (context, debouncer) => TextField(
                onChanged: (text) async {
                  if (await debouncer.wait) contrller.add(text);
                },
              ),
            ),
            StreamBuilder(
              initialData: '',
              stream: contrller.stream,
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                      Text(snapshot.data),
            ),
          ],
        ),
      ),
    );
  }
}
