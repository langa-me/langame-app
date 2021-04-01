import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/views/image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';

class LangameView extends StatefulWidget {
  final String opponentUid;
  final String topic;
  final String question;
  final bool notifyOthers;
  LangameView(this.opponentUid, this.topic, this.question, this.notifyOthers);

  @override
  _LangameViewState createState() =>
      _LangameViewState(opponentUid, topic, question, notifyOthers);
}

class _LangameViewState extends State<LangameView> {
  final String opponentUid;
  final String topic;
  final String question;
  Duration _remaining = Duration(minutes: 15);
  late StreamSubscription<CountdownTimer> _sub;
  RtcEngine? _engine;
  final bool notifyOthers;

  String channelId = AppConst.agoraChannelId;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false,
      everyoneJoined = false;

  _LangameViewState(
      this.opponentUid, this.topic, this.question, this.notifyOthers) {
    CountdownTimer countDownTimer = new CountdownTimer(
      Duration(minutes: 15),
      Duration(seconds: 1),
    );

    // TODO: start when everyone is here
    _sub = countDownTimer.listen(null);
    _sub.onData((duration) {
      setState(() {
        _remaining = duration.remaining;
      });
    });

    _sub.onDone(_sub.cancel);
  }

  @override
  void initState() {
    super.initState();
    this._initEngine();

    if (!notifyOthers) return;
    Provider.of<AuthenticationProvider>(context, listen: false)
        .sendReadyForLangame(opponentUid, topic, question)
        .then((res) {
      res.handle(context, () {
        final snackBar = SnackBar(
            content: Text('Your friend has been told of your presence!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
          !kReleaseMode
              ? 'failed to sendReadyForLangame ${res.error.toString()}'
              : Provider.of<FunnyProvider>(context).getFailingRandom());
    });
  }

  @override
  Widget build(BuildContext context) {
    this._joinChannel();
    return !everyoneJoined
        ? Scaffold(
            body: FutureBuilder<LangameUser?>(
                future: Provider.of<AuthenticationProvider>(context)
                    .getLangameUser(opponentUid),
                builder: (c, snapshot) {
                  if (snapshot.hasError) {
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpinKitWave(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: AppSize.blockSizeHorizontal * 3,
                                  ),
                                  SizedBox(
                                      width: AppSize.blockSizeHorizontal * 5),
                                  Text(
                                    'Waiting for ${snapshot.data!.displayName}...',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                                ]),
                          ),
                          SizedBox(height: AppSize.blockSizeVertical * 5),
                          Container(
                            width: AppSize.blockSizeHorizontal * 80,
                            height: AppSize.blockSizeVertical * 60,
                            color: Colors.white,
                          )
                        ]);
                  }
                  return SpinKitRotatingCircle(
                    color: Theme.of(context).colorScheme.primary,
                    size: 50.0,
                  );
                }),
          )
        : Scaffold(
            // appBar: AppBar(automaticallyImplyLeading: false),
            body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            _buildTimerText(),
            _buildQuestion(),
            _buildVideo(),
          ]));
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
    _leaveChannel();
    _engine?.destroy();
  }

  _initEngine() async {
    _engine =
        await RtcEngine.createWithConfig(RtcEngineConfig(AppConst.agoraAppID));
    this._addListeners();

    await _engine!.enableAudio();
    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine!.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine?.setEventHandler(RtcEngineEventHandler(
      userJoined: (a, b) {
        debugPrint('someone joined');
        debugPrint('$a | $b');
        setState(() {
          everyoneJoined = true;
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        debugPrint('joinChannelSuccess $channel $uid $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      leaveChannel: (stats) {
        debugPrint('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    await _engine?.joinChannel(AppConst.agoraToken, channelId, null, 0);
  }

  _leaveChannel() async {
    await _engine?.leaveChannel();
  }

  _switchMicrophone() {
    _engine?.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {
      debugPrint('enableLocalAudio $err');
    });
  }

  _switchSpeakerphone() {
    _engine?.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    }).catchError((err) {
      debugPrint('setEnableSpeakerphone $err');
    });
  }

  Widget _buildTimerText() {
    var theme = Theme.of(context);
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

  Widget _buildQuestion() {
    var theme = Theme.of(context);
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
          child: Center(
            child: Text(
              question,
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.button,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideo() {
    var theme = Theme.of(context);
    // TODO: should really show video :)
    // var p = notification.relation.other.photoUrl == null
    //     ? 'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'
    //     : notification.relation.other.photoUrl;
    return Center(
        child: Container(
            margin: EdgeInsets.only(top: AppSize.safeBlockVertical * 5),
            height: AppSize.blockSizeVertical * 50,
            width: AppSize.blockSizeHorizontal * 90,
            child: buildCroppedRoundedNetworkImage(null)));
  }
}
