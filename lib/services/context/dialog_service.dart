import 'dart:async';

import 'package:flutter/material.dart';

class DialogService {
  Completer? _dialogCompleter;
  final GlobalKey<NavigatorState> _navigationKey;
  DialogService(this._navigationKey);

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future showDialog(Function showDialogListener) {
    _dialogCompleter = Completer();
    showDialogListener();
    return _dialogCompleter!.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete() {
    if (_navigationKey.currentState!.canPop()) {
      _navigationKey.currentState!.pop();
    }
    _dialogCompleter?.complete();
    _dialogCompleter = null;
  }
}
