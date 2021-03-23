import 'dart:async';

import 'package:langame/models/notification.dart';
import 'package:langame/services/http/message_api.dart';

class ImplMessageApi extends MessageApi {
  ImplMessageApi(Function(LangameNotification) add) : super(add);

  @override
  Future send(String topic) async {
    throw UnimplementedError();
  }

  @override
  void receive() {
    throw UnimplementedError();
    // // https://firebase.flutter.dev/docs/messaging/usage#handling-messages
    // Future<void> _firebaseMessagingBackgroundHandler(
    //     RemoteMessage message) async {
    //   print("background message: ${message.toString()}");
    //   // TODO: get user from message.senderId
    //   add(LangameNotification(
    //       type: LangameNotification_Type.INVITATION, background: false));
    // }
    //
    // Future<void> _firebaseMessagingForegroundHandler(
    //     RemoteMessage message) async {
    //   print('foreground message: ${message.toString()}');
    //   add(LangameNotification(
    //       type: LangameNotification_Type.INVITATION, background: true));
    // }
    //
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
  }

  @override
  void get() {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(LangameNotification n) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
