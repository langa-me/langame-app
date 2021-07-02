import 'dart:async';
import 'dart:core';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/remote_config_provider.dart';
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
  CrashAnalyticsProvider _cap;
  RemoteConfigProvider _rcp;
  AuthenticationProvider _ap;

  AudioProvider(this.firebase, this._cap, this._rcp, this._ap) {
    this._ap.userStream.listen((e) {
      if (e.type == UserChangeType.NewAuthentication) {
      } else if (e.type == UserChangeType.NewAuthentication) {
        leaveChannel();
      }
    });
  }

  bool _isMicrophoneEnabled = false;

  bool get isMicrophoneEnabled => _isMicrophoneEnabled;
  bool _isSpeakerphoneEnabled = true;

  bool get isSpeakerphoneEnabled => _isSpeakerphoneEnabled;
  bool _hasJoinedChannel = false;
  bool _isJoining = false;
  String? _langameSnapId;

  Future<LangameResponse<bool>> checkPermission() async {
    try {
      bool s = await Permission.microphone.isGranted;
      return LangameResponse(LangameStatus.succeed, result: s);
    } catch (e, s) {
      _cap.log('failed to check permission');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<bool>> requestPermission() async {
    try {
      var s = await Permission.microphone.request();
      return LangameResponse(LangameStatus.succeed, result: s.isGranted);
    } catch (e, s) {
      _cap.log('failed to requestPermission');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> initEngine(
      RtcEngineEventHandler eventHandler) async {
    try {
      _engine = await RtcEngine.createWithConfig(
          RtcEngineConfig(AppConst.agoraAppID));
      eventHandler.leaveChannel = (a) {
        // TODO: might do some handler stuff on provider side too
        eventHandler.leaveChannel!(a);
        leaveChannel();
      };

      _engine!.setEventHandler(eventHandler);
      await Future.wait([
        _engine!.enableAudio(),
        _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting),
        _engine!.setClientRole(ClientRole.Broadcaster),
        _engine!.enableLocalAudio(_isMicrophoneEnabled),
        // switchMicrophone(),
        // switchMicrophone(),
        _engine!.setEnableSpeakerphone(_isSpeakerphoneEnabled),
        // @see https://docs.agora.io/en/Voice/API%20Reference/flutter/rtc_engine/RtcEngine/enableAudioVolumeIndication.html
        // TODO: remote config
        _engine!.enableAudioVolumeIndication(200, 3, false),
      ]); // Usually disabling microphone by default

    } catch (e, s) {
      _cap.log('failed to init audio engine');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<void>> joinChannel(
      DocumentSnapshot<Langame> langame) async {
    try {
      if (_engine == null) {
        return LangameResponse(LangameStatus.failed, error: 'engine_null');
      }
      if (_hasJoinedChannel || _isJoining) {
        _cap.log('joinChannel already joining channel or has joined');
        return LangameResponse(LangameStatus.succeed);
      }

      var self = await firebase.firestore!
          .doc(
              'langames/${langame.id}/players/${firebase.auth!.currentUser!.uid}')
          .withConverter<Player>(
            fromFirestore: (snapshot, _) =>
                PlayerExt.fromObject(snapshot.data()!),
            toFirestore: (user, _) => user.toMapStringDynamic(),
          )
          .get();

      if (self.data() == null || !self.data()!.hasAudioToken())
        return LangameResponse(LangameStatus.failed,
            error: 'invalid audio id or has no audio token');
      final msg =
          'trying to join channel with audio id ${self.data()!.audioId}';
      _cap.log(msg);

      _isJoining = true;

      final r = RetryOptions(maxAttempts: 8);

      var lr = await runZonedGuarded<Future<LangameResponse<void>>>(() async {
        var response = await r.retry<LangameResponse<void>>(
            () => _engine!
                .joinChannel(self.data()!.audioToken,
                    langame.data()!.channelName, null, self.data()!.audioId)
                .timeout(Duration(seconds: 20))
                .then((_) => LangameResponse(LangameStatus.succeed))
                .catchError((_) => LangameResponse(LangameStatus.failed)),
            retryIf: (e) => e is PlatformException || e is TimeoutException,
            onRetry: (e) {
              _cap.log(
                  'failed to join channel with token ${self.data()!.audioToken}, retrying $e',
                  analyticsMessage: 'audio_failed_join',
                  analyticsParameters: {
                    'error': e,
                    'token': self.data()!.audioToken,
                  });
            });
        return response;
      }, (e, s) {
        _cap.log('failed to join channel ${langame.data()!.channelName}');
        _cap.recordError(e, s);
      })!;
      if (lr.status == LangameStatus.failed)
        LangameResponse(LangameStatus.failed);
    } catch (e, s) {
      _cap.log('failed to join channel ${langame.data()!.channelName}');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    _hasJoinedChannel = true;
    _langameSnapId = langame.id;
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<void>> leaveChannel() async {
    try {
      _hasJoinedChannel = false;
      _isJoining = false;
      await runZonedGuarded(() async {
        await _engine?.leaveChannel();
        await _engine?.destroy();
      }, (_, __) {});
      if (_langameSnapId != null) {
        firebase.firestore!
            .collection('langames')
            .doc(_langameSnapId!)
            .collection('players')
            .doc(firebase.auth!.currentUser!.uid)
            .update({
          'timeOut': FieldValue.serverTimestamp(),
        });
      }
      _langameSnapId = null;
      _engine = null;
      _cap.log('audio_provider:leaveChannel');
    } catch (e, s) {
      _cap.log('audio_provider:failed to leaveChannel');
      _cap.recordError(e, s);
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
      _cap.log('failed to switchMicrophone');
      _cap.recordError(e, s);
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
      _cap.log('failed to switchSpeakerphone');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<User>> getLangameUserFromAudioId(int audioId) async {
    try {
      var players = (await firebase.firestore!
              .collection('langames')
              .doc(_langameSnapId)
              .collection('players')
              .where('audioId', isEqualTo: audioId)
              .withConverter<Player>(
                fromFirestore: (snapshot, _) =>
                    PlayerExt.fromObject(snapshot.data()!),
                toFirestore: (user, _) => user.toMapStringDynamic(),
              )
              .get())
          .docs;

      if (players.length == 0)
        return LangameResponse(LangameStatus.failed, error: 'unknown_user');
      var player = players.first.data();
      var user = await firebase.firestore!
          .collection('users')
          .doc(player.userId)
          .withConverter<User>(
            fromFirestore: (snapshot, _) =>
                UserExt.fromObject(snapshot.data()!),
            toFirestore: (user, _) => user.toMapStringDynamic(),
          )
          .get();
      if (!user.exists)
        return LangameResponse(LangameStatus.failed, error: 'unknown_user');
      return LangameResponse(LangameStatus.succeed, result: user.data()!);
    } catch (e, s) {
      _cap.log('failed to getLangameUserFromAudioId');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> incrementCurrentMeme(
      Langame l, int value) async {
    try {
      if (l.currentMeme + value < 0 || l.currentMeme + value >= l.memes.length)
        return LangameResponse(LangameStatus.succeed);
      var ref = firebase.firestore!
          .collection(AppConst.firestoreLangamesCollection)
          .doc(_langameSnapId);
      await ref.update({
        'currentMeme': FieldValue.increment(value),
      });
      _cap.log('incrementCurrentMeme ${l.currentMeme} + $value');

      l.currentMeme = l.currentMeme + value;
      notifyListeners();

      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to switchSpeakerphone');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
