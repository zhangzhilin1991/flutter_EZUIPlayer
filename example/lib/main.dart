import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ezuiplayer/ezuiplayer.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter TextView example')),
        body: Column(children: [
          Center(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  width: 130.0,
                  height: 100.0,
                  child: EzuiPlayer(
                    onEzuiPlayerCreated: _onEzuiPlayerCreated,
                  ))),
          Expanded(
              flex: 3,
              child: Container(
                  color: Colors.blue[100],
                  child: Center(child: Text("Hello from Flutter!"))))
        ]));
  }

  void _onEzuiPlayerCreated(EzuiPlayerController controller) {
    controller.setText('Hello from Android!');
  }
}
