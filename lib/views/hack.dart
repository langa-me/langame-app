import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/admin_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';

class HackView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HackView> with AfterLayoutMixin<HackView> {
  final myController = TextEditingController();
  List<String> topics = [];
  List<lg.Prompt> prompts = [];
  String? selectedTopic;
  String? selectedPrompt;
  int? selectedAmount;
  List<DocumentSnapshot<lg.Meme>>? memesToCheck;
  bool isLoading = true;

  TextEditingController? memeController;
  List<TextEditingController>? memeTopicControllers;
  List<String>? currentMemeTopics;

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('hack_view');
    var ap = Provider.of<AdminProvider>(context, listen: false);
    var f1 = ap.getTopics().then((value) => setState(() => topics = value));
    var f2 = ap.getPrompts().then((value) => setState(() => prompts = value));
    Future.wait([f1, f2]).whenComplete(() => setState(() => isLoading = false));
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var ap = Provider.of<AdminProvider>(context);

    final PageController controller = PageController(initialPage: 0);
    return Scaffold(
      backgroundColor: getBlackAndWhite(context, 0, reverse: true),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Center(child: cp.buildLoadingWidget())])
          : PageView(
              scrollDirection: Axis.vertical,
              controller: controller,
              children: memesToCheck == null || memesToCheck!.isEmpty
                  ? <Widget>[
                      Center(
                        child: Text('SEARCH MEME'),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: AppSize.safeBlockVertical * 60,
                                  width: AppSize.safeBlockHorizontal * 60,
                                  color: Colors.transparent,
                                  child: ListView(
                                    children: prompts
                                        .map((e) => ExpansionTile(
                                              backgroundColor: getBlackAndWhite(
                                                  context,
                                                  selectedPrompt == e.type
                                                      ? 2
                                                      : 1,
                                                  reverse: true),
                                              collapsedBackgroundColor:
                                                  getBlackAndWhite(
                                                      context,
                                                      selectedPrompt == e.type
                                                          ? 2
                                                          : 1,
                                                      reverse: true),
                                              // onTap: () => setState(() => selectedPrompt = e.type),
                                              title: Text(
                                                e.type,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                              trailing: Switch(
                                                value: selectedPrompt == e.type,
                                                onChanged: (_) => setState(() =>
                                                    selectedPrompt = e.type),
                                              ),
                                              children: [
                                                SingleChildScrollView(
                                                    child: Column(
                                                  children: [
                                                    Text(e.template),
                                                  ],
                                                ))
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                ),
                                Container(
                                  height: AppSize.safeBlockVertical * 60,
                                  width: AppSize.safeBlockHorizontal * 40,
                                                                    color: Colors.transparent,

                                  child: ListView(
                                    children: topics
                                        .map((e) => ListTile(
                                              tileColor: getBlackAndWhite(
                                                  context,
                                                  selectedTopic == e ? 2 : 1,
                                                  reverse: true),
                                              onTap: () => setState(
                                                  () => selectedTopic = e),
                                              title: Text(
                                                e,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: AppSize.safeBlockVertical * 15),
                            LangameButton(
                              FontAwesomeIcons.brain,
                              text: 'generate',
                              highlighted: true,
                              onPressed: () {
                                if (selectedTopic == null) {
                                  cp.showSnackBar(
                                      'You must select a topic at least');
                                  return;
                                }
                                setState(() => isLoading = true);
                                ap
                                    .generate(selectedTopic!,
                                        prompt: selectedPrompt,
                                        amount: selectedAmount)
                                    .then((e) {
                                  if (e != null) {
                                    setState(() {
                                      memeController = TextEditingController();
                                      memesToCheck = e;
                                      memeTopicControllers = [];
                                    });
                                    memeController!.text =
                                        e.first.data()!.content;
                                    currentMemeTopics = e.first.data()!.topics;
                                  } else {
                                    cp.showSnackBar('failed to generate');
                                  }
                                }).whenComplete(() =>
                                        setState(() => isLoading = false));
                              },
                            ),
                            Container(
                                width: AppSize.safeBlockHorizontal * 80,
                                child: Column(children: [
                                  Text(
                                    selectedAmount != null
                                        ? selectedAmount.toString() + ' meme(s)'
                                        : '1 meme(s)',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Slider(
                                    min: 1,
                                    max: 10,
                                    divisions: 9,
                                    value: selectedAmount != null
                                        ? selectedAmount!.toDouble()
                                        : 1.0,
                                    onChanged: (e) => setState(
                                      () => selectedAmount = e.toInt(),
                                    ),
                                  ),
                                ]))
                          ])
                    ]
                  : [
                      Column(children: [
                        Container(
                            height: AppSize.safeBlockVertical * 30,
                            child: SingleChildScrollView(
                                child: Column(children: [
                              TextFormField(
                                controller: memeController,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ]))),
                        Container(
                          height: AppSize.safeBlockVertical * 30,
                          width: AppSize.safeBlockVertical * 80,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: currentMemeTopics!.map<Widget>((t) {
                                  var ct = TextEditingController();
                                  ct.text = t;
                                  memeTopicControllers!.add(ct);
                                  return Container(
                                      width: AppSize.safeBlockHorizontal * 5,
                                      height: AppSize.safeBlockVertical * 10,
                                      child: TextFormField(
                                        controller: ct,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ));
                                }).toList() +
                                <Widget>[
                                  LangameButton(
                                    FontAwesomeIcons.plusCircle,
                                    onPressed: () => setState(
                                        () => currentMemeTopics!.add('fillme')),
                                  )
                                ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LangameButton(
                              FontAwesomeIcons.trash,
                              onPressed: () {
                                setState(() => isLoading = true);
                                ap.delete([memesToCheck!.first.id]).then((ok) {
                                  if (ok) {
                                    memesToCheck!.removeWhere((mtc) =>
                                        mtc.id == memesToCheck!.first.id);
                                    currentMemeTopics = memesToCheck!.length > 0 ?
                                        memesToCheck!.first.data()!.topics : [];
                                  } else
                                    cp.showSnackBar('failed to delete');
                                }).whenComplete(
                                    () => setState(() => isLoading = false));
                              },
                            ),
                            LangameButton(
                              FontAwesomeIcons.checkCircle,
                              onPressed: () {
                                setState(() => isLoading = true);

                                ap
                                    .confirm(
                                        memesToCheck!.first.id,
                                        memeController!.text,
                                        memeTopicControllers!
                                            .map((e) => e.text)
                                            .toList())
                                    .then((ok) {
                                  if (ok) {
                                    memesToCheck!.removeWhere((mtc) =>
                                        mtc.id == memesToCheck!.first.id);
                                    currentMemeTopics = memesToCheck!.length > 0 ?
                                        memesToCheck!.first.data()!.topics : [];
                                  } else
                                    cp.showSnackBar('failed to confirm');
                                }).whenComplete(() =>
                                        setState(() => isLoading = false));
                              },
                            ),
                          ],
                        ),
                      ]),
                    ],
            ),
    );
  }
}
