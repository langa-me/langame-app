import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/users/user_tile.dart';
import 'package:provider/provider.dart';


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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Recommendations',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(
                        width: AppSize.safeBlockHorizontal * 2,
                      ),
                      Tooltip(
                          message:
                              'Recommended according to your favorite topics and your recent activities',
                          child: Icon(FontAwesomeIcons.questionCircle,
                              color: getBlackAndWhite(context, 0))),
                    ],
                  ),
                  lp.recommendations.length > 0
                      ? Container(
                          width: AppSize.safeBlockHorizontal * 90,
                          height: AppSize.safeBlockHorizontal * 50,
                          child: ListView(
                              children: lp.recommendations.entries
                                  .take(5)
                                  .map((e) =>
                                      buildUserTile(context, e.value.data()!))
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

      return Container(
        width: AppSize.safeBlockHorizontal * 90,
        height: AppSize.safeBlockHorizontal * 50,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(children: [buildUserTile(context, p.selectedUser!)]),
      );
    });
  }
}
