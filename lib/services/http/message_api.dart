import 'dart:async';

import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/firebase.dart';

/// Handle message listening, sending,
/// fetching from firestore, deleting from firestore
abstract class MessageApi {
  final FirebaseApi firebase;

  final void Function(lg.Notification?) onBackgroundOrForegroundOpened;

  MessageApi(this.firebase, this.onBackgroundOrForegroundOpened);

  /// Initialize permissions (required only on iOS) and some asynchronous
  /// configuration for notifications...
  Future<LangameResponse> initializePermissions();

  /// Send a Langame message and return the message id retrievable in Firestore
  Future<String> send(List<String> recipients, List<String> topics);
  Future<void> sendLangameEnd(String channelName);

  /// Response to a Langame message to say "I am ready and waiting"
  Future<void> notifyPresence(String channelName);

  /// Start listening to messages
  Future<void> listen(void Function(lg.Notification?) add);

  /// Overlay on top of FirebaseMessaging.cgetInitialMessage that transform
  /// into a LangameNotification
  Future<lg.Notification?> getInitialMessage();

  /// Stop listening to messages
  void cancel();

  /// Fetch a message
  Future<lg.Notification?> fetch(String id);
  Future<List<lg.Notification>> fetchAll();
  Future<void> delete(String channelName);
}
