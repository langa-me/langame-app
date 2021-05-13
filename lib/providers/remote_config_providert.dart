import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:langame/providers/crash_analytics_provider.dart';

class RemoteConfigProvider extends ChangeNotifier {
  RemoteConfigProvider(this._cap, this._remoteConfig) {
    _remoteConfig.fetchAndActivate().then((updated) {
      if (updated) {
        // the config has been updated, new parameter values are available.
        // notifyListeners();
      } else {
        // the config values were previously updated.
      }
    });
  }
  // ignore: unused_field
  final CrashAnalyticsProvider _cap;
  final RemoteConfig _remoteConfig;

  String get pubNubSubscribeKey =>
      _remoteConfig.getString('pub_nub_subscribe_key');
  String get pubNubPublishKey => _remoteConfig.getString('pub_nub_publish_key');
}
