import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseApi {
  final FirebaseMessaging? messaging;
  final FirebaseFirestore? firestore;
  final FirebaseAuth? auth;
  final FirebaseFunctions? functions;
  final GoogleSignIn? googleSignIn;
  final FirebaseCrashlytics? crashlytics;
  final FirebaseAnalytics? analytics;
  final FirebaseStorage? storage;
  final RemoteConfig? remoteConfig;
  final bool useEmulator;
  FirebaseApi(
      {this.messaging,
      this.firestore,
      this.auth,
      this.functions,
      this.googleSignIn,
      this.crashlytics,
      this.analytics,
      this.storage,
      this.remoteConfig,
      this.useEmulator = false}) {
    if (!useEmulator) return;

    // Need to clear local cache otherwise would use non-emulator data
    firestore!.clearPersistence();
    auth!.currentUser?.delete();
    auth!.signOut();

    /// https://firebase.google.com/docs/emulator-suite
    /// Warning: change local IP accordingly i.e. `ip a`
    /// then from mobile `telnet IP PORT`
    const myIp = 'http://192.168.43.41';
    auth?.useEmulator('$myIp:9099');
    functions?.useFunctionsEmulator(origin: '$myIp:5001');
    firestore?.settings = Settings(
      host: '$myIp:8080',
      sslEnabled: false,
    );
  }
}
