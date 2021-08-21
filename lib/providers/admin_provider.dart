import 'dart:core';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/services/http/firebase.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider(this.firebase, this.cap, this.algolia);
  final FirebaseApi firebase;
  final CrashAnalyticsProvider cap;
  final Algolia? algolia;

  Future<List<String>> query(String value) async {
    final i = algolia?.index('prod_topics');
    final o = await i?.query('$value').getObjects();
    if (o == null) return [];
    return o.hits
        .map((e) => e.data['objectID'] as String)
        .toList()
        .reversed
        .toList();
  }

  Future<List<String>> getTopics() async =>
      (await firebase.firestore!.collection('topics').get())
          .docs
          .map((e) => e.id)
          .toList();

  Future<List<lg.Prompt>> getPrompts() async => (await firebase.firestore!
          .collection('prompts')
          .withConverter<lg.Prompt>(
            fromFirestore: (s, _) => PromptExt.fromObject(s.data()!),
            toFirestore: (s, _) => s.toMapStringDynamic(),
          )
          .get())
      .docs
      .map((e) => e.data())
      .toList();

  Future<List<DocumentSnapshot<lg.Meme>>?> generate(String topic,
      {String? prompt, int? amount}) async {
    try {
      var data = <String, dynamic>{
        'topic': topic,
      };
      if (prompt != null) data['promptType'] = prompt;
      if (amount != null) data['amount'] = amount;
      var res = await firebase.functions!
          .httpsCallable(
            'createMemes',
            options: HttpsCallableOptions(
              timeout: Duration(seconds: 100 * (amount ?? 1)),
            ),
          )
          .call(data);

      List<String> memesId =
          res.data['memesId'].map<String>((e) => e as String).toList();
      await Future.delayed(Duration(seconds: 10));
      // TODO: wait its classified
      return Future.wait(memesId.map((e) => firebase.firestore!
          .collection('memes')
          .withConverter<lg.Meme>(
            fromFirestore: (s, _) => MemeExt.fromObject(s.data()!),
            toFirestore: (s, _) => s.toMapStringDynamic(),
          )
          .doc(e)
          .get()));
    } catch (e, s) {
      cap.log('Error generating memes: $e $s');
      cap.recordError(e, s);
      return null;
    }
  }

  Future<bool> delete(List<String> memesId) async {
    try {
      await Future.wait(memesId
          .map((e) => firebase.firestore!.collection('memes').doc(e).delete()));
      return true;
    } catch (e, s) {
      cap.log('failed to delete $memesId $e $s');
      cap.recordError(e, s);
      return false;
    }
  }

  Future<bool> confirm(
      String memeId, String content, List<String> topics) async {
    // TODO: transaction?
    try {
      firebase.firestore!.collection('memes').doc(memeId).update({
        'disabled': false,
        'content': content,
        'topics': topics,
      });
      cap.log('confirmed $memeId');
      return true;
    } catch (e, s) {
      cap.log('failed to confirm $memeId $e $s');
      cap.recordError(e, s);
      return false;
    }
  }
}
