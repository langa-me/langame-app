import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/firebase.dart';

import 'crash_analytics_provider.dart';

class PhysicalLangameProvider extends ChangeNotifier {
  FirebaseApi _firebase;
  CrashAnalyticsProvider _cap;
  PhysicalLangameProvider(this._firebase, this._cap);

  List<Map<String, dynamic>> _memes = [];
  List<Map<String, dynamic>> get memes => _memes;
  int _currentMeme = 0;
  int get currentMeme => _currentMeme;
  void previous() {
    if (_currentMeme <= 0) return;
    _currentMeme--;
    notifyListeners();
  }

  void next() {
    if (_currentMeme >= _memes.length - 1) return;
    _currentMeme++;
    notifyListeners();
  }

  Future<LangameResponse<void>> getMemes({List<String>? topics}) async {
    try {
      var memes = await _firebase.functions!
          .httpsCallable(
        'getMemes',
        options: HttpsCallableOptions(
          timeout: Duration(seconds: 20),
        ),
      )
          .call(<String, dynamic>{
        'topics': topics ?? [],
      });

      _memes = ((memes.data as Map<String, dynamic>)['memes'] as List<dynamic>)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      _currentMeme = 0;
      notifyListeners();
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to getMemes');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }
}
