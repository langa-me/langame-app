import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashAnalyticsProvider extends ChangeNotifier {
  FirebaseCrashlytics crashlytics;
  FirebaseAnalytics analytics;
  CrashAnalyticsProvider(this.crashlytics, this.analytics);

  log(String message,
      {String? analyticsMessage, Map<String, Object?>? analyticsParameters}) {
    debugPrint(message);
    crashlytics.log(message);
    if (analyticsMessage != null)
      analytics.logEvent(
          name: analyticsMessage, parameters: analyticsParameters);
  }
}
