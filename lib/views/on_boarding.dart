import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/langames/langames_schedule_settings_widget.dart';
import 'package:langame/views/languages/language_selection_widget.dart';
import 'package:langame/views/topics/favorite_topics_widget.dart';
import 'package:langame/views/topics/most_popular_topics.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'goals/goals_list_tiles.dart';
import 'main_view.dart';
import 'notifications/notification_view.dart';

/// Setup the app for the user (topics, friends...)
class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State with AfterLayoutMixin {
  final _introKey = GlobalKey<IntroductionScreenState>();
  final _formKey = GlobalKey<FormState>(debugLabel: '_formKey');
  TextEditingController _textEditingController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('on_boarding');
    // TODO: collect metrics about time spent on each page
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: IntroductionScreen(
            key: _introKey,
            globalBackgroundColor: getBlackAndWhite(context, 0, reverse: true),
            color: getBlackAndWhite(context, 0),
            done: Icon(FontAwesomeIcons.check,
                color: Theme.of(context).colorScheme.secondary),
            next: Icon(FontAwesomeIcons.arrowRight,
                color: Theme.of(context).colorScheme.secondary),
            pages: _buildPageModels(),
            isBottomSafeArea: true,
            showDoneButton: false,
            onDone: _onDone, // TODO: ask permission notification
            dotsFlex: 2,
          ),
        ));
  }

  List<PageViewModel> _buildPageModels() {
    return [
      _buildPitch(),
      _buildFavoriteTopicsPage(),
      _buildGoalsPage(),
      // _buildLanguagePage(), // TODO: implement me
      _buildNotificationPreferences(),
      _buildProfilePage(),
      // _buildFindContactPage(), // TODO: implement me
      _buildLangameSchedulerPage(),
    ];
  }

  PageViewModel _buildPitch() {
    return PageViewModel(
      decoration: PageDecoration(
        bodyAlignment: Alignment.center,
      ),
      titleWidget:
          Text('Why Langame?', style: Theme.of(context).textTheme.headline5),
      bodyWidget: Column(children: [
        Lottie.asset(
          'animations/conversation.json',
          height: AppSize.safeBlockVertical *
              40 *
              (AppSize.isLargeWidth ? 1 : 0.75),
          width: AppSize.safeBlockHorizontal * 70,
          alignment: Alignment.center,
        ),
        // This is a rounded box containing text highlighting the benefit of this application
        Container(
          width:
              AppSize.safeBlockHorizontal * 45 * (AppSize.isLargeWidth ? 1 : 2),
          height: AppSize.safeBlockVertical * 40,
          decoration: BoxDecoration(
            color: getBlackAndWhite(context, 1, reverse: true),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'The Internet and computers have brought connectivity, but have not improved conversations. Artificial intelligence is capable of understanding us better than we understand ourselves.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(height: AppSize.safeBlockVertical * 5),
                  Text(
                    'Conversations are what increase transparency, cooperation and therefore prosperity, knowledge and happiness.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ]),
          ),
        ),
      ]),
    );
  }

  PageViewModel _buildFavoriteTopicsPage() {
    var pp = Provider.of<PreferenceProvider>(context);
    return PageViewModel(
      decoration: PageDecoration(
        bodyAlignment: Alignment.center,
      ),
      titleWidget: Text('What are your interests?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5),
      bodyWidget: Container(
        width: AppSize.safeBlockHorizontal * 80,
        height: AppSize.safeBlockVertical * 80,
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Wrap(
              spacing: 2,
              runSpacing: 2,
              children: getMostPopularTopics()
                  .map(
                    (e) => ChoiceChip(
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      selected: pp.preference.favoriteTopics.contains(e),
                      onSelected: (value) => value
                          ? pp.addFavoriteTopic(e)
                          : pp.removeFavoriteTopic(e),
                      label: Text(
                        e,
                        style: Theme.of(context).textTheme.headline6!.merge(
                              TextStyle(
                                color: getBlackAndWhite(context, 0,
                                    reverse: pp.preference.favoriteTopics
                                        .contains(e)),
                              ),
                            ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: AppSize.safeBlockVertical * 5),
            Text('Popular topics',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption),
          ]),
          SizedBox(height: AppSize.safeBlockVertical * 5),
          Text(
            'You can also search',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: AppSize.safeBlockHorizontal * 100,
            height: AppSize.safeBlockVertical * 50,
            child: FavoriteTopicsWidget(),
          ),
          SizedBox(height: AppSize.safeBlockVertical * 20),
        ]),
      ),
    );
  }

  PageViewModel _buildGoalsPage() {
    return PageViewModel(
      decoration: PageDecoration(
        bodyAlignment: Alignment.center,
      ),
      titleWidget: Text('What are your goals with Langame?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5),
      footer: Text('It will customize the app according to your goals.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4),
      bodyWidget: Consumer<PreferenceProvider>(
        builder: (context, pp, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'animations/goal.json',
              height: AppSize.safeBlockVertical * 30,
              width: AppSize.safeBlockHorizontal * 40,
              alignment: Alignment.center,
            ),
            Container(
                height: AppSize.safeBlockVertical * 40,
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: buildGoalsListTiles(context, pp, layer: 1),
                    ).toList())),
          ],
        ),
      ),
    );
  }

  PageViewModel _buildLanguagePage() {
    return PageViewModel(
      decoration: PageDecoration(
        bodyAlignment: Alignment.center,
      ),
      titleWidget: Text('What is your preferred written language?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5),
      bodyWidget: LanguageSelectionWidget(),
    );
  }

  PageViewModel _buildNotificationPreferences() {
    final mp = Provider.of<MessageProvider>(context);
    return PageViewModel(
      decoration: PageDecoration(
        bodyAlignment: Alignment.center,
      ),
      titleWidget: Text('How do you want to be notified?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5),
      bodyWidget: Consumer<PreferenceProvider>(
        builder: (context, p, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'animations/notification.json',
              height: AppSize.safeBlockVertical * 40,
              width: AppSize.safeBlockHorizontal * 40,
              alignment: Alignment.center,
            ),
            Container(
                height: AppSize.safeBlockVertical * 40,
                child: buildNotificationPreferences(context, p, mp)),
          ],
        ),
      ),
    );
  }

  // This is a single page pitching the benefits of Langame and what it brings to the user
  PageViewModel _buildProfilePage() {
    return PageViewModel(
      decoration: PageDecoration(
        bodyAlignment: Alignment.center,
      ),
      titleWidget:
          Text('Choose a tag', style: Theme.of(context).textTheme.headline5),
      footer: Text(
          'That\'s how people will find you.\nYou can change this later.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5),
      bodyWidget: Container(
        width: AppSize.safeBlockHorizontal * (AppSize.isLargeWidth ? 40 : 80),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                style: Theme.of(context).textTheme.headline6,
                controller: _textEditingController,
                decoration: new InputDecoration(
                  focusColor: Theme.of(context).colorScheme.secondary,
                  // fillColor: Theme.of(context).colorScheme.primary,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: 'How will people find you?',
                  fillColor: getBlackAndWhite(context, 1, reverse: true),
                  hintStyle: Theme.of(context).textTheme.headline6,
                  prefixIcon: Icon(
                    Icons.alternate_email_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('^[a-zA-Z]*\$')),
                ],
                maxLength: 12,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: LangameButton(
                  FontAwesomeIcons.tag,
                  text: 'Choose this tag',
                  highlighted: true,
                  onPressed: () {
                    var cp =
                        Provider.of<ContextProvider>(context, listen: false);
                    cp.showLoadingDialog(text: 'Validating...');
                    var ap = Provider.of<AuthenticationProvider>(context,
                        listen: false);
                    ap.updateTag(_textEditingController.text).then((res) {
                      cp.handleLangameResponse(
                        res,
                        succeedMessage:
                            'Welcome to Langame ${_textEditingController.text}',
                        failedMessage: 'Tag is not available',
                        onSucceed: () {
                          final currentPage =
                              _introKey.currentState?.controller.page ?? 0.0;

                          _introKey.currentState
                              ?.animateScroll(currentPage.toInt() + 1);
                        },
                      );
                    }).whenComplete(() {
                      cp.dialogComplete();
                      // Hide keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageViewModel _buildLangameSchedulerPage() {
    final pp = Provider.of<PreferenceProvider>(context, listen: false);
    var kindOfRelationshipsMessage =
        LangamesScheduleSettingsWidget.getKindOfRelationshipsMessage(pp);

    return PageViewModel(
      decoration: PageDecoration(
        bodyAlignment: Alignment.center,
      ),
      titleWidget: Text('Schedule your Langames',
          style: Theme.of(context).textTheme.headline5),
      footer: Container(
        width: AppSize.safeBlockHorizontal * 70,
        child: Text(kindOfRelationshipsMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5),
      ),
      bodyWidget: LangamesScheduleSettingsWidget(
        onDone: _onDone,
      ),
    );
  }

  void _onDone() async {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var pp = Provider.of<PreferenceProvider>(context, listen: false);
    pp.preference.hasDoneOnBoarding = true;
    await pp.save();
    cp.pushReplacement(MainView());
  }
}
