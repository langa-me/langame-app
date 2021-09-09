import 'dart:core';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/future.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecordingProvider extends ChangeNotifier {
  RecordingProvider(this.firebase, this.cap, this.ap, this.algolia) {
    ap.userStream.listen((e) {
      if (e.type == UserChangeType.NewAuthentication) {
        firebase.firestore!
            .collection('recordings')
            .where('userId', isEqualTo: e.after!.uid)
            .withConverter<lg.Recording>(
              fromFirestore: (s, _) => RecordingExt.fromObject(s.data()!),
              toFirestore: (e, _) => e.toMapStringDynamic(),
            )
            .snapshots()
            .listen((e) {
          _recordings = e;
        });
        cap.log('recording_provider: listening for snapshots');
      } else if (e.type == UserChangeType.Disconnection) {
        _recordings = null;
      }
    });
  }
  final FirebaseApi firebase;
  final CrashAnalyticsProvider cap;
  final AuthenticationProvider ap;
  final Algolia? algolia;
  stt.SpeechToText _speech = stt.SpeechToText();
  String _textRecorded = '';
  bool _gotFinalResult = false;

  QuerySnapshot<lg.Recording>? _recordings;

  QuerySnapshot<lg.Recording>? get recordings => _recordings;

  Future<LangameResponse<void>> start() async {
    try {
      _textRecorded = '';
      bool available = await _speech.initialize(onStatus: (e) {
        cap.log('stt status: ' + e,
            analyticsMessage: 'stt_status',
            analyticsParameters: {
              'status': e,
            });
      }, onError: (e) {
        print('stt error: ' + e.toString());
      });
      if (available) {
        _speech.listen(onResult: (e) {
          print(e.toJson());
          if (e.finalResult) {
            _textRecorded = e.recognizedWords;
            _gotFinalResult = true;
          }
        });
      } else {
        cap.log(
          "The user has denied the use of speech recognition.",
          analyticsMessage: 'stt_permission_denied',
        );
        return LangameResponse(LangameStatus.cancelled);
      }
      cap.log('start recording');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      cap.log('failed to start recording');
      cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }

  /// Stops recording and save the text recorded to Firestore.
  /// Optionally can give metadata (such as topic...) to the recording.
  Future<LangameResponse<bool>> stop({Map<dynamic, dynamic>? metadata}) async {
    try {
      await _speech.stop();
      await waitUntil(() => _gotFinalResult, maxIterations: 200);
      _gotFinalResult = false;
      if (_textRecorded == '') {
        cap.log('stopped recording, empty text, not saving');
        return LangameResponse(LangameStatus.succeed);
      }
      var d = {
        'createdAt': FieldValue.serverTimestamp(),
        'text': _textRecorded,
        'userId': firebase.auth!.currentUser!.uid,
        'metadata': metadata,
      };
      var doc = await firebase.firestore!.collection('recordings').add(d);
      cap.log('stopped recording, doc: ' + doc.id);
      _textRecorded = '';
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      cap.log('failed to stop recording');
      cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }

  Future<LangameResponse<bool>> updateNote(String recordingId, String note) async {
    try {
      await firebase.firestore!.collection('recordings').doc(recordingId).update({
        'note': note,
      });
      cap.log('updated note to recording ' + recordingId);
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      cap.log('failed to add note to recording');
      cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }
}
