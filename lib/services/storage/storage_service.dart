// This is the contract that all storage services must follow. Using an abstract
// class like this allows you to swap concrete implementations. This is useful
// for separating architectural layers. It also makes testing and development
// easier because you can provide a mock implementation or fake data.
import 'package:flutter/material.dart';

abstract class StorageService {
  Future saveTheme(ThemeMode data);

  Future<ThemeMode?> getTheme();
  //
  // Future saveFavoriteCurrencies(List<Currency> data);
  //
  // Future<List<Currency>> getFavoriteCurrencies();
  //
  // Future<bool> isExpiredCache();
}
