part of 'controller_widget_builder.dart';

Widget _buildFullscreenEzuiPlayerController(EzuiPlayerController controller){
  return DefaultEzuiPlayerControllerWidget(
    controller: controller,
    currentFullScreenState: true,
  );
}

Widget buildFullscreenEzuiPlayerController(EzuiPlayerController controller) {
  print("buildFullscreenEzuiPlayerController()");
  return _buildFullscreenEzuiPlayerController(controller);
}

showFullScreenEZUIPlayer({
    BuildContext context,
    EzuiPlayerController controller,
    EzuiPlayerControllerWidgetBuilder fullscreenControllerWidgetBuilder,
    }) {
  Navigator.push(context,
      new MaterialPageRoute(builder: (BuildContext context) => FullScreenRoute(
    controller: controller,
    controllerWidgetBuilder: fullscreenControllerWidgetBuilder
      )
      )
  );
}