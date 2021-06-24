import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
  FirebaseApi firebase;
  CrashAnalyticsProvider _cap;

  /// Authentication, relations, users ///

  /// Defines whether it's fake API or real
  final AuthenticationApi _authenticationApi;
  late Stream<User?> _firebaseUserStream;

  // ignore: close_sinks
  late StreamController<lg.User?> _userStream;

  Stream<lg.User?> get userStream {
    return _userStream.stream.asBroadcastStream();
  }

  lg.User? _user;

  lg.User? get user {
    return _user;
  }

  /// Create an authentication provider, and
  AuthenticationProvider(this.firebase, this._authenticationApi, this._cap) {
    _firebaseUserStream = _authenticationApi.userChanges;
    _userStream = StreamController.broadcast();
    _firebaseUserStream.listen((data) async {
      // data.refreshToken being null means need to re-auth basically
      if (data == null) {
        // If logged out, set logout time
        if (user != null) {
          firebase.firestore!
              .collection(AppConst.firestoreUsersCollection)
              .doc(user!.uid)
              .update({
            'lastLogout': FieldValue.serverTimestamp(),
          });
        }
        return null;
      }
      var r = await firebase.firestore!.runTransaction((t) async {
        final langameUser = UserExt.fromFirebase(data);
        final ref = firebase.firestore!
            .collection(AppConst.firestoreUsersCollection)
            .withConverter<lg.User>(
              fromFirestore: (s, _) => UserExt.fromObject(s.data()!),
              toFirestore: (s, _) => s.toMapStringDynamic(),
            )
            .doc(langameUser.uid);
        t.set(ref, langameUser, SetOptions(merge: true));
        return ref;
      });

      _user = (await r.get()).data();
      await firebase.crashlytics?.setUserIdentifier(data.uid);
      await firebase.analytics?.setUserId(data.uid);
      _userStream.add(_user);
      notifyListeners();
    });
  }

  Future<LangameResponse<void>> _loginWith(
      {OAuthCredential? oAuthCredential,
      UserCredential? userCredential}) async {
    try {
      _cap.log('authentication_provider:loginWith');
      UserCredential uc;
      if (oAuthCredential != null) {
        uc = await _authenticationApi.loginWithFirebase(oAuthCredential);
      } else if (userCredential != null) {
        uc = userCredential;
      } else {
        _cap.log(
            'should either provide oauth credentials (Google, Apple ...), or UserCredential (email)');
        return LangameResponse(LangameStatus.failed);
      }
      if (uc.user == null) throw LangameAuthException('null_user');
      // Shouldn't update profile on new user at login
      if (uc.additionalUserInfo != null && uc.additionalUserInfo!.isNewUser) {
        firebase.analytics?.logLogin();
        return LangameResponse(LangameStatus.succeed);
      }
      // TODO: Temporary hack because above if doesn't work
      if (!(await firebase.firestore!
              .collection(AppConst.firestoreUsersCollection)
              .doc(uc.user!.uid)
              .get())
          .exists) return LangameResponse(LangameStatus.succeed);

      // If it's an existing user and it has some new data from auth
      // i.e. updated social profile maybe? Or simply
      // authenticated with another social provider which has more data
      // TODO: maybe should only change photo, name when it was empty,
      // TODO: maybe the user want  different photo, name on social and langame
      var newDisplayName = _user != null &&
              _user!.displayName.isEmpty &&
              uc.user!.displayName != null &&
              uc.user!.displayName!.isNotEmpty
          ? uc.user!.displayName
          : null;
      // TODO: not implemented
      // var newPhoneNumber = _user != null && _user!.phoneNumber.isEmpty &&
      //     data.phoneNumber != null &&
      //     data.phoneNumber!.isNotEmpty ? data.phoneNumber : null;
      var newPhotoUrl = _user != null &&
              _user!.photoUrl.isEmpty &&
              uc.user!.photoURL != null &&
              uc.user!.photoURL!.isNotEmpty
          ? uc.user!.photoURL
          : null;

      var isGoogle = uc.credential!.providerId == 'google.com';
      var isApple = uc.credential!.providerId == 'apple.com';
      await _authenticationApi.updateProfile(
        displayName: newDisplayName,
        photoURL: newPhotoUrl,
        google: isGoogle,
        apple: isApple,
      );
    } catch (e, s) {
      _cap.log('failed to authentication_provider:loginWith');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    firebase.analytics?.logLogin();
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<void>> loginWithApple() async {
    try {
      var res = await _authenticationApi.loginWithApple();
      return _loginWith(oAuthCredential: res);
    } catch (e, s) {
      _cap.log('authentication_provider:failed to loginWithApple');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse<void>> loginWithGoogle() async {
    try {
      var res = await _authenticationApi.loginWithGoogle();
      return _loginWith(oAuthCredential: res);
    } catch (e, s) {
      _cap.log('authentication_provider:failed to loginWithGoogle');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse<void>> loginWithHack(String password) async {
    try {
      var res = await _authenticationApi.loginWithHack(password);
      return _loginWith(userCredential: res);
    } catch (e, s) {
      _cap.log('authentication_provider:failed to loginWithGoogle');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse<void>> logout() async {
    try {
      _cap.log('authentication_provider:purging local storage');
      var i = await SharedPreferences.getInstance();
      await i.clear();
      // TODO: permission denied somehow (firestore)
      // _crashAnalyticsProvider.log('purging local firestore');
      // await firebase.firestore!.clearPersistence();
      await _authenticationApi.logout();
      _cap.log('logout');
      return LangameResponse<lg.User>(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('authentication_provider:failed to logout');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  // TODO langame response
  Future<LangameResponse<List<lg.User>>> getLangameUsersStartingWithTag(
      String tag) async {
    try {
      _cap.log('authentication_provider:getLangameUsersStartingWithTag $tag');
      var u = await _authenticationApi.getLangameUsersStartingWithTag(
          _user!.tag, tag);
      return LangameResponse(LangameStatus.succeed, result: u);
    } catch (e, s) {
      _cap.log('failed to getLangameUsersStartingWithTag $tag');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<lg.User>> getLangameUser(String uid) async {
    try {
      var r = await _authenticationApi
          .getLangameUser(uid)
          .firstWhere((e) => e.data() != null)
          .timeout(Duration(seconds: 20));
      _cap.log('getLangameUser');
      return LangameResponse<lg.User>(LangameStatus.succeed, result: r.data()!);
    } catch (e, s) {
      _cap.log('failed to getLangameUser');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<List<lg.User>>> getLangameUsers(
      List<String> userIds) async {
    try {
      List<DocumentSnapshot<lg.User>> r = await Future.wait(userIds.map((u) =>
          _authenticationApi
              .getLangameUser(u)
              .firstWhere((e) => e.data() != null)
              .timeout(Duration(seconds: 20))));

      _cap.log('getLangameUsers');
      return LangameResponse<List<lg.User>>(LangameStatus.succeed,
          result: r.map((e) => e.data()!).toList());
    } catch (e, s) {
      _cap.log('failed to get users');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse> updateProfile(
      {String? displayName,
      String? photoURL,
      String? newEmail,
      String? tag,
      List<String>? topics}) async {
    try {
      await _authenticationApi.updateProfile(
          displayName: displayName,
          photoURL: photoURL,
          newEmail: newEmail,
          tag: tag,
          topics: topics);
      _cap.log('updateProfile');
    } catch (e, s) {
      _cap.log('failed to updateProfile');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<void>> delete() async {
    try {
      _cap.log('deleting all data');
      // [firebase_auth/requires-recent-login] This operation is sensitive
      //  and requires recent authentication. Log in again before
      //retrying this request.
      var cred = await (user!.google
          ? _authenticationApi.loginWithGoogle()
          : user!.apple
              ? _authenticationApi.loginWithApple()
              : user!.facebook
                  ? _authenticationApi.loginWithFacebook()
                  : null);
      if (cred == null)
        throw LangameException(
            'the user is authenticated without any social providers');
      await _authenticationApi.reAuthenticate(cred);
      await _authenticationApi.delete();
      _cap.log('purging local storage');
      var i = await SharedPreferences.getInstance();
      await i.clear();
      // _crashAnalyticsProvider.log('purging local firestore');
      // await firebase.firestore!.clearPersistence();
      _cap.log('logging out');
      await logout();
    } catch (e, s) {
      _cap.log('failed to delete');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }
}
