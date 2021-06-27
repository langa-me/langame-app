import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CrashAnalyticsProvider extends ChangeNotifier {
  FirebaseCrashlytics? crashlytics;
  FirebaseAnalytics analytics;
  CrashAnalyticsProvider(this.crashlytics, this.analytics);

  void log(String message,
      {String? analyticsMessage, Map<String, Object?>? analyticsParameters}) {
    if (!kReleaseMode) debugPrint(message);
    crashlytics?.log(message);
    if (analyticsMessage != null)
      analytics.logEvent(
          name: analyticsMessage, parameters: analyticsParameters);
  }

  void logNewFeatureClick(String featureName) =>
      log('click on "$featureName"',
          analyticsMessage: 'new_feature_request',
          analyticsParameters: {'feature': featureName});

  void setCurrentScreen(String screenName) {
    analytics.setCurrentScreen(screenName: screenName);
    crashlytics?.setCustomKey('screenName', screenName);
  }

  void recordError(dynamic exception, StackTrace? stack) {
    crashlytics?.recordError(exception, stack, printDetails: !kReleaseMode);
  }
}
