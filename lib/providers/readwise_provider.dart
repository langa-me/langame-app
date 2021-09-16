import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadwiseProvider extends ChangeNotifier {
  ReadwiseProvider(this.firebase, this._cap, this._ap) {
    _ap.userStream.listen((e) {
      if (e.type == UserChangeType.NewAuthentication) {
        SharedPreferences.getInstance().then((p) {
          _apiKey = p.getString('readwise_api_key');
          notifyListeners();
          _cap.log('readwise_provider: got api key from local storage');
        });
      } else if (e.type == UserChangeType.Disconnection) {
        _apiKey = null;
        notifyListeners();
      }
    });
  }
  final FirebaseApi firebase;
  final CrashAnalyticsProvider _cap;
  final AuthenticationProvider _ap;
  String? _apiKey;
  String? get apiKey => _apiKey;

  /// This function call https://readwise.io/api/v2/auth/
  /// to check if the API Key is valid.
  Future<LangameResponse<bool>> isKeyValid(String apiKey) async {
    try {
      var response = await get(
        Uri.parse('https://readwise.io/api/v2/auth/'),
        headers: {
          'Authorization': 'Token $apiKey',
        },
      );
      if (response.statusCode == 204 && _apiKey != apiKey) {
        _apiKey = apiKey;
        SharedPreferences.getInstance().then((p) async {
          await p.setString('readwise_api_key', apiKey);
          notifyListeners();
        });
      }
      return LangameResponse.succeed(result: response.statusCode == 204);
    } catch (e) {
      _cap.log('readwise_provider: failed to check key');
      return LangameResponse.failed();
    }
  }
}
