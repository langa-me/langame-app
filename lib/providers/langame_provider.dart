import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/langame_api.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import 'authentication_provider.dart';
import 'crash_analytics_provider.dart';

class LangameProvider extends ChangeNotifier {
  final FirebaseApi _firebase;
  final CrashAnalyticsProvider _cap;
  final AuthenticationProvider _ap;
  final LangameApi _langameApi;
  LangameProvider(this._firebase, this._cap, this._ap, this._langameApi);

  Map<String, lg.Langame> _runningLangames = {};

  /// Contains all [Langame] current user is part of
  Map<String, lg.Langame> get runningLangames => _runningLangames;

  Map<String, lg.Langame> _finishedLangames = {};

  /// Contains all [Langame] current user is part of
  Map<String, lg.Langame> get finishedLangames => _finishedLangames;

  Future<LangameResponse<void>> initialize() async {
    try {
      var stream = _langameApi.getLangames(unDoneOnly: false);
      // TODO: what happen if user log in / out, delete acc, to the stream subs?
      stream.listen((snaps) {
        snaps.docs.forEach((snap) {
          if (snap.data().done) {
            _finishedLangames[snap.id] = snap.data();
          } else {
            _runningLangames[snap.id] = snap.data();
          }
          notifyListeners();
        });
      });
      _cap.log('initialize');
      return LangameResponse<void>(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to send langame');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<Stream<DocumentSnapshot<lg.Langame>>>> createLangame(
      List<lg.User> players, List<lg.Topic> topics, DateTime date,
      {bool instant = false}) async {
    try {
      final String msg =
          'create Langame about ${topics.map((e) => e.content).join(',')} with ${players.map((e) => e.uid).join(',')} on ${date.toIso8601String()}';
      _cap.log(msg);

      // TODO: we'd likely send the whole  topic in the future (with classifications)
      var langameSnapshot = await _langameApi.createLangame(
        players.map((e) => e.uid).toList(),
        topics.map((e) => e.content).toList(),
        date,
      );
      return LangameResponse(LangameStatus.succeed, result: langameSnapshot);
    } catch (e, s) {
      _cap.log('failed to send langame');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse> notifyPresence(String channelName) async {
    try {
      await _langameApi.notifyPresence(channelName);
      _cap.log('notifyPresence');
    } catch (e, s) {
      _cap.log('failed to notifyPresence');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<void>> joinLangame(String channelName) async {
    try {
      await _langameApi.joinLangame(channelName);
      _cap.log('joinLangame');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to joinLangame');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> addNote(String channelName, String note) async {
    try {
      await _langameApi.addNoteToLangame(channelName, note);
      _cap.log('addNote $note');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to addNote $note');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
