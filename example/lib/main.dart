import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ezuiplayer/src/ezuiplayer.dart';
import 'package:ezuiplayer/fultter_ezuiplayer.dart';

String appKey = 'cbc4453d01b2406da120d5ed1453b737';
String accessToken = 'at.c3e2hhfyajbgkdge01f85si80e8uyyri-7p1tp8lfri-0sk5eby-lyluigo6s';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EzuiPlayerManager.initEzuiPlayer(appKey, accessToken);
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isPlay = false;

  //
  //Map<String, EzuiPlayerController> controllers = new Map();
  EzuiPlayerController controller = new EzuiPlayerController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //controller.setEzuiPlayerCalback(ezuiPlayerCalback)
    setController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(title: const Text('Flutter EZUIPlayer example')),
        body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Center(
              child: Container(
                  //padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: 320.0,
                  height: 240.0,
                  child: EzuiPlayer(
                    ezuiPlayerController: controller,
                    //onEzuiPlayerCreated: _onEzuiPlayerCreated,
                  ))),
          MaterialButton(
            child: Text((controller.isPlay? "pause": "play"), style: TextStyle(color: Colors.white),),
          color: Colors.blue,
          onPressed: _play,
          ),
    /*Center(
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
    )
     */
        ]
        )
    )
    )
    );
  }

  void _play(){
    if (controller.isPlay){
      controller.stopPlay();
    } else {
      controller.startPlay();
    }
    //isPlay = !isPlay;
    //setState(() {
    //
     //});
  }

  void setController() {
    //this.controller = controller;
    //controllers[controller.channelName] = controller; //保存
    controller.setEzuiPlayerCalback(EzuiPlayerCallback(
        onCreated: (){
          print("EzuiPlayerCalback: onCreated");
          controller.setUrl("ezopen://PDTYNU@open.ys7.com/C34337958/1.hd.live");
        },
        onPrepared: (){
          controller.startPlay();
        },
        onPlaySuccess: () {
          print("EzuiPlayerCalback: onPlaySuccess");
          isPlay = true;
          setState(() {

          });
        },
        onPlayFailed: (error) {
          print("EzuiPlayerCallback: " + error);
        },
        onPlayStopped: () {
          print("EzuiPlayerCalback: onPlayStopped");
          isPlay = false;
          setState(() {
          });
        },
        onPlayTime: (time) {
          //print("onPlayTime: " + time);
        }
    ));
    //controller.play();
  }
}
