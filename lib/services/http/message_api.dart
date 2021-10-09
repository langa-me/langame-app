import 'dart:async';

import 'package:langame/services/http/firebase.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

/// Handle message listening, sending,
/// fetching from firestore, deleting from firestore
abstract class MessageApi {
  final FirebaseApi firebase;

  final void Function(lg.Message) onBackgroundOrForegroundOpened;

  MessageApi(this.firebase, this.onBackgroundOrForegroundOpened);

  /// Initialize permissions (required only on iOS) and some asynchronous
  /// configuration for notifications...
  Future<void> initializePermissions();

  /// Start listening to messages
  Future<void> listen(void Function(lg.Message)? add);

  /// Overlay on top of FirebaseMessaging.getInitialMessage that get
  Future<lg.Message?> getInitialMessage();

  /// Stop listening to messages
  Future<void> cancel();
}
