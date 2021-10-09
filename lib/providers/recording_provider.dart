import 'dart:core';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/future.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';

class RecordingProvider extends ChangeNotifier {
  RecordingProvider(this.firebase, this.cap, this.ap, this.pp, this.algolia) {
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
          // No clue why need 2 notifyListeners, but works
          notifyListeners();
          _recordings = e;
          _recordingsSorted = e.docs.map((e) => e.data()).toList();
          _recordingsSorted!.sort(
              (a, b) => b.createdAt.seconds.compareTo(a.createdAt.seconds));
          notifyListeners();
        });
        cap.log('recording_provider: listening for snapshots');
      } else if (e.type == UserChangeType.Disconnection) {
        _recordings = null;
        _recordingsSorted = null;
        notifyListeners();
      }
    });
  }
  final FirebaseApi firebase;
  final CrashAnalyticsProvider cap;
  final AuthenticationProvider ap;
  final PreferenceProvider pp;
  Algolia? algolia;
  stt.SpeechToText _speech = stt.SpeechToText();
  String _textRecorded = '';

  QuerySnapshot<lg.Recording>? _recordings;
  QuerySnapshot<lg.Recording>? get recordings => _recordings;
  List<lg.Recording>? _recordingsSorted;
  List<lg.Recording>? get recordingsSorted => _recordingsSorted;

  List<LocaleName> _locales = [];
  List<LocaleName> get locales => _locales;
  String get selectedSpeechToTextLocaleId => pp.preference!.speechToTextLocale;
  void set selectedSpeechToTextLocaleId(String id) {
    pp.preference!.speechToTextLocale = id;
    notifyListeners();
  }

  Future<bool> _init() => _speech.initialize(onStatus: (e) {
        cap.log('recording_provider: stt status: ' + e,
            analyticsMessage: 'stt_status',
            analyticsParameters: {
              'status': e,
            });
      }, onError: (e) {
        cap.log('recording_provider: stt error: ' + e.toString());
      });

  Future<LangameResponse<void>> getLocales() async {
    try {
      cap.log('recording_provider: start getLocales');

      bool available = await _init();
      if (available) {
        _locales = await _speech.locales();
        notifyListeners();
        return LangameResponse.succeed();
      } else {
        cap.log(
          "recording_provider: The user has denied the use of speech recognition.",
          analyticsMessage: 'stt_permission_denied',
        );
        return LangameResponse.cancelled();
      }
    } catch (e, s) {
      cap.log('recording_provider: failed to getLocales');
      cap.recordError(e, s);
      return LangameResponse.failed();
    }
  }

  Future<LangameResponse<void>> start() async {
    try {
      _textRecorded = '';
      bool available = await _init();
      if (available) {
        _speech.listen(
            localeId: pp.preference!.hasSpeechToTextLocale()
                ? pp.preference!.speechToTextLocale
                : null,
            onResult: (e) {
              if (e.finalResult) {
                _textRecorded = e.recognizedWords;
                print(e);
              }
            });
      } else {
        cap.log(
          "recording_provider: The user has denied the use of speech recognition.",
          analyticsMessage: 'stt_permission_denied',
        );
        return LangameResponse(LangameStatus.cancelled);
      }
      cap.log('recording_provider: start recording');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      cap.log('recording_provider: failed to start recording');
      cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }

  /// Stops recording and save the text recorded to Firestore.
  /// Optionally can give metadata (such as topic...) to the recording.
  Future<LangameResponse<String>> stop(
      {Map<dynamic, dynamic>? metadata}) async {
    try {
      await _speech.stop();
      await waitUntil(() => _textRecorded != '', maxIterations: 500);
      var d = {
        'createdAt': FieldValue.serverTimestamp(),
        'text': _textRecorded,
        'userId': firebase.auth!.currentUser!.uid,
        'metadata': metadata,
      };
      var doc = await firebase.firestore!.collection('recordings').add(d);
      cap.log('stopped recording, doc: ' + doc.id);
      var t = _textRecorded;
      _textRecorded = '';
      return LangameResponse(LangameStatus.succeed, result: t);
    } catch (e, s) {
      cap.log('failed to stop recording');
      cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, result: '');
    }
  }

  Future<LangameResponse<bool>> updateNote(
      String recordingId, String note) async {
    try {
      await firebase.firestore!
          .collection('recordings')
          .doc(recordingId)
          .update({
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

  Future<LangameResponse<bool>> deleteRecording(String recordingId) async {
    try {
      await firebase.firestore!
          .collection('recordings')
          .doc(recordingId)
          .delete();
      cap.log('deleted recording ' + recordingId);
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      cap.log('failed to delete recording');
      cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }
}
