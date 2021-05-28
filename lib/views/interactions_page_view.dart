import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/providers/relation_provider.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'users/user_tile.dart';

class InteractionsPageView extends StatefulWidget {
  final void Function(int, {Curve? curve}) _goToPage;
  InteractionsPageView(this._goToPage);

  @override
  _State createState() => _State();
}

class _State extends State<InteractionsPageView>
    with AfterLayoutMixin<InteractionsPageView> {
  GlobalKey _toolTipKey = GlobalKey();

  _State();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('interactions_page_view');
  }

  @override
  Widget build(BuildContext context) => Consumer<RelationProvider>(
        builder: (context, r, _) => Flex(direction: Axis.vertical, children: [
          Expanded(
              child: Column(children: [
            Expanded(child: _buildLatestInteractionsContainer(r)),
            Expanded(child: _buildRecommendations(r)),
          ]))
        ]),
      );

  Widget _buildRecommendations(RelationProvider r) =>
      Consumer<PreferenceProvider>(
        builder: (context, pp, c) => !pp.preference.unknownPeopleRecommendations
            ? SizedBox.shrink()
            : Container(
                height: AppSize.safeBlockVertical * 40,
                child: Column(
                  children: [
                    ListTile(
                      // tileColor: Theme.of(context).colorScheme.primaryVariant,
                      title: Text(
                        'Recommendations',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      leading: Switch(
                          value: pp.preference.unknownPeopleRecommendations,
                          onChanged: (v) {
                            Provider.of<ContextProvider>(context, listen: false)
                                .showSnackBar(
                                    'Understood, you can still reactivate recommendations in settings later');
                            pp.setRecommendations(
                                !pp.preference.unknownPeopleRecommendations);
                          }),
                      trailing: Stack(children: [
                        Tooltip(
                          key: _toolTipKey,
                          message: 'Recommendations feature is experimental',
                        ),
                        IconButton(
                          icon: Icon(Icons.help_outline_outlined),
                          onPressed: () {
                            final dynamic tooltip = _toolTipKey.currentState;
                            tooltip.ensureTooltipVisible();
                          },
                        ),
                      ]),
                    ),
                    Divider(thickness: 3),
                    Expanded(
                      child: Container(
                        height: AppSize.safeBlockVertical * 40,
                        child: Consumer<NewLangameProvider>(
                          builder: (c, lp, child) => ListView.builder(
                            itemCount: r.userRecommendations.length,
                            itemBuilder: (context, index) => FutureBuilder<
                                    LangameResponse<InteractionLevel?>>(
                                future: r.getInteraction(
                                    r.userRecommendations[index].uid),
                                builder: (ctx, s) => BuildUserTile(
                                    context,
                                    lp,
                                    r.userRecommendations[index],
                                    s.hasData &&
                                            s.data != null &&
                                            s.data!.result != null
                                        ? s.data!.result
                                        : null,
                                        widget._goToPage,
                                        )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );

  Widget _buildLatestInteractionsContainer(RelationProvider r) => Container(
        height: AppSize.safeBlockVertical * 40,
        child: Column(
          children: [
            ListTile(
              // tileColor: Theme.of(context).colorScheme.primaryVariant,
              title: Text(
                'Recent',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Divider(thickness: 3),
            Expanded(
              child: Container(
                height: AppSize.safeBlockVertical * 40,
                child: Consumer<NewLangameProvider>(
                  builder: (c, lp, child) => r.recentInteractions.length == 0
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No recent interactions, launch a Langame!',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline4),
                              SizedBox(height: AppSize.safeBlockVertical * 5),
                    LangameButton(
                        () => widget._goToPage(0, curve: Curves.bounceIn),
                        'Why not start\na new Langame with friends?',
                        FontAwesomeIcons.plus,
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: r.recentInteractions.length,
                          itemBuilder: (context, index) => BuildUserTile(
                              context,
                              lp,
                              r.recentInteractions.elementAt(index).item1,
                              r.recentInteractions.elementAt(index).item2,
                              widget._goToPage,
                              ),
                              
                        ),
                ),
              ),
            ),
          ],
        ),
      );
}
