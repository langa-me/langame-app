import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseApi {
  final FirebaseMessaging messaging;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseFunctions functions;
  final GoogleSignIn googleSignIn;
  final FirebaseCrashlytics crashlytics;
  final FirebaseAnalytics analytics;
  // final FirebaseRemoteConfig remoteConfig;
  final bool useEmulator;
  FirebaseApi(this.messaging, this.firestore, this.auth, this.functions,
      this.googleSignIn, this.crashlytics, this.analytics,
      {this.useEmulator = false}) {
    if (kDebugMode) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      // Pass all uncaught errors from the framework to Crashlytics.
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }

    if (!useEmulator) return;

    // Need to clear local cache otherwise would use non-emulator data
    // firestore.clearPersistence();

    /// https://firebase.google.com/docs/emulator-suite
    /// Warning: change local IP accordingly i.e. `ip a`
    /// then from mobile `telnet IP PORT`
    auth.useEmulator('http://192.168.1.19:9099');
    functions.useFunctionsEmulator(origin: 'http://192.168.1.19:5001');
    firestore.settings = Settings(
      host: '192.168.1.19:8080',
      sslEnabled: false,
    );
  }
}
