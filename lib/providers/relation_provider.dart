import 'package:flutter/foundation.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/authentication_api.dart';
import 'package:ordered_set/comparing.dart';
import 'package:ordered_set/ordered_set.dart';
import 'package:tuple/tuple.dart';

import '../models/extension.dart';
import 'authentication_provider.dart';
import 'crash_analytics_provider.dart';

class RelationProvider extends ChangeNotifier {
  CrashAnalyticsProvider _crashAnalyticsProvider;
  AuthenticationProvider _authenticationProvider;
  AuthenticationApi _authenticationApi;

  List<lg.User> _userRecommendations = [];

  List<lg.User> get userRecommendations {
    return _userRecommendations;
  }

  OrderedSet<Tuple2<lg.User, lg.InteractionLevel>> _recentInteractions =
      OrderedSet<Tuple2<lg.User, lg.InteractionLevel>>(
          Comparing.on((e) => e.item2.value));

  OrderedSet<Tuple2<lg.User, lg.InteractionLevel>> get recentInteractions {
    return _recentInteractions;
  }

  RelationProvider(this._authenticationApi, this._crashAnalyticsProvider,
      this._authenticationProvider);

  Future<LangameResponse<void>> getUserRecommendations() async {
    try {
      _userRecommendations = await _authenticationApi
          .getUserRecommendations(_authenticationProvider.user!);
      _crashAnalyticsProvider
          .log('getUserRecommendations ${_authenticationProvider.user!.uid}');
      notifyListeners();
      return LangameResponse<void>(LangameStatus.succeed);
    } catch (e, s) {
      _crashAnalyticsProvider.log(
          'failed to getUserRecommendations ${_authenticationProvider.user?.uid}');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> getRecentInteractions() async {
    try {
      var interactions = await _authenticationApi
          .getInteractions(_authenticationProvider.user!.uid);
      var users = await Future.wait(
          interactions.map((i) => _authenticationApi.getLangameUser(i.item1)
          .firstWhere((e) => e.data() != null)
          .timeout(Duration(seconds: 20))));
      _recentInteractions = OrderedSet<Tuple2<lg.User, lg.InteractionLevel>>(
          Comparing.on((e) => e.item2.value));
      users.asMap().forEach((i, u) {
          _recentInteractions
              .add(Tuple2(u.data()!, interactions[i].item2.toInteractionLevel()));
      });
      notifyListeners();

      _crashAnalyticsProvider
          .log('getRecentInteractions ${_authenticationProvider.user!.uid}');
      notifyListeners();
      return LangameResponse<void>(LangameStatus.succeed);
    } catch (e, s) {
      _crashAnalyticsProvider.log(
          'failed to getRecentInteractions ${_authenticationProvider.user?.uid}');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<lg.InteractionLevel?>> getInteraction(
      String otherUid) async {
    try {
      var r = await _authenticationApi.getInteraction(
          _authenticationProvider.user!.uid, otherUid);
      _crashAnalyticsProvider.log('getInteraction $otherUid');
      if (r == null)
        return LangameResponse(LangameStatus.failed, error: 'no interactions');
      return LangameResponse(LangameStatus.succeed,
          result: r.toInteractionLevel());
    } catch (e, s) {
      _crashAnalyticsProvider.log('failed to getInteraction $otherUid');
      _crashAnalyticsProvider.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
