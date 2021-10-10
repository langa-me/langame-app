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

  LangameProvider(this._firebase, this._cap, this._ap, this._langameApi) {
    _ap.userStream.listen((e) {
      if (e.type == UserChangeType.NewAuthentication) {
        initialize();
      } else if (e.type == UserChangeType.Disconnection) {
        _clearState();
      }
    });
  }

  Map<String, lg.Langame> _langames = {};

  /// Contains all [Langame] current user is part of
  Map<String, lg.Langame> get langames => _langames;

  Timer? _lockTimer;
  String? get canLock =>
      _lockTimer == null || !_lockTimer!.isActive ? null : 'a moment please...';

  _clearState() {
    _lockTimer = null;
  }

  Future<LangameResponse<void>> initialize() async {
    try {
      var stream = await _langameApi.getLangames();
      stream.listen((e) {
        _langames[e.channelName] = e;
        notifyListeners();
      });
      // TODO: what happen if user log in / out, delete acc, to the stream subs?

      _cap.log('langame_provider:initialize and get langames');
      return LangameResponse<void>(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('langame_provider:failed to initialize and get langames');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<DocumentSnapshot<lg.Langame>>> createLangame(
      List<lg.User> players, List<String> topics, DateTime date,
      {bool instant = false, isText = false}) async {
    try {
      var stream = await _firebase.firestore!
          .collection(AppConst.firestoreLangamesCollection)
          .add({
        'topics': topics,
        'initiator': _firebase.auth!.currentUser!.uid,
        'date': date,
        'reservedSpots': players.map((e) => e.uid).toList(),
        'isText': isText,
      }).then((e) => e
              .withConverter<lg.Langame>(
                fromFirestore: (s, _) => LangameExt.fromObject(s.data()!),
                toFirestore: (s, _) => s.toMapStringDynamic(),
              )
              .snapshots()
              .timeout(Duration(seconds: 20)));
      // TODO: we'd likely send the whole  topic in the future (with classifications)

      final snap = await stream.firstWhere((e) =>
          e.exists &&
          e.data() != null &&
          (e.data()!.memes.isNotEmpty || e.data()!.errors.isNotEmpty));
      if (snap.data()!.errors.isNotEmpty) {
        var errors = snap.data()!.errors;
        errors.sort((a, b) =>
            a.createdAt.toDateTime().compareTo(b.createdAt.toDateTime()));
        var msg = errors.first.userMessage;
        _cap.log(
            'langame_provider:failed to create langame with topics ${topics.join(',')} and date $date - ${errors.first.developerMessage}');
        return LangameResponse(LangameStatus.failed,
            error: msg.isNotEmpty ? msg : null);
      }
      initialize();
      _cap.log(
          'langame_provider:created langame with topics ${topics.join(',')} and date $date');
      return LangameResponse(LangameStatus.succeed, result: snap);
    } catch (e, s) {
      _cap.log(
          'langame_provider:failed to create langame with topics ${topics.join(',')} and date $date');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse> notifyPresence(String channelName) async {
    try {
      await _langameApi.notifyPresence(channelName);
      _cap.log('langame_provider:notifyPresence');
    } catch (e, s) {
      _cap.log('langame_provider:failed to notifyPresence');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<Stream<DocumentSnapshot<lg.Langame>>>> joinLangame(
      String channelName) async {
    try {
      final ret = await _firebase.firestore!
          .collection(AppConst.firestoreLangamesCollection)
          .where('channelName', isEqualTo: channelName)
          .withConverter<lg.Langame>(
            fromFirestore: (snapshot, _) =>
                LangameExt.fromObject(snapshot.data()!),
            toFirestore: (user, _) => user.toMapStringDynamic(),
          )
          .get();
      if (ret.docs.isEmpty || !ret.docs.first.exists)
        return LangameResponse.failed(
            error: LangameException('invalid_channel_name'));
      if (ret.docs.first.data().hasDone())
        return LangameResponse.failed(error: LangameException('langame_done'));
      if (ret.docs.first.data().isLocked)
        return LangameResponse.failed(
            error: LangameException('langame_locked'));

      // Set time in (whether was in initially invited players or not)
      var snapP = ret.docs.first.reference
          .collection('players')
          .doc(_firebase.auth!.currentUser!.uid)
          .withConverter<lg.Player>(
            fromFirestore: (s, _) => PlayerExt.fromObject(s.data()!),
            toFirestore: (s, _) => s.toMapStringDynamic(),
          );
      // No need to await this set as we wait that the server update self
      var p = lg.Player(
        userId: _firebase.auth!.currentUser!.uid,
        audioId: -1,
      );
      snapP.set(
        p,
        SetOptions(merge: true),
      );
      // Wait that server assign a audio id
      await snapP
          .snapshots()
          .firstWhere((e) => e.data() != null && e.data()!.audioId != -1)
          .timeout(Duration(seconds: 20));

      _cap.log('langame_provider:joinLangame $channelName');
      initialize();
      return LangameResponse(LangameStatus.succeed,
          result: ret.docs.first.reference.snapshots());
    } catch (e, s) {
      _cap.log('langame_provider:failed to joinLangame $channelName');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> addNote(
      String channelName, String note, lg.Note_Type type) async {
    try {
      await _langameApi.addNoteToLangame(channelName, note, type);
      _cap.log('langame_provider:addNote $note');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('langame_provider:failed to addNote $note');
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
      _cap.log('langame_provider:getNotes $notes');
      return LangameResponse(LangameStatus.succeed,
          result: notes.docs.map((e) => e.data()).toList());
    } catch (e, s) {
      _cap.log('langame_provider:failed to getNotes in $channelName');
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
      _cap.log('langame_provider:getUsers');
      return LangameResponse(LangameStatus.succeed,
          result: users
              .where((e) => e.data() != null)
              .map((e) => e.data()!)
              .toList());
    } catch (e, s) {
      _cap.log('langame_provider:failed to getUsers');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> addLink(String langameId, String link) async {
    try {
      await _firebase.firestore!
          .collection(AppConst.firestoreLangamesCollection)
          .doc(langameId)
          .update({'link': link});
      _cap.log('addLink $langameId $link');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to addLink $langameId $link');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> lock(String channelName) async {
    try {
      if (canLock != null) return LangameResponse(LangameStatus.failed);
      final lgId = _langames.entries
          .firstWhere((e) => e.value.channelName == channelName)
          .key;
      var langame = await _firebase.firestore!
          .collection(AppConst.firestoreLangamesCollection)
          .withConverter<lg.Langame>(
            fromFirestore: (s, _) => LangameExt.fromObject(s.data()!),
            toFirestore: (e, _) => e.toMapStringDynamic(),
          )
          .doc(lgId)
          .get();
      if (!langame.data()!.hasIsLocked()) {
        return LangameResponse(LangameStatus.failed);
      }
      await langame.reference.update({'isLocked': !langame.data()!.isLocked});
      _cap.log('lock $lgId ${!langame.data()!.isLocked}');
      _lockTimer = Timer(Duration(seconds: 5), () {});
    } catch (e, s) {
      _cap.log('failed to notifyPresence');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }
}
