import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/preference/impl_preference_service.dart';
import 'package:langame/services/http/preference/preference_service.dart';

import 'crash_analytics_provider.dart';

class PreferenceProvider extends ChangeNotifier {
  static const _historyLength = 5;

  FirebaseApi firebase;
  CrashAnalyticsProvider _crashAnalyticsProvider;
  late PreferenceService _api;

  Stream<UserPreference>? _stream;
  // ignore: cancel_subscriptions
  StreamSubscription<UserPreference>? _streamSubscription;
  UserPreference _preference = PreferenceService.defaultPreference;
  UserPreference get preference => _preference;
  setTheme(ThemeMode t) {
    _preference.themeIndex = t.index;
    notifyListeners();
  }

  setShakeToFeedback(bool value) {
    _preference.shakeToFeedback = value;
    notifyListeners();
  }

  setRecommendations(bool v) {
    _preference.unknownPeopleRecommendations = v;
    notifyListeners();
  }

  List<String> _filteredTagSearchHistory = [];
  List<String> get filteredTagSearchHistory => _filteredTagSearchHistory;
  set filteredTagSearchHistory(v) {
    _filteredTagSearchHistory = v;
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
    _selectedUser = v;
    notifyListeners();
  }

  PreferenceProvider(this.firebase, this._crashAnalyticsProvider) {
    this._api = ImplPreferenceService(this.firebase);
    _api.tryFetchFromLocalStorage().then((p) {
      if (p != null) {
        _preference = p;
        notifyListeners();
      }
    });

    // Whenever auth state change, renew the snapshot sub, cuz uid might change when deleting acc for ex
    firebase.auth!.authStateChanges().listen((u) async {
      // Logged out or linked another social account, no uid change
      // no need to update the stream with a new uid
      // kinda hacky :)
      if (u == null || u.providerData.length > 1) return;
      if (_streamSubscription != null) {
        await _streamSubscription!.cancel();
        _streamSubscription = null;
      }
      _stream = _api.streamPreference(u);
      _streamSubscription = _stream!.listen((p) {
        _crashAnalyticsProvider.log('streamPreference ${p.writeToJson()}');
        _preference = p;
        notifyListeners();
      });
    });
  }

  Future<LangameResponse> save() async {
    try {
      await _api.savePreference(firebase.auth!.currentUser?.uid, _preference);
      firebase.analytics?.logEvent(
          name: 'save_preference',
          parameters: _preference.toProto3Json() as Map<String, dynamic>);
      _crashAnalyticsProvider.log('save ${_preference.writeToJson()}');
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to notifyPresence');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  void addSearchHistory(String tag) {
    _preference.searchHistory.add(tag);
    if (_preference.searchHistory.length > _historyLength) {
      for (var i = _preference.searchHistory.length; i > _historyLength; i--) {
        _preference.searchHistory
            .remove(_preference.searchHistory.elementAt(i));
      }
    }
    _crashAnalyticsProvider.log('addSearchHistory');

    notifyListeners();
    firebase.analytics
        ?.logEvent(name: 'add_search_history', parameters: {'tag': tag});
  }

  void placeFirstSearchHistory(String tag) {
    _crashAnalyticsProvider.log('placeFirstSearchHistory');

    _preference.searchHistory.removeWhere((e) => e == tag);
    _preference.searchHistory.add(tag);
  }

  void deleteSearchHistory(String tag) {
    _crashAnalyticsProvider.log('deleteSearchHistory');

    _preference.searchHistory.removeWhere((e) => e == tag);
    _filteredTagSearchHistory.removeWhere((e) => e == tag);
    notifyListeners();
    firebase.analytics
        ?.logEvent(name: 'delete_search_history', parameters: {'tag': tag});
  }

  void resetFilteredSearchTagHistory() {
    _crashAnalyticsProvider.log('resetFilteredSearchTagHistory');

    _filteredTagSearchHistory = _preference.searchHistory;
    notifyListeners();
  }
}
