
import '../firebase.dart';

abstract class AlgoliaClient {
  FirebaseApi firebase;

  AlgoliaClient(this.firebase);

  Future<void> pushEvents(String eventType, String eventName, String index);
}
