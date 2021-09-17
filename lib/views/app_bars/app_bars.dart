import 'package:flutter/material.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:langame/views/colors/colors.dart';

PreferredSizeWidget buildAppBar(BuildContext context, String title) => AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
      iconTheme: IconThemeData(
        color: getBlackAndWhite(context, 0), //change your color here
      ),
      backgroundColor: Colors.transparent,
      actions: [
        buildPopupMenuWithHelpAndFeedback(context),
      ],
    );
