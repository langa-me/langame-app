import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/views/langame.dart';
import 'package:package_info/package_info.dart';

class DynamicLinksProvider extends ChangeNotifier {
  final CrashAnalyticsProvider _cap;
  final ContextProvider _cp;
  final FirebaseDynamicLinks _dynamicLinks;

  DynamicLinksProvider(this._cap, this._cp, this._dynamicLinks);

  Future<LangameResponse<String>> createDynamicLink(
    String path,
    bool short,
  ) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final basePath = Uri.encodeFull(!packageInfo.packageName.contains('dev')
          ? 'https://langa.me/join'
          : 'https://langamedev.page.link/join');
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: basePath,
        link: Uri.parse(basePath + Uri.encodeFull('/$path')),
        androidParameters: AndroidParameters(
          packageName: packageInfo.packageName.contains('dev') ?
          'me.langa.dev' :
          'me.langa',
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
      _dynamicLinks.onLink(
          onSuccess: _onSuccess,
          onError: (OnLinkErrorException e) async {
            _cap.log('onLinkError $e');
            _cap.recordError(e, null);
          });

      _onSuccess(await _dynamicLinks.getInitialLink()).then((_) => _cap.log(
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
    if (dl != null && dl.link.path.split('/').length > 1) {
      _cap.log('opening view ${dl.link.path.split('/')[2]}');
      // Opened a Langame link that opened the app
      // i.e. https://DOMAIN/CHANNEL_NAME
      // path starts with "/" thats why the substring
      _cp.pushReplacement(LangameView(dl.link.path.split('/')[2], false));
    }
  }
}
