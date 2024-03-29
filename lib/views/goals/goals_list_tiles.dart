import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/colors/colors.dart';

List<ListTile> buildGoalsListTiles(
  BuildContext context,
  PreferenceProvider pp, {
  int? layer,
}) =>
    [
      ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: layer != null
            ? getBlackAndWhite(context, layer, reverse: true)
            : null,
        leading: Icon(
          FontAwesomeIcons.dumbbell,
          color: getBlackAndWhite(context, 0),
        ),
        onTap: () {
          pp.preference.goals.compoundRelationships =
              !pp.preference.goals.compoundRelationships;
          pp.refresh();
        },
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Text('Strengthen your relationships',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline6),
          ),
          Tooltip(
            message:
                'Have frequent interactions with your current relationships and get to know them better.',
            child: Icon(
              FontAwesomeIcons.questionCircle,
              color: getBlackAndWhite(context, 0),
            ),
          ),
        ]),
        trailing: Switch(
            value: pp.preference.goals.compoundRelationships,
            onChanged: (_) {
              pp.preference.goals.compoundRelationships =
                  !pp.preference.goals.compoundRelationships;
              pp.refresh();
            }),
      ),
      ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: layer != null
            ? getBlackAndWhite(context, layer, reverse: true)
            : null,
        leading: Icon(
          FontAwesomeIcons.seedling,
          color: getBlackAndWhite(context, 0),
        ),
        onTap: () {
          pp.preference.goals.growRelationships =
              !pp.preference.goals.growRelationships;
          pp.refresh();
        },
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Text('Forge new relationships',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6),),
          Tooltip(
              message:
                  'Get recommendations for new people to meet and establish new relationships.',
              child: Icon(FontAwesomeIcons.questionCircle,
                  color: getBlackAndWhite(context, 0))),
        ]),
        trailing: Switch(
            value: pp.preference.goals.growRelationships,
            onChanged: (_) {
              pp.preference.goals.growRelationships =
                  !pp.preference.goals.growRelationships;
              pp.refresh();
            }),
      ),
      ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: layer != null
            ? getBlackAndWhite(context, layer, reverse: true)
            : null,
        leading: Icon(
          FontAwesomeIcons.brain,
          color: getBlackAndWhite(context, 0),
        ),
        onTap: () {
          pp.preference.goals.learn = !pp.preference.goals.learn;
          pp.refresh();
        },
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Text('Learn new things',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6),),
          Tooltip(
              message: 'Challenge what you know and learn new things.',
              child: Icon(FontAwesomeIcons.questionCircle,
                  color: getBlackAndWhite(context, 0))),
        ]),
        trailing: Switch(
            value: pp.preference.goals.learn,
            onChanged: (_) {
              pp.preference.goals.learn = !pp.preference.goals.learn;
              pp.refresh();
            }),
      ),
    ];
