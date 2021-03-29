import 'dart:async';
import 'dart:math';

import 'package:langame/helpers/fake.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/services/http/message_api.dart';
import 'package:uuid/uuid.dart';

import 'firebase.dart';

class FakeMessageApi extends MessageApi {
  FakeMessageApi(FirebaseApi firebase) : super(firebase);
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
  Future<List<LangameNotification>?> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  void cancel() {
    // TODO: implement cancel
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<String?> send(String recipient, String topic) async {
    return uuid.v4();
  }

  @override
  Future listen(Function(LangameNotification p1) add) async {
    var r = Random();
    var delay = Duration(seconds: 5 + r.nextInt(10));

    Timer.periodic(delay, (timer) {
      add(_fakeNotification());
      delay = Duration(seconds: 5 + r.nextInt(10));
    });
  }

  LangameNotification _fakeNotification() {
    var r = Random().nextDouble();
    var sender = faang.pickAny();

    return LangameNotification(
      uuid.v4(),
      sender!.uid!,
    );
  }
}
