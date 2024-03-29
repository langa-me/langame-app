import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/preference/impl_preference_service.dart';
import 'package:langame/services/http/preference/preference_service.dart';

import 'crash_analytics_provider.dart';

class PreferenceProvider extends ChangeNotifier {
  PreferenceProvider(this.firebase, this._cap, this._ap) {
    this._api = ImplPreferenceService(this.firebase);
    _preferenceStream = StreamController.broadcast();

    _ap.userStream.listen((e) {
      if (e.type == UserChangeType.NewAuthentication) {
        _stream = _api.streamPreference(e.after!);
        _streamSubscription = _stream!.listen((p) {
          _cap.log('preference_provider: streamPreference');
          _preference = p;
          _preferenceStream.add(p);
          notifyListeners();
        });
      } else if (e.type == UserChangeType.Disconnection) {
        _streamSubscription?.cancel();
        _stream?.drain(); // TODO: necessary?
        _stream = null;
        _streamSubscription = null;
        _preference = PreferenceService.defaultPreference;
        notifyListeners();
      }
    });
  }

  static const _historyLength = 5;

  FirebaseApi firebase;
  CrashAnalyticsProvider _cap;
  AuthenticationProvider _ap;

  late PreferenceService _api;

  Stream<lg.UserPreference>? _stream;
  // ignore: cancel_subscriptions
  StreamSubscription<lg.UserPreference>? _streamSubscription;
  // ignore: close_sinks
  late StreamController<lg.UserPreference> _preferenceStream;

  Stream<lg.UserPreference> get preferenceStream {
    return _preferenceStream.stream.asBroadcastStream();
  }

  lg.UserPreference _preference = PreferenceService.defaultPreference;
  lg.UserPreference get preference => _preference;

  Future<LangameResponse<void>> save() async {
    try {
      if (_ap.user == null) return LangameResponse(LangameStatus.succeed);
      await _api.savePreference(_ap.user!.uid, _preference);
      firebase.analytics?.logEvent(name: 'save_preference', parameters: {
        'hasDoneOnBoarding': preference.hasDoneOnBoarding,
        'userRecommendations': preference.userRecommendations,
        'themeIndex': preference.themeIndex,
      });
      _cap.log('preference_provider: save preference');
    } catch (e, s) {
      _cap.log('preference_provider: failed to save');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse.failed(error: e);
    }
    return LangameResponse.succeed();
  }

  addFavoriteTopic(String topic) {
    if (_preference.favoriteTopics.contains(topic)) return;
    _cap.sendClickTopic(topic);
    _preference.favoriteTopics.add(topic);
    notifyListeners();
  }

  removeFavoriteTopic(String topic) {
    // Removing can still be interesting event interaction.
    _cap.sendClickTopic(topic);
    _preference.favoriteTopics.remove(topic);
    notifyListeners();
  }

  void setTheme(ThemeMode t) {
    _preference.themeIndex = t.index;
    notifyListeners();
  }
  void setRecommendations(bool v) {
    _preference.userRecommendations = v;
    notifyListeners();
  }

  void refresh() => notifyListeners();

  List<String> _filteredUserSearchHistory = [];
  List<String> get filteredUserSearchHistory => _filteredUserSearchHistory;
  set filteredUserSearchHistory(List<String> v) {
    _filteredUserSearchHistory = v;
    notifyListeners();
  }

  String? _selectedTag;
  String? get selectedTag => _selectedTag;
  set selectedTag(String? v) {
    _selectedTag = v;
    notifyListeners();
  }

  lg.User? _selectedUser;
  lg.User? get selectedUser => _selectedUser;
  set selectedUser(lg.User? v) {
    if (v != null) _cap.sendUserInteraction(v.uid);
    _selectedUser = v;
    notifyListeners();
  }

  void addUserSearchHistory(String tag) {
    _preference.userSearchHistory.add(tag);
    if (_preference.userSearchHistory.length > _historyLength) {
      // remove all oldest
      _preference.userSearchHistory.removeRange(0,
          _preference.userSearchHistory.length - _historyLength);
    }
    _cap.log('preference_provider: adduserSearchHistory');

    notifyListeners();
    firebase.analytics
        ?.logEvent(name: 'add_user_search_history', parameters: {'tag': tag});
  }

  void placeFirstUserSearchHistory(String tag) {
    _cap.log('preference_provider: placeFirstuserSearchHistory');

    _preference.userSearchHistory.removeWhere((e) => e == tag);
    _preference.userSearchHistory.add(tag);
  }

  void deleteUserSearchHistory(String tag) {
    _cap.log('preference_provider: deleteuserSearchHistory');

    _preference.userSearchHistory.removeWhere((e) => e == tag);
    _filteredUserSearchHistory.removeWhere((e) => e == tag);
    notifyListeners();
    firebase.analytics?.logEvent(
        name: 'delete_user_search_history', parameters: {'tag': tag});
  }

  void resetFilteredSearchTagHistory() {
    _cap.log('preference_provider: resetFilteredSearchTagHistory');

    _filteredUserSearchHistory = _preference.userSearchHistory;
    notifyListeners();
  }
}
