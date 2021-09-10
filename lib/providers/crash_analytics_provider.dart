import 'package:algolia/algolia.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/services/http/firebase.dart';

class CrashAnalyticsProvider extends ChangeNotifier {
  FirebaseCrashlytics? crashlytics;
  FirebaseAnalytics analytics;
  Algolia? _algolia;
  RemoteConfig? _remoteConfig;
  FirebaseApi _firebase;
  CrashAnalyticsProvider(this.crashlytics, this.analytics, this._remoteConfig,
      this._firebase, this._algolia);

  void log(String message,
      {String? analyticsMessage, Map<String, Object?>? analyticsParameters}) {
    message = '[${AppConst.isDev ? 'DEV' : 'PROD'}] $message';
    if (!kReleaseMode) debugPrint(message);
    crashlytics?.log(message);
    if (analyticsMessage != null) {
      analytics.logEvent(
          name: analyticsMessage, parameters: analyticsParameters);
    }
  }

  void logNewFeatureClick(String featureName) {
    log('click on "$featureName"',
        analyticsMessage: 'new_feature_request',
        analyticsParameters: {'feature': featureName});
    // algolia?.pushEvents([
    //   AlgoliaEvent(
    //     eventType: AlgoliaEventType.click,
    //     eventName: 'feature_$featureName',
    //     index: AppConst.isDev ? 'dev_users' : 'prod_users',
    //     userToken: _firebase.auth!.currentUser!.uid,
    //   )
    // ]).catchError(recordError);
  }

  void setCurrentScreen(String screenName) {
    analytics.setCurrentScreen(screenName: screenName);
    crashlytics?.setCustomKey('screenName', screenName);
    // algolia?.pushEvents([
    //   AlgoliaEvent(
    //     eventType: AlgoliaEventType.view,
    //     eventName: screenName,
    //     index: AppConst.isDev ? 'dev_users' : 'prod_users',
    //     objectIDs: [_firebase.auth!.currentUser!.uid],
    //     userToken: _firebase.auth!.currentUser!.uid,
    //   )
    // ]).catchError(recordError);
  }

  void recordError(dynamic exception, StackTrace? stack) {
    crashlytics?.recordError(exception, stack, printDetails: !kReleaseMode);
  }

  void sendClickTopic(String topic) {
    // algolia?.pushEvents([
    //   AlgoliaEvent(
    //     eventType: AlgoliaEventType.click,
    //     eventName: topic,
    //     index: AppConst.isDev ? 'dev_users' : 'prod_users',
    //     userToken: _firebase.auth!.currentUser!.uid,
    //     objectIDs: [_firebase.auth!.currentUser!.uid],
    //   )
    // ]).catchError(recordError);
    analytics.logEvent(name: 'click_topic', parameters: {'topic': topic});
  }

  void sendUserInteraction(String uid) {
    // algolia?.pushEvents([
    //   AlgoliaEvent(
    //     eventType: AlgoliaEventType.click,
    //     eventName: 'user_interaction',
    //     objectIDs: [uid],
    //     index: AppConst.isDev ? 'dev_users' : 'prod_users',
    //     userToken: _firebase.auth!.currentUser!.uid,
    //   )
    // ]).catchError(recordError);
    analytics.logEvent(name: 'selected_user', parameters: {'uid': uid});
  }
}
