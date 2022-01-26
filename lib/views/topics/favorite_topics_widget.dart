import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/topics/topic_search_bar.dart';
import 'package:provider/provider.dart';

class FavoriteTopicsWidget extends StatefulWidget {
  FavoriteTopicsWidget();

  @override
  _State createState() => _State();
}

class _State extends State<FavoriteTopicsWidget> {
  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<PreferenceProvider>(context);
    final cp = Provider.of<ContextProvider>(context, listen: false);

    // Return a widget composed of a search bar and a list of topics
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: AppSize.safeBlockVertical * 20,
            margin: EdgeInsets.only(bottom: AppSize.safeBlockVertical * 5),
            child: TopicSearchWidget(
              onTopicSelected: (topic) {
                if (pp.preference.favoriteTopics.length >= 9) {
                  cp.showSnackBar(
                    'You can only have up to 9 interests',
                  );
                  return;
                }
                // Add to favorite
                pp.addFavoriteTopic(topic);
              },
            )),
        Expanded(
            child: Wrap(
              spacing: 2,
              runSpacing: 2,
          children: pp.preference.favoriteTopics
              .map((e) => LangameButton(FontAwesomeIcons.times,
                  layer: 1,
                  text: e,
                  onPressed: () => pp.removeFavoriteTopic(e)))
              .toList(),
        )),
      ],
    );
  }
}
