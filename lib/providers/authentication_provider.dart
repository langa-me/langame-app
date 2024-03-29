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
  Algolia algolia;

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
    _firebaseUserStream = _authenticationApi.userChanges.asBroadcastStream();
    _userStream = StreamController.broadcast();
    _firebaseUserStream.listen((data) async {
      await waitUntil(() => readyToInit);
      if (data == null || firebase.auth!.currentUser == null) {
        // TODO: should go back to login automatically

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
      if (_user == null) {
        await ref
            .snapshots()
            .where((e) => e.exists && e.data() != null)
            .timeout(Duration(seconds: 20));
      }
      final userAsMap = UserExt.fromFirebaseAsMap(data);
      // Note that we don't use lg.User otherwise would fuck up with firestore
      // rules
      await firebase.firestore!.runTransaction((t) async {
        t.set(firebase.firestore!.collection('users').doc(data.uid), userAsMap,
            SetOptions(merge: true));
        return ref;
      });

      final newUser = (await ref.get()).data();
      final change = UserChange(
          _user == null
              ? UserChangeType.NewAuthentication
              : UserChangeType.ProfileEdition,
          _user,
          newUser);
      // First auth, hack to notify only after other dependencies have constructed
      // if (_user == null) await Future.delayed(Duration(milliseconds: 1000));
      if (_user == null) {
        _onNewAuthentication(ref);
      }
      _userStream.add(change);
      _user = newUser;
      _cap.log('authentication_provider:${change.type}');
      await firebase.crashlytics?.setUserIdentifier(data.uid);
      await firebase.analytics?.setUserId(data.uid);
      notifyListeners();
    });
  }

  _onNewAuthentication(DocumentReference<lg.User> u) async {
    final packageInfo = await PackageInfo.fromPlatform();
    // Asynchronously, update devices information in db
    final dip = DeviceInfoPlugin();
    final deviceInfo = UniversalPlatform.isAndroid
        ? (await dip.androidInfo).model
        : UniversalPlatform.isIOS
            ? (await dip.iosInfo).utsname.machine
            : UniversalPlatform.isWeb
                ? (await dip.webBrowserInfo).userAgent
                : null; // TODO other platforms not supported

    _user!.devices.add(
      lg.User_Device(
        langameVersion: _getLangameVersion(packageInfo),
        deviceInfo: deviceInfo.toString(),
      ),
    );
    // dumb way to de-duplicate devices
    final ids = Set();
    _user!.devices.retainWhere((x) => ids.add(x.deviceInfo));

    await u.set(lg.User(devices: _user!.devices), SetOptions(merge: true));

    _userSubscription = u.snapshots().listen((s) {
      final change = UserChange(UserChangeType.ProfileEdition, _user, s.data());
      _userStream.add(change);
      _user = s.data();
      notifyListeners();
    });

    _cap.log('authentication_provider:updated devices');
  }

  Future<LangameResponse<void>> _loginWith(Credential c) async {
    try {
      _cap.log('authentication_provider:loginWith');
      UserCredential uc;
      if (c.oAuthCrendential != null) {
        uc = await firebase.auth!.signInWithCredential(c.oAuthCrendential!);
      } else if (c.userCredential != null) {
        uc = c.userCredential!;
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
        'lastLogin': DateTime.now(),
      });
      firebase.analytics?.logLogin();
      _cap.log('authentication_provider:loginWith');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to authentication_provider:loginWith $e $s');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> loginWithApple() async {
    try {
      var res = await _authenticationApi.loginWithApple();
      return _loginWith(res);
    } catch (e, s) {
      _cap.log('authentication_provider:failed to loginWithApple $e $s');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse<void>> loginWithGoogle() async {
    try {
      var res = await _authenticationApi.loginWithGoogle();
      return _loginWith(res);
    } catch (e, s) {
      // HACK
      if (e.toString().contains('cancel') || e.toString().contains('closed'))
        return LangameResponse.cancelled();
      _cap.log('authentication_provider:failed to loginWithGoogle $e $s');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse<void>> loginWithEmail(
      String email, String password) async {
    try {
      final res = await _authenticationApi.loginWithEmail(email, password);
      _cap.log('authentication_provider:loginWithEmail');
      return _loginWith(res);
    } catch (e, s) {
      _cap.log('authentication_provider:failed to loginWithEmail $email $e');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse<void>> logout() async {
    try {
      _cap.log('authentication_provider:purging local storage');
      var i = await SharedPreferences.getInstance();
      await i.clear();
      if (user != null) {
        await firebase.firestore!
            .collection(AppConst.firestoreUsersCollection)
            .doc(user!.uid)
            .update({
          'lastLogout': FieldValue.serverTimestamp(),
        });
      }
      await _authenticationApi.logout();
      await firebase.firestore!.terminate();
      await firebase.firestore!.clearPersistence();
      _user = null;
      _cap.log('logout');
      return LangameResponse<lg.User>(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('authentication_provider:failed to logout $e');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<List<lg.User>>> getUserTag(String tag) async {
    try {
      _cap.log('authentication_provider:getUserTag $tag',
          analyticsMessage: 'get_user_by_tag');
      if (tag.isEmpty) {
        return LangameResponse.succeed(result: []);
      }

      final objects = await algolia
          .index(AppConst.isDev ? "dev_users" : "prod_users")
          // .filters(tag)
          .query(tag)
          // .query('tag:$tag')
          .getObjects();
      _cap.log(
          'authentication_provider:getUserTag ${objects.hits.length} hits');

      return LangameResponse(LangameStatus.succeed,
          result: objects.hits
              .where((e) => e.objectID != _user!.uid)
              .map((e) => UserExt.fromObject(e.data))
              .toList());
    } catch (e, s) {
      _cap.log('authentication_provider: failed to getUserTag $tag');
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
      _cap.log('authentication_provider: getLangameUser');
      return LangameResponse<lg.User>(LangameStatus.succeed, result: r.data()!);
    } catch (e, s) {
      _cap.log('authentication_provider: failed to getLangameUser');
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

      _cap.log('authentication_provider: getLangameUsers');
      return LangameResponse<List<lg.User>>(LangameStatus.succeed,
          result: r.map((e) => e.data()!).toList());
    } catch (e, s) {
      _cap.log('authentication_provider: failed to get users');
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
      _cap.log('authentication_provider: updateTag');
      _user!.tag = tag;

      notifyListeners();
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('authentication_provider: failed to updateTag');
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
      // final Credential cred = await (user!.google
      //     ? _authenticationApi.loginWithGoogle()
      //     : user!.apple
      //         ? _authenticationApi.loginWithApple()
      //         : _authenticationApi.loginWithEmail(null, null));
      // await firebase.auth!.currentUser!
      //     .reauthenticateWithCredential(cred.oAuthCrendential!);
      await firebase.auth!.currentUser!.delete();
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
