import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/services/context/dialog_service.dart';
import 'package:langame/services/context/navigation_service.dart';
import 'package:langame/services/context/snack_bar_service.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:lottie/lottie.dart';

enum spinKitType { SpinKitChasingDots, SpinKitDualRing, SpinKitWanderingCubes }

List<Function(Color)> _loaders = [
  (Color c) => SpinKitChasingDots(color: c),
  (Color c) => SpinKitDualRing(color: c),
  (Color c) => SpinKitWanderingCubes(color: c),
  (Color c) => SpinKitPouringHourglass(color: c),
  (Color c) => SpinKitFoldingCube(color: c),
  (Color c) => SpinKitDoubleBounce(color: c),
];

class ContextProvider extends ChangeNotifier {
  final GlobalKey<NavigatorState> _navigationKey;
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;
  late DialogService _dialogService;
  late SnackBarService _snackBarService;
  late NavigationService _navigationService;

  void showSnackBar(String message, {SnackBarAction? action}) =>
      _snackBarService.show(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        action: action,
      ));

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future _showDialog(Function showDialogListener) async =>
      await _dialogService.showDialog(() async => await showDialog(
          context: _navigationKey.currentContext!,
          builder: (BuildContext context) => showDialogListener()));

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete() => _dialogService.dialogComplete();

  Future<Widget?> push(Widget route) => _navigationService.push(route);

  Future<Widget?> pushReplacement(Widget route) =>
      _navigationService.pushReplacement(route);

  void pop() => _navigationService.pop();

  Future showCustomDialog(List<Widget> children,
          {bool canBack = false, Color? backgroundColor}) =>
      _showDialog(
        () => WillPopScope(
          onWillPop: () async => canBack,
          child: SimpleDialog(
            backgroundColor: backgroundColor ??
                variantIsLightThenDark(_navigationKey.currentContext!, reverse: true),
            children: children,
          ),
        ),
      );

  Future showLoadingDialog(String text) => showCustomDialog(
        [
          Center(
            child: Column(children: [
              _loaders.pickAny()!(isLightThenDark(
                  _navigationKey.currentContext!,
                  reverse: true)),
              SizedBox(
                height: 10,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(_navigationKey.currentContext!)
                    .textTheme
                    .caption!,
              )
            ]),
          )
        ],
      );

  Future<void> showSuccessDialog(String text) => showCustomDialog([
        Center(
          child: Column(children: [
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
              style:
                  Theme.of(_navigationKey.currentContext!).textTheme.headline6!,
            )
          ]),
        )
      ]);

  Future<void> showFailureDialog(String text) => showCustomDialog([
        Center(
          child: Column(children: [
            Lottie.asset(
              'animations/sad.json',
              width: AppSize.safeBlockHorizontal * 30,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style:
                  Theme.of(_navigationKey.currentContext!).textTheme.headline6!,
            )
          ]),
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

  ContextProvider(this._navigationKey, this._scaffoldMessengerKey) {
    _dialogService = DialogService(_navigationKey);
    _navigationService = NavigationService(_navigationKey);
    _snackBarService = SnackBarService(_scaffoldMessengerKey);
  }
}
