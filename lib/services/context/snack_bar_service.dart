import 'package:flutter/material.dart';

class SnackBarService {
  late GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;

  SnackBarService(this._scaffoldMessengerKey);

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  void show(SnackBar snackBar) {
    _scaffoldMessengerKey.currentState!.removeCurrentSnackBar();
    _scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
  }
}
