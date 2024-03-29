import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildPopupMenuWithHelpAndFeedback(BuildContext context) {
  return PopupMenuButton(
    icon: Icon(Icons.more_vert_outlined, color: getBlackAndWhite(context, 0)),
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          child: ListTile(
            dense: true,
            minVerticalPadding: 2,
            onTap: () async {
              if (await canLaunch(AppConst.helpUrl)) {
              await launch(
                AppConst.helpUrl,
              );
              } else {
                Provider.of<ContextProvider>(context, listen: false)
                    .showSnackBar(
                        Provider.of<FunnyProvider>(context, listen: false)
                            .getFailingRandom());
              }
            },
            leading: Icon(Icons.help_center_outlined,
                color: getBlackAndWhite(context, 0)),
            title: Text('Help', style: Theme.of(context).textTheme.headline6),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            dense: true,
            minVerticalPadding: 2,
            onTap: () => Provider.of<FeedbackProvider>(context, listen: false)
                .show(fromShaking: false),
            leading:
                Icon(Icons.feedback_outlined, color: getBlackAndWhite(context, 0)),
            title:
                Text('Feedback', style: Theme.of(context).textTheme.headline6),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            dense: true,
            minVerticalPadding: 2,
            onTap: () async {
              if (await canLaunch(AppConst.productificUrl)) {
                await launch(
                  AppConst.productificUrl,
                );
              } else {
                Provider.of<ContextProvider>(context, listen: false)
                    .showSnackBar(
                        Provider.of<FunnyProvider>(context, listen: false)
                            .getFailingRandom());
              }
            },
            leading:
                Icon(FontAwesomeIcons.poll, color: getBlackAndWhite(context, 0)),
            title: Text('Vote for features',
                style: Theme.of(context).textTheme.headline6),
          ),
        ),
      ];
    },
  );
}
