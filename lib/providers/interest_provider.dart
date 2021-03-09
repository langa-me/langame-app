import 'dart:async';

import 'package:flutter/material.dart';
import 'package:langame/protos/api.pb.dart';
import 'package:langame/services/http/fake_interest_api.dart';
import 'package:langame/services/http/impl_interest_api.dart';
import 'package:langame/services/http/interest_api.dart';

class InterestProvider extends ChangeNotifier {
  /// Defines whether it's fake API or real
  bool _fake = true;
  late InterestApi _api;
  final _streamController = StreamController<Interest>();

  Stream<Interest> get interestsStream {
    return _streamController.stream;
  }

  Future<void> getAllInterests() async {
    final results = await _api.getInterests();
    results.forEach((element) {
      _streamController.add(element);
    });
  }

  InterestProvider({bool fake = true}) {
    _fake = fake;
    _api = _fake ? FakeInterestApi() : ImplInterestApi();
  }
}
