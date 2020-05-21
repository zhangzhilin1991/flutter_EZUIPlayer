/**
 * 播放成功回调
 */
typedef OnPlaySuccess = void Function();

/**
 * 播放失败回调
 */
typedef OnPlayFailed = void Function(String error);

/**
 * 播放停止回调
 */
typedef OnPlayStopped = void Function();

/**
 * 视频大小发生改变回调
 */
typedef OnVideoSizeChanged = void Function();

/**
 * 视频播放器创建完成回调
 */
typedef OnCreated = void Function();

/**
 * 视频播放器准备好播放回调
 */
typedef OnPrepared = void Function();

/**
 * 当前播放时间回调
 */
typedef OnPlayTime = void Function(String time);

/**
 * 播放完成回调
 */
typedef OnPlayFinish = void Function();

class EzuiPlayerCallback {
  OnCreated onCreated;
  OnPrepared onPrepared;
  OnPlaySuccess onPlaySuccess;
  OnPlayFailed onPlayFailed;
  OnPlayStopped onPlayStopped;
  OnVideoSizeChanged onVideoSizeChanged;
  OnPlayTime onPlayTime;
  OnPlayFinish onPlayFinish;
  //void onPlaySuccess();
  EzuiPlayerCallback({this.onCreated, this.onPlaySuccess, this.onPlayFailed, this.onPlayStopped, this.onVideoSizeChanged, this.onPrepared, this.onPlayTime, this.onPlayFinish});
}