import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/message_api.dart';

import 'authentication_provider.dart';

class MessageProvider extends ChangeNotifier {
  FirebaseApi firebase;
  CrashAnalyticsProvider _crashAnalyticsProvider;
  // ignore: unused_field
  AuthenticationProvider _authenticationProvider;
  AuthenticationApi _authenticationApi;

  /// Messages, notifications ///

  MessageApi _messageApi;

  /// In-memory local notifications
  List<lg.Notification> _notifications = [];

  List<lg.Notification> get notifications => _notifications;

  /// Create an authentication provider, and
  MessageProvider(this.firebase, this._messageApi, this._authenticationApi,
      this._crashAnalyticsProvider, this._authenticationProvider);

  Future<LangameResponse> initializeMessageApi() async {
    try {
      _messageApi.cancel();
      await _messageApi.initializePermissions();
      await _messageApi.listen(_onNotificationHandler);
      // i.e. no internet
      // TODO  Caused by: java.net.UnknownHostException: Unable to resolve host "firestore.googleapis.com": No address associated with hostname
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to initializeMessageApi');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<String>> getChannelToken(String channelName) async {
    try {
      var r = await _authenticationApi.getChannelToken(channelName);
      _crashAnalyticsProvider.log('getChannelToken $r');
      return LangameResponse<String>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to get channel $channelName token');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<lg.Langame>> getChannel(String channelName) async {
    try {
      var r = await _authenticationApi.getChannel(channelName);
      _crashAnalyticsProvider.log('getChannel ${r.channelName}');
      return LangameResponse<lg.Langame>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to get channel $channelName');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  void _onNotificationHandler(lg.Notification? notification) {
    if (notification == null) return;
    _notifications.add(notification);
    notifyListeners();
  }

  Future<LangameResponse<String>> send(
      List<lg.User> recipients, List<lg.Topic> topics,
      {bool now = false}) async {
    try {
      final String msg =
          'send langame to ${recipients.map((e) => e.uid).join(',')}';
      _crashAnalyticsProvider.log(msg);

      // TODO: we'd likely send the whole  topic in the future (with classifications)
      var channelName = await _messageApi.send(
          recipients.map((e) => e.uid).toList(),
          topics.map((e) => e.content).toList());
      if (now) await notifyPresence(channelName);
      return LangameResponse(LangameStatus.succeed, result: channelName);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to send langame');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> sendLangameEnd(String channelName) async {
    try {
      await _messageApi.sendLangameEnd(channelName);
      _crashAnalyticsProvider.log('sendLangameEnd $channelName');
      return LangameResponse<void>(LangameStatus.succeed);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to sendLangameEnd $channelName');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse> notifyPresence(String channelName) async {
    try {
      await _messageApi.notifyPresence(channelName);
      _crashAnalyticsProvider.log('notifyPresence');
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to notifyPresence');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  /// Get a precise notification
  Future<LangameResponse<lg.Notification>> getNotification(
      String id) async {
    try {
      var r = await _messageApi.fetch(id);
      _crashAnalyticsProvider.log('getNotification ${r?.channelName}');
      return LangameResponse<lg.Notification>(LangameStatus.succeed,
          result: r);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to getNotification');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  // TODO: use langame resp
  Future<LangameResponse<void>> fetchNotifications() async {
    try {
      var r = await _messageApi.fetchAll(); // TODO: make it a generator
      r.forEach((n) {
        _notifications.add(n);
        notifyListeners();
      });
      _crashAnalyticsProvider.log('fetchNotifications');
      return LangameResponse<lg.Notification>(LangameStatus.succeed);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to fetchNotifications');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> deleteNotification(String channelName) async {
    try {
      var f = _messageApi.delete(channelName);
      f
          .then((value) => _notifications
              .removeWhere((element) => element.channelName == channelName))
          .then((value) => notifyListeners());
      _crashAnalyticsProvider.log('deleteNotification');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to deleteNotification');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  void stopNotifications() => _messageApi.cancel();

  Future<LangameResponse<lg.Notification?>> getInitialMessage() async {
    try {
      var r = await _messageApi.getInitialMessage();
      _crashAnalyticsProvider.log('getInitialMessage');
      return LangameResponse(LangameStatus.succeed, result: r);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to getInitialMessage');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
