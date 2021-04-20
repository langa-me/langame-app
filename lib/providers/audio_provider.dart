import 'dart:async';
import 'dart:core';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiver/async.dart';
import 'package:retry/retry.dart';

/// [AudioProvider] handles logic for audio communication
/// currently only supporting Agora
/// see doc https://docs.agora.io/en/Voice/API%20Reference/flutter/index.html
class AudioProvider extends ChangeNotifier {
  RtcEngine? _engine;
  FirebaseApi firebase;

  AudioProvider(this.firebase);

  bool _isMicrophoneEnabled = false;
  bool get isMicrophoneEnabled => _isMicrophoneEnabled;
  bool _isSpeakerphoneEnabled = true;
  bool get isSpeakerphoneEnabled => _isSpeakerphoneEnabled;

  // ignore: close_sinks
  StreamController<Duration> _remaining = StreamController.broadcast();
  Stream<Duration> get remaining => _remaining.stream.asBroadcastStream();
  StreamSubscription<CountdownTimer>? _sub;

  bool get timerStarted => _sub != null;

  LangameResponse<void> startTimer() {
    try {
      // Ignore
      if (_sub != null) return LangameResponse(LangameStatus.succeed);
      CountdownTimer countDownTimer = CountdownTimer(
        Duration(minutes: 15),
        Duration(seconds: 1),
      );

      _sub = countDownTimer.listen(null);
      _sub?.onData((duration) {
        _remaining.add(duration.remaining);
      });

      _sub?.onDone(_sub?.cancel);
    } catch (e, s) {
      firebase.crashlytics?.log('failed to start timer');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  LangameResponse stopTimer() {
    try {
      _sub?.cancel();
      _sub = null;
    } catch (e, s) {
      firebase.crashlytics?.log('failed to stop timer');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<bool>> checkPermission() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        bool s = await Permission.microphone.isGranted;
        return LangameResponse(LangameStatus.succeed, result: s);
      } else {
        // iOS? TODO: how it works
        return LangameResponse(LangameStatus.succeed, result: true);
      }
    } catch (e, s) {
      firebase.crashlytics?.log('failed to check permission');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<bool>> requestPermission() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        var s = await Permission.microphone.request();
        return LangameResponse(LangameStatus.succeed, result: s.isGranted);
      } else {
        // iOS? TODO: how it works
        return LangameResponse(LangameStatus.succeed, result: true);
      }
    } catch (e, s) {
      firebase.crashlytics?.log('failed to requestPermission');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> initEngine(
      RtcEngineEventHandler eventHandler) async {
    try {
      _engine = await RtcEngine.createWithConfig(
          RtcEngineConfig(AppConst.agoraAppID));
      _engine!.setEventHandler(eventHandler);
      await Future.wait([
        _engine!.enableAudio(),
        _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting),
        _engine!.setClientRole(ClientRole.Broadcaster),
        _engine!.enableLocalAudio(_isMicrophoneEnabled),
        _engine!.setEnableSpeakerphone(_isSpeakerphoneEnabled),
      ]); // Usually disabling microphone by default

    } catch (e, s) {
      firebase.crashlytics?.log('failed to init audio engine');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<void>> joinChannel(
      String token, String channel, int agoraUid) async {
    try {
      final msg =
          'trying to join channel $channel with token $token with uid $agoraUid';
      debugPrint(msg);
      firebase.crashlytics?.log(msg);

      // TODO: replace by which use string uid
      // _engine.joinChannelWithUserAccount(token, channelName, userAccount)
      final r = RetryOptions(maxAttempts: 8);
      await r.retry(
        () => _engine
            ?.joinChannel(token, channel, null, agoraUid)
            .timeout(Duration(seconds: 5)),
        retryIf: (e) => e is PlatformException || e is TimeoutException,
      );
    } catch (e, s) {
      firebase.crashlytics?.log('failed to join channel $channel');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<void>> leaveChannel() async {
    try {
      await _engine?.leaveChannel();
      await _engine?.destroy();
      _engine = null;
    } catch (e, s) {
      firebase.crashlytics?.log('failed to leaveChannel');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<void>> switchMicrophone() async {
    try {
      await _engine!.enableLocalAudio(!_isMicrophoneEnabled);
      _isMicrophoneEnabled = !_isMicrophoneEnabled;
      notifyListeners();
    } catch (e, s) {
      firebase.crashlytics?.log('failed to switchMicrophone');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<void>> switchSpeakerphone() async {
    try {
      await _engine!.setEnableSpeakerphone(!_isSpeakerphoneEnabled);
      _isSpeakerphoneEnabled = !_isSpeakerphoneEnabled;
      notifyListeners();
    } catch (e, s) {
      firebase.crashlytics?.log('failed to switchSpeakerphone');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }
}
