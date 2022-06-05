import 'package:algolia/algolia.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/firebase.dart';

import 'crash_analytics_provider.dart';

class PhysicalLangameProvider extends ChangeNotifier {
  FirebaseApi _firebase;
  Algolia algolia;
  CrashAnalyticsProvider _cap;
  PhysicalLangameProvider(this._firebase, this._cap, this.algolia);

  List<lg.Meme> _memes = [];
  List<lg.Meme> get memes => _memes;
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

  Future<LangameResponse<bool>> getMemes({List<String>? topics, int quantity = 1}) async {
    try {
      var memes = await _firebase.functions!
          .httpsCallable(
        'getMemes',
        options: HttpsCallableOptions(
          timeout: Duration(seconds: 40),
        ),
      )
          .call(<String, dynamic>{
        'topics': topics ?? [],
        'quantity': quantity,
      });

      _memes = memes.data['memes']
          .map<lg.Meme>((e) => MemeExt.fromObject(e))
          .toList();
      _currentMeme = 0;
      _cap.log(
          'getMemes topics: ${topics?.join(',')} memes: ${_memes.map((e) => e.content).join(',')}');

      notifyListeners();
      return LangameResponse(LangameStatus.succeed, result: true);
    } catch (e, s) {
      if (e.toString().contains('could not find memes')) {
        // No more memes in this topic
        return LangameResponse(LangameStatus.succeed, result: false);
      }
      _cap.log('failed to getMemes $e $s');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }

  Future<LangameResponse<List<String>>> topicSearch(String value) async {
    try {
      final objects = await algolia
          .index(AppConst.isDev ? "dev_topics" : "prod_topics")
          .query(value)
          .getObjects();

      return LangameResponse(LangameStatus.succeed,
          result: objects.hits.map((e) => e.objectID).toList());
    } catch (e, s) {
      _cap.log('failed to topicSearch');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }
}
