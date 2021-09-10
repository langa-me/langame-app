import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:feedback/feedback.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shake/shake.dart';
import 'package:universal_platform/universal_platform.dart';
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

  int _hack = 0;

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
        if (_hack > 10) {
          // Prevent spamming storage
          // TODO:https://stackoverflow.com/questions/40513101/setting-limits-on-file-uploads-via-firebase-auth-and-storage-without-server-in-t/61151267#61151267
          return;
        }
        _hack++;
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
      if (UniversalPlatform.isAndroid) {
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
      } else if (UniversalPlatform.isIOS) {
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

  Future<LangameResponse<void>> sendMemeLike(String memeId, bool like) async {
    try {
      await firebase.firestore!
          .collection('feedbacks')
          .doc(firebase.auth!.currentUser!.uid)
          .set(like
              ? {
                  'likes': FieldValue.arrayUnion([memeId]),
                  'dislikes': FieldValue.arrayRemove([memeId]),
                }
              : {
                  'dislikes': FieldValue.arrayUnion([memeId]),
                  'likes': FieldValue.arrayRemove([memeId]),
                }, SetOptions(merge: true));
      // await firebase.firestore!
      //     .collection("memes")
      //     .doc(memeId)
      //     .update({'userFeedback': FieldValue.increment(like ? 1 : -1)});
      _cap.log('sendMemeLike $memeId $like');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to sendMemeLike $memeId');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }
}
