import 'dart:async';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/future.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

enum UserChangeType {
  NewAuthentication,
  Disconnection,
  ProfileEdition,
}

class UserChange {
  UserChangeType type;
  lg.User? before;
  lg.User? after;

  UserChange(this.type, this.before, this.after);
}

class AuthenticationProvider extends ChangeNotifier {
  FirebaseApi firebase;
  CrashAnalyticsProvider _cap;
  Algolia? algolia;

  /// Authentication, relations, users ///

  /// Defines whether it's fake API or real
  final AuthenticationApi _authenticationApi;
  late Stream<User?> _firebaseUserStream;

  StreamSubscription<DocumentSnapshot<lg.User>>? _userSubscription;
  // ignore: close_sinks
  late StreamController<UserChange> _userStream;

  Stream<UserChange> get userStream {
    return _userStream.stream.asBroadcastStream();
  }

  lg.User? _user;

  lg.User? get user {
    return _user;
  }

  bool readyToInit = false;

  /// Create an authentication provider, and
  AuthenticationProvider(
      this.firebase, this._authenticationApi, this._cap, this.algolia) {
    _firebaseUserStream = _authenticationApi.userChanges;
    _userStream = StreamController.broadcast();
    _firebaseUserStream.listen((data) async {
      await waitUntil(() => readyToInit);
      if (data == null || firebase.auth!.currentUser == null) {
        // TODO: should go back to login automatically
        // If logged out, set logout time
        // TODO: can't update firestore when disconnected
        // if (user != null) {
        //   firebase.firestore!
        //       .collection(AppConst.firestoreUsersCollection)
        //       .doc(user!.uid)
        //       .update({
        //     'lastLogout': FieldValue.serverTimestamp(),
        //   });
        //   _user = null;
        // }
        final change = UserChange(UserChangeType.Disconnection, _user, null);
        _user = null;
        _userStream.add(change);
        _cap.log('authentication_provider:${change.type}');
        _userSubscription?.cancel();
        notifyListeners();
        return null;
      }

      final ref = firebase.firestore!
          .collection(AppConst.firestoreUsersCollection)
          .withConverter<lg.User>(
            fromFirestore: (s, _) => UserExt.fromObject(s.data()!),
            toFirestore: (s, _) => s.toMapStringDynamic(),
          )
          .doc(data.uid);
      // Wait until back-end created used
      await ref
          .snapshots()
          .firstWhere((e) => e.exists)
          .timeout(Duration(seconds: 20));
      var r = await firebase.firestore!.runTransaction((t) async {
        t.set(ref, UserExt.fromFirebase(data), SetOptions(merge: true));
        return ref;
      });

      final newUser = (await r.get()).data();
      final change = UserChange(
          _user == null
              ? UserChangeType.NewAuthentication
              : UserChangeType.ProfileEdition,
          _user,
          newUser);
      // First auth, hack to notify only after other dependencies have constructed
      // if (_user == null) await Future.delayed(Duration(milliseconds: 1000));
      if (_user == null) {
        _onNewAuthentication();
      }
      _userStream.add(change);
      _user = newUser;
      _cap.log('authentication_provider:${change.type}');
      await firebase.crashlytics?.setUserIdentifier(data.uid);
      await firebase.analytics?.setUserId(data.uid);
      notifyListeners();
    });
  }

  _onNewAuthentication() async {
    final packageInfo = await PackageInfo.fromPlatform();
    // Asynchronously, update devices information in db

    final deviceInfo = UniversalPlatform.isAndroid
        ? (await DeviceInfoPlugin().androidInfo).model
        : UniversalPlatform.isIOS
            ? (await DeviceInfoPlugin().iosInfo).utsname.machine
            : null; // TODO other platforms not supported
    bool newDevice = true;
    for (var i = 0; i < _user!.devices.length; i++) {
      if (_user!.devices[i].deviceInfo == deviceInfo) {
        _user!.devices[i].langameVersion = _getLangameVersion(packageInfo);
        newDevice = false;
      }
    }
    if (newDevice) {
      _user!.devices.add(
        lg.User_Device(
          langameVersion: _getLangameVersion(packageInfo),
          deviceInfo: deviceInfo.toString(),
        ),
      );
    }
    final ref = firebase.firestore!
        .collection(AppConst.firestoreUsersCollection)
        .doc(_user!.uid)
        .withConverter<lg.User>(
          fromFirestore: (s, _) => UserExt.fromObject(s.data()!),
          toFirestore: (s, _) => s.toMapStringDynamic(),
        );
    await ref.set(lg.User(devices: _user!.devices), SetOptions(merge: true));

    _userSubscription = ref.snapshots().listen((s) {
      final change = UserChange(UserChangeType.ProfileEdition, _user, s.data());
      _userStream.add(change);
      _user = s.data();
      notifyListeners();
    });

    _cap.log('authentication_provider:updated devices');
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
      firebase.firestore!
          .collection(AppConst.firestoreUsersCollection)
          .doc(uc.user!.uid)
          .update({
        'lastSignInTime': DateTime.now(),
      });
      firebase.analytics?.logLogin();
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to authentication_provider:loginWith');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
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
      // HACK
      if (e is LangameGoogleSignInException && e.cause.contains('cancel'))
        return LangameResponse(LangameStatus.cancelled);
      _cap.log('authentication_provider:failed to loginWithGoogle');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse<void>> loginWithHack(String password, {String email = 'hack@langa.me'}) async {
    try {
      final res = await firebase.auth!
        .signInWithEmailAndPassword(email: email, password: password);
      return _loginWith(userCredential: res);
    } catch (e, s) {
      _cap.log('authentication_provider:failed to loginWithHack');
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
      _user = null;
      _cap.log('logout');
      return LangameResponse<lg.User>(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('authentication_provider:failed to logout');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<List<lg.User>>> getUserTag(String tag) async {
    try {
      _cap.log('authentication_provider:getUserTag $tag',
          analyticsMessage: 'get_user_by_tag');

      if (algolia == null)
        return LangameResponse(LangameStatus.succeed, result: []);
      final objects = await algolia!
          .index(AppConst.isDev ? "dev_users" : "prod_users")
          .query(tag)
          .getObjects();
      _cap.log('authentication_provider:getUser ${objects.hits.length} hits');

      return LangameResponse(LangameStatus.succeed,
          result: objects.hits
              .where((e) => e.objectID != _user!.uid)
              .map((e) => UserExt.fromObject(e.data))
              .toList());
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

  Future<LangameResponse> updateTag(String tag) async {
    try {
      var sameTag = await getUserTag(tag);
      if (sameTag.result == null) {
        return LangameResponse.failed();
      }
      if (sameTag.result!.map((e) => e.tag).contains(tag)) {
        return LangameResponse(LangameStatus.failed,
            error: 'tag_already_exist');
      }
      await firebase.firestore!
          .collection('users')
          .doc(user!.uid)
          .update({'tag': tag});
      _cap.log('updateTag');
      _user!.tag = tag;

      notifyListeners();
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to updateTag');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse> removePhoto() async {
    try {
      await firebase.firestore!
          .collection('users')
          .doc(user!.uid)
          .update({'photoUrl': null});
      await firebase.auth!.currentUser!.updatePhotoURL(null);
      _cap.log('removePhoto');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to removePhoto');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
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

  String _getLangameVersion(PackageInfo packageInfo) =>
      '${packageInfo.version.replaceAll('-dev', '')}+${packageInfo.buildNumber}';

  Future<LangameResponse<lg.FunctionResponse_VersionCheck_UpdateRequired>>
      checkVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      final callable = firebase.functions!.httpsCallable(
        'versionCheck',
        options: HttpsCallableOptions(
          timeout: Duration(seconds: 20),
        ),
      );
      final raw = await retry(
          () async => await callable.call(<String, dynamic>{
                'version': _getLangameVersion(packageInfo),
              }),
          maxAttempts: 3, onRetry: (e) async {
        _cap.log('authentication_provider:failed to checkVersion');
        return _cap.recordError(e, null);
      });
      _cap.log('authentication_provider:checkVersion response ${raw.data}');

      return LangameResponse(LangameStatus.succeed,
          result: lg.FunctionResponse_VersionCheck_UpdateRequired.values[
              (raw.data as Map<String, dynamic>)['versionCheck']['update']
                  as int]);
    } catch (e, s) {
      _cap.log('authentication_provider:failed to checkVersion');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
