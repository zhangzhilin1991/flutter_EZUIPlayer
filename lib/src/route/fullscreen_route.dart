import 'package:auto_orientation/auto_orientation.dart';
import 'package:ezuiplayer/fultter_ezuiplayer.dart';
import 'package:ezuiplayer/src/widget/controller_widget_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenRoute extends StatefulWidget{
  final EzuiPlayerController controller;
  final EzuiPlayerControllerWidgetBuilder controllerWidgetBuilder;
  final EzuiPlayerMode fullscreenMode;

  FullScreenRoute({
    @required this.controller,
    @required this.controllerWidgetBuilder,
    this.fullscreenMode = EzuiPlayerMode.fullscreen_landscape,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FullScreenRouteState();
  }
}

class FullScreenRouteState extends State<FullScreenRoute> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //widget.controller.ezuiPlayerMode = EzuiPlayerMode.fullscreen_landscape;
    SystemChrome.setEnabledSystemUIOverlays([]);
    AutoOrientation.landscapeAutoMode();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Container(

        color: Colors.black,
        child: TextureEzuiPlayer(
                ezuiPlayerController: widget.controller,
                ezuiPlayerControllerWidgetBuilder: (ctl) => widget.controllerWidgetBuilder(ctl),
              ),
            ),
           // ),
           // ),
    //),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //AutoOrientation.portraitUpMode();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    //widget.controller.ezuiPlayerMode = EzuiPlayerMode.normal;
  }
}
