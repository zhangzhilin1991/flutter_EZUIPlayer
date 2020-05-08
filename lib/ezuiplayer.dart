import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void EzuiPlayerCreatedCallback(EzuiPlayerController controller);

class EzuiPlayer extends StatefulWidget{
  final int width;
  final int height;
  final String url;

  const EzuiPlayer({
    Key key,
    this.width = 320,
    this.height = 240,
    this.url,
    this.onEzuiPlayerCreated
  }) :super(key: key);

  final EzuiPlayerCreatedCallback onEzuiPlayerCreated;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return _EzuiPlayerState();
  }

  static void init(){

  }
}

class _EzuiPlayerState extends State<EzuiPlayer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'plugins.com.nyiit.ezuiplayer/EzuiPlayer',
        creationParams: <String, dynamic>{
          "width": widget.width,
          "height": widget.height,
          //"url": widget.url,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the text_view plugin');
  }


  void _onPlatformViewCreated(int id) {
    if (widget.onEzuiPlayerCreated == null) {
      return;
    }
    widget.onEzuiPlayerCreated(new EzuiPlayerController._(id));
  }
}

class EzuiPlayerController {
  EzuiPlayerController._(int id)
      : _channel = new MethodChannel('plugins.com.nyiit.ezuiplayer/EzuiPlayer_$id');

  final MethodChannel _channel;

  Future<void> setUrl(String url) async {
    assert(url != null);
    return _channel.invokeMethod('setUrl', url);
  }

  Future<void> play() async {
    //assert(url != null);
    return _channel.invokeMethod('play');
  }

  Future<void> stop() async {
    //assert(url != null);
    return _channel.invokeMethod('stop');
  }
}
