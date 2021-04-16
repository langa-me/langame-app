import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// child: InkWell(
// onTap: () async {
// if (await canLaunch(AppConst.helpUrl)) {
// await launch(AppConst.helpUrl);
// } else {
// final snackBar = SnackBar(
// content: Text(Provider.of<FunnyProvider>(context)
//     .getFailingRandom()));
// ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
// },
// child: Text(
// 'Help',
// ),
// ),

Widget buildPopupMenuWithHelpAndFeedback() {
  return PopupMenuButton(
    icon: Icon(Icons.more_vert_outlined),
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          child: ListTile(
            dense: true,
            minVerticalPadding: 2,
            onTap: () async {
              if (await canLaunch(AppConst.helpUrl)) {
                await launch(AppConst.helpUrl);
              } else {
                final snackBar = SnackBar(
                    content: Text(Provider.of<FunnyProvider>(context)
                        .getFailingRandom()));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            leading: Icon(Icons.help_center_outlined),
            title: Text('Help'),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            dense: true,
            minVerticalPadding: 2,
            onTap: () => Provider.of<FeedbackProvider>(context, listen: false)
                .show(context: context, fromShaking: false),
            leading: Icon(Icons.feedback_outlined),
            title: Text('Feedback'),
          ),
        ),
      ];
    },
  );
}
