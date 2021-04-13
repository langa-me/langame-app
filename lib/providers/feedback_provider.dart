import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:feedback/feedback.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:package_info/package_info.dart';
import 'package:shake/shake.dart';
import 'package:uuid/uuid.dart';

class FeedbackProvider extends ChangeNotifier {
  FirebaseApi firebase;
  bool _detectShakes = true;

  FeedbackProvider(this.firebase);

  bool get detectShakes => _detectShakes;

  ShakeDetector? _detector;
  // TODO: store in local storage preference shake ...
  set detectShakes(value) {
    if (value) {
      _detector?.startListening();
    } else {
      _detector?.stopListening();
    }
    _detectShakes = value;
    notifyListeners();
  }

  initShake() {
    _detector = ShakeDetector.autoStart(
      shakeThresholdGravity: 2,
      onPhoneShake: () {
        firebase.analytics.logEvent(name: 'shake', parameters: {
          'user': firebase.auth.currentUser!.displayName,
        });
        show();
      },
    );
  }

  Null show({BuildContext? context, bool fromShaking = true}) {
    // TODO: isn't this hack dangerous?
    BetterFeedback.of(context ?? AppConst.navKey.currentContext!)!
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
            firebase.storage.ref('/feedbacks').child('$uid.png');

        final UploadTask uploadTask = storageReference.putData(
          feedbackScreenshot!,
          SettableMetadata(
            contentType: 'image/png',
            customMetadata: {
              'feedback': feedback,
              'uid': uid,
              'user': firebase.auth.currentUser!.displayName!,
              'deviceInfo': deviceInfo,
            },
          ),
        );
        uploadTask.catchError((e, s) => firebase.crashlytics.recordError(e, s));
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
              detectShakes = false;
              final snackBar = SnackBar(
                  content:
                      Text('Understood, you can enable it again in settings'));
              ScaffoldMessenger.of(AppConst.navKey.currentContext!)
                  .showSnackBar(snackBar);
            },
          ),
        );
      }
      ScaffoldMessenger.of(AppConst.navKey.currentContext!)
          .showSnackBar(snackBar);
    });
  }
}
