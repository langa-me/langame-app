import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:provider/provider.dart';

class TopicView extends StatefulWidget {
  final LangameUser user;
  TopicView(this.user);

  @override
  _TopicState createState() => _TopicState(user);
}

class _TopicState extends State<TopicView> with AfterLayoutMixin<TopicView> {
  List<Widget> topicGroups = [];
  late TopicProvider provider;
  LangameUser user;

  _TopicState(this.user);

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<TopicProvider>(context, listen: false).getAllTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Langame to ${user.displayName}'),
      ),
      // body: Consumer<TopicProvider>(
      //   builder: (context, t, child) {
      //     return ListView(
      //         children: t.topicGroups
      //             .map((e) => TopicGroupCard(e, onPressed: buildBasicButton(context, text, onPressed: _onTopicPressed())))
      //             .toList());
      //   },
      // ),
    );
  }

  // void _onTopicPressed(BuildContext context, String text, LangameUser user) {
  //   // TODO: send message to X, I send you a Langame
  //   // and also make an api call or message triggered
  //   // piece of code that find appropriate question
  //   var messageProvider =
  //       Provider.of<AuthenticationProvider>(context, listen: false);
  //   messageProvider.send(text).then((e) {
  //     final snackBar =
  //         SnackBar(content: Text('Sent $text to ${user.displayName}'));
  //
  //     // Find the ScaffoldMessenger in the widget tree
  //     // and use it to show a SnackBar.
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     Navigator.pop(context);
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => FriendsView()),
  //     );
  //   }).catchError((err) {
  //     final snackBar = SnackBar(
  //         content: Text(
  //             'Failed to send $text to ${user.displayName}, ${(err as SendLangameException).cause}'));
  //
  //     // Find the ScaffoldMessenger in the widget tree
  //     // and use it to show a SnackBar.
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }, test: (e) => e is SendLangameException);
  // }
}

// class TopicGroupCard extends StatelessWidget {
//   const TopicGroupCard(this.topicGroup, this.topicWidget);
//   final TopicGroup topicGroup;
//   final Widget topicWidget;
//
//   @override
//   Widget build(BuildContext context) {
//     return new Card(
//       child: new Center(
//           child: new Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Container(
//                 child: Column(children: [
//                   Text(this.topicGroup.name),
//                   Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: this
//                           .topicGroup
//                           .topics
//                           .asChunk(
//                               1) // TODO: too big topics may depasser screen
//                           .map((e) => Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: e
//                                     .map((e) => this.topicWidget(e))
//                                     .intersperse(SizedBox(width: 5))
//                                     .toList(),
//                               ))
//                           .toList()),
//                 ]),
//                 decoration: BoxDecoration(
//                   borderRadius:
//                       new BorderRadius.all(const Radius.circular(10.0)),
//                 ),
//               ))),
//     );
//   }
// }
