import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import '../firebase.dart';

abstract class PreferenceService {
  static const sharedPrefPrefKey = 'pref_key';
  static final lg.UserPreference defaultPreference = lg.UserPreference(
    userRecommendations: false,
    themeIndex: 0, // System
    hasDoneOnBoarding: false,
    userSearchHistory: [],
    shakeToFeedback: false,
  );
  final FirebaseApi firebase;
  PreferenceService(this.firebase);

  Stream<lg.UserPreference> streamPreference(lg.User user);
  Future<void> savePreference(String? userId, lg.UserPreference preferences);
  Future<lg.UserPreference?> tryFetchFromLocalStorage();
}
