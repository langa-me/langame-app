import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/toast.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/local_storage_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'dialogs/dialogs.dart';
import 'friends.dart';
import 'notifications.dart';

/// Setup the app for the user (topics, friends...)
class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State with AfterLayoutMixin {
  List<Topic> favouriteTopics = [];
  final controller = PageController(initialPage: 0, viewportFraction: 0.9);

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>(debugLabel: '_formKey');
  final GlobalKey<State> _keyLoader =
      new GlobalKey<State>(debugLabel: '_keyLoader');

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .analytics
        .setCurrentScreen(screenName: 'setup');
    // Provider.of<TopicProvider>(context, listen: false).getAllTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        done: Text("Done"),
        next: Text("Next"),
        pages: _buildPageModels(),
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
              FilteringTextInputFormatter.allow(RegExp('^[a-zA-Z0-9]*\$')),
            ],
            maxLength: 8,
            // The validator receives the text that the user has entered.
            validator: (value) {
              showBasicSnackBar(context, 'this is not implemented yet!');
              // TODO: validation should at least check availability of tag
              // TODO: and maybe check profanity (funniest part)
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
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
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  void _onDone() {
    Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
      'favourite topics ${favouriteTopics.map((e) => e.content).join(",")}',
      analyticsMessage: 'favourite_topics',
      analyticsParameters: {'topics': favouriteTopics.join(',')},
    );

    // TODO: send mail to everyone "join langame bro"

    Future<LangameResponse> f =
        Provider.of<AuthenticationProvider>(context, listen: false)
            .initializeMessageApi(onBackgroundOrForegroundOpened);
    LgDialogs.showLoadingDialog(context, _keyLoader,
        Provider.of<FunnyProvider>(context, listen: false).getLoadingRandom());

    f.then((res) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      res.thenShowSnackBar(
        context: context,
        failedMessage: !kReleaseMode
            ? 'failed to initialize the application, ${res.error.toString()}'
            : Provider.of<FunnyProvider>(context, listen: false)
                .getFailingRandom(),
        onSucceed: () {
          Provider.of<LocalStorageProvider>(context, listen: false)
              .saveHasDoneSetup(true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FriendsView(),
            ),
          );
        },
        onFailure: () => controller.previousPage(
            duration: new Duration(seconds: 1), curve: Curves.bounceIn),
      );
    });
  }

  List<PageViewModel> _buildPageModels() => [
        PageViewModel(
          title: 'Send us a feedback anytime?',
          bodyWidget: Consumer<FeedbackProvider>(
            builder: (context, p, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () {
                    p.detectShakes = !p.detectShakes;
                  },
                  leading: Icon(Icons.feedback_outlined),
                  title: Text('Shake-to-feedback'),
                  trailing: Switch(
                      value: p.detectShakes,
                      onChanged: (v) => p.detectShakes = !p.detectShakes),
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
          title: 'Choose a tag',
          bodyWidget: _buildTagForm(),
        ),
      ];
}
