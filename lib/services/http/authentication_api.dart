import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:tuple/tuple.dart';

import 'firebase.dart';

class Credential {
  OAuthCredential? oAuthCrendential;
  UserCredential? userCredential;
  /// Constructor
  Credential(this.oAuthCrendential, this.userCredential);
}
abstract class AuthenticationApi {
  final FirebaseApi firebase;

  Stream<User?> get userChanges;

  AuthenticationApi(
    this.firebase,
  );

  /// Login with Google, return Google account and credentials
  Future<Credential> loginWithGoogle();

  /// Login with Apple, return Apple account and credentials
  Future<Credential> loginWithApple();

  Future<Credential> loginWithEmail(String? email, String? password);

  /// Login with firebase with previously acquired credential
  Future<void> logout();


  /// Get [LangameUser] from Firestore using Firebase uid
  Stream<DocumentSnapshot<lg.User>> getLangameUser(String uid);

  Future<List<lg.User>> getUserRecommendations(lg.User user);

  Future<int?> getInteraction(String uid, String otherUid);

  Future<List<Tuple2<String, int>>> getInteractions(String uid,
      {int limit = 5});

}
