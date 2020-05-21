import 'dart:async';

import 'package:ezuiplayer/src/widget/controller_widget_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../fultter_ezuiplayer.dart';

typedef void EzuiPlayerCreatedCallback(EzuiPlayerController controller);

class EzuiPlayer extends StatefulWidget{
  final int width;
  final int height;
  //final String url;
  final EzuiPlayerController ezuiPlayerController;

  final EzuiPlayerControllerWidgetBuilder ezuiPlayerControllerWidgetBuilder;
  //final EzuiPlayerCreatedCallback onEzuiPlayerCreated;

  const EzuiPlayer({
    Key key,
    @required this.ezuiPlayerController,
    this.ezuiPlayerControllerWidgetBuilder = defaultEzuiPlayerControllerWidgetBuilder,
    this.width = 320,
    this.height = 240,
    //this.onEzuiPlayerCreated,
  }) :super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return _EzuiPlayerState();
  }
}

class _EzuiPlayerState extends State<EzuiPlayer> {

  //EzuiPlayerCreatedCallback onEzuiPlayerCreated;
  EzuiPlayerController ezuiPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.ezuiPlayerController = widget.ezuiPlayerController?? new EzuiPlayerController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //ezuiPlayerController.ezuiPlayerMode = EzuiPlayerMode.normal;

    Widget controllerWidget = widget.ezuiPlayerControllerWidgetBuilder?.call(ezuiPlayerController);
    Widget playerWidget = _buildEzuiPlayer();

    return Stack(
      children: <Widget>[
        playerWidget,
        controllerWidget,
      ],
    );
  }

  Widget _buildEzuiPlayer() {
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
    //if (widget.onEzuiPlayerCreated == null) {
    //  return;
    //}
    //widget.onEzuiPlayerCreated(new EzuiPlayerController._(id));
    ezuiPlayerController.bindTexture(id);
  }
}



//callback

