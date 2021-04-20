import 'package:flutter/material.dart';

Color isLightThenBlack(BuildContext ctx, {bool reverse = false}) =>
    Theme.of(ctx).brightness == Brightness.light
        ? reverse
            ? Colors.white
            : Colors.black
        : reverse
            ? Colors.black
            : Colors.white;
