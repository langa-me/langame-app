import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/impl_tag_api.dart';
import 'package:langame/services/http/tag_api.dart';
import 'package:ordered_set/comparing.dart';
import 'package:ordered_set/ordered_set.dart';

class TagProvider extends ChangeNotifier {
  final FirebaseApi firebase;
  final CrashAnalyticsProvider _cap;

  late TagApi _api;
  final Map<String, lg.Tag> _topics = Map<String, lg.Tag>();
  Map<String, lg.Tag> get topics => _topics;

  TagProvider(this.firebase, this._cap) {
    _api = ImplTagApi(firebase);
    _api.streamTopics().listen(
          (snap) => snap.docs.forEach(
            (t) {
              if (t.data().hasTopic()) {
                topics[t.data().topic.content] = t.data();
                notifyListeners();
              }
            },
          ),
        );
  }

  Future<LangameResponse<lg.Meme>> getMeme(
      String memeId) async {
    try {
      var meme = await firebase.firestore!
          .collection(AppConst.firestoreMemesCollection)
          .doc(memeId)
          .withConverter<lg.Meme>(
            fromFirestore: (s, _) => MemeExt.fromObject(s.data()!),
            toFirestore: (s, _) => s.toMapStringDynamic(),
          )
          .get();
      if (meme.data() == null) return LangameResponse(LangameStatus.failed);
      return LangameResponse(LangameStatus.succeed, result: meme.data());
    } catch (e, s) {
      _cap.log('failed to getMeme $memeId');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<List<lg.Tag>>> getMemeTags(String memeId) async {
    try {
      var tags = await firebase.firestore!
          .collection(AppConst.firestoreMemesCollection)
          .doc(memeId)
          .collection(AppConst.firestoreTagsSubCollection)
          .withConverter<lg.Tag>(
            fromFirestore: (s, _) => TagExt.fromObject(s.data()!),
            toFirestore: (s, _) => s.toMapStringDynamic(),
          )
          .get();

      _cap.log('getMemeTags $memeId');

      return LangameResponse(LangameStatus.succeed,
          result: tags.docs.map((e) => e.data()).toList());
    } catch (e, s) {
      _cap.log('failed to getMemeTags $memeId');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
