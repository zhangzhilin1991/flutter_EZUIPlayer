import 'dart:async';

import 'package:flutter/services.dart';

import '../../fultter_ezuiplayer.dart';

enum EzuiPlayerMode{
  normal,
  //fullscreen_portrait,
  fullscreen_landscape
}

class EzuiPlayerController {
  /// video info stream controller
  StreamController<EzuiPlayerStatus> _ezuiPlayerStatusController = StreamController.broadcast();

  /// video info stream
  Stream<EzuiPlayerStatus> get ezuiPlayerStatusStream => _ezuiPlayerStatusController?.stream;

  //String channelName;
  int textureId;

  MethodChannel _channel;
  EzuiPlayerCallback _mEzuiPlayerCalback;

  EzuiPlayerController();

  bool _isPlay = false;

  /*EzuiPlayerMode _ezuiPlayerMode = EzuiPlayerMode.normal;

  get ezuiPlayerMode => _ezuiPlayerMode;

  set ezuiPlayerMode(EzuiPlayerMode ezuiPlayerMode) {
    _ezuiPlayerMode = ezuiPlayerMode;
    _ezuiPlayerStatusController.add(isFullScreen? EzuiPlayerStatus.onFullScreen: EzuiPlayerStatus.onNormal);
  }

  bool get isFullScreen => _ezuiPlayerMode != EzuiPlayerMode.normal;
   */

  //set ezuiPlayerMode(EzuiPlayerMode ezuiPlayerMode) {
  //  this._ezuiPlayerMode = ezuiPlayerMode;
  //}

  dispose() {
    _ezuiPlayerStatusController?.close();
  }

  bindTexture(int id){
     textureId = id;
     _channel = new MethodChannel('plugins.com.nyiit.ezuiplayer/EzuiPlayer_$id');
      //channelName = _channel.name;
     _channel.setMethodCallHandler(_handleMethodCall);
     _mEzuiPlayerCalback?.onCreated(); //onCreated
     _ezuiPlayerStatusController.add(EzuiPlayerStatus.onCreated);
  }

  setEzuiPlayerCalback(EzuiPlayerCallback ezuiPlayerCalback){
    this._mEzuiPlayerCalback = ezuiPlayerCalback;
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    //print("_handleMethodCall: " + call.method);
    switch (call.method) {
      case 'onPrepared':
        _mEzuiPlayerCalback?.onPrepared();
        _ezuiPlayerStatusController.add(EzuiPlayerStatus.onPrepared);
        break;
      case 'onPlaySuccess':
        _isPlay = true;
      //regionDidChange();
      //if (mEzuiPlayerCalback != null) {
        _mEzuiPlayerCalback?.onPlaySuccess();
        _ezuiPlayerStatusController.add(EzuiPlayerStatus.onPlaySuccess);
        //}
        break;
      case 'onPlayFail':
        _isPlay = false;
        String err = call.arguments;
        _mEzuiPlayerCalback?.onPlayFailed(err);
        _ezuiPlayerStatusController.add(EzuiPlayerStatus.onPlayFail);
        break;
      case 'onPlayStopped':
        _isPlay = false;
        _mEzuiPlayerCalback?.onPlayStopped();
        _ezuiPlayerStatusController.add(EzuiPlayerStatus.onPlayStopped);
        break;
      case 'onVideoSizeChange':
        break;
      case 'onPlayTime':
       // _ezuiPlayerStatusController.add(EzuiPlayerStatus.onPlayTime);
        break;
      case 'onPlayFinish':
        _ezuiPlayerStatusController.add(EzuiPlayerStatus.onPlayFinish);
        _isPlay = false;
        break;
    }
  }

  bool get isPlay => _isPlay;

  Future<void> playOrPause() async {
    return isPlay? stopPlay() :  startPlay();
  }

  Future<void> setUrl(String url) async {
    assert(url != null);
    return _channel.invokeMethod('setUrl', url);
  }

  Future<void> startPlay() async {
    //assert(url != null);
    return _channel.invokeMethod('startPlay');
  }

  Future<void> stopPlay() async {
    //assert(url != null);
    return _channel.invokeMethod('stopPlay');
  }
}