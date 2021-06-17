import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/langame_api.dart';

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

  List<StreamSubscription<DocumentSnapshot<lg.Langame>>> _subs = [];

  clearLangames() {
    _subs.forEach((e) => e.cancel());
    _subs.clear();
    _finishedLangames.clear();
    _runningLangames.clear();
  }

  Future<LangameResponse<void>> initialize() async {
    try {
      clearLangames();
      var streams = await _langameApi.getLangames(unDoneOnly: false);
      // TODO: what happen if user log in / out, delete acc, to the stream subs?
      streams.forEach((stream) {
        _finishedLangames.clear();
        _runningLangames.clear();
        _subs.add(stream.listen((snap) {
          if (snap.data() == null) return;
          // Seconds = 0 = null
          if (snap.data()!.hasDone() && snap.data()?.done.seconds != 0) {
            _finishedLangames[snap.id] = snap.data()!;
          } else {
            _runningLangames[snap.id] = snap.data()!;
          }
        }));
        notifyListeners();
      });

      _cap.log('initialize and get langames');
      return LangameResponse<void>(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to initialize and get langames');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<DocumentSnapshot<lg.Langame>>> createLangame(
      List<lg.User> players, List<lg.Tag> topics, DateTime date,
      {bool instant = false}) async {
    try {
      // TODO: we'd likely send the whole  topic in the future (with classifications)
      var stream = await _langameApi.createLangame(
        players.map((e) => e.uid).toList(),
        topics.map((e) => e.topic.content).toList(),
        date,
      );
      var snap = await stream.firstWhere((e) =>
          e.exists &&
          e.data() != null &&
          e.data()!.errors.isEmpty &&
          e.data()!.channelName.isNotEmpty);

      initialize();
      return LangameResponse(LangameStatus.succeed, result: snap);
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

  Future<LangameResponse<Stream<DocumentSnapshot<lg.Langame>>>> joinLangame(
      String channelName) async {
    try {
      final ret = await _langameApi.joinLangame(channelName);
      _cap.log('joinLangame $channelName');
      initialize();
      return LangameResponse(LangameStatus.succeed, result: ret);
    } catch (e, s) {
      _cap.log('failed to joinLangame $channelName');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> addNote(
      String channelName, String note, lg.Note_Type type) async {
    try {
      await _langameApi.addNoteToLangame(channelName, note, type);
      _cap.log('addNote $note');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to addNote $note');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<List<lg.Note>>> getNotes(String channelName) async {
    try {
      var notes = await _firebase.firestore!
          .collection(
              '${AppConst.firestoreLangamesCollection}/players/${_firebase.auth!.currentUser!.uid}/notes')
          .withConverter<lg.Note>(
            fromFirestore: (snapshot, _) =>
                NoteExt.fromObject(snapshot.data()!),
            toFirestore: (e, _) => e.toMapStringDynamic(),
          )
          .get();
      _cap.log('getNotes $notes');
      return LangameResponse(LangameStatus.succeed,
          result: notes.docs.map((e) => e.data()).toList());
    } catch (e, s) {
      _cap.log('failed to getNotes in $channelName');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<List<lg.User>>> getUsers(String channelName) async {
    try {
      var langame = await _firebase.firestore!
          .collection('${AppConst.firestoreLangamesCollection}')
          .where('channelName', isEqualTo: channelName)
          .withConverter<lg.Langame>(
            fromFirestore: (s, _) => LangameExt.fromObject(s.data()!),
            toFirestore: (e, _) => e.toMapStringDynamic(),
          )
          .get();
      if (langame.docs.isEmpty)
        return LangameResponse(LangameStatus.succeed, result: []);
      var players =
          await langame.docs.first.reference.collection('players').get();
      var users = await Future.wait(players.docs.map((e) => _firebase.firestore!
          .collection('users')
          .doc(e.id)
          .withConverter<lg.User>(
            fromFirestore: (s, _) => UserExt.fromObject(s.data()!),
            toFirestore: (e, _) => e.toMapStringDynamic(),
          )
          .get()));
      _cap.log('getUsers');
      return LangameResponse(LangameStatus.succeed,
          result: users
              .where((e) => e.data() != null)
              .map((e) => e.data()!)
              .toList());
    } catch (e, s) {
      _cap.log('failed to getUsers');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
