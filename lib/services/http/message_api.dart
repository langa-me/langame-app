import 'dart:async';

import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/services/http/firebase.dart';

/// Handle message listening, sending,
/// fetching from firestore, deleting from firestore
abstract class MessageApi {
  final FirebaseApi firebase;
  final void Function(LangameNotification) onBackgroundOrForegroundOpened;

  MessageApi(this.firebase, this.onBackgroundOrForegroundOpened);

  /// Initialize permissions (required only on iOS) and some asynchronous
  /// configuration for notifications...
  Future<LangameResponse> initializePermissions();

  /// Send a Langame message and return the message id retrievable in Firestore
  Future<String?> send(String recipient, String topic);

  /// Response to a Langame message to say "I am ready and waiting"
  /// Also send the Langame question along
  Future<String?> sendReadyForLangame(
      String recipient, String topic, String question);

  /// Start listening to messages
  Future<void> listen(void Function(LangameNotification) add);

  /// Overlay on top of FirebaseMessaging.cgetInitialMessage that transform
  /// into a LangameNotification
  Future<LangameNotification?> getInitialMessage();

  /// Stop listening to messages
  void cancel();

  /// Fetch a message
  Future<LangameNotification?> fetch(String id);
  Future<List<LangameNotification>?> fetchAll();
  Future<void> delete(String id);
}
