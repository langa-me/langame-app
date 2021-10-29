import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/settings_view.dart';
import 'package:langame/views/topics/favorite_topics_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'main_view.dart';
import 'notifications/notification_view.dart';

/// Setup the app for the user (topics, friends...)
class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State with AfterLayoutMixin {
  final _formKey = GlobalKey<FormState>(debugLabel: '_formKey');
  bool hasFinishedOnBoarding = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('on_boarding');
    // TODO: collect metrics about time spent on each page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: getBlackAndWhite(context, 0, reverse: true),
        color: getBlackAndWhite(context, 0),
        done: Icon(FontAwesomeIcons.check,
            color: Theme.of(context).colorScheme.secondary),
        next: Icon(FontAwesomeIcons.arrowRight,
            color: Theme.of(context).colorScheme.secondary),
        pages: _buildPageModels(),
        isBottomSafeArea: true,
        showDoneButton: hasFinishedOnBoarding,
        onDone: _onDone, // TODO: ask permission notification
      ),
    );
  }

  PageViewModel _buildNotificationPreferences() {
    return PageViewModel(
      titleWidget: Text('Want any notifications?',
          style: Theme.of(context).textTheme.headline5),
      bodyWidget: Consumer<PreferenceProvider>(
        builder: (context, p, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: AppSize.safeBlockVertical * 40,
                child: buildNotificationPreferences(context, p)),
            !kIsWeb
                ? Lottie.asset(
                    'animations/notification.json',
                    height: AppSize.safeBlockVertical * 40,
                    width: AppSize.safeBlockHorizontal * 40,
                    alignment: Alignment.center,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  List<PageViewModel> _buildPageModels() {
    return [
      _buildPitch(),
      PageViewModel(
        titleWidget: Text('What are your interests?',
            style: Theme.of(context).textTheme.headline5),
        footer: Text('We will use it to customize your first experiences.',
            style: Theme.of(context).textTheme.caption),
        bodyWidget: Container(
            child: FavoriteTopicsWidget(),
            height: AppSize.safeBlockVertical * 40,
            width: AppSize.safeBlockHorizontal * 80,
          ),
      ),
      PageViewModel(
        titleWidget: Text('Get user recommendations?',
            style: Theme.of(context).textTheme.headline5),
        bodyWidget: Consumer<PreferenceProvider>(
          builder: (context, p, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildRecommendationSetting(context, p),
              !kIsWeb
                  ? Lottie.asset(
                      'animations/recommendations.json',
                      height: AppSize.safeBlockVertical * 70,
                      width: AppSize.safeBlockHorizontal * 70,
                      alignment: Alignment.center,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
      _buildNotificationPreferences(),
      PageViewModel(
        titleWidget:
            Text('Choose a tag', style: Theme.of(context).textTheme.headline5),
        bodyWidget: _buildTagForm(),
      ),
    ];
  }

  PageViewModel _buildPitch() {
    return PageViewModel(
      titleWidget:
          Text('Why Langame?', style: Theme.of(context).textTheme.headline5),
      bodyWidget: Column(children: [
        !kIsWeb
            ? Lottie.asset(
                'animations/conversation.json',
                height: AppSize.safeBlockVertical * 40,
                width: AppSize.safeBlockHorizontal * 70,
                alignment: Alignment.center,
              )
            : SizedBox.shrink(),
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

  // This is a single page pitching the benefits of Langame and what it brings to the user
  Widget _buildTagForm() {
    return Form(
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
              hintStyle: Theme.of(context).textTheme.headline6,
              prefixIcon: Icon(
                Icons.alternate_email_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('^[a-zA-Z]*\$')),
            ],
            maxLength: 8,
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
                var cp = Provider.of<ContextProvider>(context, listen: false);
                cp.showLoadingDialog(text: 'Validating...');
                var ap =
                    Provider.of<AuthenticationProvider>(context, listen: false);
                ap.updateTag(_textEditingController.text).then((res) {
                  cp.handleLangameResponse(
                    res,
                    succeedMessage:
                        'Welcome to Langame ${_textEditingController.text}',
                    failedMessage: 'Tag is not available',
                    onSucceed: () {
                      setState(() => hasFinishedOnBoarding = true);
                      _onDone();
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
    );
  }

  void _onDone() async {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var fp = Provider.of<FunnyProvider>(context, listen: false);
    cp.showLoadingDialog();
    var showFailure = () async {
      cp.dialogComplete();
      cp.showFailureDialog(fp.getFailingRandom());
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
    };
    var pp = Provider.of<PreferenceProvider>(context, listen: false);
    pp.preference.hasDoneOnBoarding = true;
    var r = await pp.save();
    cp.handleLangameResponse(r, onFailure: showFailure, onSucceed: () {
      cp.dialogComplete();
      cp.pushReplacement(MainView());
    });
  }
}
