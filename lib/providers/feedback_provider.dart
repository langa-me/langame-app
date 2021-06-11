import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:feedback/feedback.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:package_info/package_info.dart';
import 'package:shake/shake.dart';
import 'package:uuid/uuid.dart';

import 'crash_analytics_provider.dart';

class FeedbackProvider extends ChangeNotifier {
  FirebaseApi firebase;
  final CrashAnalyticsProvider _cap;
  final ContextProvider _contextProvider;
  final PreferenceProvider _preferenceProvider;
  ShakeDetector? _detector;

  int _feedbackMemeRelevanceScore = 1;
  int _feedbackMemeGeneralScore = 1;
  List<bool> _feedbackMemeRelevanceSelected = [false, true, false];
  List<bool> _feedbackMemeGeneralScoreSelected = [false, true, false];

  int get feedbackMemeRelevanceScore => _feedbackMemeRelevanceScore;
  int get feedbackMemeGeneralScore => feedbackMemeGeneralScore;
  List<bool> get feedbackMemeRelevanceSelected =>
      _feedbackMemeRelevanceSelected;
  List<bool> get feedbackMemeGeneralScoreSelected =>
      _feedbackMemeGeneralScoreSelected;
  set feedbackMemeRelevanceScore(v) {
    _feedbackMemeRelevanceScore = v;
    _feedbackMemeRelevanceSelected = [false, false, false];
    _feedbackMemeRelevanceSelected[v] = true;
    notifyListeners();
  }

  set feedbackMemeGeneralScore(v) {
    _feedbackMemeGeneralScore = v;
    _feedbackMemeGeneralScoreSelected = [false, false, false];
    _feedbackMemeGeneralScoreSelected[v] = true;
    notifyListeners();
  }

  FeedbackProvider(this.firebase, this._cap, this._contextProvider,
      this._preferenceProvider) {
    // init();
  }

  disable() {
    // _detector?.stopListening();
  }

  init() {
    // _detector = ShakeDetector.waitForStart(
    //   shakeThresholdGravity: 2,
    //   onPhoneShake: () {
    //     _crashAnalyticsProvider.log(
    //       'shake detector activated',
    //       analyticsMessage: 'shake',
    //     );
    //     show();
    //   },
    // );
    // onPreferenceChange();
  }

  onPreferenceChange() {
    // if (_preferenceProvider.preference.shakeToFeedback) {
    //   _detector?.startListening();
    // } else {
    //   _detector?.stopListening();
    // }
    // _crashAnalyticsProvider.log(
    //     'shake detector ${_preferenceProvider.preference.shakeToFeedback}',
    //     analyticsMessage: 'shake_enable',
    //     analyticsParameters: {
    //       'value': _preferenceProvider.preference.shakeToFeedback,
    //     });
  }

  Null show({bool fromShaking = true}) {
    // TODO: isn't this hack dangerous?
    BetterFeedback.of(_contextProvider.navigationKey.currentContext!)!
        .show((feedback, feedbackScreenshot) async {
      final String uid = Uuid().v4();
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      var packageInfoAsMap = {
        'version': packageInfo.version,
        'appName': packageInfo.appName,
        'buildNumber': packageInfo.buildNumber,
        'packageName': packageInfo.packageName
      };
      final upload = (String deviceInfo) {
        final Reference storageReference =
            firebase.storage!.ref('/feedbacks').child('$uid.png');

        final UploadTask uploadTask = storageReference.putData(
          feedbackScreenshot!,
          SettableMetadata(
            contentType: 'image/png',
            customMetadata: {
              'feedback': feedback,
              'uid': uid,
              'user': firebase.auth!.currentUser!.displayName!,
              'deviceInfo': deviceInfo,
            },
          ),
        );
        uploadTask.catchError((e, s) => _cap.recordError(e, s));
      };
      if (Platform.isAndroid) {
        // TODO: maybe wrap this device info stuff into helper
        deviceInfo.androidInfo.then((value) {
          upload(jsonEncode({
            'packageInfo': packageInfoAsMap,
            'version': {
              'baseOS': value.version.baseOS,
              'sdkInt': value.version.sdkInt,
              'release': value.version.release,
            },
            'brand': value.brand,
            'device': value.device,
            'model': value.model,
          }));
        });
      } else if (Platform.isIOS) {
        deviceInfo.iosInfo.then((value) {
          upload(jsonEncode({
            'packageInfo': packageInfoAsMap,
            'systemVersion': value.systemVersion,
            'name': value.name,
            'systemName': value.systemName,
            'model': value.model,
          }));
        });
      }
      var snackBar = SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Thank you!'),
      );
      if (fromShaking) {
        snackBar = SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Thank you!'),
          action: SnackBarAction(
            label: 'Disable shaking',
            onPressed: () {
              _preferenceProvider.setShakeToFeedback(false);
              final snackBar = SnackBar(
                  content:
                      Text('Understood, you can enable it again in settings'));
              ScaffoldMessenger.of(
                      _contextProvider.navigationKey.currentContext!)
                  .showSnackBar(snackBar);
            },
          ),
        );
      }
      ScaffoldMessenger.of(_contextProvider.navigationKey.currentContext!)
          .showSnackBar(snackBar);
    });
  }

  Future<LangameResponse<void>> sendMemeFeedback(String memeId) async {
    try {
      final tags = firebase.firestore!
          .collection(AppConst.firestoreMemesCollection)
          .doc(memeId)
          .collection(AppConst.firestoreTagsSubCollection)
          .withConverter<lg.Tag>(
            fromFirestore: (s, _) => TagExt.fromObject(s.data()!),
            toFirestore: (e, _) => e.toMapStringDynamic(),
          );
      final selfTagsSnap = await tags
          .where('feedback.userId', isEqualTo: firebase.auth!.currentUser!.uid)
          .get();
      if (selfTagsSnap.docs.isEmpty) {
        await Future.wait([
          tags.add(
            lg.Tag(
              feedback: lg.Tag_Feedback(
                  relevance: lg.Tag_Feedback_Relevance(
                      score: _feedbackMemeRelevanceScore),
                  userId: firebase.auth!.currentUser!.uid),
            ),
          ),
          tags.add(
            lg.Tag(
              feedback: lg.Tag_Feedback(
                  general:
                      lg.Tag_Feedback_General(score: _feedbackMemeGeneralScore),
                  userId: firebase.auth!.currentUser!.uid),
            ),
          ),
        ]);
      } else {
        await Future.wait(selfTagsSnap.docs.map((e) {
          if (e.data().feedback.hasRelevance()) {
            return e.reference.set(
                lg.Tag(
                  feedback: lg.Tag_Feedback(
                    relevance: lg.Tag_Feedback_Relevance(
                        score: _feedbackMemeRelevanceScore),
                  ),
                ),
                SetOptions(merge: true));
          } else if (e.data().feedback.hasGeneral()) {
            return e.reference.set(
                lg.Tag(
                  feedback: lg.Tag_Feedback(
                    general: lg.Tag_Feedback_General(
                        score: _feedbackMemeGeneralScore),
                  ),
                ),
                SetOptions(merge: true));
          }
          return Future.delayed(Duration.zero);
        }));
      }
      _cap.log('sendMemeFeedback $memeId');
    } catch (e, s) {
      _cap.log('failed to sendMemeFeedback $memeId');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }
}
