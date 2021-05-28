import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/services/http/firebase.dart';

/// Handle message listening, sending,
/// fetching from firestore, deleting from firestore
abstract class MessageApi {
  final FirebaseApi firebase;

  final void Function(dynamic) onBackgroundOrForegroundOpened;

  MessageApi(this.firebase, this.onBackgroundOrForegroundOpened);

  /// Initialize permissions (required only on iOS) and some asynchronous
  /// configuration for notifications...
  Future<LangameResponse> initializePermissions();

  /// Start listening to messages
  Future<void> listen(void Function(dynamic)? add);

  /// Overlay on top of FirebaseMessaging.getInitialMessage that get
  Future<dynamic> getInitialMessage();

  /// Stop listening to messages
  void cancel();
}
