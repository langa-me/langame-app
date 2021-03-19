import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  bool _profileShown = false;

  bool get profileShown {
    return _profileShown;
  }

  set profileShown(bool value) {
    _profileShown = value;
    notifyListeners();
  }
}
