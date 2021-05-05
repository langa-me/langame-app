import 'package:firebase_auth/firebase_auth.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import '../firebase.dart';

abstract class PreferenceService {
  static const sharedPrefPrefKey = 'pref_key';
  static final lg.UserPreference defaultPreference = lg.UserPreference(
    unknownPeopleRecommendations: false,
    themeIndex: 0, // System
    hasDoneOnBoarding: false,
    searchHistory: [],
    shakeToFeedback: false,
  );
  final FirebaseApi firebase;
  PreferenceService(this.firebase);

  Stream<lg.UserPreference> streamPreference(User user);
  Future<void> savePreference(String? userId, lg.UserPreference preferences);
  Future<lg.UserPreference?> tryFetchFromLocalStorage();
}
