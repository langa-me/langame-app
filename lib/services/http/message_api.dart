import 'dart:async';

import 'package:langame/api/api.pb.dart';

abstract class MessageApi {
  MessageApi(this.add) {
    receive();
    get();
  }
  Function(LangameNotification) add;
  Future send(String topic);
  void receive();
  void get();
  Future<void> delete(LangameNotification n);
}
