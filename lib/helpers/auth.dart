import 'package:firebase_auth/firebase_auth.dart';
import 'package:langame/models/user.dart';

extension userExtension on User {
  LangameUser toLangameUser() => LangameUser.fromFirebaseUser(this);
}
