import 'package:langame/api/api.pb.dart';

abstract class AuthenticationApi {
  Future<LangameUser?> loginWithGoogle();
  Future<LangameUser?> loginWithFacebook();
  Future<LangameUser?> loginWithApple();
  Future<List<Friend>> getFriends(String uid);
}
