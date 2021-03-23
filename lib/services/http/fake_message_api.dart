import 'dart:async';
import 'dart:math';

import 'package:langame/helpers/random.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/models/user.dart';
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
    var sender = faang.pickAny();

    return LangameNotification(
      uuid.v4(),
      Relation(sender!,
          level: <RelationLevel>[
            RelationLevel.GREAT,
            RelationLevel.AVERAGE,
            RelationLevel.BAD
          ].pickAny()!),
      hardcodedTopics.pickAny()!,
      type: LangameNotificationType.INVITATION,
      background: r > 0.5,
    );
  }

  @override
  Future<void> delete(LangameNotification n) {
    return Future.value();
  }
}
