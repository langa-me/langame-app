import 'dart:async';

import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/services/http/message_api.dart';
import 'package:uuid/uuid.dart';

import 'firebase.dart';

class FakeMessageApi extends MessageApi {
  FakeMessageApi(FirebaseApi firebase,
      void Function(LangameNotification?) onBackgroundOrForegroundOpened)
      : super(firebase, onBackgroundOrForegroundOpened);

  @override
  Future<LangameResponse> initializePermissions() async {
    return LangameResponse(LangameStatus.succeed);
  }

  var uuid = Uuid();

  @override
  Future<LangameNotification?> fetch(String id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<List<LangameNotification>> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  void cancel() {
    // TODO: implement cancel
  }
  @override
  Future<LangameNotification?> getInitialMessage() {
    // TODO: implement getInitialMessage
    throw UnimplementedError();
  }

  @override
  Future<String> send(List<String> recipients, List<String> topics) async {
    throw UnimplementedError();
  }

  @override
  Future<void> notifyPresence(String channelName) {
    throw UnimplementedError();
  }

  @override
  Future<void> listen(void Function(LangameNotification p1) add) {
    // TODO: implement listen
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String channelName) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
