import 'dart:async';

import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/services/http/firebase.dart';

/// Handle message listening, sending,
/// fetching from cloud storage, deleting from cloud storage
abstract class MessageApi {
  final FirebaseApi firebase;

  MessageApi(this.firebase);

  Future<LangameResponse> initializePermissions();

  /// Send a Langame message and return the message id retrievable in Firestore
  Future<String?> send(String recipient, String topic);

  /// Start listening to messages
  Future<void> listen(Function(LangameNotification) add);

  /// Stop listening to messages
  void cancel();

  /// Fetch a message
  Future<LangameNotification?> fetch(String id);
  Future<List<LangameNotification>?> fetchAll();
  Future<void> delete(String id);
}
