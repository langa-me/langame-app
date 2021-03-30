import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';

class Dialogs {
  static Future<void> showSuccessDialog(
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
                        Image.asset(
                          'images/checked.png',
                          width: AppSize.blockSizeHorizontal * 20,
                          height: AppSize.blockSizeVertical * 20,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6!.merge(
                              TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black
                                      : Colors.white)),
                        )
                      ]),
                    )
                  ]));
        });
  }

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
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
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please Wait....',
                          style: Theme.of(context).textTheme.headline6!.merge(
                              TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black
                                      : Colors.white)),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
