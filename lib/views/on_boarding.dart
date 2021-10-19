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
import 'package:langame/providers/tag_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import 'feature_preview/beta.dart';
import 'main_view.dart';

/// Setup the app for the user (topics, friends...)
class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State with AfterLayoutMixin {
  final _formKey = GlobalKey<FormState>(debugLabel: '_formKey');
  bool hasFinishedOnBoarding = false;

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('on_boarding');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
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

  Widget _buildTagForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            style: Theme.of(context).textTheme.headline6,
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
              var cp = Provider.of<ContextProvider>(context, listen: false);
              cp.showLoadingDialog(text: 'Validating...');
              var ap =
                  Provider.of<AuthenticationProvider>(context, listen: false);
              ap.updateTag(value).then((res) {
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
            child: LangameButton(
              FontAwesomeIcons.tag,
              text: 'Choose this tag',
              highlighted: true,
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
    pp.preference!.hasDoneOnBoarding = true;
    var r = await pp.save();
    cp.handleLangameResponse(r, onFailure: showFailure, onSucceed: () {
      cp.dialogComplete();
      cp.pushReplacement(MainView());
    });
  }

  List<PageViewModel> _buildPageModels() {
    return [
      PageViewModel(
        titleWidget: Text('What are your interests?',
            style: Theme.of(context).textTheme.headline5),
        bodyWidget: Container(
            height: AppSize.safeBlockVertical * 80,
            width: AppSize.safeBlockHorizontal *
                45 *
                (AppSize.isLargeWidth ? 1 : 2),
            child: Consumer2<PreferenceProvider, TagProvider>(
              builder: (context, pp, tp, child) => Container(
                  height: AppSize.safeBlockVertical * 80,
                  width: AppSize.safeBlockHorizontal *
                      45 *
                      (AppSize.isLargeWidth ? 1 : 2),
                  alignment: Alignment.center,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20.0),
                    children: tp.availableTopics
                        .map(
                          (e) => ToggleButton(
                              width: AppSize.safeBlockHorizontal *
                                  45 *
                                  (AppSize.isLargeWidth ? 1 : 2),
                              selected: pp.preference != null &&
                                  pp.preference!.favoriteTopics.contains(e),
                              onChange: (bool selected) {
                                if (selected)
                                  pp.addFavoriteTopic(e);
                                else
                                  pp.removeFavoriteTopic(e);
                              },
                              textUnselected: e,
                              textSelected: e),
                        )
                        .toList(),
                  )),
            )),
      ),
      PageViewModel(
        titleWidget: Text('Get user recommendations?',
            style: Theme.of(context).textTheme.headline5),
        bodyWidget: Consumer<PreferenceProvider>(
          builder: (context, p, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Beta(
                  Icon(FontAwesomeIcons.cartPlus,
                      color: getBlackAndWhite(context, 0)),
                  type: BetaType.SOON,
                ),
                title: Text('New relationships',
                    style: Theme.of(context).textTheme.headline6),
                trailing: Switch(value: false, onChanged: (_) {}),
              ),
              ListTile(
                onTap: () => p.setRecommendations(
                    p.preference!.userRecommendations ==
                            lg.UserPreference_RecommendationType.COMPOUND
                        ? lg.UserPreference_RecommendationType.NONE
                        : lg.UserPreference_RecommendationType.COMPOUND),
                leading: Icon(FontAwesomeIcons.layerGroup,
                    color: getBlackAndWhite(context, 0)),
                title: Text('Compound relationships',
                    style: Theme.of(context).textTheme.headline6),
                trailing: Switch(
                    value: p.preference!.userRecommendations ==
                        lg.UserPreference_RecommendationType.COMPOUND,
                    onChanged: (v) => p.setRecommendations(v
                        ? lg.UserPreference_RecommendationType.COMPOUND
                        : lg.UserPreference_RecommendationType.NONE)),
              ),
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
      PageViewModel(
        titleWidget: Text('Your friends don\'t have Langame?',
            style: Theme.of(context).textTheme.headline5),
        bodyWidget: Column(children: [
          !kIsWeb
              ? Lottie.asset(
                  'animations/share.json',
                  height: AppSize.safeBlockVertical * 70,
                  width: AppSize.safeBlockHorizontal * 70,
                  alignment: Alignment.center,
                )
              : SizedBox.shrink(),
          LangameButton(
            FontAwesomeIcons.shareAlt,
            highlighted: true,
            onPressed: () => Share.share(
                'I\'m using Langame to have incredible conversations, you should try:\n${AppConst.mainUrl}',
                subject:
                    'Join me on Langame app for incredible conversations!'),
            text: 'Invite your friends',
          )
        ]),
      ),
      PageViewModel(
        titleWidget:
            Text('Choose a tag', style: Theme.of(context).textTheme.headline5),
        bodyWidget: _buildTagForm(),
      ),
    ];
  }
}
