package com.nyiit.ezuiplayer;

import android.content.Context;
import android.view.View;
import android.widget.TextView;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import static io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import static io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;
import com.ezvizuikit.open.EZUIPlayer;


public class FlutterEzuiplayerView implements PlatformView, MethodCallHandler  {
    private final EZUIPlayer mEZUIPlayer;
    private final TextView textView;
    private final MethodChannel methodChannel;

    FlutterEzuiplayerView(Context context, BinaryMessenger messenger, int id) {
        textView = new TextView(context);
        mEZUIPlayer = new EZUIPlayer(context);
        methodChannel = new MethodChannel(messenger, "plugins.com.nyiit.ezuiplayer/EzuiPlayer_" + id);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public View getView() {
        return textView;
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method) {
            case "setText":
                setText(methodCall, result);
                break;
            default:
                result.notImplemented();
        }

    }

    private void setText(MethodCall methodCall, Result result) {
        String text = (String) methodCall.arguments;
        textView.setText(text);
        result.success(null);
    }

    @Override
    public void dispose() {}
}
