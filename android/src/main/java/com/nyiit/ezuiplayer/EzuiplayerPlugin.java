package com.nyiit.ezuiplayer;

import android.app.Application;
import android.content.Context;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import static io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import static io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformViewRegistry;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

import com.ezvizuikit.open.EZUIPlayer;
import com.ezvizuikit.open.EZUIKit;

/** EzuiplayerPlugin */
public class EzuiplayerPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {
  private Application application;

  MethodChannel methodChannel;

  //v1
  public static void registerWith(Registrar registrar) {
    //registrar
    //        .platformViewRegistry()
    //        .registerViewFactory(
    //                "plugins.com.nyiit.ezuiplayer/EzuiPlayer", new EzuiplayerFactory(registrar.messenger()));
    final EzuiplayerPlugin instance = new EzuiplayerPlugin();
    instance.application = (Application) registrar.context().getApplicationContext();

    instance.registerEzuiPlayerManager(registrar.messenger());
    instance.registerEzuiplayerView(registrar.platformViewRegistry(), registrar.messenger());
  }

  //v2
  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    //onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
    application = (Application) binding.getApplicationContext();
    registerEzuiPlayerManager(binding.getBinaryMessenger());
    registerEzuiplayerView(binding.getPlatformViewRegistry(), binding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    application = null;
  }

  //v2
  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivityForConfigChanges(){

  }

  private void registerEzuiplayerView(PlatformViewRegistry platformViewRegistry, BinaryMessenger messenger){
    platformViewRegistry
            .registerViewFactory(
                    "plugins.com.nyiit.ezuiplayer/EzuiPlayer", new EzuiplayerFactory(messenger));
  }

  private void registerEzuiPlayerManager(BinaryMessenger messenger) {
    //this.application = application;
    methodChannel = new MethodChannel(messenger, "plugins.com.nyiit.ezuiplayer/EzuiPlayerManager");
    methodChannel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
    switch (methodCall.method) {
      //case "setText":
      //    setText(methodCall, result);
      //    break;
      case "EzuiPlayerInit":
        //Map<Object, >
        String appKey = methodCall.argument("appKey");
        String accessToken = methodCall.argument("accessToken");;
        EzuiPlayerInit(application, appKey, accessToken);
        result.success(null);
        break;
      default:
        result.notImplemented();
    }
  }

  private void EzuiPlayerInit(Application application, String appKey, String AccessToken){
    EZUIKit.initWithAppKey(application, appKey);
    EZUIKit.setAccessToken(AccessToken);
  }

}
