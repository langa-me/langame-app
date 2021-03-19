import 'dart:convert';
import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langame/api/api.pb.dart';
import 'package:langame/models/errors.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'authentication_api.dart';

// TODO: ABSOLUTELY TEST
class ImplAuthenticationApi implements AuthenticationApi {
  Future<LangameUser> getUser(String uid, {double timeout = 5}) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getUser');

    const errorCause = 'could not get user';
    final run = () async {
      HttpsCallableResult? results;
      try {
        results = await callable.call(<String, dynamic>{
          'uid': uid,
        });
        print(results.data);
        print(results.data['result']['uid'] == null);
        if (results.data['statusCode'] != 200 ||
            results.data['result']['uid'] == null) return null;
        return Map<String, dynamic>.from(results.data['result']);
      } on FirebaseFunctionsException catch (e) {
        print(e);

        throw GetUserException('$errorCause, err: ${e.message}');
      } catch (e) {
        print(e);

        throw GetUserException('$errorCause, err: ${e.toString()}');
      }
    };
    print('yolo');
    const delay = const Duration(milliseconds: 200);
    const maxAttempts = 5;
    var attempts = 0;
    Map<String, dynamic>? resultsAsMap = await run();
    while (resultsAsMap == null && attempts < maxAttempts) {
      resultsAsMap = await run();
      attempts++;
      print('attempt n°$attempts/$maxAttempts');
      await Future.delayed(delay);
    }
    if (resultsAsMap == null) {
      throw GetUserException(errorCause);
    }
    return LangameUser(
      uid: resultsAsMap['uid'],
      email: resultsAsMap['email'],
      displayName: resultsAsMap['displayName'],
      emailVerified: resultsAsMap['emailVerified'],
      phoneNumber: resultsAsMap['phoneNumber'],
      photoUrl: resultsAsMap['photoUrl'],
    );
  }

  @override
  Future<LangameUser?> loginWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    throw UnimplementedError('nop');
  }

  @override
  Future<LangameUser?> loginWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken? result = await FacebookAuth.instance.login();
    if (result != null) {
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.token!);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      final data = await FacebookAuth.instance.getUserData();
      // final users = FirebaseFirestore.instance.collection('users');
      // final firestoreUser = await users.doc(data['email']).get();
      // TODO: call cloud function, get langame user return
      print(data);
      return null;
      // if (firestoreUser.exists) {
      //   // TODO: not really beautiful (string -> map -> string -> object)
      //   return LangameUser.fromJson(jsonEncode(firestoreUser.data()));
      // }
      // // https://developers.facebook.com/docs/permissions/reference
      // final newUser = LangameUser(
      //     username: data['username'],
      //     firstName: data['first_name'],
      //     lastName: data['last_name'],
      //     email: data['email']);
      // await users.add(newUser.writeToJsonMap());
      // return newUser;
    }
    return null;
  }

  @override
  Future<LangameUser?> loginWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // If Google Auth cancelled
    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential u =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (u.user == null) return null;

    return getUser(u.user!.uid);
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String _generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<List<Friend>> getFriends(String uid) {
    // TODO: implement getFriends
    throw UnimplementedError();
  }
}
