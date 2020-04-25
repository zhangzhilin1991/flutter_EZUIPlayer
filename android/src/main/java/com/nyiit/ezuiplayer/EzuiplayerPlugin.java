package com.nyiit.ezuiplayer;

import io.flutter.plugin.common.PluginRegistry.Registrar;

/** EzuiplayerPlugin */
public class EzuiplayerPlugin{
  public static void registerWith(Registrar registrar) {
    registrar
            .platformViewRegistry()
            .registerViewFactory(
                    "plugins.com.nyiit.ezuiplayer/EzuiPlayer", new EzuiplayerFactory(registrar.messenger()));
  }
}
