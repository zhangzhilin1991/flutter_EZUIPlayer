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
  bool isPlay = false;

  EzuiPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter TextView example')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Center(
              child: Container(
                  //padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: 320.0,
                  height: 240.0,
                  child: EzuiPlayer(
                    onEzuiPlayerCreated: _onEzuiPlayerCreated,
                  ))),
          MaterialButton(
            child: Text((isPlay? "pause": "play"), style: TextStyle(color: Colors.white),),
          color: Colors.blue,
          onPressed: _play,
          ),
        ]));
  }

  void _play(){
    if (isPlay){
      controller.stop();
    } else {
      controller.play();
    }
    isPlay = !isPlay;
    setState(() {

    });
  }

  void _onEzuiPlayerCreated(EzuiPlayerController controller) {
    this.controller = controller;
    controller.setEzuiPlayerCalback(EzuiPlayerCallback(
        onPlaySuccess: () {
          print("EzuiPlayerCalback: onPlaySuccess");
          isPlay = true;
          setState(() {

          });
        }
    ));

    controller.setUrl("ezopen://PDTYNU@open.ys7.com/C34337958/1.hd.live");
    //controller.play();
  }
}
