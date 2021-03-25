import 'dart:async';

import 'package:langame/models/notification.dart';

abstract class MessageApi {
  MessageApi(this.add) {
    receive();
    get();
  }
  Function(LangameNotification) add;
  Future send(String topic);
  void receive();
  void stopReceiving();
  void get();
  Future<void> delete(LangameNotification n);
}
