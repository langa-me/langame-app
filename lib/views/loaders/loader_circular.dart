import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
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
                          "Please Wait....",
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
