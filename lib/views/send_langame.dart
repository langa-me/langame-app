import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/functional.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/topic.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:langame/views/friends.dart';
import 'package:provider/provider.dart';

class SendLangameView extends StatefulWidget {
  final LangameUser _user;
  SendLangameView(this._user);

  @override
  _SendLangameState createState() => _SendLangameState(_user);
}

class _SendLangameState extends State<SendLangameView>
    with AfterLayoutMixin<SendLangameView> {
  List<Widget> topicGroups = [];
  late TopicProvider provider;
  LangameUser _user;

  _SendLangameState(this._user);

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<TopicProvider>(context, listen: false).getAllTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Send Langame ...'),
        ),
        body: Consumer<TopicProvider>(
          builder: (context, t, child) {
            return ListView(
                children: t.topicGroups
                    .map((e) => TopicGroupCard(e, _user))
                    .toList());
          },
        ));

    // return Scaffold(appBar: AppBar(), body: ListView(children: topicGroups));
  }
}

class TopicGroupCard extends StatelessWidget {
  const TopicGroupCard(this.topicGroup, this.user);
  final TopicGroup topicGroup;
  final LangameUser user;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new Card(
      child: new Center(
          child: new Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                child: Column(children: [
                  Text(this.topicGroup.name),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: this
                          .topicGroup
                          .topics
                          .asChunk(
                              2) // TODO: too big topics may depasser screen
                          .map((e) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: e
                                    .map((e) =>
                                        _buildButton(context, theme, e, user))
                                    .intersperse(SizedBox(width: 5))
                                    .toList(),
                              ))
                          .toList()),
                ]),
                decoration: BoxDecoration(
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0)),
                ),
              ))),
    );
  }

  Widget _buildButton(
      BuildContext context, ThemeData theme, String text, LangameUser user) {
    return OutlinedButton.icon(
        style: theme.textButtonTheme.style,
        onPressed: () {
          // TODO: send message to X, I send you a Langame
          // and also make an api call or message triggered
          // piece of code that find appropriate question
          var provider =
              Provider.of<AuthenticationProvider>(context, listen: false);
          provider.send(user, text).then((e) {
            final snackBar =
                SnackBar(content: Text('Sent $text to ${user.displayName}'));

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FriendsView()),
            );
          }).catchError((err) {
            final snackBar = SnackBar(
                content: Text(
                    'Failed to send $text to ${user.displayName}, ${(err as LangameSendLangameException).cause}'));

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }, test: (e) => e is LangameSendLangameException);
        },
        icon: Icon(Icons.autorenew_outlined),
        label: Text(text));
  }
}
