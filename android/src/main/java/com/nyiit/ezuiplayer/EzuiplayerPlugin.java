package com.nyiit.ezuiplayer;

import android.app.Application;
import android.content.Context;

import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformViewRegistry;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import com.ezvizuikit.open.EZUIPlayer;
import com.ezvizuikit.open.EZUIKit;

/** EzuiplayerPlugin */
public class EzuiplayerPlugin implements FlutterPlugin {
  //private Context applicationContext;

  //v1
  public static void registerWith(Registrar registrar) {
    //registrar
    //        .platformViewRegistry()
    //        .registerViewFactory(
    //                "plugins.com.nyiit.ezuiplayer/EzuiPlayer", new EzuiplayerFactory(registrar.messenger()));
    final EzuiplayerPlugin instance = new EzuiplayerPlugin();
    instance.registerEzuiplayerView(registrar.platformViewRegistry(), registrar.messenger());
  }

  //v2
  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    //onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
    registerEzuiplayerView(binding.getPlatformViewRegistry(), binding.getBinaryMessenger());
  }

  //private void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger, ) {
    //this.applicationContext = applicationContext;
  //}

  private void registerEzuiplayerView(PlatformViewRegistry platformViewRegistry, BinaryMessenger messenger){
    platformViewRegistry
            .registerViewFactory(
                    "plugins.com.nyiit.ezuiplayer/EzuiPlayer", new EzuiplayerFactory(messenger));
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    //applicationContext = null;
  }

  public static void EzuiplayerInit(Application application, String appKey, String AccessToken){
    EZUIKit.initWithAppKey(application, appKey);
    EZUIKit.setAccessToken(AccessToken);
  }

}
