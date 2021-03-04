import 'package:flutter/material.dart';
import 'package:langame/services/storage/storage_service.dart';
import 'package:langame/services/storage/storage_service_fake.dart';
import 'package:langame/services/storage/storage_service_implementation.dart';

class SettingProvider extends ChangeNotifier {
  /// Defines whether it's fake API or real
  bool _fake = true;
  StorageService _api;
  ThemeMode _theme = ThemeMode.system;
  ThemeMode get theme => _theme;

  Future set(ThemeMode t) async {
    var f = _api.saveTheme(t);
    notifyListeners();
    return f;
  }

  SettingProvider({bool fake = true}) {
    _fake = fake;
    _api = _fake ? FakeStorageService() : StorageServiceImpl();
    // Only fetch from preferences at boot
    _api
        .getTheme()
        .then((value) => _theme = value != null ? value : ThemeMode.system);
  }
}
