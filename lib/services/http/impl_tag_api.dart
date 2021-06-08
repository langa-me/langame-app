import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/firebase.dart';

import 'tag_api.dart';

class ImplTagApi extends TagApi {
  ImplTagApi(FirebaseApi firebase) : super(firebase);

  @override
  Stream<QuerySnapshot<lg.Tag>> streamTopics() {
    return firebase.firestore!
        .collectionGroup(AppConst.firestoreTagsSubCollection)
        .where('topic.content', isNotEqualTo: '')
        .withConverter<lg.Tag>(
          fromFirestore: (s, _) => TagExt.fromObject(s.data()!),
          toFirestore: (s, _) => s.toMapStringDynamic(),
        )
        .snapshots();
  }
}
