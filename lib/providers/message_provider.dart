import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:langame/models/djinn/djinn.pbgrpc.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/grpc_interceptors.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/message_api.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:universal_platform/universal_platform.dart';
import 'authentication_provider.dart';
import 'langame_provider.dart';

class MessageProvider extends ChangeNotifier {
  FirebaseApi firebase;
  CrashAnalyticsProvider _cap;
  // ignore: unused_field
  AuthenticationProvider _ap;
  LangameProvider _lp;
  ContextProvider _cp;
  bool _isReady = false;
  bool get isReady => _isReady;

  String? _conversationApiUrl;
  ClientChannelBase? _conversationMagnifierChannel;
  ConversationMagnifierClient? _conversationMagnifierClient;
  Stream<MagnificationResponse>? _conversationMagnifierStream;
  int _conversationMagnifierFailCount = 0;

  /// Messages, notifications ///
  ///

  MessageApi _messageApi;

  /// Create an authentication provider, and
  MessageProvider(
      this.firebase, this._messageApi, this._cap, this._ap, this._cp, this._lp,
      {bool isLocalConversationApi = false}) {
    _ap.userStream.listen((e) async {
      if (e.type == UserChangeType.NewAuthentication) {
        await _messageApi.cancel();
        try {
          await _messageApi.initializePermissions();
          await _messageApi.listen(null);
        } catch (e, s) {
          _cap.log(
              'message_provider initializePermissions failed to initialize permissions');
          _cap.recordError(e, s);
        }
        _isReady = true;
        notifyListeners();
        _cap.log('message_provider:initialize');
        _messageApi.getInitialMessage().then((e) async {}).catchError((e, s) {
          _cap.log('message_provider:failed to get initial messages');
          _cap.recordError(e, s);
        });

        // initializateConversationApi(local: isLocalConversationApi);
      } else if (e.type == UserChangeType.Disconnection) {
        _messageApi.cancel();
        terminateConversationClient();
      }
    });
  }

  void terminateConversationClient() {
    _conversationMagnifierChannel?.shutdown();
    _conversationMagnifierChannel = null;
    _conversationMagnifierClient = null;
    _conversationApiUrl = null;
    _conversationMagnifierStream = null;
    _conversationMagnifierFailCount = 0;
  }

  void initializateConversationApi({bool local = false}) async {
    if (UniversalPlatform.isWeb) return;

    final token = await firebase.auth!.currentUser!.getIdToken(true);
    _conversationApiUrl =
        // TODO: ip???
        local
            ? '192.168.43.41'
            : (await firebase.firestore!
                    .collection('apis')
                    .doc('sentiment')
                    .get())
                .data()!['url'];
    final channelOptions = ChannelOptions(
        backoffStrategy: (d) => d ?? Duration(seconds: 1) * 2,
        credentials: local
            ? ChannelCredentials.insecure()
            : ChannelCredentials.secure());
    _conversationMagnifierChannel = ClientChannel(
      _conversationApiUrl!,
      options: channelOptions,
      port: local ? 8080 : 443,
    );

    _conversationMagnifierClient = ConversationMagnifierClient(
      _conversationMagnifierChannel!,
      options: CallOptions(
        timeout: Duration(seconds: 30),
      ),
      interceptors: [
        ClientFirebaseAuthInterceptor(token),
      ],
    );

    _cap.log(
        'message_provider:conversation api initialized with url ${_conversationApiUrl}');
  }

  Future<LangameResponse<void>> cancel() async {
    try {
      await _messageApi.cancel();
      _cap.log('message_provider:cancel');
      _isReady = false;
      notifyListeners();
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('message_provider:failed to cancel');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> sendMessage(
      String langameId, String message) async {
    try {
      _cap.log('message_provider:send message to channel $langameId');
      final data = {
        'body': message,
        'type': lg.Message_Type.MESSAGE.value,
        'createdAt': FieldValue.serverTimestamp(),
        'author': lg.Langame_Player(
          id: _ap.user!.uid,
          tag: _ap.user!.tag,
          photoUrl: _ap.user!.photoUrl,
          bot: _ap.user!.bot,
          email: _ap.user!.email,
        ).toMapStringDynamic(),
        'langameId': langameId,
      };
      firebase.firestore!.collection('messages').add(data);
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('message_provider:failed to send message');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  // Call the sentiment api to get the sentiment of the message
  Future<MagnificationResponse?> getSentiment(String text) async {
    if (UniversalPlatform.isWeb) return null;

    if (_conversationMagnifierClient == null) return null;
    try {
      if (_conversationMagnifierStream != null) {
        // Wait for first value
        await for (MagnificationResponse value
            in _conversationMagnifierStream!) {
          return value;
        }
        // Will throw and stop everything on exception
      }
      _conversationMagnifierStream = _conversationMagnifierClient!
          .magnify(Stream.value(MagnificationRequest(text: text)))
          .asBroadcastStream();
    } catch (e, s) {
      _cap.log('message_provider:failed to get sentiment');
      _conversationMagnifierFailCount++;
      if (_conversationMagnifierFailCount > 5) {
        terminateConversationClient();
        _cap.recordError(e, s);
      }
      return null;
    }
  }
}
