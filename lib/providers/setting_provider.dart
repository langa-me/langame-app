import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/services/storage/storage_service.dart';
import 'package:langame/services/storage/storage_service_fake.dart';
import 'package:langame/services/storage/storage_service_implementation.dart';

class SettingProvider extends ChangeNotifier {
  late StorageService _api;
  ThemeMode _theme = ThemeMode.system;

  ThemeMode get theme => _theme;
  bool _hasDoneSetup = false;

  bool get hasDoneSetup => _hasDoneSetup;

  Future<void> setTheme(t) async {
    var f = _api.saveTheme(t);
    f.then((_) {
      if (!kReleaseMode) print('set theme $t');
      _theme = t;
      notifyListeners();
    });
    return f;
  }

  Future<void> setHasDoneSetup(value) async {
    var f = _api.saveSetup(value);
    f.then((_) {
      if (!kReleaseMode) print('set hasDoneSetup to $value');
      _hasDoneSetup = value;
      notifyListeners();
    });
    return f;
  }

  Future load() async {
    FutureGroup f = FutureGroup();
    var f1 = _api.getTheme();
    var f2 = _api.getSetup();
    f.add(f1);
    f.add(f2);
    f.close();
    f1.then((t) {
      if (t != null) {
        setTheme(t);
      }
    });
    f2.then(setHasDoneSetup);
    return f;
  }

  SettingProvider({bool fake = false}) {
    this._api = fake ? FakeStorageService() : StorageServiceImpl();
  }
}
