// It is not necessary to review or understand the code in this file in order
// to understand how to use the FlexColorScheme package demonstrated in
// the examples.

import 'package:flutter/material.dart';

/// Layout constants and strings used in the example application
class AppConst {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppConst._();

  // This info is mainly for the Live public web builds of the examples.
  // When I build a new public version I just make sure to update this info
  // before building them.
  static const String appName = 'Langame';
  static const String author = 'Louis Beaumont';

  // Whether to log debug settings events
  static const bool debugSettings = false;

  /// Define App ID and Token
  static const String agoraAppID = '04dbfdb7d4a349bf9b02758aabd97c78';

  static const String notifyPresenceFunction = 'notifyPresence';
  static const String createStripeSubscriptionFunction =
      'createStripeSubscription';

  static const String firestoreUsersCollection = 'users';
  static const String firestoreLangamesCollection = 'langames';
  static const String firestoreMemesCollection = 'memes';
  static const String firestoreTagsSubCollection = 'tags';
  static const String firestoreInteractionsCollection = 'interactions';
  static const String firestorePreferencesCollection = 'preferences';
  static const String firestoreStripeCustomersCollection = 'stripe_customers';
  static const String firestoreProductsCollection = 'products';

  static const String helpUrl = 'https://help.langa.me';
  static const String mainUrl = 'https://langa.me';
  static const String productificUrl = 'https://productific.com/@Langame';
  static const String testFlightUrl =
      'https://testflight.apple.com/join/pxxfLXZc';
  static const String appStoreUrl =
      'https://apps.apple.com/us/app/langame/id1564745604';
  static const String googlePlayUrl =
      'https://play.google.com/store/apps/details?id=me.langa';
}

/// Fonts assets used in this application,
class AppFont {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppFont._();

  // We use usage specific terms like mainFont and logoFont in the code,
  // not actual font names. These names then refer to const strings containing
  // the actual used font name.
  static const String mainFont = fontRoboto;

  // We use Roboto as an asset so we can get it on all platforms and have same
  // look. If we do not do this, then on some platforms we will instead get a
  // Roboto 'like' font as replacement font. In this app we want to make sure
  // we actually use Roboto on all platforms. So we provide it as a bundled
  // asset and also specify it in our theme explicitly via the mainFont.
  static const String fontRoboto = 'Roboto';
}

class AppText {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppText._();
}

class AppSize {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late bool isLargeWidth;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  AppSize(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    isLargeWidth = screenWidth > 1000;
  }
}
