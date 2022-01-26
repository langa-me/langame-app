import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import '../firebase.dart';

abstract class PreferenceService {
  static const sharedPrefPrefKey = 'pref_key';
  static final lg.UserPreference defaultPreference = lg.UserPreference(
    userRecommendations: true,
    themeIndex: 0, // System
    hasDoneOnBoarding: false,
    userSearchHistory: [],
    previewMode: false,
    notification: lg.UserPreference_Notification(
      invite: lg.UserPreference_Notification_Invite(email: true, push: true),
      message: lg.UserPreference_Notification_Message(email: true, push: true),
      newVersion: lg.UserPreference_Notification_NewVersion(email: true, push: true),
    ),
    goals: lg.UserPreference_Goals(
      compoundRelationships: true,
      growRelationships: true,
      learn: true,
    ),
  );
  final FirebaseApi firebase;
  PreferenceService(this.firebase);

  Stream<lg.UserPreference> streamPreference(lg.User user);
  Future<void> savePreference(String? userId, lg.UserPreference preferences);
  Future<lg.UserPreference?> tryFetchFromLocalStorage();
}
