import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  RtcEngine? _engine;

  LangameView(this.opponentUid, this.topic, this.question, this.notifyOthers);

  @override
  _LangameViewState createState() => _LangameViewState(question);
}

class Player {
  int agoraUid;
  int langameUid;
  bool isSpeaking;

  Player(this.agoraUid, this.langameUid, this.isSpeaking);
}

class _LangameViewState extends State<LangameView> {
  final String question;
  Duration _remaining = Duration(minutes: 15);
  late StreamSubscription<CountdownTimer> _sub;
  // agoraUid -> Player
  HashMap _players = HashMap<int, Player>();
  String channelId = AppConst.agoraChannelId;
  bool isJoined = false,
      openMicrophone = false,
      enableSpeakerphone = false,
      playEffect = false,
      everyoneJoined = false;

  _LangameViewState(this.question) {
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

    if (!widget.notifyOthers) return;
    // TODO: generate and send some int id for channel
    Provider.of<AuthenticationProvider>(context, listen: false)
        .sendReadyForLangame(widget.opponentUid, widget.topic, question)
        .then((res) {
      res.thenShowSnackBar(context, () {
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
                    .getLangameUser(widget.opponentUid),
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
                                  // SpinKitWave(
                                  //   color:
                                  //       Theme.of(context).colorScheme.primary,
                                  //   size: AppSize.blockSizeHorizontal * 3,
                                  // ),
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
                  return SizedBox.shrink();
                  // return SpinKitRotatingCircle(
                  //   color: Theme.of(context).colorScheme.primary,
                  //   size: 50.0,
                  // );
                }),
          )
        : Scaffold(
            // appBar: AppBar(automaticallyImplyLeading: false),
            body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              _buildTimerText(),
              _buildQuestion(),
              _buildBottomHalf(),
            ]),
          );
  }

  @override
  void dispose() {
    super.dispose();
    Future.value([_sub.cancel(), _leaveChannel()])
        .whenComplete(() => widget._engine?.destroy());
  }

  _initEngine() async {
    widget._engine =
        await RtcEngine.createWithConfig(RtcEngineConfig(AppConst.agoraAppID));
    this._addListeners();
    await widget._engine!.enableAudio();
    await widget._engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await widget._engine!.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    widget._engine?.setEventHandler(RtcEngineEventHandler(
      activeSpeaker: (int uid) {
        setState(() {
          _players[uid].isSpeaking = true;
        });
      },
      microphoneEnabled: (bool a) {
        debugPrint('microphoneEnabled $a');
      },
      streamMessage: (int a, int b, String c) {
        debugPrint('streamMessage a $a b $b c $c');
      },
      localUserRegistered: (int a, String b) {
        debugPrint('localUserRegistered a $a b$b');
      },
      userOffline: (int uid, UserOfflineReason reason) {
        debugPrint('someone left $uid $reason');
        if (reason == UserOfflineReason.Quit)
          Fluttertoast.showToast(msg: '... left');
        setState(() {
          _players.remove(uid);
        });
      },
      userJoined: (int uid, int b) {
        debugPrint('someone joined');
        debugPrint('$uid | $b');
        widget._engine
            ?.getUserInfoByUid(uid)
            .then((v) => debugPrint('getUserInfoByUid ${v.toJson()}'));

        setState(() {
          everyoneJoined = true;
          _players[uid] = Player(uid, -1, false); // TODO -1 get mapping
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        debugPrint('joinChannelSuccess $channel $uid $elapsed');
        setState(() {
          isJoined = true;
          _players[uid] = Player(uid, -1, false); // TODO: get self id?
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
    await widget._engine?.joinChannel(
        AppConst.agoraToken, channelId, 'foobar', Random().nextInt(10));
  }

  _leaveChannel() async {
    await widget._engine?.leaveChannel();
  }

  _switchMicrophone() {
    widget._engine?.sendStreamMessage(0, 'yo bro');
    widget._engine?.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {
      debugPrint('enableLocalAudio $err');
    });
  }

  _switchSpeakerphone() {
    widget._engine?.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
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

  Widget _buildBottomHalf() {
    return Column(
      children: [
        Divider(),
        SizedBox(height: AppSize.safeBlockVertical * 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 7.0,
              ),
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
          width: AppSize.blockSizeHorizontal * 80,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _players.values
                  .map((p) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          border: Border.all(
                            width: 3,
                            color: p.isSpeaking
                                ? Colors.red
                                : Theme.of(context).colorScheme.primary,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child: buildCroppedRoundedNetworkImage(null),
                        ),
                      ))
                  .toList()),
        ),
        SizedBox(height: AppSize.safeBlockVertical * 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
            icon: Icon(
                openMicrophone ? Icons.mic_rounded : Icons.mic_off_rounded),
            onPressed: () => _switchMicrophone(),
          ),
          IconButton(
            icon: Icon(enableSpeakerphone
                ? Icons.speaker_notes_off_outlined
                : Icons.speaker_notes_outlined),
            onPressed: () => _switchSpeakerphone(),
          )
        ]),
      ],
    );
  }
}
