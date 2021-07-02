import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/future.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/services/context/dialog_service.dart';
import 'package:langame/services/context/navigation_service.dart';
import 'package:langame/services/context/snack_bar_service.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/langame.dart';
import 'package:langame/views/login.dart';
import 'package:lottie/lottie.dart';

enum spinKitType { SpinKitChasingDots, SpinKitDualRing, SpinKitWanderingCubes }

List<Function(Color)> _loaders = [
  (Color c) => SpinKitChasingDots(color: c),
  (Color c) => SpinKitDualRing(color: c),
  (Color c) => SpinKitWanderingCubes(color: c),
  (Color c) => SpinKitPouringHourglass(color: c),
  (Color c) => SpinKitFoldingCube(color: c),
  (Color c) => SpinKitDoubleBounce(color: c),
  (Color c) => SpinKitCubeGrid(color: c),
  (Color c) => SpinKitFoldingCube(color: c),
  (Color c) => SpinKitPumpingHeart(color: c),
];

enum LangameRoute {
  LoginView,
  MainView,
  LangameView,
}

class ContextProvider extends ChangeNotifier {
  final GlobalKey<NavigatorState> _navigationKey;
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;
  late DialogService _dialogService;
  late SnackBarService _snackBarService;
  late NavigationService _navigationService;
  final FunnyProvider _funny;

  bool _isLoading = false;

  LangameRoute _route = LangameRoute.LoginView;
  LangameRoute get route => _route;

  ContextProvider(
      this._navigationKey, this._scaffoldMessengerKey, this._funny) {
    _dialogService = DialogService(_navigationKey);
    _navigationService = NavigationService(_navigationKey);
    _snackBarService = SnackBarService(_scaffoldMessengerKey);
    final noInternet = (ConnectivityResult e) {
      if (e == ConnectivityResult.none) {
        showLoadingDialog(text: 'You have no Internet access 😥');
      } else if (_isLoading) {
        dialogComplete();
        _isLoading = false;
      }
    };
    Connectivity().checkConnectivity().then((e) {
      waitUntil(() => _navigationKey.currentContext != null, maxIterations: 500)
          .then((_) => noInternet(e));
    });
    Connectivity().onConnectivityChanged.listen(noInternet);
  }

  void showSnackBar(String message, {SnackBarAction? action}) =>
      _snackBarService.show(SnackBar(
        backgroundColor: variantIsLightThenDark(
            _scaffoldMessengerKey.currentContext!,
            reverse: true),
        behavior: SnackBarBehavior.floating,
        content: Text(message,
            style: Theme.of(_scaffoldMessengerKey.currentContext!)
                .textTheme
                .caption),
        action: action,
      ));

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<T> _showDialog<T>(Function showDialogListener) async =>
      await _dialogService.showDialog(() async => (await showDialog<T>(
          context: _navigationKey.currentContext!,
          builder: (BuildContext context) => showDialogListener()))) ??
      false;

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete() => _dialogService.dialogComplete();

  _updateRoute(Widget route) {
    if (Widget is LangameView) {
      _route = LangameRoute.LangameView;
    } else if (Widget is LoginView) {
      _route = LangameRoute.LoginView;
    } else {
      _route = LangameRoute.MainView;
    }
    notifyListeners();
  }

  Future<Widget?> push(Widget route) {
    _updateRoute(route);
    return _navigationService.push(route);
  }

  Future<Widget?> pushReplacement(Widget route, {bool tryPopParents = true}) {
    _updateRoute(route);
    return _navigationService.pushReplacement(route,
        tryPopParents: tryPopParents);
  }

  

  void pop() => _navigationService.pop(); // TODO: not updating route, I think its ok, staying in mainview w/e

  Future<T> showCustomDialog<T>({
    List<Widget>? stateless,
    Widget? title,
    bool canBack = false,
    Color? backgroundColor,
    int height = 50,
    int width = 80,
  }) =>
      _showDialog<T>(() {
        final dialog = SimpleDialog(
          contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(0),
          titlePadding: EdgeInsets.all(24),
          title: title,
          backgroundColor: backgroundColor ??
              getBlackAndWhite(_navigationKey.currentContext!, 1,
                  reverse: true),
          children: [
            Container(
              color: backgroundColor ??
                  getBlackAndWhite(_navigationKey.currentContext!, 1,
                      reverse: true),
              height: AppSize.safeBlockVertical * height,
              width: AppSize.safeBlockHorizontal * width,
              child: Scaffold(
                backgroundColor: backgroundColor ??
                    getBlackAndWhite(_navigationKey.currentContext!, 1,
                        reverse: true),
                body: Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: stateless != null ? stateless : [],
                  )),
                ),
              ),
            ),
          ],
        );
        return WillPopScope(
          onWillPop: () async => canBack,
          child: dialog,
        );
      });

  Future showLoadingDialog({String? text}) {
    _isLoading = true;
    return showCustomDialog(
      stateless: [
        buildLoadingWidget(text: text, backgroundColor: Colors.transparent),
      ],
    );
  }

  /// Note: Material is needed because of this
  /// https://stackoverflow.com/questions/47114639/yellow-lines-under-text-widgets-in-flutter
  Widget buildLoadingWidget({String? text, Color? backgroundColor}) => Material(
        type: MaterialType.transparency,
        child: Container(
          color: backgroundColor ??
              variantIsLightThenDark(_navigationKey.currentContext!,
                  reverse: true),
          child: Column(
            children: [
              _loaders.pickAny()!(isLightThenDark(
                  _navigationKey.currentContext!,
                  reverse: false)),
              SizedBox(height: AppSize.safeBlockVertical * 5),
              Text(
                text ?? _funny.getLoadingRandom(),
                textAlign: TextAlign.center,
                style:
                    Theme.of(_navigationKey.currentContext!).textTheme.caption!,
              )
            ],
          ),
        ),
      );

  Future<void> showSuccessDialog(String text) => showCustomDialog(stateless: [
        Lottie.asset(
          'animations/check.json',
          width: AppSize.safeBlockHorizontal * 30,
          repeat: false,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(_navigationKey.currentContext!).textTheme.headline6!,
        ),
      ]);

  Future<void> showFailureDialog(String? text) => showCustomDialog(stateless: [
        Lottie.asset(
          'animations/sad.json',
          width: AppSize.safeBlockHorizontal * 30,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text ?? _funny.getFailingRandom(),
          textAlign: TextAlign.center,
          style: Theme.of(_navigationKey.currentContext!).textTheme.headline6!,
        )
      ]);

  void handleLangameResponse(LangameResponse res,
      {String? succeedMessage,
      String? failedMessage,
      Function? onSucceed,
      Function? onCancelled,
      Function? onFailure}) {
    switch (res.status) {
      case LangameStatus.cancelled:
        if (onCancelled != null) onCancelled();
        break;
      case LangameStatus.failed:
        if (failedMessage != null) showSnackBar(failedMessage);
        if (onFailure != null) onFailure();
        break;
      case LangameStatus.succeed:
        if (succeedMessage != null) showSnackBar(succeedMessage);
        if (onSucceed != null) onSucceed();
        break;
    }
  }

  Future<T> showCustomStatefulDialog<T>({
    Widget Function(BuildContext, void Function(void Function()))? stateful,
    Widget? title,
    bool canBack = false,
    Color? backgroundColor,
    int height = 50,
    int width = 80,
  }) =>
      _showDialog<T>(() {
        final dialog = StatefulBuilder(
            builder: (c, s) => SimpleDialog(
                  contentPadding: EdgeInsets.all(0),
                  insetPadding: EdgeInsets.all(0),
                  titlePadding: EdgeInsets.all(24),
                  title: title,
                  backgroundColor: backgroundColor ??
                      getBlackAndWhite(_navigationKey.currentContext!, 1,
                          reverse: true),
                  children: [
                    Container(
                      color: backgroundColor ??
                          getBlackAndWhite(_navigationKey.currentContext!, 1,
                              reverse: true),
                      height: AppSize.safeBlockVertical * height,
                      width: AppSize.safeBlockHorizontal * width,
                      child: Scaffold(
                        backgroundColor: backgroundColor ??
                            getBlackAndWhite(_navigationKey.currentContext!, 1,
                                reverse: true),
                        body: Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: stateful != null ? [stateful(c, s)] : [],
                          )),
                        ),
                      ),
                    ),
                  ],
                ));

        return WillPopScope(
          onWillPop: () async => canBack,
          child: dialog,
        );
      });
}
