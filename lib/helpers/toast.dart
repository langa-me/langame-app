import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showBasicSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(message),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showToast(String message,
    {Color color = Colors.green,
    Color textColor = Colors.white,
    double fontSize = 16.0}) {
  if (!kReleaseMode) debugPrint(message);
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: textColor,
    fontSize: fontSize,
  );
}

void showToastWithContext(BuildContext context, String message,
    {Color color = Colors.green}) {
  if (!kReleaseMode) debugPrint(message);
  final FToast fToast = FToast();
  fToast.init(context);
  fToast.showToast(child: buildContextToast(message, color: Colors.red));
}

Widget buildContextToast(String message, {Color color = Colors.green}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );
