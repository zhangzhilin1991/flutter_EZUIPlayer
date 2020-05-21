package com.nyiit.ezuiplayer_example;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.nyiit.ezuiplayer.EzuiplayerPlugin;

public class MainActivity extends FlutterActivity {

  //private final String appKey = "cbc4453d01b2406da120d5ed1453b737";
  //private final String mAccessToken = "at.8n34e0zyc8hf22oudawpf2j41zgr8k1q-4u953rl869-0r7xdys-ixkhhf3nq";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    //EzuiplayerPlugin.EzuiplayerInit(this.getApplication(), appKey, mAccessToken);
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    //EzuiplayerPlugin.registerWith(registrarFor("com.nyiit.ezuiplayer.EzuiplayerPlugin"));
  }
}
