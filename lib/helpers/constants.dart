// It is not necessary to review or understand the code in this file in order
// to understand how to use the FlexColorScheme package demonstrated in
// the examples.

/// Layout constants and strings used in the example application
class AppConst {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppConst._();

  // This info is mainly for the Live public web builds of the examples.
  // When I build a new public version I just make sure to update this info
  // before building them.
  static const String appName = 'Langame';
  static const String version = '0.0.1';
  static const String author = 'Louis Beaumont';
  // static const String icon = 'assets/images/app_icon.png';

  // The max dp width used for layout content on the screen in the available
  // body area. Wider content gets growing side padding, kind of like on most
  // web pages when they are used on super wide screen. Just a design used for
  // this demo app, that works pretty well in this use case.
  static const double maxBodyWidth = 1000;

  // Edge padding for page content on the screen. A better looking result
  // can be obtained if this increases in steps depending on canvas size.
  // Keeping it fairly tight now, but not too small, it is a compromise for
  // both phone and larger media.
  static const double edgePadding = 12;

  // The width of the side menu when expanded, only used by example 5.
  static const double expandWidth = 225;

  // The width of the side menu when rail sized, only used by example 5.
  static const double shrinkWidth = 60;

  // Whether to log debug settings events
  static const bool debugSettings = false;

  /// Define App ID and Token
  static const agoraAppID = '04dbfdb7d4a349bf9b02758aabd97c78';
  static const agoraToken =
      '00604dbfdb7d4a349bf9b02758aabd97c78IACDZaxW7iTSrSlwDDVVj+Hu14xkzq/Rz+C6W+3XeI88wCFlc4wAAAAAEABfjXZE77pVYAEAAQDuulVg';
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

  // TODO https://flutter.dev/docs/development/accessibility-and-localization/internationalization#:~:text=platform%20might%20require.-,Setting%20up%20an%20internationalized%20app%3A%20the%20Flutter_localizations%20package,include%20a%20package%20called%20flutter_localizations%20.
}
