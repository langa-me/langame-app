import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:material_dialogs/material_dialogs.dart';

class LgDialogs {
  static Future<void> showSuccessDialog(
          BuildContext context, GlobalKey key, String text) async =>
      Dialogs.materialDialog(
          barrierDismissible: false,
          color: Theme.of(context).colorScheme.primary,
          title: text,
          titleStyle: Theme.of(context)
              .textTheme
              .headline5!
              .merge(TextStyle(color: Colors.white)),
          animation: 'animations/check.json',
          animationRepeat: false,
          context: context,
          actions: []);

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key, String text) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              key: key,
              backgroundColor: Theme.of(context).colorScheme.primary,
              children: <Widget>[
                Center(
                  child: Column(children: [
                    // TODO: random SpinKit :)
                    SpinKitChasingDots(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6!.merge(
                            TextStyle(color: Colors.white),
                          ),
                    )
                  ]),
                )
              ],
            ),
          );
        });
  }
}

Future<bool> basicOnWillPopScope(BuildContext context) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        title: const Text('Exit Langame?', textAlign: TextAlign.center),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline4!
            .merge(TextStyle(color: Colors.white)),
        actions: [
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pop(false),
            icon: Icon(Icons.cancel_outlined,
                color: Theme.of(context).colorScheme.secondary),
            label: Text('CANCEL',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isLightThenBlack(context, reverse: false))),
            style: ElevatedButton.styleFrom(
              primary: isLightThenBlack(context, reverse: true),
              side: BorderSide(
                  width: 2.0, color: Theme.of(context).colorScheme.secondary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          Spacer(),
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              primary: isLightThenBlack(context, reverse: true),
              side: BorderSide(
                  width: 2.0, color: Theme.of(context).colorScheme.secondary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            icon: Icon(Icons.exit_to_app_rounded,
                color: Theme.of(context).colorScheme.secondary),
            label: Text('YES',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isLightThenBlack(context, reverse: false))),
          ),
        ],
      ),
    ) ??
    false;
