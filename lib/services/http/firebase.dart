import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseApi {
  final FirebaseMessaging messaging;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseFunctions functions;
  final GoogleSignIn googleSignIn;
  final bool useEmulator;
  FirebaseApi(this.messaging, this.firestore, this.auth, this.functions,
      this.googleSignIn,
      {this.useEmulator = false}) {
    if (!useEmulator) return;

    /// https://firebase.google.com/docs/emulator-suite
    /// Warning: change local IP accordingly i.e. `ip a`
    /// then from mobile `telnet IP PORT`
    auth.useEmulator('http://192.168.1.102:9099');
    functions.useFunctionsEmulator(origin: 'http://192.168.1.102:5001');
    firestore.settings = Settings(
      host: '192.168.1.102:8080',
      sslEnabled: false,
    );
  }
}
