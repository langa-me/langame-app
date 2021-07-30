import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import '../firebase.dart';

abstract class AlgoliaClient {
  FirebaseApi firebase;

  AlgoliaClient(this.firebase);

  Future<void> pushEvents(String eventType, String eventName, String index);
}
