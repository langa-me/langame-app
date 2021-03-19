import 'dart:convert';
import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:langame/api/api.pb.dart';
import 'package:langame/helpers/functional.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:langame/views/schedule.dart';

class TopicView extends StatefulWidget {
  @override
  _TopicState createState() => _TopicState();
}

class _TopicState extends State<TopicView> with AfterLayoutMixin<TopicView> {
  late Future<Talks> _data;
  List<Widget> topicGroups = [];
  TopicProvider provider = TopicProvider();
  @override
  void initState() {
    super.initState();
    provider.getAllTopics(); // TODO: doesn't load

    // _data = _fetchTalks();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // provider = Provider.of<TopicProvider>(context);

    provider.topicStream.listen((event) {
      topicGroups.add(TopicGroupCard(event));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: ListView(children: topicGroups));
    // provider = Provider.of<TopicProvider>(context);
    // return FutureBuilder<void>(
    //     future: provider.getAllTopics(),
    //     builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
    //       return StreamProvider<TopicGroup>.value(
    //         value: provider.topicStream,
    //         initialData: TopicGroup(),
    //         child: Consumer<TopicGroup>(
    //           builder: (context, TopicGroup data, w) {
    //             print('doc: $data');
    //             return Align(child: TopicGroupCard(data));
    //           },
    //         ),
    //       );
    //     });
    // return StreamBuilder(
    //     stream: provider.topicStream,
    //     builder: (BuildContext context, AsyncSnapshot<TopicGroup> snapshot) {
    //       List<Widget> children = <Widget>[];
    //       if (snapshot.hasData) {
    //         print(snapshot.data);
    //         snapshot.data ?? children.add(TopicGroupCard(snapshot.data!));
    //         print(children);
    //       } else if (snapshot.hasError) {
    //         children = <Widget>[
    //           Icon(
    //             Icons.error_outline,
    //             color: Colors.red,
    //             size: 60,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(top: 16),
    //             child: Text('Error: ${snapshot.error}'),
    //           )
    //         ];
    //       } else {
    //         children = <Widget>[
    //           SizedBox(
    //             child: CircularProgressIndicator(),
    //             width: 60,
    //             height: 60,
    //           ),
    //           const Padding(
    //             padding: EdgeInsets.only(top: 16),
    //             child: Text('Loading topics...'),
    //           )
    //         ];
    //       }
    //       return Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: children,
    //         ),
    //       );
    //     });
    // Column(children: [
    //   Text('Recommendations'),
    //   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    //     _buildActionButton(theme, 'Philosophy'),
    //     _buildActionButton(theme, 'Trans-humanism'),
    //     _buildActionButton(theme, 'BCI'),
    //   ]),
    //   Text('Life'),
    //   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    //     _buildActionButton(theme, 'Philosophy'),
    //     _buildActionButton(theme, 'Trans-humanism'),
    //     _buildActionButton(theme, 'BCI'),
    //   ]),
    //   Text('Personal'),
    //   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    //     _buildActionButton(theme, 'Philosophy'),
    //     _buildActionButton(theme, 'Philosophy'),
    //     _buildActionButton(theme, 'Philosophy'),
    //   ]),
    // ]),
    // );
    // return FutureBuilder<Talks>(
    //   future: _data,
    //   builder: (context, snapshot) {
    //     Widget? child;
    //     if (snapshot.hasData) {
    //       final d = snapshot.data!.basic
    //           .map((e) => _buildActionButton(theme, e))
    //           .toList();
    //       child = ListView.builder(
    //         itemCount: d.length,
    //         itemBuilder: (context, index) {
    //           return d[index];
    //         },
    //       );
    //     } else if (snapshot.hasError) {
    //       debugPrint("${snapshot.error}");
    //     } else {
    //       child = CircularProgressIndicator();
    //     }
    //     return Scaffold(
    //       appBar: AppBar(),
    //       body: child,
    //     );
    //   },
    // );
  }

  Future<Talks> _fetchTalks() async {
    final res = await get(Uri.https('raw.githubusercontent.com',
        'louis030195/big-talks/main/docs/big-talks.json'));

    print(res.body);
    if (res.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Talks.fromJson(jsonDecode(res.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load talks');
    }
  }
}

class Talks {
  List<String> basic = <String>[];

  factory Talks.fromJson(Map<String, dynamic> json) {
    return Talks(
      List<String>.from(json['basic']),
    );
  }

  Talks(this.basic);
}

Widget _buildActionButton(BuildContext context, ThemeData theme, String text) {
  return TextButton(
      style: ButtonStyle(
          textStyle:
              MaterialStateProperty.all<TextStyle>(theme.textTheme.button!),
          backgroundColor: MaterialStateProperty.all<Color>(
              Color((Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.5))),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScheduleView()),
        );
      },
      child: Text(text));
}

class TopicGroupCard extends StatelessWidget {
  const TopicGroupCard(this.topicGroup);
  final TopicGroup topicGroup;
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
                              3) // TODO: too big topics may depasser screen
                          .map((e) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: e
                                    .map((e) =>
                                        _buildActionButton(context, theme, e))
                                    .intersperse(SizedBox(width: 20))
                                    .toList(),
                              ))
                          .toList()
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: this
                      //       .topicGroup
                      //       .topics
                      //       .map((e) => _buildActionButton(context, theme, e))
                      //       .intersperse(SizedBox(width: 20))
                      //       .toList(),
                      // )
                      ),
                ]),
                decoration: BoxDecoration(
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0)),
                ),
              ))),
    );
  }
}
