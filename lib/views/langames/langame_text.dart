import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/messages.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/helpers/widget.dart';
import 'package:langame/models/djinn/djinn.pbgrpc.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:provider/provider.dart';
import 'package:langame/helpers/functional.dart';

class LangameTextView extends StatefulWidget {
  final lg.Langame initialLangame;
  LangameTextView(this.initialLangame);
  @override
  _State createState() => _State();
}

class _State extends State<LangameTextView>
    with AfterLayoutMixin<LangameTextView> {
  TextEditingController _textEditingController = TextEditingController();
  String _currentText = '';
  final f = new DateFormat('hh:mm');
  final ScrollController _scrollController = ScrollController();
  MagnificationResponse_Sentiment? _currentSentiment;
  bool _canSend = true;
  Set<String> _reflectionsLiked = {};

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('langame_text_view');

    postFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<ContextProvider>(context, listen: false);
    final lp = Provider.of<LangameProvider>(context);
    final mp = Provider.of<MessageProvider>(context);
    final ap = Provider.of<AuthenticationProvider>(context, listen: false);
    final fp = Provider.of<FirebaseApi>(context, listen: false);
    final myUid = ap.user!.uid;

    final langame =
        lp.langames[widget.initialLangame.id] ?? widget.initialLangame;
    final reflections = langame.reflections;
    reflections.sort(
      (a, b) => b.createdAt.toDateTime().compareTo(
            a.createdAt.toDateTime(),
          ),
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: getBlackAndWhite(context, 0, reverse: true),
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: false,
          iconTheme: IconThemeData(
            color: getBlackAndWhite(context, 0), //change your color here
          ),
          backgroundColor: Colors.transparent,
          actions: [buildPopupMenuWithHelpAndFeedback(context)],
        ),
        body: StreamBuilder<QuerySnapshot<lg.Message>>(
          stream: // TODO cursor etc
              fp.firestore!
                  .collection('messages')
                  .withConverter<lg.Message>(
                    fromFirestore: (s, _) => MessageExt.fromObject(s.data()!),
                    toFirestore: (s, _) => s.toMapStringDynamic(),
                  )
                  .where('langameId', isEqualTo: widget.initialLangame.id)
                  .orderBy('createdAt', descending: false)
                  .snapshots(),
          builder: (context, snapshot) => !snapshot.hasData ||
                  (snapshot.data != null && snapshot.data!.docs.isEmpty)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Center(child: cp.buildLoadingWidget(last: true))])
              : Column(
                  children: [
                    Expanded(
                      flex: 7,
                      // height: AppSize.safeBlockVertical * 70,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (context, i) => _buildMessageBox(
                            myUid, snapshot.data!.docs[i].data()),
                        itemCount: snapshot.data!.size,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                    Divider(),
                    _buildReflections(
                        snapshot.data!.docs.map((e) => e.data()).toList(),
                        langame,
                        reflections
                            .where((e) => e.userId == ap.user!.uid)
                            .toList()),
                    Divider(),
                    // This is a Whatsapp-like send message bar with rounded corner
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(
                          color: getBlackAndWhite(context, 0),
                          width: 0.1,
                        ),
                        color: getBlackAndWhite(context, 1, reverse: true),
                      ),
                      child: Row(
                        children: [
                          _currentSentiment != null && _currentText.isNotEmpty
                              ? IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    _currentSentiment!.negative > 0.5
                                        ? FontAwesomeIcons.sadTear
                                        : _currentSentiment!.positive > 0.5
                                            ? FontAwesomeIcons.grinTongue
                                            : FontAwesomeIcons.meh,
                                    color: getBlackAndWhite(context, 0),
                                  ),
                                )
                              : SizedBox.shrink(),
                          Expanded(
                            child: TextField(
                              style: Theme.of(context).textTheme.headline6,
                              // cursorColor: getBlackAndWhite(context, 0),
                              onChanged: (e) async {
                                setState(() => _currentText = e);
                                // Check every new word
                                if (e.split(" ").length < 2 ||
                                    e[e.length - 1] != " ") return;
                                final val = await mp
                                    .getSentiment(_textEditingController.text);
                                if (val == null) return;
                                setState(() =>
                                    _currentSentiment = val.sentimentResponse);
                              },
                              enabled: _canSend,
                              onSubmitted: (e) => _onSend(),
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                // fillColor: getBlackAndWhite(context, 1, reverse: true),
                                hintText: 'Type a message...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _currentText.isEmpty
                              ? SizedBox.shrink()
                              : IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.paperPlane,
                                    color: getBlackAndWhite(
                                        context, _canSend ? 0 : 1),
                                  ),
                                  onPressed: _onSend,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  /// This is a function that return a WhatsApp like message box
  Widget _buildMessageBox(String myUid, lg.Message m) => Stack(
        children: [
          Align(
            alignment: m.author.id == myUid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              width: AppSize.safeBlockHorizontal *
                  (AppSize.isLargeWidth ? 50 : 70),
              // nb lines
              // height: AppSize.safeBlockVertical * ((m.body.length / 20) + 10) * 2,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                border: Border.all(
                  color: getBlackAndWhite(context, 0),
                  width: 0.1,
                ),
                color: m.author.id != myUid
                    ? getBlackAndWhite(context, 1, reverse: true)
                    : Theme.of(context).colorScheme.secondary,
              ),
              margin: EdgeInsets.all(10),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onLongPress: () {
                  var cp = Provider.of<ContextProvider>(context, listen: false);
                  FlutterClipboard.copy(m.body);
                  cp.showSnackBar('copied to clipboard');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m.author.tag,
                            style: Theme.of(context).textTheme.caption!.merge(
                                  TextStyle(
                                    color: getBlackAndWhite(context, 0,
                                        reverse: m.author.id == myUid),
                                  ),
                                ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            m.body,
                            style: Theme.of(context).textTheme.headline6!.merge(
                                  TextStyle(
                                    color: getBlackAndWhite(context, 0,
                                        reverse: m.author.id == myUid),
                                  ),
                                ),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                f.format(m.createdAt.toDateTime().toLocal()),
                                style:
                                    Theme.of(context).textTheme.caption!.merge(
                                          TextStyle(
                                            color: getBlackAndWhite(context, 0,
                                                reverse: m.author.id == myUid),
                                          ),
                                        ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildReflections(List<lg.Message> messages, lg.Langame currentLg,
      List<lg.Langame_Reflection> reflections) {
    final fp = Provider.of<FirebaseApi>(context, listen: false);
    final cp = Provider.of<ContextProvider>(context, listen: false);
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: reflections
            .mapIndexed(
              (e, i) => Padding(
                  padding: EdgeInsets.all(12),
                  child: LangameButton(
                      e.contentFilter == lg.ContentFilter.Safe
                          ? FontAwesomeIcons.smileBeam
                          : e.contentFilter == lg.ContentFilter.Sensitive
                              ? FontAwesomeIcons.frown
                              : FontAwesomeIcons.meh,
                      layer: 1,
                      tooltip: e.alternatives.last,
                      text: e.alternatives.last.substring(
                              0,
                              e.alternatives.last.length > 20
                                  ? 20
                                  : e.alternatives.last.length) +
                          '...', onPressed: () {
                    cp.showCustomDialog(
                      stateless: [
                        Column(children: [
                          Container(
                            height: AppSize.safeBlockVertical * 20,
                            width: AppSize.safeBlockHorizontal * 70,
                            child: SingleChildScrollView(
                                child: Text(
                              e.alternatives.last,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline5,
                            )),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _reflectionsLiked.contains(e.alternatives.last)
                                    ? SizedBox.shrink()
                                    : LangameButton(FontAwesomeIcons.heart,
                                        tooltip: 'Like the reflection',
                                        layer: 1,
                                        disableForFewMs: 5000,
                                        disabled: _reflectionsLiked
                                            .contains(e.alternatives.last),
                                        onPressed: () {
                                        if (_reflectionsLiked.contains(
                                            e.alternatives.last)) return;

                                        fp.firestore!
                                            .collection('feedbacks')
                                            .doc(fp.auth!.currentUser!.uid)
                                            .set({
                                          'likes': FieldValue.arrayUnion([
                                            {
                                              'langame':
                                                  widget.initialLangame.id,
                                              'reflection': e.toProto3Json(),
                                            }
                                          ])
                                        }, SetOptions(merge: true));

                                        setState(() {
                                          _reflectionsLiked
                                              .add(e.alternatives.last);
                                        });
                                        cp.dialogComplete();
                                        cp.showSnackBar(
                                            gratitudeMessages.pickAny()!);
                                      }),
                              ]),
                        ]),
                      ],
                      canBack: true,
                      height: 40,
                      title: Text('🤔',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4),
                    );
                  })),
            )
            .toList(),
      ),
    );
  }

  void _onSend() async {
    if (_textEditingController.text.isNotEmpty && _canSend) {
      debugPrint('send: ' + _textEditingController.text);
      // Clear text field
      _textEditingController.clear();
      // Hide keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      _scrollToBottom();

      var mp = Provider.of<MessageProvider>(context, listen: false);

      mp.sendMessage(widget.initialLangame.id, _currentText);

      setState(() {
        _currentText = '';
        _currentSentiment = null;
        _canSend = false;
      });
      Future.delayed(Duration(milliseconds: 3000)).then((_) {
        if (!this.mounted) return;
        setState(() {
          _canSend = true;
        });
      });
    }
  }

  void _scrollToBottom({bool later = false}) async {
    // Delay to make sure the frames are rendered properly
    await Future.delayed(Duration(milliseconds: later ? 1000 : 300));
    if (!_scrollController.hasClients) return;

    // await waitUntil(() => _scrollController.hasClients, maxIterations: 1000);
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    });
  }
}
