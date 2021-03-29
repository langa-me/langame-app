import 'package:flutter/material.dart';

abstract class StorageService {
  Future<void> saveTheme(ThemeMode data);
  Future<ThemeMode?> getTheme();
  Future<void> saveSetup(bool value);
  Future<bool> getSetup();
}
