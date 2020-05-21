
import 'package:flutter/services.dart';

class EzuiPlayerManager{
  static MethodChannel _globalChannel = new MethodChannel("plugins.com.nyiit.ezuiplayer/EzuiPlayerManager");

  static void initEzuiPlayer(String appKey, String accessToken) async{
    _globalChannel.invokeMethod("EzuiPlayerInit", {'appKey': '$appKey', 'accessToken': '$accessToken'});
  }
}