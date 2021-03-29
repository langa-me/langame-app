import 'dart:math';

import 'package:flutter/material.dart';

import 'storage_service.dart';

class FakeStorageService implements StorageService {
  @override
  Future<ThemeMode> getTheme() async =>
      Random().nextDouble() > 0.5 ? ThemeMode.light : ThemeMode.dark;

  @override
  Future<void> saveTheme(ThemeMode data) async {}

  @override
  Future<bool> getSetup() async => Random().nextDouble() > 0.5;

  @override
  Future<void> saveSetup(bool value) async {}
}
