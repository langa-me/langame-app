import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/message_api.dart';

import 'authentication_provider.dart';

class MessageProvider extends ChangeNotifier {
  FirebaseApi firebase;
  CrashAnalyticsProvider _cap;
  // ignore: unused_field
  AuthenticationProvider _ap;
  AuthenticationApi _authApi;

  /// Messages, notifications ///

  MessageApi _messageApi;

  /// Create an authentication provider, and
  MessageProvider(
      this.firebase, this._messageApi, this._authApi, this._cap, this._ap);

  Future<LangameResponse<void>> initializeMessageApi() async {
    try {
      await _messageApi.cancel();
      await _messageApi.initializePermissions();
      await _messageApi.listen(null);

      // i.e. no internet
      // TODO  Caused by: java.net.UnknownHostException: Unable to resolve host "firestore.googleapis.com": No address associated with hostname
    } catch (e, s) {
      _cap.log('failed to initializeMessageApi');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<dynamic>> getInitialMessage() async {
    try {
      var r = await _messageApi.getInitialMessage();
      _cap.log('getInitialMessage');
      return LangameResponse(LangameStatus.succeed, result: r);
    } catch (e, s) {
      _cap.log('failed to getInitialMessage');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> cancel() async {
    try {
      await _messageApi.cancel();
      _cap.log('langame_provider:cancel');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('langame_provider:failed to cancel');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
