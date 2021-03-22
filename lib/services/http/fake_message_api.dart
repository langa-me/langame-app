import 'dart:async';
import 'dart:math';

import 'package:langame/api/api.pb.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:langame/services/http/fake_authentication_api.dart';
import 'package:langame/services/http/message_api.dart';
import 'package:uuid/uuid.dart';

class FakeMessageApi extends MessageApi {
  FakeMessageApi(Function(LangameNotification) add) : super(add);
  var uuid = Uuid();
  @override
  Future send(String topic) async {
    if (Random().nextDouble() > 0.5) throw SendLangameException('FAIL');
  }

  @override
  void receive() {
    var r = Random();
    var delay = Duration(seconds: 5 + r.nextInt(10));

    Timer.periodic(delay, (timer) {
      add(_fakeNotification());
      delay = Duration(seconds: 5 + r.nextInt(10));
    });
  }

  @override
  void get() {
    add(_fakeNotification());
  }

  LangameNotification _fakeNotification() {
    var r = Random().nextDouble();
    var sender = r < 0.3
        ? getLarryPage()
        : r < 0.6
            ? getMarkZuckerberg()
            : getSteveJobs();
    return LangameNotification(
        id: uuid.v4(),
        sender: sender,
        type: LangameNotification_Type.INVITATION,
        background: r > 0.5,
        topic: hardcodedTopics.pickAny(),
        relation: r < 0.3
            ? RelationLevel.GREAT
            : r < 0.6
                ? RelationLevel.AVERAGE
                : RelationLevel.BAD);
  }

  @override
  Future<void> delete(LangameNotification n) {
    return Future.value();
  }
}
