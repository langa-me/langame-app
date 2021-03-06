import 'package:langame/protos/api.pb.dart';

abstract class AuthenticationApi {
  Future<LangameUser> loginWithGoogle();
  Future<LangameUser> loginWithFacebook();
  Future<LangameUser> loginWithApple();
}
