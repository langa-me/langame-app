import 'dart:collection';
import 'dart:ui';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/toast.dart';
import 'package:langame/models/channel.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/audio_provider.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
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
  String? channelToken;
  LangameChannel? channel;
  List<LangameUser> channelLangameUsers = [];
  bool engineInitialized = false;
  bool channelJoined = false;
  HashMap<int, Player> joinedPlayers = HashMap();
  String? question; // TODO!!!!!!!!!!!!!!!
  int errors = 0;
  static const int maxErrors = 3;

  String _loadingMessage = '';
  String _failingMessage = '';

  @override
  void initState() {
    super.initState();
    if (!widget.notifyOthers) return;
    Provider.of<AuthenticationProvider>(context, listen: false)
        .sendReadyForLangame(widget.notification.channelName!);
    // showToast(
    //   'Your friends have been told of your presence!',
    //   color: Theme.of(context).colorScheme.primary,
    //   textColor: Theme.of(context).brightness == Brightness.dark
    //       ? Colors.white
    //       : Colors.black,
    // );
    var fp = Provider.of<FunnyProvider>(context, listen: false);
    _loadingMessage = fp.getLoadingRandom();
    _failingMessage = fp.getFailingRandom();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: might do that on other pages too
    var network = Provider.of<ConnectivityResult>(context, listen: false);
    if (network != ConnectivityResult.wifi &&
        network != ConnectivityResult.mobile) {
      Provider.of<CrashAnalyticsProvider>(context, listen: false)
          .analytics
          .logEvent(name: 'offline', parameters: {
        'view': 'langame_view',
        'initialized': joinedPlayers.length != channel?.players.length,
      });
      return _buildLoading(text: 'You are offline!');
    }

    Widget? permission = _handlePermission();
    if (permission != null) return permission;

    // Second-step, ask for a token generation
    if (channelToken == null) {
      var p = Provider.of<AuthenticationProvider>(context, listen: false);
      return FutureBuilder<LangameResponse<String>>(
          future: p.getChannelToken(widget.notification.channelName!),
          builder: (c, s) {
            if (s.hasError) _handleError();
            if (s.hasData &&
                s.data != null &&
                s.data!.status == LangameStatus.succeed) {
              _postFrameCallback(
                  (_) => setState(() => channelToken = s.data!.result));
            } else if (s.hasData &&
                s.data != null &&
                s.data!.status == LangameStatus.failed) {
              _handleError();
              _postFrameCallback((_) => setState(() => channelToken = null));
            }
            return _buildLoading(text: _loadingMessage);
          });
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .log('channelToken $channelToken');
    // Third-step, retrieve channel data
    if (channel == null) {
      var p = Provider.of<AuthenticationProvider>(context, listen: false);
      return FutureBuilder<LangameResponse<LangameChannel>>(
        future: p.getChannel(widget.notification.channelName!),
        builder: (c, s) {
          if (s.hasError) _handleError();
          if (s.hasData &&
              s.data != null &&
              s.data!.status == LangameStatus.succeed) {
            _postFrameCallback((_) {
              setState(() {
                channel = s.data!.result;
                question = s.data!.result!.questions.isEmpty
                    ? Provider.of<FunnyProvider>(context, listen: false)
                        .getFailingRandom()
                    : channel!.questions.first;
              });
            });
          } else if (s.hasData &&
              s.data != null &&
              s.data!.status == LangameStatus.failed) {
            _handleError();
            _postFrameCallback((_) => setState(() => channel = null));
          }
          return _buildLoading(text: _loadingMessage);
        },
      );
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
        'channel ${channel?.channelName} ${channel?.players.map((p) => p.toJson()).join(',')}');

    // Fourth-step, retrieve langame users data
    if (channelLangameUsers.isEmpty) {
      var p = Provider.of<AuthenticationProvider>(context, listen: false);
      return FutureBuilder<LangameResponse<List<LangameUser>>>(
        future: p.getLangameUsers(
            channel!.players.map((e) => e.langameUid).toList()),
        builder: (c, s) {
          if (s.hasError) _handleError();
          if (s.hasData &&
              s.data != null &&
              s.data!.status == LangameStatus.succeed) {
            _postFrameCallback(
                (_) => setState(() => channelLangameUsers = s.data!.result!));
          } else if (s.hasData &&
              s.data != null &&
              s.data!.status == LangameStatus.failed) {
            _handleError();
            _postFrameCallback((_) => setState(() => channelLangameUsers = []));
          }
          return _buildLoading(text: _loadingMessage);
        },
      );
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
        'channelLangameUsers ${channelLangameUsers.map((e) => e.displayName).join(',')}');

    // Fifth-step, initialize audio engine
    if (!engineInitialized) {
      var p = Provider.of<AudioProvider>(context, listen: false);
      return FutureBuilder<LangameResponse<void>>(
        future: p.initEngine(_buildEventHandler()),
        builder: (c, s) {
          if (s.hasError) _handleError();
          if (s.hasData &&
              s.data != null &&
              s.data!.status == LangameStatus.succeed) {
            _postFrameCallback((_) => setState(() => engineInitialized = true));
          } else if (s.hasData &&
              s.data != null &&
              s.data!.status == LangameStatus.failed) {
            _handleError();
            _postFrameCallback(
                (_) => setState(() => engineInitialized = false));
          }
          return _buildLoading(text: _loadingMessage);
        },
      );
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .log('engineInitialized $engineInitialized');

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
            if (s.hasData &&
                s.data != null &&
                s.data!.status == LangameStatus.succeed) {
              _postFrameCallback((_) => setState(() => channelJoined = true));
            } else if (s.hasData &&
                s.data != null &&
                s.data!.status == LangameStatus.failed) {
              _handleError();
              _postFrameCallback((_) => setState(() => channelJoined = false));
            }
            return _buildLoading(text: _loadingMessage);
          });
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .log('channelJoined $channelJoined');

    if (channelToken == null ||
        channel == null ||
        channelLangameUsers.isEmpty ||
        !engineInitialized ||
        !channelJoined) {
      // TODO: turn mic off
      _buildLoading(text: _loadingMessage);
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
        'joinedPlayers ${joinedPlayers.values.map((e) => e.langameUser.displayName).join(',')}');

    return joinedPlayers.length != channel?.players.length
        ? _buildWaitingScreen()
        : Scaffold(
            // appBar: AppBar(
            //   automaticallyImplyLeading: false,
            //   actions: [
            //     IconButton(
            //       icon: Icon(Icons.record_voice_over_outlined),
            //       onPressed: () {},
            //     ),
            //   ],
            // ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTimerText(),
                _buildQuestion(),
                Spacer(),
                _buildBottomHalf(),
                SizedBox(height: AppSize.safeBlockVertical * 5),
              ],
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<AudioProvider>(AppConst.navKey.currentContext!, listen: false)
        .leaveChannel(); // TODO: might fail?
  }

  void _goBackToMainMenu() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FriendsView()),
      );

  Widget? _handlePermission() {
    if (!permissionRequested) {
      var p = Provider.of<AudioProvider>(context, listen: false);
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
                    onPressed: _goBackToMainMenu,
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
                        _failingMessage,
                        onSucceed: () {
                          // Permission granted!
                          if (res.result != null && res.result!) {
                            _postFrameCallback((duration) =>
                                setState(() => permissionRequested = true));
                            return;
                          }
                          showToast(
                              'You can\'t play Langame without microphone :(, you can still enable it in your settings later.');
                          _goBackToMainMenu();
                        },
                        onFailure: _goBackToMainMenu,
                      );
                    },
                    icon: Icon(Icons.check_circle_outline),
                    label: Text('UNDERSTOOD'),
                  ),
                ],
              );
            }
          }
          return _buildLoading(text: _loadingMessage);
        },
      );
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .log('permissionRequested $permissionRequested');
  }

  void _handleError() {
    if (errors > maxErrors) {
      _goBackToMainMenu();
      showToast(
        _failingMessage,
        color: Colors.red,
      );
      Provider.of<CrashAnalyticsProvider>(context, listen: false)
          .crashlytics
          .recordError(LangameException('failed to start langame'), null,
              reason: 'failed to start langame', fatal: true);
      return;
    }
    setState(() => errors++);
  }

  void _postFrameCallback(FrameCallback callback) {
    WidgetsBinding.instance!.addPostFrameCallback(callback);
  }

  Widget _buildLoading({String? text}) {
    return Column(
      children: [
        Spacer(),
        Text(
          text ?? '',
          style: Theme.of(context).textTheme.headline6,
        ),
        SpinKitPumpingHeart(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        Spacer(),
      ],
    );
  }

  RtcEngineEventHandler _buildEventHandler() => RtcEngineEventHandler(
        activeSpeaker: (int uid) {
          setState(() {
            joinedPlayers[uid]?.isSpeaking = true;
          });
          Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
              '${joinedPlayers[uid]?.langameUser.displayName} speaking: ${joinedPlayers[uid]?.isSpeaking}');
        },
        microphoneEnabled: (bool a) {
          Provider.of<CrashAnalyticsProvider>(context, listen: false)
              .log('microphoneEnabled $a');
        },
        streamMessage: (int a, int b, String c) {
          Provider.of<CrashAnalyticsProvider>(context, listen: false)
              .log('streamMessage a $a b $b c $c');
        },
        localUserRegistered: (int a, String b) {
          Provider.of<CrashAnalyticsProvider>(context, listen: false)
              .log('localUserRegistered a $a b$b');
        },
        userOffline: (int uid, UserOfflineReason reason) {
          Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
              'userOffline $uid $reason',
              analyticsMessage: 'langame_user_leave',
              analyticsParameters: {
                'uid': joinedPlayers[uid]?.langameUser.uid
              });
          setState(() {
            joinedPlayers.remove(uid);
          });
          _onEnd(left: joinedPlayers[uid]?.langameUser.displayName);
        },
        userJoined: (int uid, int _) {
          var joinerIds =
              channel?.players.firstWhere((p) => p.channelUid == uid);
          var joinerAsLangameUser = channelLangameUsers
              .firstWhere((p) => p.uid == joinerIds?.langameUid);
          // TODO: might fail to retrieve this user?
          setState(() {
            joinedPlayers[uid] = Player(joinerAsLangameUser, false);
          });
          Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
              'userJoined $uid',
              analyticsMessage: 'langame_user_join',
              analyticsParameters: {
                'uid': joinedPlayers[uid]?.langameUser.uid
              });
        },
        joinChannelSuccess: (channelName, uid, elapsed) {
          var joinerIds =
              channel?.players.firstWhere((p) => p.channelUid == uid);
          var joinerAsLangameUser = channelLangameUsers
              .firstWhere((p) => p.uid == joinerIds?.langameUid);
          // TODO: might fail to retrieve this user?
          setState(() {
            joinedPlayers[uid] = Player(joinerAsLangameUser, false);
          });

          Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
            'joinChannelSuccess $channelName $uid $elapsed',
            analyticsMessage: 'langame_user_join_self',
            analyticsParameters: {'uid': joinedPlayers[uid]?.langameUser.uid},
          );
        },
        leaveChannel: (stats) {
          Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
            'leaveChannel ${stats.toJson()}',
            analyticsMessage: 'langame_user_leave_self',
          );
        },
      );

  void _onEnd({String? left}) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .log('langame end', analyticsMessage: 'langame_end');
    Future.delayed(Duration.zero, () => _showEndDialog(context, left: left));
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: EdgeInsets.all(5),
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
            SizedBox(width: AppSize.blockSizeVertical * 3),
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
          height: AppSize.blockSizeVertical * 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(
              color: Theme.of(context).colorScheme.primaryVariant,
              width: 5,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(40.0),
            ),
          ),
          child: Center(
            child: Text(
              'In the future there will be a wikipedia page about the topic(s) here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildTimerText() {
    var theme = Theme.of(context);

    Widget _loadIfNotStarted(AudioProvider p) {
      p.startTimer(); // TODO: no error handling ^^
      // hack to force rebuild (notifyListeners() in provider cause
      // setState() or markNeedsBuild() called during build)
      _postFrameCallback((_) => setState(() {}));
      return _buildLoading();
    }

    return Consumer<AudioProvider>(
      builder: (context, p, child) => !p.timerStarted
          ? _loadIfNotStarted(p)
          : StreamBuilder<Duration>(
              stream: p.remaining,
              builder: (c, s) {
                if (s.hasData && s.data != null && s.data!.inSeconds == 1) {
                  _onEnd();
                }
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
                          color: theme.colorScheme.primary,
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0))),
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
                );
              }),
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
              color: theme.colorScheme.primaryVariant,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Center(
            child: Text(
              question!,
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
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            border: Border.all(
              color: Theme.of(context).colorScheme.primaryVariant,
              width: 5,
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
          width: AppSize.blockSizeHorizontal * 80,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: joinedPlayers.values
                  .map(
                    (p) => Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            border: Border.all(
                              width: 10,
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
                        ),
                        // Icon(Icons
                        //     .mic_rounded), // TODO: use show if other has mic on or not
                      ],
                    ),
                  )
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
                      // TODO: does not work somehow, not rly mandatory
                      // IconButton(
                      //   icon: Icon(p.isSpeakerphoneEnabled
                      //       ? Icons.speaker_notes_outlined
                      //       : Icons.speaker_notes_off_outlined),
                      //   onPressed: () => p.switchSpeakerphone(),
                      // )
                    ])),
      ],
    );
  }

  Future<void> _showEndDialog(BuildContext context, {String? left}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Langame is over!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(left != null
                    ? '$left left the Langame, it terminated it'
                    : 'Time elapsed'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Leave'),
              onPressed: _goBackToMainMenu,
            ),
          ],
        );
      },
    );
  }
}
