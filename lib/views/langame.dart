import 'dart:async';

import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/views/image.dart';
import 'package:quiver/async.dart';

class LangameView extends StatefulWidget {
  final LangameNotification notification;
  LangameView(this.notification);

  @override
  _LangameViewState createState() => _LangameViewState(notification);
}

class _LangameViewState extends State<LangameView> {
  final LangameNotification notification;
  Duration _remaining = Duration(minutes: 15);
  late StreamSubscription<CountdownTimer> _sub;

  _LangameViewState(this.notification) {
    CountdownTimer countDownTimer = new CountdownTimer(
      Duration(minutes: 15),
      Duration(seconds: 1),
    );

    _sub = countDownTimer.listen(null);
    _sub.onData((duration) {
      setState(() {
        _remaining = duration.remaining;
      });
    });

    _sub.onDone(_sub.cancel);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      // appBar: AppBar(automaticallyImplyLeading: false),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        _buildTimerText(theme),
        _buildQuestion(theme),
        _buildVideo(theme),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
  }

  Widget _buildTimerText(ThemeData theme) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
            top: AppSize.safeBlockVertical * 5,
            bottom: AppSize.blockSizeVertical * 5),
        height: AppSize.blockSizeVertical * 8,
        width: AppSize.blockSizeHorizontal * 30,
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: theme.buttonTheme.colorScheme!.primary,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: new Center(
            child: new Text(
              '${_remaining.inMinutes}:${_remaining.inSeconds.remainder(60).toString().length == 2 ? '' : '0'}${_remaining.inSeconds.remainder(60)}',
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.button,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(ThemeData theme) {
    return Center(
      child: Container(
        height: AppSize.blockSizeVertical * 20,
        width: AppSize.blockSizeHorizontal * 70,
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: theme.buttonTheme.colorScheme!.secondary,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: new Center(
            child: new Text(
              'Who is your role model?',
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.button,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideo(ThemeData theme) {
    // TODO: should really show video :)
    var p = notification.relation.other.photoUrl == null
        ? 'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'
        : notification.relation.other.photoUrl;
    return Center(
        child: Container(
            margin: EdgeInsets.only(top: AppSize.safeBlockVertical * 5),
            height: AppSize.blockSizeVertical * 50,
            width: AppSize.blockSizeHorizontal * 90,
            child: buildCroppedRoundedNetworkImage(p!)));
  }
}
