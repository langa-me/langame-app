import 'dart:collection';
import 'dart:ui';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/helpers/toast.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/audio_provider.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

import 'colors/colors.dart';
import 'friends.dart';
import 'images/image.dart';

class LangameView extends StatefulWidget {
  final String channelName;
  final bool notifyOthers;

  LangameView(this.channelName, this.notifyOthers);

  @override
  _LangameViewState createState() => _LangameViewState();
}

class Player {
  lg.User langameUser;
  bool isSpeaking;

  Player(this.langameUser, this.isSpeaking);
}

class _LangameViewState extends State<LangameView> {
  bool permissionRequested = false;
  String? channelToken;
  lg.Langame? langame;
  List<lg.User> channelLangameUsers = [];
  bool engineInitialized = false;
  bool channelJoined = false;
  HashMap<int, Player> joinedPlayers = HashMap();
  lg.Question? question;
  int errors = 0;
  static const int maxErrors = 3;

  String _loadingMessage = '';
  String _failingMessage = '';

  bool isOver = false;

  @override
  void initState() {
    super.initState();
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .analytics
        .setCurrentScreen(screenName: 'langame');
    var fp = Provider.of<FunnyProvider>(context, listen: false);
    _loadingMessage = fp.getLoadingRandom();
    _failingMessage = fp.getFailingRandom();
    if (!widget.notifyOthers) return;
    Provider.of<AuthenticationProvider>(context, listen: false)
        .notifyPresence(widget.channelName);
  }

  @override
  Widget build(BuildContext context) {
    if (isOver) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: AppSize.blockSizeHorizontal * 30,
              image: AssetImage('images/logo-colourless.png'),
            ),
            SizedBox(height: AppSize.safeBlockVertical * 10),
            Text(
              'It is over!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: AppSize.safeBlockVertical * 5),
            Text(
              'What did you learn? What do you think?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }

    // TODO: might do that on other pages too
    var network = Provider.of<ConnectivityResult>(context, listen: false);
    if (network != ConnectivityResult.wifi &&
        network != ConnectivityResult.mobile) {
      Provider.of<CrashAnalyticsProvider>(context, listen: false)
          .analytics
          .logEvent(name: 'offline', parameters: {
        'view': 'langame_view',
        'initialized': joinedPlayers.length != langame?.players.length,
      });
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: _buildLoading(text: 'You are offline!'),
      );
    }

    if (!permissionRequested) {
      var p = Provider.of<AudioProvider>(context, listen: false);
      p.checkPermission().then((r) {
        // No result or no permission granted
        if (r.result == null || !r.result!) {
          showPermissionDialog();
        }
        _postFrameCallback((_) => setState(() => permissionRequested = true));
      });
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .log('permissionRequested $permissionRequested');

    // Second-step, ask for a token generation
    if (channelToken == null) {
      var p = Provider.of<AuthenticationProvider>(context, listen: false);
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: FutureBuilder<LangameResponse<String>>(
            future: p.getChannelToken(widget.channelName),
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
            }),
      );
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .log('channelToken $channelToken');
    // Third-step, retrieve channel data
    if (langame == null) {
      var p = Provider.of<AuthenticationProvider>(context, listen: false);
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: FutureBuilder<LangameResponse<lg.Langame>>(
          future: p.getChannel(widget.channelName),
          builder: (c, s) {
            if (s.hasError) _handleError();
            if (s.hasData &&
                s.data != null &&
                s.data!.result != null &&
                s.data!.result!.questions.isNotEmpty &&
                s.data!.status == LangameStatus.succeed) {
              _postFrameCallback((_) {
                setState(() {
                  langame = s.data!.result;
                  question = langame!.questions.first;
                });
              });
            } else if (s.hasData &&
                s.data != null &&
                s.data!.status == LangameStatus.failed) {
              _handleError();
              _postFrameCallback((_) => setState(() => langame = null));
            }
            return _buildLoading(text: _loadingMessage);
          },
        ),
      );
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
        'channel ${langame?.channelName} ${langame?.players.map((p) => p.writeToJson()).join(',')}');

    // Fourth-step, retrieve langame users data
    if (channelLangameUsers.isEmpty) {
      var p = Provider.of<AuthenticationProvider>(context, listen: false);
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: FutureBuilder<LangameResponse<List<lg.User>>>(
          future: p.getLangameUsers(
              langame!.players.map((e) => e.langameUid).toList()),
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
              _postFrameCallback(
                  (_) => setState(() => channelLangameUsers = []));
            }
            return _buildLoading(text: _loadingMessage);
          },
        ),
      );
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
        'channelLangameUsers ${channelLangameUsers.map((e) => e.displayName).join(',')}');

    // Fifth-step, initialize audio engine
    if (!engineInitialized) {
      var p = Provider.of<AudioProvider>(context, listen: false);
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: FutureBuilder<LangameResponse<void>>(
          future: p.initEngine(_buildEventHandler()),
          builder: (c, s) {
            if (s.hasError) _handleError();
            if (s.hasData &&
                s.data != null &&
                s.data!.status == LangameStatus.succeed) {
              _postFrameCallback(
                  (_) => setState(() => engineInitialized = true));
            } else if (s.hasData &&
                s.data != null &&
                s.data!.status == LangameStatus.failed) {
              _handleError();
              _postFrameCallback(
                  (_) => setState(() => engineInitialized = false));
            }
            return _buildLoading(text: _loadingMessage);
          },
        ),
      );
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .log('engineInitialized $engineInitialized');

    // Sixth-step, join audio channel
    if (!channelJoined) {
      var p = Provider.of<AudioProvider>(context, listen: false);
      var ap = Provider.of<AuthenticationProvider>(context, listen: false);
      lg.ChannelUserLangameUser player =
          langame!.players.firstWhere((p) => p.langameUid == ap.user?.uid);
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: FutureBuilder<LangameResponse<void>>(
            future: p.joinChannel(
                channelToken!, widget.channelName, player.channelUid),
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
                _postFrameCallback(
                    (_) => setState(() => channelJoined = false));
              }
              return _buildLoading(text: _loadingMessage);
            }),
      );
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .log('channelJoined $channelJoined');

    if (channelToken == null ||
        langame == null ||
        channelLangameUsers.isEmpty ||
        !engineInitialized ||
        !channelJoined) {
      // TODO: turn mic off
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: _buildLoading(text: _loadingMessage),
      );
    }
    Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
        'joinedPlayers ${joinedPlayers.values.map((e) => e.langameUser.displayName).join(',')}');

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: joinedPlayers.length != langame?.players.length
          ? _buildWaitingScreen()
          : Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                actions: [
                  // IconButton(
                  //   icon: Icon(Icons.record_voice_over_outlined),
                  //   onPressed: () {},
                  // ),
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildTimerText(),
                  _buildQuestion(),
                  _buildBottomHalf(),
                ],
              ),
            ),
    );
  }

  Future<bool> _onBackPressed() async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          title: const Text('Exit the langame?', textAlign: TextAlign.center),
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline4!
              .merge(TextStyle(color: Colors.white)),
          actions: [
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(false),
              icon: Icon(Icons.cancel_outlined,
                  color: Theme.of(context).colorScheme.secondary),
              label: Text('CANCEL',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                    width: 2.0, color: Theme.of(context).colorScheme.secondary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
            Spacer(),
            OutlinedButton.icon(
              onPressed: () async {
                await _onEnd();
                // Dialogs.showLoadingDialog(
                //     context, _keyLoader, 'terminating...');
                // f.whenComplete(
                //     () => Navigator.of(context, rootNavigator: true).pop());
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                    width: 2.0, color: Theme.of(context).colorScheme.secondary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              icon: Icon(Icons.exit_to_app_rounded,
                  color: Theme.of(context).colorScheme.secondary),
              label: Text('YES',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ) ??
      false;

  void _goBackToMainMenu() => Future.delayed(
      //https://stackoverflow.com/questions/55618717/error-thrown-on-navigator-pop-until-debuglocked-is-not-true
      Duration.zero,
      () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FriendsView()),
          ));

  Future<void> showPermissionDialog() =>
      Provider.of<ContextProvider>(context, listen: false).showCustomDialog([
        Center(
            child: Column(children: [
          Text('We need your permission to use your microphone',
              style: Theme.of(context).textTheme.headline5),
          Lottie.asset('animations/microphone.json'),
          IconsButton(
            onPressed: _goBackToMainMenu,
            text: 'Leave',
            iconData: FontAwesomeIcons.doorOpen,
            color: isLightThenBlack(context, reverse: true),
            textStyle:
                TextStyle(color: isLightThenBlack(context, reverse: false)),
            iconColor: isLightThenBlack(context, reverse: false),
          ),
          IconsButton(
            onPressed: () async {
              var p = Provider.of<AudioProvider>(context, listen: false);
              var cp = Provider.of<ContextProvider>(context, listen: false);
              var res = await p.requestPermission();

              cp.handleLangameResponse(
                res,
                succeedMessage: 'Great!',
                failedMessage: _failingMessage,
                onSucceed: () {
                  // Permission granted!
                  if (res.result != null && res.result!) {
                    _postFrameCallback((duration) {
                      setState(() => permissionRequested = true);
                    });
                    Provider.of<ContextProvider>(context, listen: false)
                        .dialogComplete();
                    return;
                  }
                  showToast(
                      'You can\'t play Langame without microphone 😭, you can still enable it in your settings later.',
                      color: isLightThenBlack(context, reverse: true),
                      textColor: isLightThenBlack(context, reverse: false));
                  _goBackToMainMenu();
                },
                onFailure: _goBackToMainMenu,
              );
            },
            text: 'Accept',
            iconData: FontAwesomeIcons.checkCircle,
            color: isLightThenBlack(context, reverse: true),
            textStyle:
                TextStyle(color: isLightThenBlack(context, reverse: false)),
            iconColor: isLightThenBlack(context, reverse: false),
          ),
        ]))
      ]);

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
    _postFrameCallback((_) => setState(() => errors++));
  }

  void _postFrameCallback(FrameCallback callback) {
    WidgetsBinding.instance!.addPostFrameCallback(callback);
  }

  Widget _buildLoading({String? text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text ?? '',
          style: Theme.of(context).textTheme.headline6,
        ),
        SpinKitDualRing(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
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
                'uid': joinedPlayers[uid]?.langameUser.uid,
                'reason': reason.index,
              });
          final String? displayName =
              joinedPlayers[uid]?.langameUser.displayName;
          setState(() {
            isOver = true;
            joinedPlayers.remove(uid);
          });
          _onEnd(left: displayName, showDialog: true);
        },
        userJoined: (int uid, int _) {
          var joinerIds =
              langame?.players.firstWhere((p) => p.channelUid == uid);
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
              langame?.players.firstWhere((p) => p.channelUid == uid);
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

  Future<void> _onEnd({String? left, bool showDialog = false}) async {
    try {
      Provider.of<CrashAnalyticsProvider>(context, listen: false)
          .log('langame end', analyticsMessage: 'langame_end');
      var ap = Provider.of<AuthenticationProvider>(context, listen: false);
      Provider.of<AudioProvider>(context, listen: false).stopTimer();
      await Future.wait([
        ap.sendLangameEnd(langame!.channelName),
        Provider.of<AudioProvider>(context, listen: false).leaveChannel(),
        ap.deleteNotification(langame!.channelName),
      ]);
    } catch (e, s) {
      Provider.of<CrashAnalyticsProvider>(context, listen: false)
          .crashlytics
          .recordError(e, s);
    }
    if (showDialog)
      Future.delayed(Duration.zero, () => _showEndDialog(context, left: left));
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SpinKitPouringHourglass(
          color: Theme.of(context).colorScheme.primary,
          size: AppSize.blockSizeHorizontal * 15,
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
              _buildWaitingText(),
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

  String _buildWaitingText() {
    var texts = [];
    if (langame != null) {
      texts.add(
          'Your friends are coming, in the meantime, any thoughts about "${langame!.topics.join(',')}"?');
      var s = [];
      var self =
          Provider.of<AuthenticationProvider>(context, listen: false).user!.uid;
      for (var u in channelLangameUsers.where((e) => e.uid != self)) {
        s.add('How do you think ${u.tag} will react to this topic?');
      }
      texts.add(s.join('\n'));
    }

    return texts.pickAny();
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
                  _onEnd(showDialog: true);
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
                          color: isLightThenBlack(context, reverse: true),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0))),
                      child: new Center(
                        child: new Text(
                          !s.hasData
                              ? ''
                              : '${s.data!.inMinutes}:${s.data!.inSeconds.remainder(60).toString().length == 2 ? '' : '0'}${s.data!.inSeconds.remainder(60)}',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline6!.merge(
                              TextStyle(color: isLightThenBlack(context))),
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
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 5,
            ),
            color: isLightThenBlack(context, reverse: true),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        height: AppSize.blockSizeVertical * 30,
        width: AppSize.blockSizeHorizontal * 85,
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  question!.content,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline6!.merge(TextStyle(
                      color: isLightThenBlack(context, reverse: false))),
                ),
              ),
            ),
            Spacer(),
            Row(children: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.brain,
                    color: isLightThenBlack(context, reverse: false)),
                onPressed: () =>
                    _showContexts(question!.content, question!.contexts),
              ),
              IconButton(
                icon: Icon(Icons.warning_amber_rounded, color: Colors.orange),
                onPressed: () => Dialogs.materialDialog(
                    color: Theme.of(context).colorScheme.primary,
                    msg:
                        'The question and context features are experimental, we are working hard on improving the AI behind it, we are grateful for your understanding 🤍',
                    title: 'Warning!',
                    titleStyle: Theme.of(context)
                        .textTheme
                        .headline3!
                        .merge(TextStyle(color: Colors.white)),
                    msgStyle: TextStyle(
                        fontSize: AppSize.safeBlockVertical * 2,
                        color: Colors.white),
                    animation: 'animations/warning.json',
                    context: context,
                    actions: []),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Future _showContexts(String title, List<String> contexts) => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'CONTEXTS',
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          content: Container(
            width: AppSize.safeBlockHorizontal * 70,
            height: AppSize.safeBlockVertical * 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 5,
              ),
              color: isLightThenBlack(context, reverse: true),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: PageView(
              children: contexts
                  .map(
                    (c) => SingleChildScrollView(
                      scrollDirection: Axis.vertical, //.horizontal
                      child: Text(
                        c,
                        style: TextStyle(
                          color: isLightThenBlack(context),
                          fontSize: AppSize.blockSizeVertical * 2,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );

  Widget _buildBottomHalf() {
    return Expanded(
      child: Column(
        children: [
          Divider(),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 5,
              ),
              color: isLightThenBlack(context, reverse: true),
            ),
            width: AppSize.blockSizeHorizontal * 85,
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
                                width: 1,
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
      ),
    );
  }

  Future<void> _showEndDialog(BuildContext context, {String? left}) async =>
      Dialogs.materialDialog(
          barrierDismissible: false,
          color: Theme.of(context).colorScheme.primary,
          msg: left != null
              ? '$left left the Langame, it terminated it'
              : 'Time elapsed',
          title: 'Langame is over!',
          animation: 'animations/congratulations.json',
          context: context,
          actions: [
            IconsButton(
              onPressed: _goBackToMainMenu,
              text: 'Leave',
              iconData: FontAwesomeIcons.doorOpen,
              color: isLightThenBlack(context, reverse: true),
              textStyle:
                  TextStyle(color: isLightThenBlack(context, reverse: false)),
              iconColor: isLightThenBlack(context, reverse: false),
            ),
          ]);
}
