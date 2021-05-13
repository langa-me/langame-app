import 'package:flutter/material.dart';

Widget buildRoundedElevatedIconButton(void Function()? onPressed,
        IconData? icon, Color? buttonColor, Color? iconColor) =>
    IconButton(
      onPressed: onPressed,
      color: buttonColor ?? Colors.transparent,
      padding: EdgeInsets.all(0),
      icon: Icon(icon, color: iconColor),
    );
