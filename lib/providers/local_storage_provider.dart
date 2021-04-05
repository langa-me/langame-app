import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/user.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/storage/storage_service.dart';
import 'package:langame/services/storage/storage_service_fake.dart';
import 'package:langame/services/storage/storage_service_implementation.dart';
import 'package:ordered_set/ordered_set.dart';

class LocalStorageProvider extends ChangeNotifier {
  static const _historyLength = 5;

  FirebaseApi firebase;
  late StorageService _api;

  /// Application theme
  ThemeMode _theme = ThemeMode.system;
  ThemeMode get theme => _theme;

  /// Has done initial application setup?
  bool _hasDoneSetup = false;
  bool get hasDoneSetup => _hasDoneSetup;

  /// User search tag history
  OrderedSet<String> _searchTagHistory = OrderedSet();
  List<String> get searchTagHistory => _searchTagHistory.toList();
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

  LangameUser? _selectedUser;
  LangameUser? get selectedUser => _selectedUser;
  set selectedUser(LangameUser? v) {
    _selectedUser = v;
    notifyListeners();
  }

  Future<void> saveTheme(t) async {
    var f = _api.saveTheme(t);
    f.then((_) {
      _theme = t;
      notifyListeners();
    }).then((value) => firebase.analytics
        .logEvent(name: 'setTheme', parameters: {'theme': theme.index}));
    return f;
  }

  Future<void> saveHasDoneSetup(value) async {
    var f = _api.saveSetup(value);
    f.then((_) {
      _hasDoneSetup = value;
      notifyListeners();
    });
    return f;
  }

  Future<void> saveSearchHistory() async {
    var f = _api.saveSearchTagsHistory(_searchTagHistory.toList());
    f.then((_) {
      _searchTagHistory = _searchTagHistory;
      notifyListeners();
    });
    return f;
  }

  void addSearchHistory(String tag) {
    _searchTagHistory.add(tag);
    if (_searchTagHistory.length > _historyLength) {
      for (var i = _searchTagHistory.length; i > _historyLength; i--) {
        _searchTagHistory.remove(_searchTagHistory.elementAt(i));
      }
    }
    notifyListeners();
    firebase.analytics
        .logEvent(name: 'addSearchHistory', parameters: {'tag': tag});
  }

  void placeFirstSearchHistory(String tag) {
    _searchTagHistory.removeWhere((e) => e == tag);
    _searchTagHistory.add(tag);
    debugPrint('${_searchTagHistory.toList()}'); // TODO: set = unordered
  }

  void deleteSearchHistory(String tag) {
    _searchTagHistory.removeWhere((e) => e == tag);
    _filteredTagSearchHistory.removeWhere((e) => e == tag);
    notifyListeners();
    firebase.analytics
        .logEvent(name: 'deleteSearchHistory', parameters: {'tag': tag});
  }

  void resetFilteredSearchTagHistory() {
    _filteredTagSearchHistory = _searchTagHistory.toList();
    notifyListeners();
  }

  Future load() async {
    FutureGroup f = FutureGroup();
    var f1 = _api.getTheme();
    var f2 = _api.getSetup();
    var f3 = _api.getSearchTagsHistory();
    f.add(f1);
    f.add(f2);
    f.add(f3);
    f.close();
    f1.then((t) {
      if (t != null) {
        saveTheme(t);
      }
    });
    f2.then(saveHasDoneSetup);
    f3.then((e) {
      _searchTagHistory.addAll(e);
      notifyListeners();
    });
    return f;
  }

  LocalStorageProvider(this.firebase, {bool fake = false}) {
    this._api = fake ? FakeStorageService() : StorageServiceImpl();
  }
}
