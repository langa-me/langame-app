import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/users/user_tile.dart';
import 'package:provider/provider.dart';

import 'other_profile_widget.dart';

class SearchResultsListView extends StatefulWidget {
  const SearchResultsListView();

  @override
  _SearchResultsListViewState createState() => _SearchResultsListViewState();
}

class _SearchResultsListViewState extends State<SearchResultsListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferenceProvider, NewLangameProvider>(
        builder: (c, p, lp, _) {
      if (p.selectedUser == null) {
        return p.preference.goals.growRelationships
            ? Column(
                children: [
                  Text('Recommendations',
                      style: Theme.of(context).textTheme.headline5),
                  lp.recommendations.length > 0
                      ? Expanded(
                          child: ListView(
                              children: lp.recommendations.entries
                                  .take(5)
                                  .map((e) => buildUserTile(
                                      context, e.value.data()!))
                                  .toList()
                                  .reversed
                                  .toList()),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Image.asset(
                                'images/logo-colourless.png',
                                width: AppSize.safeBlockHorizontal * 20,
                              ),
                              Text(
                                  'After playing some Langames, you will have some recommendations!',
                                  style: Theme.of(context).textTheme.caption,
                                  textAlign: TextAlign.center),
                            ]),
                ],
              )
            : Image.asset('images/logo-colourless.png');
      }

      var cp = Provider.of<ContextProvider>(context, listen: false);
      return Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
        OtherProfileWidget(p.selectedUser!),
        Positioned(
          bottom: AppSize.safeBlockVertical * 15,
          child: LangameButton(
          FontAwesomeIcons.grinTongue,
          text: 'Select',
          highlighted: true,
          onPressed: () {
            lp.addPlayer(p.selectedUser!);
            cp.pop();
          },
        ),),
      ]);
    });
  }
}
