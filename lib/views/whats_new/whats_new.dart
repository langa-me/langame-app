// This is a stateless Flutter widget that is
// intended to show within a dialog to show the user
// what is new in this version of the app.

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/feature_preview/beta.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

final _news = [ // TODO: should be accessible through remote config / firestore
  'Simplified interface',
];

Widget whatsNew(BuildContext context) {
  return Column(
    children: _news
            .map<Widget>((e) => ListTile(
                leading: Beta(null, type: BetaType.PREVIEW),
                title: Text(
                  e,
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                )))
            .toList() +
        [
          SizedBox(height: AppSize.safeBlockVertical * 3),
          LangameButton(FontAwesomeIcons.poll, highlighted: true,
              onPressed: () async {
            if (await canLaunch(AppConst.productificUrl)) {
              await launch(
                AppConst.productificUrl,
              );
            } else {
              Provider.of<ContextProvider>(context, listen: false).showSnackBar(
                  Provider.of<FunnyProvider>(context, listen: false)
                      .getFailingRandom());
            }
          }, text: 'Support Langame\nVote for new feature ❤️'),
        ],
  );
}
