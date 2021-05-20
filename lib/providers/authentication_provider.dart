import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
  FirebaseApi firebase;
  CrashAnalyticsProvider _crashAnalyticsProvider;

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
  AuthenticationProvider(
      this.firebase, this._authenticationApi, this._crashAnalyticsProvider) {
    _firebaseUserStream = _authenticationApi.userChanges;
    _userStream = StreamController.broadcast();
    _firebaseUserStream.listen((data) async {
      _crashAnalyticsProvider
          .log('_firebaseUserStream.listen ${data.toString()}');
      // data.refreshToken being null means need to re-auth basically
      if (data == null) return null;
      try {
        await firebase.crashlytics?.setUserIdentifier(data.uid);
        await firebase.analytics?.setUserId(data.uid);
        _user = await _authenticationApi.getLangameUser(data.uid);
      } catch (e) {
        _crashAnalyticsProvider.log('failed to get user uid: ${data.uid}, $e');
      }
      try {
        if (_user == null) {
          _user = await _authenticationApi.addLangameUser(data);
        }
      } catch (e, s) {
        _crashAnalyticsProvider.log('failed to add user uid: ${data.uid}');
        _crashAnalyticsProvider.recordError(e, s);
        // _authenticationApi.logout();
      }
      _userStream.add(_user);
      notifyListeners();
    });
  }

  Future<LangameResponse> _loginWith(OAuthCredential credential) async {
    try {
      _crashAnalyticsProvider.log('_crashAnalyticsProvider.loginWith');
      var uc = await _authenticationApi.loginWithFirebase(credential);
      if (uc.user == null) throw LangameAuthException('null_user');
      // Shouldn't update profile on new user at login
      if (uc.additionalUserInfo != null && uc.additionalUserInfo!.isNewUser) {
        firebase.analytics?.logLogin();
        return LangameResponse(LangameStatus.succeed);
      }
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

      var isGoogle =
          uc.user!.providerData.any((e) => e.providerId == 'google.com');
      var isApple =
          uc.user!.providerData.any((e) => e.providerId == 'apple.com');
      _crashAnalyticsProvider.log(
          'updateProfile newDisplayName $newDisplayName newPhotoUrl $newPhotoUrl isGoogle $isGoogle isApple $isApple');
      await _authenticationApi.updateProfile(
        displayName: newDisplayName,
        photoURL: newPhotoUrl,
        google: isGoogle,
        apple: isApple,
      );
    } catch (e, s) {
      _crashAnalyticsProvider
          .log('failed to _crashAnalyticsProvider.loginWith');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    firebase.analytics?.logLogin();
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse> loginWithApple() async {
    try {
      var res = await _authenticationApi.loginWithApple();
      return _loginWith(res);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to loginWithApple');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse> loginWithFacebook() async {
    try {
      var res = await _authenticationApi.loginWithFacebook();
      return _loginWith(res);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to loginWithFacebook');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse> loginWithGoogle() async {
    try {
      var res = await _authenticationApi.loginWithGoogle();
      return _loginWith(res);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to loginWithGoogle');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse> logout() async {
    try {
      await _authenticationApi.logout();
      _crashAnalyticsProvider.log('logout');
      return LangameResponse<lg.User>(LangameStatus.succeed);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to logout');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  // TODO langame response
  Future<List<lg.User>> getLangameUsersStartingWithTag(String tag) async {
    _crashAnalyticsProvider.log('getLangameUsersStartingWithTag $tag');
    return await _authenticationApi.getLangameUsersStartingWithTag(
        _user!.tag, tag);
  }

  Future<LangameResponse<lg.User>> getLangameUser(String uid) async {
    try {
      var r = await _authenticationApi.getLangameUser(uid);
      _crashAnalyticsProvider.log('getLangameUser $uid');
      return LangameResponse<lg.User>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to getLangameUser $uid');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<List<lg.User>>> getLangameUsers(
      List<String> userIds) async {
    try {
      List<lg.User> r = [];
      for (var i = 0; i < userIds.length; i++) {
        var user = await _authenticationApi.getLangameUser(userIds[i]);
        if (user != null) r.add(user);
      }
      _crashAnalyticsProvider.log('getLangameUsers ${userIds.join(",")}');
      return LangameResponse<List<lg.User>>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to get users ${userIds.join(",")}');
      _crashAnalyticsProvider.recordError(e, s);
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
      _crashAnalyticsProvider.log('updateProfile');
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to updateProfile');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse> delete() async {
    try {
      _crashAnalyticsProvider.log('deleting all data');
      await _authenticationApi.delete();
      _crashAnalyticsProvider.log('logging out');
      await logout();
      _crashAnalyticsProvider.log('purging local storage');
      var i = await SharedPreferences.getInstance();
      await i.clear();
      _crashAnalyticsProvider.log('purging local firestore');
      await firebase.firestore!.clearPersistence();
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to delete');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }
}
