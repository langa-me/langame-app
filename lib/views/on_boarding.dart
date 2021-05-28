import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main_view.dart';

/// Setup the app for the user (topics, friends...)
class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State with AfterLayoutMixin {
  List<Topic> favouriteTopics = [];

  final _formKey = GlobalKey<FormState>(debugLabel: '_formKey');
  bool hasFinishedOnBoarding = false;

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('setup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        done: Text('Done'),
        next: Text('Next'),
        pages: _buildPageModels(),
        isBottomSafeArea: true,
        showDoneButton: hasFinishedOnBoarding,
        onDone: _onDone, // TODO: ask permission notification
      ),
    );
  }

  Widget _buildTagForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: new InputDecoration(
              focusColor: Theme.of(context).colorScheme.secondary,
              // fillColor: Theme.of(context).colorScheme.primary,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: 'How will people find you?',
              // hintStyle: Theme.of(context).textTheme.button,
              prefixIcon: Icon(Icons.alternate_email_outlined,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('^[a-zA-Z]*\$')),
            ],
            maxLength: 8,
            // The validator receives the text that the user has entered.
            validator: (value) {
              // showBasicSnackBar(context, 'this is not implemented yet!');
              // TODO: validation should at least check availability of tag
              // TODO: and maybe check profanity (funniest part)
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              var cp = Provider.of<ContextProvider>(context, listen: false);
              cp.showLoadingDialog('Validating...');
              var ap =
                  Provider.of<AuthenticationProvider>(context, listen: false);
              ap // Sometimes the user has no displayName (apple hidden mail), using the tag then
                  .updateProfile(
                      tag: value,
                      displayName: ap.user!.displayName.isEmpty ? value : null)
                  .then((res) {
                cp.handleLangameResponse(
                  res,
                  succeedMessage: 'Welcome to Langame $value',
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  // ScaffoldMessenger.of(context)
                  //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Choose this tag'),
            ),
          ),
        ],
      ),
    );
  }

  void _onDone() async {
    // Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
    //   'favourite topics ${favouriteTopics.map((e) => e.content).join(',')}',
    //   analyticsMessage: 'favourite_topics',
    //   analyticsParameters: {'topics': favouriteTopics.join(',')},
    // );

    LangameResponse res =
        await Provider.of<MessageProvider>(context, listen: false)
            .initializeMessageApi();
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var fp = Provider.of<FunnyProvider>(context, listen: false);
    cp.showLoadingDialog(fp.getLoadingRandom());
    var showFailure = () async {
      cp.dialogComplete();
      cp.showFailureDialog(fp.getFailingRandom());
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
    };
    cp.handleLangameResponse(res, onSucceed: () async {
      var pp = Provider.of<PreferenceProvider>(context, listen: false);
      pp.preference.hasDoneOnBoarding = true;
      var r = await pp.save();
      cp.handleLangameResponse(r, onFailure: showFailure, onSucceed: () {
        cp.dialogComplete();
        cp.pushReplacement(MainView());
      });
    }, onFailure: showFailure);
  }

  List<PageViewModel> _buildPageModels() => [
        PageViewModel(
          title: 'Send us a feedback anytime?',
          bodyWidget: Consumer<PreferenceProvider>(
            builder: (context, p, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () =>
                      p.setShakeToFeedback(!p.preference.shakeToFeedback),
                  leading: Icon(Icons.feedback_outlined),
                  title: Text('Shake-to-feedback'),
                  trailing: Switch(
                    value: p.preference.shakeToFeedback,
                    onChanged: (v) =>
                        p.setShakeToFeedback(!p.preference.shakeToFeedback),
                  ),
                ),
                Lottie.asset(
                  'animations/feedback.json',
                  height: AppSize.safeBlockVertical * 70,
                  width: AppSize.safeBlockHorizontal * 70,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ),
        PageViewModel(
          title: 'Get user recommendations?',
          bodyWidget: Consumer<PreferenceProvider>(
            builder: (context, p, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () => p.setRecommendations(
                      !p.preference.unknownPeopleRecommendations),
                  leading: Icon(Icons.recommend),
                  title: Text('Unknown user recommendations'),
                  trailing: Switch(
                    value: p.preference.unknownPeopleRecommendations,
                    onChanged: (v) => p.setRecommendations(
                        !p.preference.unknownPeopleRecommendations),
                  ),
                ),
                Lottie.asset(
                  'animations/recommendations.json',
                  height: AppSize.safeBlockVertical * 70,
                  width: AppSize.safeBlockHorizontal * 70,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ),
        PageViewModel(
          title: 'Your friends don\'t have Langame?',
          bodyWidget: Column(children: [
            Lottie.asset(
              'animations/share.json',
              height: AppSize.safeBlockVertical * 70,
              width: AppSize.safeBlockHorizontal * 70,
              alignment: Alignment.center,
            ),
            LangameButton(
                () => Share.share(
                    'I\'m using Langame to have more interesting conversations, you should try:\n${AppConst.mainUrl}',
                    subject:
                        'Join me on Langame app for incredible conversations!'),
                'Invite your friends',
                FontAwesomeIcons.shareAlt)
          ]),
        ),
        PageViewModel(
          title: 'Choose a tag',
          bodyWidget: _buildTagForm(),
        ),
      ];
}
