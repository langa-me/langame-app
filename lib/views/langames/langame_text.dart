import 'package:after_layout/after_layout.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/future.dart';
import 'package:langame/models/djinn/djinn.pbgrpc.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/message_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/images/image.dart';
import 'package:provider/provider.dart';

class LangameTextView extends StatefulWidget {
  LangameTextView(this.langameChannelName);
  final String langameChannelName;
  @override
  _State createState() => _State();
}

class _State extends State<LangameTextView>
    with AfterLayoutMixin<LangameTextView> {
  lg.Langame? langame;
  lg.User? other;
  // Stream<List<lg.Message>>? messages;
  TextEditingController _textEditingController = TextEditingController();
  String _currentText = '';
  final f = new DateFormat('hh:mm');
  final ScrollController _scrollController = ScrollController();
  MagnificationResponse_Sentiment? _currentSentiment;

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('langame_text_view');

    var lp = Provider.of<LangameProvider>(context, listen: false);
    lp.joinLangame(widget.langameChannelName);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<ContextProvider>(context, listen: false);
    final lp = Provider.of<LangameProvider>(context);
    final mp = Provider.of<MessageProvider>(context);
    final langame = lp.langames[widget.langameChannelName];
    if (langame == null) {
      // Show error message and pop back
      cp.showFailureDialog(null);
      Future.delayed(Duration(seconds: 2)).then((_) {
        cp.dialogComplete();
        cp.pop();
      });
    }
    final reflections =
        lp.langames[widget.langameChannelName]?.reflections ?? [];
    reflections.sort(
      (a, b) => b.createdAt.toDateTime().compareTo(
            a.createdAt.toDateTime(),
          ),
    );
    final suggestions =
        lp.langames[widget.langameChannelName]?.suggestions ?? [];
    suggestions.sort(
      (a, b) => b.createdAt.toDateTime().compareTo(
            a.createdAt.toDateTime(),
          ),
    );
    if (other == null) {
      try {
        var ap = Provider.of<AuthenticationProvider>(context, listen: false);
        ap
            .getLangameUser(langame!.reservedSpots[0] == ap.user!.uid
                ? langame.initiator
                : langame.reservedSpots[0])
            .then((e) => setState(() => other = e.result));
        _scrollToBottom();
      } catch (e) {}
    }
    final messages = mp.messages[widget.langameChannelName];

    final actions = other?.photoUrl != null
        ? [
            buildCroppedRoundedNetworkImage(other?.photoUrl, width: 40),
          ]
        : [buildPopupMenuWithHelpAndFeedback(context)];
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: getBlackAndWhite(context, 0, reverse: true),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: langame!.reflections.length > 0
            ? _buildReflectionButton(cp, langame.reflections)
            : null,
        appBar: AppBar(
          title: other != null
              ? Text(
                  other!.tag,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                )
              : null,
          iconTheme: IconThemeData(
            color: getBlackAndWhite(context, 0), //change your color here
          ),
          backgroundColor: Colors.transparent,
          actions: actions,
        ),
        body: langame.memes.isEmpty || messages == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: cp.buildLoadingWidget(last: true))])
            : Column(
                children: [
                  Expanded(
                    flex: 7,
                    // height: AppSize.safeBlockVertical * 70,
                    child: other != null
                        ? ListView.builder(
                            controller: _scrollController,
                            itemBuilder: (context, i) =>
                                _buildMessageBox(messages.values.elementAt(i)),
                            itemCount: messages.length,
                            physics: BouncingScrollPhysics(),
                          )
                        : cp.buildLoadingWidget(),
                  ),
                  Divider(),
                  // This is a row showing suggestions
                  _buildSuggestions(langame, suggestions),
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
                                onPressed: () {
                                  // showPopover(
                                  //   backgroundColor:
                                  //       getBlackAndWhite(context, 1),
                                  //   // width: 200,
                                  //   // height: 400,
                                  //   // arrowHeight: 15,
                                  //   // arrowWidth: 30,
                                  //   // contentDyOffset: -300,
                                  //   direction: PopoverDirection.top,
                                  //   context: context,
                                  //   bodyBuilder: (ctx) => Text(
                                  //     _currentSentiment!.negative > 0.5
                                  //         ? 'This sounds negative 😞'
                                  //         : _currentSentiment!.positive > 0.5
                                  //             ? 'This sounds positive 😊'
                                  //             : 'This sounds neutral 😐',
                                  //   ),
                                  // );
                                },
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
                                  color: getBlackAndWhite(context, 0),
                                ),
                                onPressed: _onSend,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _onSend() async {
    if (_textEditingController.text.isNotEmpty) {
      // Clear text field
      _textEditingController.clear();
      // Hide keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      _scrollToBottom();

      var mp = Provider.of<MessageProvider>(context, listen: false);

      // TODO: feedback on response
      mp.sendMessage(widget.langameChannelName, _currentText, other!.uid);

      setState(() {
        _currentText = '';
        _currentSentiment = null;
      });
    }
  }

  void _scrollToBottom({bool later = false}) async {
    // Delay to make sure the frames are rendered properly
    // await Future.delayed(Duration(milliseconds: later ? 1000 : 300));
    await waitUntil(() => _scrollController.hasClients);
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    });
  }

  FloatingActionButton _buildReflectionButton(
          ContextProvider cp, List<lg.Langame_Reflection> reflections) =>
      FloatingActionButton(
          child: Icon(FontAwesomeIcons.brain),
          onPressed: () {
            cp.showCustomDialog(
                stateless: [
                  Container(
                    height: AppSize.safeBlockVertical * 40,
                    width: AppSize.safeBlockHorizontal * 70,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: reflections.length,
                      separatorBuilder: (ctx, i) => Divider(),
                      itemBuilder: (ctx, i) => LangameButton(
                        FontAwesomeIcons.copy,
                        text: reflections[i].alternatives.last,
                        layer: 2,
                        onPressed: () {
                          FlutterClipboard.copy(
                              reflections[i].alternatives.last);
                        },
                      ),
                    ),
                  ),
                  // Show a nice box with corners box rounded
                ],
                canBack: true,
                title: Text('Reflections',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4));
          });

  Widget _buildSuggestions(
          lg.Langame currentLg, List<lg.Langame_Suggestion> suggestions) =>
      Expanded(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
                currentLg.currentMeme < currentLg.memes.length - 1
                    ? Padding(
                        padding: EdgeInsets.all(12),
                        child: LangameButton(FontAwesomeIcons.grinTongue,
                            highlighted: true,
                            disableForFewMs: 5000,
                            tooltip:
                                'Send a new conversation starter: ${currentLg.memes[currentLg.currentMeme + 1].content}',
                            text: currentLg
                                    .memes[currentLg.currentMeme + 1].content
                                    .substring(0, 20) +
                                '...', onPressed: () {
                          setState(() {
                            _textEditingController.text = currentLg
                                .memes[currentLg.currentMeme + 1].content;
                            _currentText = currentLg
                                .memes[currentLg.currentMeme + 1].content;
                          });
                          _onSend();
                          final fs =
                              Provider.of<FirebaseApi>(context, listen: false)
                                  .firestore!;
                          fs
                              .collection('langames')
                              .where('channelName',
                                  isEqualTo: widget.langameChannelName)
                              .get()
                              .then((e) {
                            if (e.size == 0) return;
                            e.docs[0].reference.update({
                              'currentMeme': FieldValue.increment(1),
                            });
                          });
                        }))
                    : SizedBox.shrink()
              ] +
              suggestions
                  .map(
                    (e) => Padding(
                        padding: EdgeInsets.all(12),
                        child: LangameButton(
                            e.contentFilter == lg.ContentFilter.Safe
                                ? FontAwesomeIcons.smileBeam
                                : e.contentFilter == lg.ContentFilter.Sensitive
                                    ? FontAwesomeIcons.frown
                                    : FontAwesomeIcons.meh,
                            layer: 1,
                            tooltip: e.alternatives.last,
                            text: e.alternatives.last.substring(0, 20) + '...',
                            onPressed: () {
                          setState(() {
                            _textEditingController.text = e.alternatives.last;
                            _currentText = e.alternatives.last;
                          });
                        })),
                  )
                  .toList(),
        ),
      );

  /// This is a function that return a WhatsApp like message box
  Widget _buildMessageBox(lg.Message m) => Stack(
        children: [
          Align(
            alignment: m.toUid == other!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              width: AppSize.safeBlockHorizontal * 70,
              // nb lines
              // height: AppSize.safeBlockVertical * ((m.body.length / 20) + 10) * 2,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                border: Border.all(
                  color: getBlackAndWhite(context, 0),
                  width: 0.1,
                ),
                color: m.toUid != other!.uid
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
                            m.toUid != other!.uid ? other!.tag : 'You',
                            style: Theme.of(context).textTheme.caption!.merge(
                                  TextStyle(
                                    color: getBlackAndWhite(context, 0,
                                        reverse: m.toUid == other!.uid),
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
                                        reverse: m.toUid == other!.uid),
                                  ),
                                ),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                f.format(m.createdAt.toDateTime()),
                                style:
                                    Theme.of(context).textTheme.caption!.merge(
                                          TextStyle(
                                            color: getBlackAndWhite(context, 0,
                                                reverse: m.toUid == other!.uid),
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
}
