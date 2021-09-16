// This is a stateful dart widget that display a recording

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/recording_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

// The above but as a list of string in Dart trying to make the user
// think hard about the conversation he had at that time
var _questions = [
  'Did you have a goal in mind when you started the conversation?',
  'What did you wish you had said?',
  'Did anything surprise you?',
  'What didn\'t you like about it?',
  'What would you like to do next time?',
  'Did you like this conversation?',
  'What do you think about the conversation you were having?',
  'What\'s your favorite part about this conversation?',
  'Any thoughts about this recording?',
  'Did you have a goal in mind when you started the conversation?',
  'How did it feel to expose your idea?',
  'How did it feel to reveal your idea to someone who is listening to it for the first time?',
  'How do you think they felt after hearing your idea? ',
  'What did they say when they heard your idea for the first time?',
  'How do you feel about your idea now? ',
  'What are you feeling right now? ',
  'What did you like about your idea?',
  'What didn\'t you like about your idea?',
  'What did you not like about it?',
  'What do you wish you had done differently?',
  'What did you do well in the conversation?',
  'What did you do poorly in the conversation?',
  'Did you have a goal in mind when you started the conversation?',
  'What did you wish you had said?',
  'Did anything surprise you?',
  'What didn\'t you like about it?',
  'What would you like to do next time?',
  'Did you like this conversation?',
];

class Recording extends StatefulWidget {
  String _q = _questions.pickAny()!;
  String _recordingId;
  lg.Recording _recording;
  Recording(this._recordingId, this._recording);
  @override
  _State createState() => _State();
}

class _State extends State<Recording> with AfterLayoutMixin<Recording> {
  final _noteController = TextEditingController();
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('recording_view');
    setState(() {
      _noteController.text = widget._recording.note;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cp = Provider.of<ContextProvider>(context);
    var rp = Provider.of<RecordingProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: isLightThenDark(context), //change your color here
          ),
          actions: [
            IconButton(
                icon: Icon(FontAwesomeIcons.shareAlt),
                onPressed: () => Share.share(
                    'Question: ${widget._recording.metadata["meme"]!}' +
                        '\nAnswer: ${widget._recording.text}' +
                        (widget._recording.hasNote()
                            ? '\nNote: ${widget._recording.note}'
                            : ''),
                    subject: 'Langame memes')),
            IconButton(
                icon: Icon(FontAwesomeIcons.trashAlt),
                onPressed: () {
                  cp.showCustomDialog(
                    stateless: [
                      Spacer(),
                      Text(
                        'Are you sure you want to delete this recording?',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      LangameButton(
                        FontAwesomeIcons.trashAlt,
                        text: 'Delete',
                        highlighted: true,
                        onPressed: () async {
                          var r = await rp.deleteRecording(widget._recordingId);
                          cp.dialogComplete();
                          if (r.error != null)
                            cp.showFailureDialog(null);
                          else
                            cp.showSnackBar('Recording deleted');
                          await Future.delayed(Duration(milliseconds: 100));
                          cp.pop();
                        },
                      )
                    ],
                    canBack: true,
                    title: Text(
                      'Delete Recording',
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            widget._q,
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          TextFormField(
            controller: _noteController,
            maxLines: 3,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .merge(TextStyle(color: getBlackAndWhite(context, 0))),
            decoration: InputDecoration(
              filled: true,
              fillColor: getBlackAndWhite(context, 1, reverse: true),
              hintText: 'Write your thoughts...',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: getBlackAndWhite(context, 0)),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: getBlackAndWhite(context, 0)),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
          ),
          LangameButton(
            FontAwesomeIcons.save,
            text: 'Save',
            highlighted: true,
            onPressed: () => rp
                .updateNote(widget._recordingId, _noteController.text)
                .whenComplete(() {
              cp.showSnackBar('saved 🙋');

              FocusScope.of(context).unfocus();
            }),
          ),
          Spacer(),
          ListTile(
            trailing: Tooltip(
                child: Icon(
                  FontAwesomeIcons.questionCircle,
                  color: getBlackAndWhite(context, 0),
                ),
                message: 'Question asked'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            tileColor: getBlackAndWhite(context, 1, reverse: true),
            title: Text(
              widget._recording.metadata['meme']!,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .merge(TextStyle(color: getBlackAndWhite(context, 0))),
            ),
          ),
          ListTile(
            trailing: Tooltip(
                child: Icon(
                  FontAwesomeIcons.questionCircle,
                  color: getBlackAndWhite(context, 0),
                ),
                message: 'Answer given'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            tileColor: getBlackAndWhite(context, 1, reverse: true),
            title: Text(
              widget._recording.text,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .merge(TextStyle(color: getBlackAndWhite(context, 0))),
            ),
          ),
          SizedBox(height: AppSize.safeBlockVertical * 10),
        ]));
  }
}
