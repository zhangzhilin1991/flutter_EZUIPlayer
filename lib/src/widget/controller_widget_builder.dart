import 'package:ezuiplayer/fultter_ezuiplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

part 'full_screen.part.dart';

typedef Widget EzuiPlayerControllerWidgetBuilder(EzuiPlayerController controller);

Widget defaultEzuiPlayerControllerWidgetBuilder(EzuiPlayerController controller){
  return DefaultEzuiPlayerControllerWidget(
      controller: controller,
      fullscreenEzuiPlayerCControllerWidgetBuilder:
          (ctl) => buildFullscreenEzuiPlayerController(ctl), //函数
  );
}

class DefaultEzuiPlayerControllerWidget extends StatefulWidget{
  final EzuiPlayerController controller;

  final EzuiPlayerControllerWidgetBuilder fullscreenEzuiPlayerCControllerWidgetBuilder;

  final bool currentFullScreenState;

  //final void Function(bool enter) onFullScreen;

  DefaultEzuiPlayerControllerWidget({
    key,
    @required this.controller,
    this.fullscreenEzuiPlayerCControllerWidgetBuilder,
    this.currentFullScreenState = false,
  }):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DefaultEzuiPlayerControllerWidgetState();
  }
}

class DefaultEzuiPlayerControllerWidgetState extends State<DefaultEzuiPlayerControllerWidget> {
  EzuiPlayerController get controller => widget.controller;

  GlobalKey currentKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("DefaultEzuiPlayerControllerWidget() currentFullScreenState: ${widget.currentFullScreenState}");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      key: currentKey,
      child: _buildContent(context),
      onDoubleTap: onDoubleTap,
      onTap: onTap,
    );
  }

  Widget _buildContent(BuildContext context) {
    return ControllerWidget(
      controller: controller,
      //onFullScreen: onFullScreen,
      //isFullScreen: widget.currentFullScreenState,
      fullScreen: _buildFullScreenButton(context),
      isShowProgress: false,
    );
  }

  void onDoubleTap(){
    //fullscreen
  }

  void onTap() {

  }

  Widget _buildFullScreenButton(BuildContext context) {
    var isFull = widget.currentFullScreenState;

    print("_buildFullScreenButton: $isFull");

    return IconButton(
      color: Colors.white,
      icon: Icon(isFull ? Icons.fullscreen_exit : Icons.fullscreen),
      onPressed: () => onFullScreen(context),
    );
  }

  void onFullScreen(BuildContext context) {
    var isFull = widget.currentFullScreenState;

    if (isFull) {
      //controller.ezuiPlayerMode = EzuiPlayerMode.normal;
      Navigator.pop(context);
    } else {
      //controller.ezuiPlayerMode = EzuiPlayerMode.fullscreen_landscape;
      showFullScreenEZUIPlayer(
        context: context,
        controller: controller,
        fullscreenControllerWidgetBuilder: widget.fullscreenEzuiPlayerCControllerWidgetBuilder,
      );
    }
  }
}

typedef OnFullScreen = void Function();

class ControllerWidget extends StatelessWidget {
  final EzuiPlayerController controller;
  Widget fullScreen;
  //final OnFullScreen onFullScreen;
  final bool isShowProgress;
 // final bool isFullScreen;

  ControllerWidget({
    key,
    @required this.controller,
    //this.onFullScreen,
    //this.isFullScreen = false,
    this.fullScreen,
    this.isShowProgress = false,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return //new Scaffold( //Material组件
        //body:
        StreamBuilder<EzuiPlayerStatus>(
        stream: controller.ezuiPlayerStatusStream,
        builder: (context, snapshot) {
          var status = snapshot.data;
          print("ControllerWidget status: $status");
          return
            Column(
              children: <Widget>[
                //controller.isFullScreen?_buildTopBar(context):Container(),
                Expanded(
                  child: Container(),
                ),
                _buildBottomBar(),
              ],
            );
        }
        //)
    );
  }



  Widget _buildTopBar(BuildContext context) {
    Widget widget = Row(
      children: <Widget>[
        IconButton(
            icon: const BackButtonIcon(),
            color: Colors.white,
            onPressed: () {
                Navigator.pop(context);
            },
        ),
        Expanded(child: Container(),), //
      ],
    );
    widget = Container(
      color: Colors.black.withOpacity(0.12),
      child: widget
    );

    return widget;
  }

  Widget _buildBottomBar() {
    Widget widget = Row(
      children: <Widget>[
        _buildPlayButton(),
        _buildProgress(),
        //_buildFullScreenButton(),
        fullScreen,
      ],
    );
    widget = DefaultTextStyle(
      style: const TextStyle(
        color: Colors.white,
      ),
      child: widget,
    );
    widget = Container(
      color: Colors.black.withOpacity(0.12),
      child: widget,
    );
    return widget;
  }

  Widget _buildProgress() {
    if (isShowProgress) {
      return Expanded(child: Container(),); //
    } else {
      return Expanded(child: Container(),);
    }
  }

  Widget _buildPlayButton() {
    return IconButton(
      onPressed: () {
        controller.playOrPause();
      },
      color: Colors.white,
      icon: Icon(controller.isPlay ? Icons.pause : Icons.play_arrow),
      iconSize: 25.0,
    );
  }
}