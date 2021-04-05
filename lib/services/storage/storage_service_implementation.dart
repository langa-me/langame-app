import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_service.dart';

class StorageServiceImpl implements StorageService {
  static const sharedPrefThemeKey = 'theme_key';
  static const sharedPrefSetupKey = 'setup_key';
  static const sharedPrefSearchTagHistoryKey = 'search_tag_history_key';
  @override
  Future<ThemeMode?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(sharedPrefThemeKey) ?? '';
    if (data == '') return null;
    Map<String, dynamic> decoded = jsonDecode(data);
    return ThemeMode.values[decoded['themeMode']];
  }

  @override
  Future<void> saveTheme(ThemeMode data) async {
    String jsonString = jsonEncode({'themeMode': data.index});
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString(sharedPrefThemeKey, jsonString);
    if (!result) throw LangameStorageException('failed to saveSetup');
  }

  @override
  Future<bool> getSetup() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPrefSetupKey) ?? false;
  }

  @override
  Future<void> saveSetup(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setBool(sharedPrefSetupKey, value);
    if (!result) throw LangameStorageException('failed to saveSetup');
  }

  @override
  Future<List<String>> getSearchTagsHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(sharedPrefSearchTagHistoryKey) ?? [];
    return data;
  }

  @override
  Future<void> saveSearchTagsHistory(List<String> searchTagsHistory) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setStringList(
        sharedPrefSearchTagHistoryKey, searchTagsHistory);
    if (!result)
      throw LangameStorageException('failed to saveSearchTagsHistory');
  }
}
