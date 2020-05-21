import 'package:flutter/cupertino.dart';
import 'package:ezuiplayer/fultter_ezuiplayer.dart';
import 'package:flutter/material.dart';

class TextureEzuiPlayer extends StatefulWidget{
  final EzuiPlayerController ezuiPlayerController;
  final EzuiPlayerControllerWidgetBuilder ezuiPlayerControllerWidgetBuilder;

  TextureEzuiPlayer({
    @required this.ezuiPlayerController,
    this.ezuiPlayerControllerWidgetBuilder = defaultEzuiPlayerControllerWidgetBuilder,
});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextureEzuiPlayerState();
  }
}

class  TextureEzuiPlayerState extends State<TextureEzuiPlayer> {
  get controller => widget.ezuiPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget controllerWidget = widget.ezuiPlayerControllerWidgetBuilder?.call(controller);
    Widget texturePlayerWidget = _buildPlayerTexture(controller.textureId);

    return Stack(
        children: <Widget>[
        texturePlayerWidget,
        controllerWidget,
        ],);
  }

  Widget _buildPlayerTexture(int textureId) {
    Widget w = Container(
      color: Colors.black,
      child: Texture(
        textureId: textureId,
      ),
    );

    //w = AspectRatio(
    //  aspectRatio: 4 / 3,
   //   child: w,
    //);

    //w = Center(child: w,);

    return w;
  }
}

