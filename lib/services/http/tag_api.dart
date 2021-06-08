import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import 'firebase.dart';

abstract class TagApi {
  final FirebaseApi firebase;

  TagApi(this.firebase);

  Stream<QuerySnapshot<lg.Tag>> streamTopics();
}
