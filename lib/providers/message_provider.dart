import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/message_api.dart';
import 'package:langame/views/langames/langame_audio.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/views/langames/langame_text.dart';
import 'package:sortedmap/sortedmap.dart';

import 'authentication_provider.dart';

class MessageProvider extends ChangeNotifier {
  FirebaseApi firebase;
  CrashAnalyticsProvider _cap;
  // ignore: unused_field
  AuthenticationProvider _ap;
  ContextProvider _cp;
  bool _isReady = false;
  bool get isReady => _isReady;

  /// Messages, notifications ///
  ///

  StreamController<lg.Message> _messageStream = StreamController<lg.Message>();
  Map<String, SortedMap<int, lg.Message>> _messages = {};
  Map<String, SortedMap<int, lg.Message>> get messages => _messages;

  MessageApi _messageApi;

  /// Create an authentication provider, and
  MessageProvider(
      this.firebase, this._messageApi, this._cap, this._ap, this._cp) {
    _ap.userStream.listen((e) async {
      if (e.type == UserChangeType.NewAuthentication) {
        await _messageApi.cancel();
        await _messageApi.initializePermissions();
        await _messageApi.listen(null);
        _isReady = true;
        notifyListeners();
        _cap.log('message_provider:initialize');
        _messageApi.getInitialMessage().then((e) async {
          // Leave some time for UI
          await Future.delayed(Duration(seconds: 1));
          // Note that we ignore failures in dynamic link initialization
          if (e != null &&
              e.channelName.isNotEmpty &&
              e.type == lg.Message_Type.INVITE) {
            _cp.pushReplacement(LangameAudioView(e.channelName, false));
          } else if (e != null &&
              e.channelName.isNotEmpty &&
              e.type == lg.Message_Type.MESSAGE) {
            // On opening text notification, go to text view
            _cp.pushReplacement(LangameTextView(e.channelName));
          }
        }).catchError((e, s) {
          _cap.log('message_provider:failed to get initial messages');
          _cap.recordError(e, s);
        });
        var subs = [
          firebase.firestore!
              .collection('messages')
              .where('fromUid', isEqualTo: _ap.user!.uid)
              // .orderBy('createdAt', descending: false)
              .withConverter<lg.Message>(
                fromFirestore: (s, _) => MessageExt.fromObject(s.data()!),
                toFirestore: (e, _) => e.toMapStringDynamic(),
              )
              .snapshots()
              .listen((e) {
            e.docs.forEach((b) => _messageStream.add(b.data()));
          }),
          firebase.firestore!
              .collection('messages')
              .where('toUid', isEqualTo: _ap.user!.uid)
              // .orderBy('createdAt', descending: false)
              .withConverter<lg.Message>(
                fromFirestore: (s, _) => MessageExt.fromObject(s.data()!),
                toFirestore: (e, _) => e.toMapStringDynamic(),
              )
              .snapshots()
              .listen((e) {
            e.docs.forEach((b) => _messageStream.add(b.data()));
          }),
          _messageStream.stream
              // .distinct((a, b) => a.createdAt.nanos != b.createdAt.nanos)
              .listen((e) {
            // Somehow
            if (!e.hasCreatedAt()) return;

            if (_messages[e.channelName] == null) {
              _messages[e.channelName] = SortedMap(Ordering.byKey());
            }
            final key = e.createdAt.toDateTime().millisecondsSinceEpoch;
            final exists = _messages.containsKey(key);
            _messages[e.channelName]!.addAll({key: e});
            if (exists) return;
            _cap.log('message_provider: received message ${e.body}');
            notifyListeners();
          })
        ];
        _messageStream.onCancel = () => subs.forEach((e) => e.cancel());
      } else if (e.type == UserChangeType.Disconnection) {
        _messageApi.cancel();
        _messageStream.close();
      }
    });
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
      String channelName, String message, String to) async {
    try {
      _cap.log('message_provider:send message to channel $channelName');
      final data = {
        'body': message,
        'type': lg.Message_Type.MESSAGE.value,
        'createdAt': FieldValue.serverTimestamp(),
        'fromUid': firebase.auth!.currentUser!.uid,
        'toUid': to,
        'channelName': channelName,
      };
      firebase.firestore!.collection('messages').add(data);
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('message_provider:failed to send message');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
