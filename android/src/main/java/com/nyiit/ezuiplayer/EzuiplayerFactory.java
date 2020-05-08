package com.nyiit.ezuiplayer;

import android.content.Context;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class EzuiplayerFactory extends PlatformViewFactory{
    private final BinaryMessenger messenger;

    public EzuiplayerFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @Override
    public PlatformView create(Context context, int id, Object args) {
        return new FlutterEzuiplayerView(context, messenger, id, args);
    }
}
