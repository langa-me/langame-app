import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/message_provider.dart';
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
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var lp = Provider.of<LangameProvider>(context);
    var mp = Provider.of<MessageProvider>(context);

    if (langame == null) {
      try {
        setState(() {
          langame = lp.langames.values
              .firstWhere((e) => e.channelName == widget.langameChannelName);
        });
        var ap = Provider.of<AuthenticationProvider>(context, listen: false);
        ap
            .getLangameUser(langame!.reservedSpots[0] == ap.user!.uid
                ? langame!.initiator
                : langame!.reservedSpots[0])
            .then((e) => setState(() => other = e.result));
      } catch (e) {
        setState(() {
          langame = null;
        });
      }
    }

    final actions = other?.photoUrl != null
        ? [
            buildCroppedRoundedNetworkImage(other?.photoUrl, width: 40),
          ]
        : [buildPopupMenuWithHelpAndFeedback(context)];
    var messages = mp.messages[widget.langameChannelName];
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: getBlackAndWhite(context, 0, reverse: true),
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
        body: langame == null || langame!.memes.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: cp.buildLoadingWidget(last: true))])
            : Column(
                children: [
                  Expanded(
                    child: other != null ? ListView.builder(
                      itemBuilder: (context, i) =>
                          _buildMessageBox(messages!.values.elementAt(i)),
                      itemCount: messages!.length,
                      physics: BouncingScrollPhysics(),
                    ) : cp.buildLoadingWidget(),
                  ),

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
                        Expanded(
                          child: TextField(
                            style: Theme.of(context).textTheme.headline6,
                            // cursorColor: getBlackAndWhite(context, 0),
                            onChanged: (e) => setState(() => _currentText = e),
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
                                onPressed: () {
                                  if (_textEditingController.text.isNotEmpty) {
                                    // TODO: feedback on response
                                    mp.sendMessage(widget.langameChannelName,
                                        _currentText, other!.uid);
                                    // Clear text field
                                    _textEditingController.clear();
                                    setState(() => _currentText = '');
                                    // Hide keyboard
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// This is a function that return a WhatsApp like message box
  Widget _buildMessageBox(lg.Message m) => Align(
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
                          style: Theme.of(context).textTheme.caption!.merge(
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
      );
}
