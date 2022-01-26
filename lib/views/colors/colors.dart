import 'package:flutter/material.dart';

bool isLight(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light;

Color getBlackAndWhite(BuildContext context, int layer,
    {bool reverse = false}) {
  if (isLight(context)) {
    if (reverse) {
      switch (layer) {
        case 0:
          return Colors.white;
        case 1:
          return Colors.grey.shade100;
        case 2:
          return Colors.grey.shade300;
        case 3:
          return Colors.grey.shade500;
      }
    } else {
      switch (layer) {
        case 0:
          return Colors.black;
        case 1:
          return Colors.grey.shade900;
        case 2:
          return Colors.grey.shade700;
        case 3:
          return Colors.grey.shade500;
      }
    }
  } else {
    if (reverse) {
      switch (layer) {
        case 0:
          return Colors.black;
        case 1:
          return Colors.grey.shade900;
        case 2:
          return Colors.grey.shade700;
        case 3:
          return Colors.grey.shade500;
      }
    } else {
      switch (layer) {
        case 0:
          return Colors.white;
        case 1:
          return Colors.grey.shade100;
        case 2:
          return Colors.grey.shade300;
        case 3:
          return Colors.grey.shade500;
      }
    }
  }
  throw Exception('invalid arguments');
}

Color variantIsLightThenDark(BuildContext context, {bool reverse = false}) =>
    isLight(context)
        ? reverse
            ? Colors.grey.shade100
            : Colors.grey.shade900
        : reverse
            ? Colors.grey.shade900
            : Colors.grey.shade100;

Color variantBisIsLightThenDark(BuildContext context, {bool reverse = false}) =>
    isLight(context)
        ? reverse
            ? Colors.grey.shade300
            : Colors.grey.shade700
        : reverse
            ? Colors.grey.shade700
            : Colors.grey.shade300;

Color averageGrey() => Colors.grey.shade500;
