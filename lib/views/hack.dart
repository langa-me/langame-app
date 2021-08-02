import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:provider/provider.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

class HackView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HackView> with AfterLayoutMixin<HackView> {
  final myController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('hack_view');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tp = Provider.of<TagProvider>(context, listen: false);
    var cp = Provider.of<ContextProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: myController,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              setState(() {});
            },
          ),
          Expanded(
            child:
                FutureBuilder<LangameResponse<List<DocumentSnapshot<lg.Meme>>>>(
              future: tp.getMemeOfTopics([myController.text]),
              builder: (ctx, s) {
                if (s.data == null || s.data!.result == null) {
                  return cp.buildLoadingWidget();
                }
                if (s.data!.result!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          width: AppSize.blockSizeHorizontal * 30,
                          image: AssetImage('images/logo-colourless.png'),
                        ),
                        SizedBox(height: AppSize.safeBlockVertical * 10),
                        Text('Nothing there!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline4),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: s.data!.result!.length,
                    itemBuilder: (ctx, i) =>
                        _buildTile([myController.text], s.data!.result![i].data()!));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(List<String> topics, lg.Meme meme) => ExpansionTile(
        title: Text(
          meme.createdAt.toDateTime().toLocal().toString(),
          style: Theme.of(context).textTheme.headline6,
        ),
        children: [
          ListTile(
            title: Text(
              meme.content,
              style: Theme.of(context).textTheme.caption,
            ),
          )
        ],
      );
}
