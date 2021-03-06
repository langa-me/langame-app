import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/services/storage/storage_service.dart';
import 'package:langame/services/storage/storage_service_fake.dart';
import 'package:langame/services/storage/storage_service_implementation.dart';

class SettingProvider extends ChangeNotifier {
  /// Defines whether it's fake API or real
  bool _fake = true;
  StorageService _api;
  ThemeMode _theme = ThemeMode.system;
  ThemeMode get theme => _theme;

  setTheme(t) {
    if (AppConst.debugSettings) print('set theme $t');
    _theme = t;
    notifyListeners();
    _api.saveTheme(t);
  }

  Future load() async {
    final f = _api.getTheme();
    f.then(setTheme);
    return f;
  }

  SettingProvider({bool fake = false}) {
    _fake = fake;
    _api = _fake ? FakeStorageService() : StorageServiceImpl();
  }
}
