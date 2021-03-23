import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/user.dart';
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

List<LangameUser> faang = [getSteveJobs(), getMarkZuckerberg(), getLarryPage()];

/// FakeAuthenticationApi returns fake auth data with 50% chance of returning a null value (fail)
class FakeAuthenticationApi implements AuthenticationApi {
  final steve = getSteveJobs();
  final mark = getMarkZuckerberg();
  final larry = getLarryPage();

  @override
  Future<OAuthCredential> loginWithApple() async {
    if (Random().nextDouble() > 0.9) throw GetUserException();
    return Future<OAuthCredential>.value(
        OAuthCredential(providerId: '', signInMethod: ''));
  }

  @override
  Future<OAuthCredential> loginWithFacebook() async {
    if (Random().nextDouble() > 0.9) throw GetUserException();
    return Future<OAuthCredential>.value(
        OAuthCredential(providerId: '', signInMethod: ''));
  }

  @override
  Future<OAuthCredential> loginWithGoogle() async {
    if (Random().nextDouble() > 0.9) throw GetUserException();
    return Future<OAuthCredential>.value(
        OAuthCredential(providerId: '', signInMethod: ''));
  }

  @override
  Future<LangameUserRelations> getRelations(LangameUser user) async {
    if (Random().nextDouble() > 0.9)
      throw GetUserFriendsException('GetUserFriendsException');
    return LangameUserRelations(steve, <Relation>[
      Relation(getMarkZuckerberg(), level: RelationLevel.GREAT),
      Relation(getLarryPage(), level: RelationLevel.AVERAGE),
      Relation(getMarkZuckerberg(), level: RelationLevel.BAD),
    ]);
  }

  @override
  Future<Stream<User?>> loginWithFirebase(OAuthCredential credential) async {
    Stream<User?> s = Stream.empty();

    return s;
  }

  @override
  Future<LangameUser> addLangameUser(User user) async {
    return LangameUser.fromFirebaseUser(user);
  }

  @override
  Future<LangameUser?> getLangameUser(String uid) async {
    return faang.pickAny();
  }
}
