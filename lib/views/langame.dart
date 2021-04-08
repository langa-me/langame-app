import 'dart:collection';
import 'dart:ui';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/channel.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/audio_provider.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:provider/provider.dart';

import 'friends.dart';
import 'image.dart';

class LangameView extends StatefulWidget {
  final LangameNotification notification;
  final bool notifyOthers;

  LangameView(this.notification, this.notifyOthers);

  @override
  _LangameViewState createState() => _LangameViewState();
}

class Player {
  LangameUser langameUser;
  bool isSpeaking;

  Player(this.langameUser, this.isSpeaking);
}

class _LangameViewState extends State<LangameView> {
  bool permissionRequested = false;
  bool notified = false;
  String? channelToken;
  LangameChannel? channel;
  List<LangameUser> channelLangameUsers = [];
  bool engineInitialized = false;
  bool channelJoined = false;
  HashMap<int, Player> joinedPlayers = HashMap();
  String? question; // TODO!!!!!!!!!!!!!!!
  int errors = 0;
  static const int maxErrors = 3;

  @override
  Widget build(BuildContext context) {
    // TODO: might do that on other pages too
    var network = Provider.of<ConnectivityResult>(context);
    if (network != ConnectivityResult.wifi &&
        network != ConnectivityResult.mobile) {
      return _buildLoading(text: 'You are offline!');
    }

    if (!permissionRequested) {
      var p = Provider.of<AudioProvider>(context);
      return FutureBuilder<LangameResponse<bool>>(
        future: p.checkPermission(),
        builder: (c, s) {
          if (s.hasError) _handleError();
          if (s.hasData && s.data != null && s.data!.result != null) {
            // Already permission granted
            if (s.data!.result!) {
              _postFrameCallback(
                  (_) => setState(() => permissionRequested = true));
            } else {
              // Not requested / denied in the past
              return AlertDialog(
                title: Text('We need your permission to use your microphone.'),
                actions: [
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => FriendsView()),
                    ),
                    icon: Icon(Icons.cancel_outlined),
                    label: Text('CANCEL'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      var p =
                          Provider.of<AudioProvider>(context, listen: false);
                      var res = await p.requestPermission();
                      res.thenShowToast(
                        'Understood!',
                        Provider.of<FunnyProvider>(context, listen: false)
                            .getFailingRandom(),
                        onSucceed: () {
                          // Permission granted!
                          if (res.result != null && res.result!) {
                            _postFrameCallback((duration) =>
                                setState(() => permissionRequested = true));
                            return;
                          }
                          Fluttertoast.showToast(
                                  msg:
                                      'You can\'t play Langame without microphone :(, you can still enable it in your settings later.')
                              .then(
                            (_) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FriendsView(),
                              ),
                            ),
                          );
                        },
                        onFailure: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FriendsView(),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.check_circle_outline),
                    label: Text('UNDERSTOOD'),
                  ),
                ],
              );
            }
          }
          return _buildLoading();
        },
      );
    }
    // Second-step, ask for a token generation
    if (channelToken == null) {
      var p = Provider.of<AuthenticationProvider>(context, listen: false);
      return FutureBuilder<LangameResponse<String>>(
          future: p.getChannelToken(widget.notification.channelName!),
          builder: (c, s) {
            if (s.hasError) _handleError();
            if (s.hasData && s.data != null) {
              s.data!.thenShowToast(
                Provider.of<FunnyProvider>(context, listen: false)
                    .getLoadingRandom(),
                Provider.of<FunnyProvider>(context, listen: false)
                    .getFailingRandom(),
                onSucceed: () {
                  // https://stackoverflow.com/questions/47592301/setstate-or-markneedsbuild-called-during-build
                  _postFrameCallback(
                      (_) => setState(() => channelToken = s.data!.result));
                },
                onFailure: () {
                  _postFrameCallback(
                      (_) => setState(() => channelToken = null));
                },
              );
            }
            return _buildLoading();
          });
    }
    debugPrint('channelToken $channelToken');
    // Third-step, retrieve channel data
    if (channel == null) {
      var p = Provider.of<AuthenticationProvider>(context, listen: false);
      return FutureBuilder<LangameResponse<LangameChannel>>(
        future: p.getChannel(widget.notification.channelName!),
        builder: (c, s) {
          if (s.hasError) _handleError();
          if (s.hasData && s.data != null) {
            s.data!.thenShowToast(
              Provider.of<FunnyProvider>(context, listen: false)
                  .getLoadingRandom(),
              Provider.of<FunnyProvider>(context, listen: false)
                  .getFailingRandom(),
              onSucceed: () {
                _postFrameCallback((_) {
                  setState(() => channel = s.data!.result);
                  p.getLangameUsers(s.data!.result!.players
                      .map((e) => e.langameUid)
                      .toList());
                });
              },
              onFailure: () {
                _postFrameCallback((_) => setState(() => channel = null));
              },
            );
          }
          return _buildLoading();
        },
      );
    }
    debugPrint(
        'channel ${channel?.channelName} ${channel?.players.map((p) => p.toJson()).join(',')}');

    // Fourth-step, retrieve langame users data
    if (channelLangameUsers.isEmpty) {
      var p = Provider.of<AuthenticationProvider>(context, listen: false);
      return FutureBuilder<LangameResponse<List<LangameUser>>>(
        future: p.getLangameUsers(
            channel!.players.map((e) => e.langameUid).toList()),
        builder: (c, s) {
          if (s.hasError) _handleError();
          if (s.hasData && s.data != null) {
            s.data!.thenShowToast(
              Provider.of<FunnyProvider>(context, listen: false)
                  .getLoadingRandom(),
              Provider.of<FunnyProvider>(context, listen: false)
                  .getFailingRandom(),
              onSucceed: () => _postFrameCallback(
                  (_) => setState(() => channelLangameUsers = s.data!.result!)),
              onFailure: () => _postFrameCallback(
                  (_) => setState(() => channelLangameUsers = [])),
            );
          }
          return _buildLoading();
        },
      );
    }
    debugPrint(
        'channelLangameUsers ${channelLangameUsers.map((e) => e.displayName).join(',')}');

    // Fifth-step, initialize audio engine
    if (!engineInitialized) {
      var p = Provider.of<AudioProvider>(context, listen: false);
      return FutureBuilder<LangameResponse<void>>(
        future: p.initEngine(_buildEventHandler()),
        builder: (c, s) {
          if (s.hasError) _handleError();
          if (s.hasData && s.data != null) {
            s.data!.thenShowToast(
              Provider.of<FunnyProvider>(context, listen: false)
                  .getLoadingRandom(),
              Provider.of<FunnyProvider>(context, listen: false)
                  .getFailingRandom(),
              onSucceed: () => _postFrameCallback(
                  (_) => setState(() => engineInitialized = true)),
              onFailure: () => _postFrameCallback(
                  (_) => setState(() => engineInitialized = false)),
            );
          }
          return _buildLoading();
        },
      );
    }
    debugPrint('engineInitialized $engineInitialized');

    // Sixth-step, join audio channel
    if (!channelJoined) {
      var p = Provider.of<AudioProvider>(context, listen: false);
      var ap = Provider.of<AuthenticationProvider>(context, listen: false);
      ChannelUserLangameUser player =
          channel!.players.firstWhere((p) => p.langameUid == ap.user?.uid);
      return FutureBuilder<LangameResponse<void>>(
          future: p.joinChannel(channelToken!, widget.notification.channelName!,
              player.channelUid),
          builder: (c, s) {
            if (s.hasError) _handleError();
            if (s.hasData && s.data != null) {
              s.data!.thenShowToast(
                Provider.of<FunnyProvider>(context, listen: false)
                    .getLoadingRandom(),
                Provider.of<FunnyProvider>(context, listen: false)
                    .getFailingRandom(),
                onSucceed: () => _postFrameCallback(
                    (_) => setState(() => channelJoined = true)),
                onFailure: () => _postFrameCallback(
                    (_) => setState(() => channelJoined = false)),
              );
            }
            return _buildLoading();
          });
    }
    debugPrint('channelJoined $channelJoined');

    if (channelToken == null ||
        channel == null ||
        channelLangameUsers.isEmpty ||
        !engineInitialized ||
        !channelJoined) {
      // TODO: turn mic off
      _buildLoading();
    } else if (widget.notifyOthers && !notified) {
      // TODO: generate and send some int id for channel
      Provider.of<AuthenticationProvider>(context, listen: false)
          .sendReadyForLangame(widget.notification.channelName!)
          .then((res) {
        res.thenShowToast(
          'Your friends have been told of your presence!',
          !kReleaseMode
              ? 'failed to sendReadyForLangame ${res.error.toString()}'
              : Provider.of<FunnyProvider>(context, listen: false)
                  .getFailingRandom(),
          onSucceed: () =>
              _postFrameCallback((_) => setState(() => notified = true)),
          onFailure: () =>
              _postFrameCallback((_) => setState(() => notified = false)),
        );
      });
    }
    debugPrint('notified $notified');
    debugPrint(
        'joinedPlayers ${joinedPlayers.values.map((e) => e.langameUser.displayName).join(',')}');

    return joinedPlayers.length != channel?.players.length
        ? _buildWaitingScreen()
        : Scaffold(
            appBar: AppBar(automaticallyImplyLeading: false),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTimerText(),
                _buildQuestion(), // TODO!!!!!!!!!!!
                _buildBottomHalf(),
              ],
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<AudioProvider>(context, listen: false)
        .leaveChannel(); // TODO: might fail? osef?
  }

  void _handleError() {
    if (errors > maxErrors) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FriendsView()),
      );
      Fluttertoast.showToast(
        msg: Provider.of<FunnyProvider>(context, listen: false)
            .getFailingRandom(),
        backgroundColor: Colors.red,
      );
      return;
    }
    setState(() => errors++);
  }

  void _postFrameCallback(FrameCallback callback) {
    WidgetsBinding.instance!.addPostFrameCallback(callback);
  }

  Widget _buildLoading({String? text}) {
    return Center(
      child: SpinKitHourGlass(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      // child: SpinKitPumpingHeart(
      //   itemBuilder: (BuildContext context, int index) {
      //     return DecoratedBox(
      //       decoration: BoxDecoration(
      //         color: Theme.of(context).brightness == Brightness.dark
      //             ? Colors.white
      //             : Colors.black,
      //       ),
      //       child: Text(text != null
      //           ? text
      //           : Provider.of<FunnyProvider>(context, listen: false)
      //               .getLoadingRandom()),
      //     );
      //   },
      // ),
    );
  }

  RtcEngineEventHandler _buildEventHandler() => RtcEngineEventHandler(
        activeSpeaker: (int uid) {
          setState(() {
            joinedPlayers[uid]?.isSpeaking = true;
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
          if (reason == UserOfflineReason.Quit) {
            Fluttertoast.showToast(
                msg: '${joinedPlayers[uid]?.langameUser.displayName} left');
          }
          setState(() {
            joinedPlayers.remove(uid);
          });
        },
        userJoined: (int uid, int b) {
          debugPrint('someone joined');
          debugPrint('$uid | $b');
          Fluttertoast.showToast(
              msg: '${joinedPlayers[uid]?.langameUser.displayName} joined');

          var joinerIds =
              channel?.players.firstWhere((p) => p.channelUid == uid);
          var joinerAsLangameUser = channelLangameUsers
              .firstWhere((p) => p.uid == joinerIds?.langameUid);
          // TODO: might fail to retrieve this user?
          setState(() {
            joinedPlayers[uid] = Player(joinerAsLangameUser, false);
          });
        },
        joinChannelSuccess: (channelName, uid, elapsed) {
          debugPrint('joinChannelSuccess $channelName $uid $elapsed');

          var joinerIds =
              channel?.players.firstWhere((p) => p.channelUid == uid);
          var joinerAsLangameUser = channelLangameUsers
              .firstWhere((p) => p.uid == joinerIds?.langameUid);
          // TODO: might fail to retrieve this user?
          setState(() {
            joinedPlayers[uid] = Player(joinerAsLangameUser, false);
          });
        },
        leaveChannel: (stats) {
          debugPrint('leaveChannel ${stats.toJson()}');
        },
      );

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SpinKitWave(
              color: Theme.of(context).colorScheme.primary,
              size: AppSize.blockSizeHorizontal * 3,
            ),
            SizedBox(width: AppSize.blockSizeVertical * 5),
            Expanded(
              child: Text(
                /// Exclusion between 'supposed to join' and 'joined ones' joined by ','
                'Waiting for ${channelLangameUsers.where((e) => !joinedPlayers.values.map((e) => e.langameUser.uid).contains(e)).map((e) => e.displayName).join(',')}...',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ]),
        ),
        SizedBox(height: AppSize.blockSizeVertical * 5),
        Container(
            width: AppSize.blockSizeHorizontal * 80,
            height: AppSize.blockSizeVertical * 60,
            color: Colors.white,
            child: Text(
                'In the future there will be a wikipedia page about the topic(s) here'))
      ]),
    );
  }

  Widget _buildTimerText() {
    var theme = Theme.of(context);

    Widget _loadIfNotStarted(AudioProvider p) {
      p.startTimer(); // TODO: no error handling ^^
      return _buildLoading();
    }

    return Consumer<AudioProvider>(
      builder: (context, p, child) => !p.timerStarted
          ? _loadIfNotStarted(p)
          : StreamBuilder<Duration>(
              stream: p.remaining,
              builder: (c, s) => Center(
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
                        !s.hasData
                            ? '15:00'
                            : '${s.data!.inMinutes}:${s.data!.inSeconds.remainder(60).toString().length == 2 ? '' : '0'}${s.data!.inSeconds.remainder(60)}',
                        textAlign: TextAlign.center,
                        style: theme.primaryTextTheme.button,
                      ),
                    ),
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
              'foobar', //question, // TODO!!!!!!!!!!!!!!!!!!
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
              children: joinedPlayers.values
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
                          child: buildCroppedRoundedNetworkImage(
                              p.langameUser.photoUrl),
                        ),
                      ))
                  .toList()),
        ),
        SizedBox(height: AppSize.safeBlockVertical * 5),
        Consumer<AudioProvider>(
            builder: (context, p, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(p.isMicrophoneEnabled
                            ? Icons.mic_rounded
                            : Icons.mic_off_rounded),
                        onPressed: () => p.switchMicrophone(),
                      ),
                      IconButton(
                        icon: Icon(p.isSpeakerphoneEnabled
                            ? Icons.speaker_notes_off_outlined
                            : Icons.speaker_notes_outlined),
                        onPressed: () => p.switchSpeakerphone(),
                      )
                    ])),
      ],
    );
  }
}
