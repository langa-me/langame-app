import 'package:flutter/material.dart';

Color isLightThenDark(BuildContext context, {bool reverse = false}) =>
    Theme.of(context).brightness == Brightness.light
        ? reverse
            ? Colors.white
            : Colors.black
        : reverse
            ? Colors.black
            : Colors.white;

Color variantIsLightThenDark(BuildContext context, {bool reverse = false}) =>
    Theme.of(context).brightness == Brightness.light
        ? reverse
            ? Colors.grey.shade100
            : Colors.grey.shade900
        : reverse
            ? Colors.grey.shade900
            : Colors.grey.shade100;

Color variantBisIsLightThenDark(BuildContext context, {bool reverse = false}) =>
    Theme.of(context).brightness == Brightness.light
        ? reverse
            ? Colors.grey.shade300
            : Colors.grey.shade700
        : reverse
            ? Colors.grey.shade700
            : Colors.grey.shade300;

Color averageGrey() => Colors.grey.shade500;
