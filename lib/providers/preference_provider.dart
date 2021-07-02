import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/preference/impl_preference_service.dart';
import 'package:langame/services/http/preference/preference_service.dart';

import 'crash_analytics_provider.dart';

class PreferenceProvider extends ChangeNotifier {
  static const _historyLength = 5;

  FirebaseApi firebase;
  CrashAnalyticsProvider _cap;
  AuthenticationProvider _ap;

  late PreferenceService _api;

  Stream<UserPreference>? _stream;
  // ignore: cancel_subscriptions
  StreamSubscription<UserPreference>? _streamSubscription;
  UserPreference? _preference;
  UserPreference? get preference => _preference;

  setTheme(ThemeMode t) {
    _preference?.themeIndex = t.index;
    notifyListeners();
  }

  setShakeToFeedback(bool value) {
    _preference?.shakeToFeedback = value;
    notifyListeners();
  }

  setRecommendations(bool v) {
    _preference?.unknownPeopleRecommendations = v;
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

  PreferenceProvider(this.firebase, this._cap, this._ap) {
    this._api = ImplPreferenceService(this.firebase);
    // _api.tryFetchFromLocalStorage().then((p) {
    //   if (p != null) {
    //     _preference = p;
    //     notifyListeners();
    //   }
    // });
    // TODO: idc about local storage?
    _ap.userStream.listen((e) {
      if (e.type == UserChangeType.NewAuthentication) {
        _stream = _api.streamPreference(e.after!);
        _streamSubscription = _stream!.listen((p) {
          _cap.log('streamPreference');
          _preference = p;
          notifyListeners();
        });
      } else if (e.type == UserChangeType.Disconnection) {
        _streamSubscription?.cancel();
        _stream?.drain(); // TODO: necessary?
        _stream = null;
        _streamSubscription = null;
        _preference = null;
      }
    });
    _preference =
        _preference == null ? PreferenceService.defaultPreference : _preference;
    notifyListeners();
  }

  Future<LangameResponse> save() async {
    try {
      if (_ap.user == null) return LangameResponse(LangameStatus.succeed);
      await _api.savePreference(_ap.user!.uid, _preference!);
      firebase.analytics?.logEvent(name: 'save_preference', parameters: {
        'shakeToFeedback': preference!.shakeToFeedback,
        'hasDoneOnBoarding': preference!.hasDoneOnBoarding,
        'unknownPeopleRecommendations': preference!.unknownPeopleRecommendations,
        'themeIndex': preference!.themeIndex,
      });
      _cap.log('save preference');
    } catch (e, s) {
      _cap.log('failed to save');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  void addSearchHistory(String tag) {
    _preference!.searchHistory.add(tag);
    if (_preference!.searchHistory.length > _historyLength) {
      for (var i = _preference!.searchHistory.length; i > _historyLength; i--) {
        _preference!.searchHistory
            .remove(_preference!.searchHistory.elementAt(i));
      }
    }
    _cap.log('addSearchHistory');

    notifyListeners();
    firebase.analytics
        ?.logEvent(name: 'add_search_history', parameters: {'tag': tag});
  }

  void placeFirstSearchHistory(String tag) {
    _cap.log('placeFirstSearchHistory');

    _preference!.searchHistory.removeWhere((e) => e == tag);
    _preference!.searchHistory.add(tag);
  }

  void deleteSearchHistory(String tag) {
    _cap.log('deleteSearchHistory');

    _preference!.searchHistory.removeWhere((e) => e == tag);
    _filteredTagSearchHistory.removeWhere((e) => e == tag);
    notifyListeners();
    firebase.analytics
        ?.logEvent(name: 'delete_search_history', parameters: {'tag': tag});
  }

  void resetFilteredSearchTagHistory() {
    _cap.log('resetFilteredSearchTagHistory');

    _filteredTagSearchHistory = _preference!.searchHistory;
    notifyListeners();
  }
}
