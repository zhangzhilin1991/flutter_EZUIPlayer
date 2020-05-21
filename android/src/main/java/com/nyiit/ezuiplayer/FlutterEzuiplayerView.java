package com.nyiit.ezuiplayer;

import android.content.Context;
import android.graphics.Color;
import android.text.Layout;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import static io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import static io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;
import com.ezvizuikit.open.EZUIPlayer;
import com.ezvizuikit.open.EZUIError;

import java.util.Calendar;


public class FlutterEzuiplayerView implements PlatformView, MethodCallHandler, EZUIPlayer.EZUIPlayerCallBack  {
    private static final String TAG = FlutterEzuiplayerView.class.getName();

    private final int id;
    private final EZUIPlayer mEZUIPlayer;
    //private final TextView textView;
    private final MethodChannel methodChannel;
    private Context context;
    private boolean isPlay = false; //是否应该播放，用于状态切换后判断
    private String curUrl; //当前url


    FlutterEzuiplayerView(Context context, BinaryMessenger messenger, int id, Object args) {
        //textView = new TextView(context);
        this.id = id;
        mEZUIPlayer = new EZUIPlayer(context);
        mEZUIPlayer.setBackgroundColor(Color.parseColor("#FF000000"));
        RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT);
        mEZUIPlayer.setLayoutParams(params);
        //params.addRule(RelativeLayout.ALIGN_RIGHT, R.id.date); //or params.addRule(RelativeLayout.CENTER_IN_PARENT)
        mEZUIPlayer.setLoadingView(initProgressBar(context));
        mEZUIPlayer.setRatio(16*1.0f/9);

        mEZUIPlayer.setCallBack(this);
        methodChannel = new MethodChannel(messenger, "plugins.com.nyiit.ezuiplayer/EzuiPlayer_" + id);
        methodChannel.setMethodCallHandler(this);
    }

    /**
     * 创建加载view
     * @return
     */
    private View initProgressBar(Context context) { //一定要设置，否则界面一直显示转圈！！！！！！
        RelativeLayout relativeLayout = new RelativeLayout(context);
        relativeLayout.setBackgroundColor(Color.parseColor("#000000"));
        RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT);
        relativeLayout.setLayoutParams(lp);
        RelativeLayout.LayoutParams rlp=new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        rlp.addRule(RelativeLayout.CENTER_IN_PARENT);//addRule参数对应RelativeLayout XML布局的属性
        ProgressBar mProgressBar = new ProgressBar(context);
        //mProgressBar.setIndeterminateDrawable(context.getResources().getDrawable(R.drawable.progress));
        relativeLayout.addView(mProgressBar,rlp);
        return relativeLayout;
    }

    @Override
    public View getView() {
        return mEZUIPlayer;
        //textView;
    }

    @Override
    public void onFlutterViewAttached(View flutterView){
        //if (isPlay && (curUrl != null)) {
            //mEZUIPlayer.startPlay();
        //    mEZUIPlayer.setUrl(curUrl);
        //}
    }

    @Override
    public void onFlutterViewDetached() {
        mEZUIPlayer.stopPlay();
        methodChannel.invokeMethod("onPlayStopped", null);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method) {
            //case "setText":
            //    setText(methodCall, result);
            //    break;
            case "setUrl":
                setUrl(methodCall, result);
                break;
            case "startPlay":
                startPlay(result);
                isPlay = true;
                break;
            case "stopPlay":
                stopPlay(result);
                isPlay = false;
                break;
            default:
                result.notImplemented();
        }
    }

    private void setUrl(MethodCall methodCall, Result result) {
        String url = (String) methodCall.arguments;
        setUrl(url);
        result.success(null);
    }

    private void startPlay(Result result){
        startPlay();
        result.success(null);
    }

    private void stopPlay(Result result){
        stopPlay();
        result.success(null);
    }

    //状态提示
    private void setUrl(String url) {
        curUrl = url;
        mEZUIPlayer.setUrl(curUrl);
    }

    private void startPlay() {
        mEZUIPlayer.startPlay();
    }

    private void stopPlay() {
        mEZUIPlayer.stopPlay();
        methodChannel.invokeMethod("onPlayStopped", null);
    }

    @Override
    public void onPlaySuccess() {
        Log.d(TAG,"onPlaySuccess");
        // TODO: 2017/2/7 播放成功处理
        //mBtnPlay.setText(R.string.string_pause_play);
        //mEZUIPlayer.dissmissLoading();
        methodChannel.invokeMethod("onPlaySuccess", null);
    }

    @Override
    public void onPlayFail(EZUIError error) {
        Log.d(TAG,"onPlayFail");
        // TODO: 2017/2/21 播放失败处理
        if (error.getErrorString().equals(EZUIError.UE_ERROR_INNER_VERIFYCODE_ERROR)){

        }else if(error.getErrorString().equalsIgnoreCase(EZUIError.UE_ERROR_NOT_FOUND_RECORD_FILES)){
            // TODO: 2017/5/12
            //未发现录像文件
            //Toast.makeText(this,getString(R.string.string_not_found_recordfile),Toast.LENGTH_LONG).show();
        }
        methodChannel.invokeMethod("onPlayFail", error.getErrorString());
    }

    private int width;
    private int height;

    @Override
    public void onVideoSizeChange(int width, int height) {
        // TODO: 2017/2/16 播放视频分辨率回调
        Log.d(TAG,"onVideoSizeChange  width = "+width+"   height = "+height);
        //methodChannel.invokeMethod("onVideoSizeChange", width, height);
    }

    @Override
    public void onPrepared() {
        Log.d(TAG,"onPrepared");
        //播放
        //mEZUIPlayer.startPlay();
        methodChannel.invokeMethod("onPrepared", null);
    }

    @Override
    public void onPlayTime(Calendar calendar) {
        //Log.d(TAG,"onPlayTime");
        if (calendar != null) {
            // TODO: 2017/2/16 当前播放时间
            //Log.d(TAG,"onPlayTime calendar = "+calendar.getTime().toString());
            methodChannel.invokeMethod("onPlayTime", calendar.getTime().toString());
        }
    }

    @Override
    public void onPlayFinish() {
        // TODO: 2017/2/16 播放结束
        Log.d(TAG,"onPlayFinish");
        methodChannel.invokeMethod("onPlayFinish", null);
    }

    @Override
    public void dispose() {
        mEZUIPlayer.stopPlay();
        mEZUIPlayer.releasePlayer();
    }
}
