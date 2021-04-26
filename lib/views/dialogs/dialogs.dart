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
          titleStyle: Theme.of(context).textTheme.headline4!.merge(
              TextStyle(color: isLightThenBlack(context, reverse: false))),
          animation: 'animations/check.json',
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
