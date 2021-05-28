import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:package_info/package_info.dart';

class DynamicLinksProvider extends ChangeNotifier {
  final CrashAnalyticsProvider _cap;
  final FirebaseDynamicLinks _dynamicLinks;

  DynamicLinksProvider(this._cap, this._dynamicLinks);

  Future<LangameResponse<String>> createDynamicLink(
    String path,
    bool short,
  ) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://langa.page.link',
        link: Uri.parse('https://langa.me/$path'),
        androidParameters: AndroidParameters(
          packageName: packageInfo.packageName,
          minimumVersion: int.parse(packageInfo.buildNumber), // TODO
        ),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
        ),
        iosParameters: IosParameters(
          bundleId: packageInfo.packageName,
          minimumVersion: packageInfo.buildNumber,
        ),
      );

      Uri url;
      if (short) {
        final ShortDynamicLink shortLink = await parameters.buildShortLink();
        url = shortLink.shortUrl;
      } else {
        url = await parameters.buildUrl();
      }
      return LangameResponse(LangameStatus.succeed, result: url.toString());
    } catch (e, s) {
      _cap.log('failed to shareLangameDynamicLink');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<String>> setupAndCheckDynamicLinks() async {
    try {
      _dynamicLinks.onLink(
          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri? deepLink = dynamicLink?.link;

        if (deepLink != null) {
          // ignore: unawaited_futures
          // TODO: handle link for each view?
          // i.e. "bob in langame, backgrounding app and clicking a link"?
        }
      }, onError: (OnLinkErrorException e) async {
        _cap.log('onLinkError $e');
        _cap.recordError(e, null);
      });

      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        // ignore: unawaited_futures
        return LangameResponse(LangameStatus.succeed, result: deepLink.path);
      }
    } catch (e, s) {
      _cap.log('failed to setupAndCheckDynamicLinks');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }
}
