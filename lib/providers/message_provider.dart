import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/message_api.dart';
import 'package:langame/views/langame.dart';

import 'authentication_provider.dart';

class MessageProvider extends ChangeNotifier {
  FirebaseApi firebase;
  CrashAnalyticsProvider _cap;
  // ignore: unused_field
  AuthenticationProvider _ap;
  ContextProvider _cp;
  bool _isReady = false;
  bool get isReady => _isReady;

  /// Messages, notifications ///

  MessageApi _messageApi;

  /// Create an authentication provider, and
  MessageProvider(
      this.firebase, this._messageApi, this._cap, this._ap, this._cp) {
    _ap.userStream.listen((e) async {
      if (e.type == UserChangeType.NewAuthentication) {
        await _messageApi.cancel();
        await _messageApi.initializePermissions();
        await _messageApi.listen(null);
        _isReady = true;
        notifyListeners();
        _cap.log('message_provider:initialize');
        _messageApi.getInitialMessage().then((e) async {
          // Leave some time for UI
          await Future.delayed(Duration(seconds: 1));
          // Note that we ignore failures in dynamic link initialization
          if (e != null && e['channelName'] != null) {
            _cp.pushReplacement(LangameView(e['channelName'].toString(), false));
          }
        }).catchError((e, s) {
          _cap.log('message_provider:failed to get initial messages');
          _cap.recordError(e, s);
        });
      } else if (e.type == UserChangeType.Disconnection) {
        _messageApi.cancel();
      }
    });
  }

  Future<LangameResponse<void>> cancel() async {
    try {
      await _messageApi.cancel();
      _cap.log('langame_provider:cancel');
      _isReady = false;
      notifyListeners();
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('langame_provider:failed to cancel');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
