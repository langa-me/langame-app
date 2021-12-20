import 'dart:async';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/models/google/protobuf/timestamp.pb.dart' as gg;
import 'package:langame/services/http/firebase.dart';

import 'authentication_provider.dart';
import 'crash_analytics_provider.dart';

class LangameProvider extends ChangeNotifier {
  final FirebaseApi _firebase;
  final CrashAnalyticsProvider _cap;
  final AuthenticationProvider _ap;
  Algolia? algolia;
  bool _isSearching = false;
  bool get isSearching => _isSearching;
  List<String> _filteredLangameSearchHistory = [];
  List<String> get filteredLangameSearchHistory =>
      _filteredLangameSearchHistory;
  set filteredLangameSearchHistory(List<String> v) {
    _filteredLangameSearchHistory = v;
    notifyListeners();
  }

  void resetFilteredLangameSearchHistory() {
    _cap.log('langame_provider:resetFilteredLangameSearchHistory');

    _filteredLangameSearchHistory = []; // _pp.preference.topicSearchHistory;
    notifyListeners();
  }

  LangameProvider(this._firebase, this._cap, this._ap, this.algolia) {
    _ap.userStream.listen((e) {
      if (e.type == UserChangeType.NewAuthentication) {
        listenToLangames();
      } else if (e.type == UserChangeType.Disconnection) {
        _langame_presences_sub?.cancel();
        Future.wait(_langames_subs?.map((sub) => sub.cancel()) ?? [])
            .then((value) => _langames_subs = null);
      }
    });
  }

  Map<String, lg.Langame> _langames = {};

  /// Contains all [Langame] current user is part of
  Map<String, lg.Langame> get langames => _langames;

  StreamSubscription? _langame_presences_sub;
  List<StreamSubscription>? _langames_subs;

  Future<LangameResponse<void>> listenToLangames() async {
    try {
      _langame_presences_sub = _firebase.firestore!
          .collection('langame_presences')
          .doc(_ap.user!.uid)
          .snapshots()
          .listen((querySnap) async {
        if (querySnap.data() == null ||
            querySnap.data()!['presences'] == null ||
            querySnap.data()!['presences'] is! List) {
          return;
        }
        await Future.wait(_langames_subs?.map((sub) => sub.cancel()) ?? []);
        _langames_subs = [];
        _langames_subs!.addAll((querySnap.data()!['presences'] as List<dynamic>)
            .map((e) => _firebase.firestore!
                    .collection('langames')
                    .withConverter<lg.Langame>(
                      fromFirestore: (s, _) => LangameExt.fromObject(s.data()!),
                      toFirestore: (s, _) => s.toMapStringDynamic(),
                    )
                    .doc(e)
                    .snapshots()
                    .listen((doc) {
                  if (doc.data() == null) return;
                  _langames[e] = doc.data()!;
                  langames[e]!.id = doc.id;
                  notifyListeners();
                })));
        // _cap.log('Langame ${e.channelName} added');
        notifyListeners();
      });
      _cap.log('langame_provider:initialize and get langames');
      return LangameResponse<void>(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('langame_provider:failed to initialize and get langames');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<DocumentSnapshot<lg.Langame>>> createLangame(
      List<lg.User> players, List<String> topics) async {
    try {
      final docRef = await _firebase.firestore!
          .collection(AppConst.firestoreLangamesCollection)
          .withConverter<lg.Langame>(
            fromFirestore: (s, _) => LangameExt.fromObject(s.data()!),
            toFirestore: (s, _) => s.toMapStringDynamic(),
          )
          .add(lg.Langame(
            initiator: _ap.user!.uid,
            topics: topics,
            createdAt: gg.Timestamp.fromDateTime(DateTime.now()),
            players: players
                    .map(
                      (user) => lg.Langame_Player(
                        id: user.uid,
                        tag: user.tag,
                        photoUrl: user.photoUrl,
                        bot: user.bot,
                        email: user.email,
                      ),
                    )
                    .toList() +
                [
                  lg.Langame_Player(
                    id: _ap.user!.uid,
                    tag: _ap.user!.tag,
                    photoUrl: _ap.user!.photoUrl,
                    bot: _ap.user!.bot,
                    email: _ap.user!.email,
                  )
                ],
          ));
      final snap = await _firebase.firestore!
          .collection('langames')
          .withConverter<lg.Langame>(
            fromFirestore: (s, _) => LangameExt.fromObject(s.data()!),
            toFirestore: (s, _) => s.toMapStringDynamic(),
          )
          .doc(docRef.id)
          .snapshots()
          .firstWhere(
              (e) => e.exists && e.data() != null && e.data()!.errors.isEmpty)
          .timeout(Duration(seconds: 20));

      _cap.log(
          'langame_provider:created langame with topics ${topics.join(',')}');
      return LangameResponse(LangameStatus.succeed, result: snap);
    } catch (e, s) {
      _cap.log(
          'langame_provider:failed to create langame with topics ${topics.join(',')}');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  void search(String value) async {
    if (value.isEmpty) {
      resetFilteredLangameSearchHistory();
      return;
    }

    final i = algolia?.index(AppConst.isDev ? 'dev_langames' : 'prod_langames');
    _isSearching = true;
    notifyListeners();
    final o = await i?.query('$value').getObjects();
    filteredLangameSearchHistory = o?.hits
            .map((e) => e.data['objectID'] as String)
            .toList()
            .reversed
            .toList() ??
        [];
    _isSearching = false;
    notifyListeners();
  }
}
