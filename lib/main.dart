import 'dart:isolate';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:connectivity/connectivity.dart';
import 'package:feedback/feedback.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/admin_provider.dart';
import 'package:langame/providers/audio_provider.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/dynamic_links_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/providers/payment_provider.dart';
import 'package:langame/providers/physical_langame_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/providers/recording_provider.dart';
import 'package:langame/providers/remote_config_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:langame/services/http/fake_message_api.dart';
import 'package:langame/services/http/impl_authentication_api.dart';
import 'package:langame/services/http/impl_message_api.dart';
import 'package:langame/services/http/preference/preference_service.dart';
import 'package:langame/views/langame.dart';
import 'package:langame/views/login.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'helpers/future.dart';
import 'services/http/firebase.dart';
import 'services/http/impl_langame_api.dart';
import 'services/http/impl_payment_api.dart';
import 'views/colors/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // if (kReleaseMode) {
  FirebaseAppCheck.instance.activate();
  // }
  FirebaseCrashlytics? crashlytics;
  RemoteConfig? remoteConfig;
  FirebaseDynamicLinks? dynamicLinks;
  Algolia? algolia;
  // Crashlytics does not support web https://firebase.flutter.dev/
  if (!kIsWeb) {
    crashlytics = FirebaseCrashlytics.instance;
    await crashlytics.setCrashlyticsCollectionEnabled(true);
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = crashlytics.recordFlutterError;
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await crashlytics!.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);
    remoteConfig = RemoteConfig.instance;
    dynamicLinks = FirebaseDynamicLinks.instance;
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://ce6ae27b22094db983af540d6ddb8010@o404046.ingest.sentry.io/5891492';
        options.environment =
            AppConst.isDev || kDebugMode ? 'development' : 'production';
      },
    );

    remoteConfig.ensureInitialized().then((_) async {
      await waitUntil(
          () => remoteConfig!.getString('algolia_application_id').isNotEmpty);
      algolia = Algolia.init(
          applicationId: remoteConfig!.getString('algolia_application_id'),
          apiKey: remoteConfig.getString('algolia_api_key'));
    });
  }
  var analytics = FirebaseAnalytics();
  var useEmulator = false;
  FirebaseApi firebase = FirebaseApi(
    messaging: FirebaseMessaging.instance,
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    functions: FirebaseFunctions.instance,
    googleSignIn: GoogleSignIn(scopes: <String>[
      'email',
    ]),
    crashlytics: crashlytics,
    analytics: analytics,
    storage: FirebaseStorage.instance,
    remoteConfig: remoteConfig,
    dynamicLinks: dynamicLinks,
    useEmulator: useEmulator,
  );

  var navigationKey = GlobalKey<NavigatorState>(debugLabel: 'navKey');
  var scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(debugLabel: 'scaffoldKey');
  var funnyProvider = FunnyProvider();
  var contextProvider =
      ContextProvider(navigationKey, scaffoldMessengerKey, funnyProvider);
  var crashAnalyticsProvider = CrashAnalyticsProvider(firebase.crashlytics,
      firebase.analytics!, remoteConfig, firebase, algolia);
  var authenticationApi = ImplAuthenticationApi(firebase);
  var authenticationProvider = AuthenticationProvider(
      firebase, authenticationApi, crashAnalyticsProvider);
  // Cloud messaging is fucked-up with emulator
  // (something with, messaging stuff have to happen on Google infra)
  // So using fake api when using emulator
  var messageApi = useEmulator ||
          kIsWeb // TODO: web unimplemented https://firebase.flutter.dev/docs/messaging/usage#web-tokens
      ? FakeMessageApi(firebase, (_) {})
      : ImplMessageApi(firebase, (n) {
          debugPrint('opening $n');
          if (n?['channelName'] != null) {
            contextProvider.pushReplacement(
              LangameView(n!['channelName'], false),
            );
          }
        });
  var messageProvider = MessageProvider(firebase, messageApi,
      crashAnalyticsProvider, authenticationProvider, contextProvider);
  var preferenceProvider = PreferenceProvider(
      firebase, crashAnalyticsProvider, authenticationProvider);
  var remoteConfigProvider =
      RemoteConfigProvider(crashAnalyticsProvider, remoteConfig);
  var audioProvider = AudioProvider(firebase, crashAnalyticsProvider,
      remoteConfigProvider, authenticationProvider);
  var dynamicLinksProvider = DynamicLinksProvider(
    crashAnalyticsProvider,
    contextProvider,
    dynamicLinks,
    authenticationProvider,
  );
  var langameProvider = LangameProvider(firebase, crashAnalyticsProvider,
      authenticationProvider, ImplLangameApi(firebase));
  final recordingProvider = RecordingProvider(
      firebase, crashAnalyticsProvider, authenticationProvider, algolia);
  var newLangameProvider = NewLangameProvider(
      crashAnalyticsProvider, authenticationProvider, firebase);
  // SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      BetterFeedback(
        child: MultiProvider(
          providers: [
            ///////////////////////////////////////////
            ////////// Independent providers //////////
            ///////////////////////////////////////////

            ChangeNotifierProvider(create: (_) => crashAnalyticsProvider),
            StreamProvider<ConnectivityResult>.value(
                value: Connectivity().onConnectivityChanged,
                initialData: ConnectivityResult.wifi),
            ChangeNotifierProvider(
              create: (_) => contextProvider,
            ),
            ChangeNotifierProvider(
                create: (_) => TagProvider(firebase, crashAnalyticsProvider,
                    algolia, preferenceProvider)),
            ChangeNotifierProvider(create: (_) => funnyProvider),
            ChangeNotifierProvider(create: (_) => newLangameProvider),

            ///////////////////////////////////////////
            ////////// Dependent providers ////////////
            ///////////////////////////////////////////

            ChangeNotifierProxyProvider<CrashAnalyticsProvider,
                RemoteConfigProvider>(
              update: (_, cap, rcp) => rcp!,
              create: (_) => remoteConfigProvider,
            ),
            ChangeNotifierProxyProvider<CrashAnalyticsProvider,
                AuthenticationProvider>(
              update: (_, cap, ap) => ap!,
              create: (_) => authenticationProvider,
            ),
            ChangeNotifierProxyProvider2<CrashAnalyticsProvider,
                AuthenticationProvider, PreferenceProvider>(
              update: (_, cap, ap, pp) => pp!,
              create: (_) => preferenceProvider,
            ),
            ChangeNotifierProxyProvider3<CrashAnalyticsProvider,
                RemoteConfigProvider, AuthenticationProvider, AudioProvider>(
              update: (_, cap, rcp, authP, ap) => ap!,
              create: (_) => audioProvider,
            ),
            ChangeNotifierProxyProvider2<CrashAnalyticsProvider,
                AuthenticationProvider, MessageProvider>(
              // TODO: for now does not change on auth change
              update: (_, cap, ap, mp) => mp!,
              create: (_) => messageProvider,
            ),

            ChangeNotifierProxyProvider3<CrashAnalyticsProvider,
                ContextProvider, PreferenceProvider, FeedbackProvider>(
              update: (ctx, cap, cp, pp, fp) {
                fp?.disable();
                return FeedbackProvider(
                    firebase,
                    crashAnalyticsProvider,
                    contextProvider,
                    Provider.of<PreferenceProvider>(ctx, listen: false));
              },
              create: (_) => FeedbackProvider(firebase, crashAnalyticsProvider,
                  contextProvider, preferenceProvider),
            ),
            ChangeNotifierProxyProvider3<CrashAnalyticsProvider,
                ContextProvider, AuthenticationProvider, PaymentProvider>(
              update: (_, cap, cp, ap, pp) => pp!,
              create: (_) => PaymentProvider(
                  crashAnalyticsProvider,
                  contextProvider,
                  authenticationProvider,
                  ImplPaymentApi(firebase)),
            ),
            ChangeNotifierProxyProvider3<CrashAnalyticsProvider,
                ContextProvider, AuthenticationProvider, DynamicLinksProvider>(
              update: (_, cap, cp, ap, dlp) => dlp!,
              create: (_) => dynamicLinksProvider,
            ),
            ChangeNotifierProxyProvider2<CrashAnalyticsProvider,
                AuthenticationProvider, LangameProvider>(
              update: (_, cap, ap, lp) => lp!,
              create: (_) => langameProvider,
            ),
            ChangeNotifierProxyProvider<CrashAnalyticsProvider,
                PhysicalLangameProvider>(
              update: (_, cap, p) => p!,
              create: (_) => PhysicalLangameProvider(
                  firebase, crashAnalyticsProvider, algolia),
            ),
            ChangeNotifierProxyProvider<CrashAnalyticsProvider, AdminProvider>(
              update: (_, cap, p) => p!,
              create: (_) =>
                  AdminProvider(firebase, crashAnalyticsProvider, algolia),
            ),
            ChangeNotifierProxyProvider<CrashAnalyticsProvider,
                RecordingProvider>(
              update: (_, cap, p) => p!,
              create: (_) => recordingProvider,
            ),
          ],
          child: MyApp(analytics, navigationKey, scaffoldMessengerKey),
        ),
      ),
    );
    authenticationProvider.readyToInit = true;
  });
}

class MyApp extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final GlobalKey<NavigatorState> navigationKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  MyApp(this.analytics, this.navigationKey, this.scaffoldMessengerKey);

  @override
  _MyAppState createState() => _MyAppState(
      this.analytics, this.navigationKey, this.scaffoldMessengerKey);
}

// TODO: https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/example5/main.dart
class _MyAppState extends State<MyApp> {
  final FirebaseAnalytics analytics;
  final GlobalKey<NavigatorState> navigationKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  _MyAppState(this.analytics, this.navigationKey, this.scaffoldMessengerKey);

  @override
  initState() {
    super.initState();
    analytics.logAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    FlexScheme scheme = FlexScheme.bigStone;
    return Consumer<PreferenceProvider>(builder: (context, s, child) {
      return MaterialApp(
        title: 'Langame',
        themeMode: ThemeMode.values[s.preference != null
            ? s.preference!.themeIndex
            : PreferenceService.defaultPreference.themeIndex],
        theme: FlexColorScheme.light(
          scheme: scheme,
          fontFamily: AppFont.mainFont,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          background: Colors.transparent,
        ).toTheme.copyWith(
              iconTheme: IconThemeData(color: Colors.black),
              buttonTheme: ButtonThemeData(buttonColor: Colors.white),
              textTheme: TextTheme(
                caption: TextStyle(fontSize: 12, color: averageGrey()),
                headline1: TextStyle(fontSize: 45, color: Colors.black),
                headline2: TextStyle(fontSize: 40, color: Colors.black),
                headline3: TextStyle(fontSize: 30, color: Colors.black),
                headline4: TextStyle(fontSize: 25, color: Colors.black),
                headline5: TextStyle(fontSize: 20, color: Colors.black),
                headline6: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
        darkTheme: FlexColorScheme.dark(
          scheme: scheme,
          fontFamily: AppFont.mainFont,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          background: Colors.transparent,
        ).toTheme.copyWith(
              iconTheme: IconThemeData(color: Colors.white),
              buttonTheme: ButtonThemeData(buttonColor: Colors.grey.shade800),
              textTheme: TextTheme(
                caption: TextStyle(fontSize: 12, color: averageGrey()),
                headline1: TextStyle(fontSize: 45, color: Colors.white),
                headline2: TextStyle(fontSize: 40, color: Colors.white),
                headline3: TextStyle(fontSize: 30, color: Colors.white),
                headline4: TextStyle(fontSize: 25, color: Colors.white),
                headline5: TextStyle(fontSize: 20, color: Colors.white),
                headline6: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
        home: LoginView(),
        navigatorKey: navigationKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
