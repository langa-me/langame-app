import 'dart:math';

import 'package:langame/api/api.pb.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/services/http/authentication_api.dart';

LangameUser getSteveJobs() => LangameUser(
    uid: 's',
    displayName: 'Steve Jobs',
    photoUrl:
        'https://www.journaldugeek.com/content/uploads/2019/07/stevejobs.jpg');
LangameUser getMarkZuckerberg() => LangameUser(
    uid: 'm',
    displayName: 'Mark Zuckerberg',
    photoUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg/1200px-Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg');
LangameUser getLarryPage() => LangameUser(
    uid: 'l',
    displayName: 'Larry Page',
    photoUrl:
        'https://thumbor.forbes.com/thumbor/fit-in/416x416/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5c76bcaaa7ea43100043c836%2F0x0.jpg%3Fbackground%3D000000%26cropX1%3D227%26cropX2%3D2022%26cropY1%3D22%26cropY2%3D1817');

/// FakeAuthenticationApi returns fake auth data with 50% chance of returning a null value (fail)
class FakeAuthenticationApi implements AuthenticationApi {
  final steve = getSteveJobs();
  final mark = getMarkZuckerberg();
  final larry = getLarryPage();
  List<LangameUser> users = [
    getSteveJobs(),
    getMarkZuckerberg(),
    getLarryPage()
  ];

  @override
  Future<LangameUser?> loginWithApple() {
    if (Random().nextDouble() > 0.9) throw GetUserException('GetUserException');
    return Future<LangameUser?>.value(steve);
  }

  @override
  Future<LangameUser?> loginWithFacebook() {
    if (Random().nextDouble() > 0.9) throw GetUserException('GetUserException');
    return Future<LangameUser?>.value(mark);
  }

  @override
  Future<LangameUser?> loginWithGoogle() {
    if (Random().nextDouble() > 0.9) throw GetUserException('GetUserException');
    return Future<LangameUser?>.value(larry);
  }

  @override
  Future<List<Relation>> getFriends(String uid) {
    if (Random().nextDouble() > 0.9)
      throw GetUserFriendsException('GetUserFriendsException');
    return Future.value(<Relation>[
      Relation(
          firstUser: getSteveJobs(),
          secondUser: getMarkZuckerberg(),
          level: RelationLevel.GREAT),
      Relation(
          firstUser: getSteveJobs(),
          secondUser: getLarryPage(),
          level: RelationLevel.AVERAGE),
      Relation(
          firstUser: getLarryPage(),
          secondUser: getMarkZuckerberg(),
          level: RelationLevel.BAD),
    ]);
  }
}
