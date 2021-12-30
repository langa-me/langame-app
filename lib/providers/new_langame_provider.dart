import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:tuple/tuple.dart';

import 'crash_analytics_provider.dart';

/// Handle the "create new langame"
class NewLangameProvider extends ChangeNotifier {
  NewLangameProvider(this._cap, this._ap, this._firebase) {
    _ap.userStream.listen((e) {
      if (e.type == UserChangeType.NewAuthentication) {
        // ignore: cancel_subscriptions
        _subReco = _firebase.firestore!
            .collection('recommendations')
            .doc(e.after!.uid)
            .snapshots()
            .listen((e) async {

          if (e.exists && e.data() != null) {
            final reco = (e.data()!['recommendations'] as Map<String, dynamic>)
                .entries
                .map((e) => Tuple2(e.key, e.value));
            // It's forbidden by Google to log user ID
            _cap.log('new_langame_provider:stream recommendations');

            await Future.wait(reco.map((e) async {
              // TODO: until we better handle the use case "somehow user does not exist"
              try {
                final user = await _firebase.firestore!
                    .collection('users')
                    .doc(e.item1)
                    .withConverter<lg.User>(
                      fromFirestore: (s, _) => UserExt.fromObject(s.data()!),
                      toFirestore: (s, _) => s.toMapStringDynamic(),
                    )
                    .get()
                    .timeout(Duration(seconds: 10));
                _recommendations[e.item2] = user;
              } catch (e, s) {
                _cap.log(
                    'new_langame_provider: failed to get recommendation user, $e, $s');
                _cap.recordError(e, s);
              }
            }));

            notifyListeners();
          }
        });
      } else if (e.type == UserChangeType.Disconnection) {
        _subReco?.cancel();
        _recommendations = SortedMap(Ordering.byKey());
        notifyListeners();
      }
    });
  }
  CrashAnalyticsProvider _cap;
  AuthenticationProvider _ap;
  FirebaseApi _firebase;

  /// Players to be invited
  List<lg.User> _shoppingList = [];
  List<lg.User> get shoppingList => _shoppingList;
  SortedMap<int, DocumentSnapshot<lg.User>> _recommendations =
      SortedMap(Ordering.byKey());
  SortedMap<int, DocumentSnapshot<lg.User>> get recommendations =>
      _recommendations;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subReco;
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  int _maximumPlayers = 5;
  int get maximumPlayers => _maximumPlayers;

  void addPlayer(lg.User player) {
    _shoppingList.add(player);
    notifyListeners();
  }

  void removePlayer(lg.User player) {
    _shoppingList.removeWhere((e) => e.uid == player.uid);
    notifyListeners();
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setMaximumPlayers(int value) {
    _maximumPlayers = value;
    notifyListeners();
  }
}
