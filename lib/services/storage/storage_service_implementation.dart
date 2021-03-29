import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_service.dart';

class StorageServiceImpl implements StorageService {
  static const sharedPrefThemeKey = 'theme_key';
  static const sharedPrefSetupKey = 'setup_key';
  @override
  Future<ThemeMode?> getTheme() async {
    String data = await _getStringFromPreferences(sharedPrefThemeKey);
    if (data == '') return null;
    Map<String, dynamic> decoded = jsonDecode(data);
    if (!kReleaseMode) print('loaded preferences $decoded');
    return ThemeMode.values[decoded['themeMode']];
  }

  @override
  Future<void> saveTheme(ThemeMode data) async {
    String jsonString = jsonEncode({'themeMode': data.index});
    _saveStringToPreferences(sharedPrefThemeKey, jsonString);
    if (!kReleaseMode) print('saved preferences $jsonString');
  }

  Future<void> _saveStringToPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<void> _saveBoolToPreferences(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<String> _getStringFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  Future<bool> _getBoolFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  @override
  Future<bool> getSetup() async {
    bool hasUsedAlreadyDoneSetup =
        await _getBoolFromPreferences(sharedPrefSetupKey);
    if (!kReleaseMode)
      print('preferences loaded, setup done? $hasUsedAlreadyDoneSetup');
    return hasUsedAlreadyDoneSetup;
  }

  @override
  Future<void> saveSetup(bool value) async {
    _saveBoolToPreferences(sharedPrefSetupKey, value);
    if (!kReleaseMode) print('setup done $value saved to preferences');
  }
}
