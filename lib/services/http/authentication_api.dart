import 'package:langame/api/api.pb.dart';

abstract class AuthenticationApi {
  Future<LangameUser?> loginWithGoogle();
  Future<LangameUser?> loginWithFacebook();
  Future<LangameUser?> loginWithApple();
  Future<List<Relation>> getFriends(String uid);
}
