import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {
  @override
  Future<String> getToken({String? vapidKey}) async {
    return 'bar';
  }

  MockFirebaseMessaging() {
    // onMessageOpenedApp
    // onMessage.
    // FirebaseMessaging.onMessage.FirebaseMessaging.onBackgroundMessage.call();
  }
}
