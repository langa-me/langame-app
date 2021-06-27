import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/views/langame.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DynamicLinksProvider extends ChangeNotifier {
  final CrashAnalyticsProvider _cap;
  final ContextProvider _cp;
  final FirebaseDynamicLinks? _dynamicLinks;
  bool? _isDev;

  DynamicLinksProvider(
      this._cap, this._cp, this._dynamicLinks) {
    PackageInfo.fromPlatform() // TODO: move to smthing global
        .then((e) => _isDev = e.packageName.contains('dev'));
  }

  String getChannelNameFromLink(String link) {
    final sp = link.split('/');
    return sp[sp.length > 4 ? 4 : 3];
  }

  String getBasePath() => _isDev != null && !_isDev!
      ? 'https://langa.me/join'
      : 'https://langamedev.page.link';

  Future<LangameResponse<String>> createDynamicLink(
    String path,
    bool short,
  ) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final isDev = packageInfo.packageName.contains('dev');
      final basePath = Uri.encodeFull(
          !isDev ? 'https://langa.me/join' : 'https://langamedev.page.link');
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: basePath,
        link: Uri.parse(basePath + Uri.encodeFull('/$path')),
        androidParameters: AndroidParameters(
          packageName: packageInfo.packageName.contains('dev')
              ? 'me.langa.dev'
              : 'me.langa',
          // minimumVersion: int.parse(packageInfo.buildNumber),
        ),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
        ),
        iosParameters: IosParameters(
          bundleId: packageInfo.packageName.contains('dev')
              ? 'me.langa.dev'
              : 'me.langa.prod',
          // minimumVersion: packageInfo.buildNumber,
          appStoreId: '1564745604',
        ),
        // socialMetaTagParameters: SocialMetaTagParameters(
        //   title: 'A link to a Langame',
        //   description: 'Open this link to join the Langame',
        // ),
      );

      Uri url;
      if (short) {
        final ShortDynamicLink shortLink = await parameters.buildShortLink();
        url = shortLink.shortUrl;
      } else {
        url = await parameters.buildUrl();
      }
      _cap.log('created dynamic link ${url.toString()}');

      return LangameResponse(LangameStatus.succeed, result: url.toString());
    } catch (e, s) {
      _cap.log('failed to createDynamicLink');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> setupAndCheckDynamicLinks() async {
    try {
      _dynamicLinks?.onLink(
          onSuccess: _onSuccess,
          onError: (OnLinkErrorException e) async {
            _cap.log('onLinkError $e');
            _cap.recordError(e, null);
          });

      if (_dynamicLinks != null)
        _onSuccess(await _dynamicLinks!.getInitialLink()).then((_) => _cap.log(
            'opened initial langame link',
            analyticsMessage: 'dynamic_links_open_initial'));
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to setupAndCheckDynamicLinks');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<dynamic> _onSuccess(dl) async {
    _cap.log('opened link ${dl?.link.path}',
        analyticsMessage: 'dynamic_links_open');
    if (dl != null && dl.link.path.split('/').length > 0) {
      final sp = dl.link.path.split('/');
      final String channel = sp[sp.length > 2 ? 2 : 1];
      _cap.log('opening view $channel');

      // Opened a Langame link that opened the app
      // i.e. https://DOMAIN/CHANNEL_NAME
      // path starts with "/" thats why the substring
      _cp.pushReplacement(LangameView(channel, false));
    }
  }
}
