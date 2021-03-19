import 'dart:math';

import 'package:langame/api/api.pb.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/services/http/authentication_api.dart';

/// FakeAuthenticationApi returns fake auth data with 50% chance of returning a null value (fail)
class FakeAuthenticationApi implements AuthenticationApi {
  final steve = LangameUser(
      uid: 's',
      displayName: 'SteveJobs',
      photoUrl:
          'https://www.journaldugeek.com/content/uploads/2019/07/stevejobs.jpg');
  final mark = LangameUser(
      uid: 'm',
      displayName: 'MarkZuckerberg',
      photoUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg/1200px-Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg');
  final larry = LangameUser(
      uid: 'l',
      displayName: 'LarryPage',
      photoUrl:
          'https://thumbor.forbes.com/thumbor/fit-in/416x416/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5c76bcaaa7ea43100043c836%2F0x0.jpg%3Fbackground%3D000000%26cropX1%3D227%26cropX2%3D2022%26cropY1%3D22%26cropY2%3D1817');
  late List<LangameUser> users;
  FakeAuthenticationApi() {
    this.users = [steve, mark, larry];
  }

  @override
  Future<LangameUser?> loginWithApple() {
    if (Random().nextDouble() > 0.5) throw GetUserException('FAIL');
    return Future<LangameUser?>.value(steve);
  }

  @override
  Future<LangameUser?> loginWithFacebook() {
    if (Random().nextDouble() > 0.5) throw GetUserException('FAIL');
    return Future<LangameUser?>.value(mark);
  }

  @override
  Future<LangameUser?> loginWithGoogle() {
    if (Random().nextDouble() > 0.5) throw GetUserException('FAIL');
    return Future<LangameUser?>.value(larry);
  }

  @override
  Future<List<Friend>> getFriends(String uid) {
    // Friend with everyone!
    return Future.value(this
        .users
        .where((element) => element.uid != uid)
        .map((e) => Friend(
            friend: e,
            relation: Relation(
                level: Relation_Level
                    .values[Random().nextInt(Relation_Level.values.length)])))
        .toList());
  }
}
