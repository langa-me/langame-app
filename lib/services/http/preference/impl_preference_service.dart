import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preference_service.dart';

class ImplPreferenceService extends PreferenceService {
  ImplPreferenceService(FirebaseApi firebase) : super(firebase);

  // ignore: close_sinks
  StreamController<lg.UserPreference>? _streamPreference;
  // ignore: cancel_subscriptions
  StreamSubscription<DocumentSnapshot>? _streamSubscription;

  @override
  Future<void> savePreference(
      String? userId, lg.UserPreference preferences) async {
    if (!preferences.hasUserId() && userId != null) {
      preferences.userId = userId;
    }
    String jsonString = preferences.writeToJson();
    final prefs = await SharedPreferences.getInstance();
    final result =
        await prefs.setString(PreferenceService.sharedPrefPrefKey, jsonString);
    if (!result) throw LangamePreferencesException('failed_local_save');
    if (userId == null) return; // Ignore
    return firebase.firestore!
        .collection(AppConst.firestorePreferencesCollection)
        .doc(userId)
        .set(preferences.toProto3Json() as Map<String, dynamic>,
            SetOptions(merge: true));
  }

  @override
  Stream<lg.UserPreference> streamPreference(User user) {
    _streamSubscription?.cancel();
    _streamPreference = StreamController<lg.UserPreference>();
    _streamSubscription = firebase.firestore!
        .collection(AppConst.firestorePreferencesCollection)
        .doc(user.uid)
        .snapshots()
        .listen(
      (e) {
        _streamPreference!
            .add(e.data() == null || e.data()!['hasDoneOnBoarding'] == null
                ? PreferenceService.defaultPreference
                : lg.UserPreference(
                    // TODO: might do a helper
                    userId: user.uid,
                    unknownPeopleRecommendations:
                        e.data()!['unknownPeopleRecommendations'],
                    themeIndex: e.data()!['themeIndex'],
                    hasDoneOnBoarding: e.data()!['hasDoneOnBoarding'],
                    searchHistory: e.data()!['searchHistory'] != null
                        ? (e.data()!['searchHistory'] as Iterable<dynamic>)
                            .map((e) => e.toString())
                        : [],
                    shakeToFeedback: e.data()!['shakeToFeedback'],
                  ));
      },
      cancelOnError: false,
    ); // Can happen when listening to in-existent document (yet)

    return _streamPreference!.stream;
  }

  @override
  Future<lg.UserPreference?> tryFetchFromLocalStorage() async {
    var i = await SharedPreferences.getInstance();
    final data = i.getString(PreferenceService.sharedPrefPrefKey) ?? '';
    if (data != '') {
      return lg.UserPreference.fromJson(data);
    }
  }
}
