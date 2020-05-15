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
}

class _EzuiPlayerState extends State<EzuiPlayer> {

  EzuiPlayerCreatedCallback onEzuiPlayerCreated;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

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
  String channelName;
  final MethodChannel _channel;
  EzuiPlayerCallback mEzuiPlayerCalback;

  EzuiPlayerController._(int id) :
        _channel = new MethodChannel('plugins.com.nyiit.ezuiplayer/EzuiPlayer_$id') {
    channelName = _channel.name;
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  setEzuiPlayerCalback(EzuiPlayerCallback ezuiPlayerCalback){
    this.mEzuiPlayerCalback = ezuiPlayerCalback;
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    print("_handleMethodCall: " + call.method);
    switch (call.method) {
      case 'onPrepared':
        mEzuiPlayerCalback?.onPrepared();
        break;
      case 'onPlaySuccess':
        //isPlay = true;
        //regionDidChange();
      //if (mEzuiPlayerCalback != null) {
        mEzuiPlayerCalback?.onPlaySuccess();
      //}
        break;
      case 'onPlayFail':
        String err = call.arguments;
        mEzuiPlayerCalback?.onPlayFailed(err);
        break;
      case 'onPlayStopped':
        mEzuiPlayerCalback?.onPlayStopped();
        break;
      case 'onVideoSizeChange':
        break;
      case 'onPrepared':
        break;
      case 'onPlayTime':
        break;
      case 'onPlayTime':
        break;
      case 'onPlayFinish':
        break;
    }
  }

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

//callback
typedef OnPlaySuccess = void Function();
typedef OnPlayFailed = void Function(String error);
typedef OnPlayStopped = void Function();
typedef OnVideoSizeChanged = void Function();
typedef OnPrepared = void Function();
typedef OnPlayTime = void Function(String time);
typedef OnPlayFinish = void Function();
class EzuiPlayerCallback {
  OnPrepared onPrepared;
  OnPlaySuccess onPlaySuccess;
  OnPlayFailed onPlayFailed;
  OnPlayStopped onPlayStopped;
  OnVideoSizeChanged onVideoSizeChanged;
  OnPlayTime onPlayTime;
  OnPlayFinish onPlayFinish;
  //void onPlaySuccess();
  EzuiPlayerCallback({this.onPlaySuccess, this.onPlayFailed, this.onPlayStopped, this.onVideoSizeChanged, this.onPrepared, this.onPlayTime, this.onPlayFinish});
}
