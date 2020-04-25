import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void EzuiPlayerCreatedCallback(EzuiPlayerController controller);

class EzuiPlayer extends StatefulWidget{

  const EzuiPlayer({
    Key key,
    this.onEzuiPlayerCreated
  }) :super(key: key);

  final EzuiPlayerCreatedCallback onEzuiPlayerCreated;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return _EzuiPlayerState();
  }

}

class _EzuiPlayerState extends State<EzuiPlayer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'plugins.com.nyiit.ezuiplayer/EzuiPlayer',
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

  Future<void> setText(String text) async {
    assert(text != null);
    return _channel.invokeMethod('setText', text);
  }
}
