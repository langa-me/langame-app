import 'dart:ui';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/paint_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'colors/colors.dart';
import 'images/image.dart';
import 'main_view.dart';

class LangameView extends StatefulWidget {
  final String channelName;
  final bool notifyOthers;

  LangameView(this.channelName, this.notifyOthers);

  @override
  _LangameViewState createState() => _LangameViewState();
}

class LocalPlayer {
  lg.User langameUser;
  bool isSpeaking;

  LocalPlayer(this.langameUser, this.isSpeaking);
}

class _LangameViewState extends State<LangameView> {
  bool permissionRequested = false;
  Stream<DocumentSnapshot<lg.Langame>>? langameStream;
  Map<int, LocalPlayer> _localPlayers = {};
  bool engineInitialized = false;
  bool audioChannelJoined = false;
  int errors = 0;
  bool done = false;
  static const int maxErrors = 3;

  int _selfUid = 0;
  String _loadingMessage = '';
  String _failingMessage = '';

  // int _selectedIndex = 0;
  final PageController controller = PageController(initialPage: 0);
  final TextEditingController notesController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('langame');
    var fp = Provider.of<FunnyProvider>(context, listen: false);
    _loadingMessage = fp.getLoadingRandom();
    _failingMessage = fp.getFailingRandom();
    Provider.of<PaintingProvider>(context, listen: false)
        .init(widget.channelName);
    var lp = Provider.of<LangameProvider>(context, listen: false);

    if (!widget.notifyOthers) return;
    lp.notifyPresence(widget.channelName);
  }

  @override
  Widget build(BuildContext context) {
    var crash = Provider.of<CrashAnalyticsProvider>(context, listen: false);
    var lp = Provider.of<LangameProvider>(context, listen: false);
    var audio = Provider.of<AudioProvider>(context, listen: false);
    var cp = Provider.of<ContextProvider>(context, listen: false);

    // TODO: might do that on other pages too
    var network = Provider.of<ConnectivityResult>(context, listen: false);
    if (network == ConnectivityResult.none) {
      crash.analytics.logEvent(name: 'offline', parameters: {
        'view': 'langame_view',
      });
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: cp.buildLoadingWidget(text: 'You are offline!'),
      );
    }

    if (langameStream == null) {
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: FutureBuilder<
                LangameResponse<Stream<DocumentSnapshot<lg.Langame>>>>(
            future: lp.joinLangame(widget.channelName),
            builder: (c, s) {
              if (s.hasError ||
                  (s.hasData &&
                      s.data != null &&
                      s.data!.status == LangameStatus.failed)) {
                _handleError();
              }
              if (s.hasData &&
                  s.data != null &&
                  s.data!.status == LangameStatus.succeed &&
                  s.data!.result != null) {
                _postFrameCallback((_) => setState(() {
                      langameStream = s.data!.result!;
                    }));
              }
              return cp.buildLoadingWidget(text: _loadingMessage);
            }),
      );
    }

    if (done) {
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

    if (!permissionRequested) {
      audio.checkPermission().then((r) {
        // No result or no permission granted
        if (r.result == null || !r.result!) {
          showPermissionDialog();
        }
        _postFrameCallback((_) => setState(() => permissionRequested = true));
      });
    }
    crash.log('permissionRequested $permissionRequested');

    // Fifth-step, initialize audio engine
    if (!engineInitialized) {
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: FutureBuilder<LangameResponse<void>>(
          future: audio.initEngine(_buildEventHandler()),
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
            return cp.buildLoadingWidget(text: _loadingMessage);
          },
        ),
      );
    }
    crash.log('engineInitialized $engineInitialized');

    return WillPopScope(
        onWillPop: _onBackPressed,
        // Start once two players joined
        child: StreamBuilder<DocumentSnapshot<lg.Langame>>(
            builder: (context, langameSnap) {
              if (langameSnap.hasData && langameSnap.data!.exists) {
                // If it has started...
                return langameSnap.data!.data()!.hasStarted()
                    ? _buildRunningLangame(langameSnap.data!)
                    : _buildWaitingScreen(langameSnap.data!.data()!);
              }
              return cp.buildLoadingWidget(text: _loadingMessage);
            },
            stream: langameStream));
  }

  Widget _buildRunningLangame(DocumentSnapshot<lg.Langame> l) {
    Provider.of<LangameProvider>(context, listen: false)
        .addNote(widget.channelName, notesController.text, lg.Note_Type.goal);
    Provider.of<AudioProvider>(context, listen: false) // TODO
        // ignore: invalid_return_type_for_catch_error
        .joinChannel(l)
        .then((e) {
      if (e.error != null) _handleError(failNow: true);
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildHome(l.data()!),

      // body: Row(
      //   children: [
      //     NavigationRail(
      //       selectedIndex: _selectedIndex,
      //       onDestinationSelected: (int index) {
      //         setState(() => _selectedIndex = index);
      //         controller.animateToPage(
      //           _selectedIndex,
      //           duration: Duration(seconds: 1),
      //           curve: Curves.easeIn,
      //         );
      //       },
      //       labelType: NavigationRailLabelType.selected,
      //       destinations: const [
      //         NavigationRailDestination(
      //           icon: Icon(Icons.home_outlined),
      //           selectedIcon: Icon(Icons.home_outlined),
      //           label: Text('Home'),
      //         ),
      //         // NavigationRailDestination(
      //         //   icon: Icon(Icons.format_paint_outlined),
      //         //   selectedIcon: Icon(Icons.format_paint_outlined),
      //         //   label: Text('Paint'),
      //         // ),
      //       ],
      //     ),
      //     const VerticalDivider(thickness: 1, width: 1),
      //     Expanded(
      //       child: PageView(
      //         scrollDirection: Axis.vertical,
      //         controller: controller,
      //         // Prevent swiping on draw view
      //         physics:
      //             _selectedIndex == 1 ? NeverScrollableScrollPhysics() : null,
      //         onPageChanged: (v) {
      //           setState(() => _selectedIndex = v);
      //         },
      //         children: [
      //           _buildHome(l.data()!),
      //           // MultiplayerPainting(),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildHome(lg.Langame l) => Stack(children: [
        Positioned(
            top: AppSize.safeBlockVertical * 1,
            right: AppSize.safeBlockHorizontal * 1,
            child: IconButton(
                onPressed: _onBackPressed, icon: Icon(FontAwesomeIcons.times))),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTimerText(),
            _buildMeme(l),
            _buildBottomHalf(),
          ],
        )
      ]);

  Future<bool> _onBackPressed() {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    return cp.showCustomDialog<bool>(
      [
        Padding(
            padding: EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Exit the langame?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              LangameButton(cp.dialogComplete, 'Cancel', Icons.cancel_outlined),
              LangameButton(_onEnd, 'Yes', Icons.exit_to_app_rounded),
            ])),
      ],
      canBack: true,
    );
  }

  void _goBackToMainMenu() => Future.delayed(
          //https://stackoverflow.com/questions/55618717/error-thrown-on-navigator-pop-until-debuglocked-is-not-true
          Duration.zero, () {
        var cp = Provider.of<ContextProvider>(context, listen: false);
        cp.pushReplacement(MainView());
      });

  Future<void> showPermissionDialog() {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    return cp.showCustomDialog([
      Container(
          padding: EdgeInsets.all(12),
          child: Column(children: [
            Text('We need your permission to use your microphone',
                style: Theme.of(context).textTheme.headline6),
            Lottie.asset('animations/microphone.json'),
            LangameButton(() {
              cp.dialogComplete();
              _goBackToMainMenu();
            }, 'Leave', FontAwesomeIcons.doorOpen),
            LangameButton(() async {
              var p = Provider.of<AudioProvider>(context, listen: false);
              var res = await p.requestPermission();

              cp.handleLangameResponse(
                res,
                failedMessage: _failingMessage,
                onSucceed: () {
                  // Permission granted!
                  if (res.result != null && res.result!) {
                    _postFrameCallback((duration) {
                      setState(() => permissionRequested = true);
                    });
                    cp.dialogComplete();
                    return;
                  }
                  showToast(
                      'You can\'t play Langame without microphone 😭, you can still enable it in your settings later.',
                      color: isLightThenDark(context, reverse: true),
                      textColor: isLightThenDark(context, reverse: false));
                  _goBackToMainMenu();
                },
                onFailure: _goBackToMainMenu,
              );
            }, 'Accept', FontAwesomeIcons.checkCircle),
          ]))
    ]);
  }

  void _handleError({bool failNow = false}) {
    if (errors > maxErrors || failNow) {
      Provider.of<AudioProvider>(context, listen: false).leaveChannel();

      showToast(
        _failingMessage,
        color: Colors.red,
      );
      Provider.of<CrashAnalyticsProvider>(context, listen: false)
          .crashlytics
          .recordError(LangameException('failed to start langame'), null,
              reason: 'failed to start langame', fatal: true);
      _goBackToMainMenu();

      return;
    }
    _postFrameCallback((_) => setState(() => errors++));
  }

  void _postFrameCallback(FrameCallback callback) {
    WidgetsBinding.instance!.addPostFrameCallback(callback);
  }

  RtcEngineEventHandler _buildEventHandler() => RtcEngineEventHandler(
        activeSpeaker: (int audioId) async {
          LangameResponse<lg.User>? joiner;
          if (!_localPlayers.containsKey(audioId)) {
            joiner = await Provider.of<AudioProvider>(context, listen: false)
                .getLangameUserFromAudioId(audioId);
            if (joiner.error != null || joiner.result == null) {
              return;
            }
          }

          setState(() {
            if (joiner != null)
              _localPlayers[audioId] = LocalPlayer(joiner.result!, false);
            _localPlayers.keys.forEach((e) {
              _localPlayers[e]?.isSpeaking = false;
            });
            // hack because seems to use uid 0
            _localPlayers[audioId == 0 ? _selfUid : audioId]?.isSpeaking = true;
          });
          Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
              '${_localPlayers[audioId]?.langameUser.displayName} speaking: ${_localPlayers[audioId]?.isSpeaking}');
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
        userJoined: (int audioId, int _) async {
          var cap = Provider.of<CrashAnalyticsProvider>(context, listen: false);
          var joiner = await Provider.of<AudioProvider>(context, listen: false)
              .getLangameUserFromAudioId(audioId);
          if (joiner.error != null || joiner.result == null) {
            return;
          }

          setState(() {
            _localPlayers[audioId] = LocalPlayer(joiner.result!, false);
          });
          cap.log('userJoined $audioId',
              analyticsMessage: 'langame_user_join',
              analyticsParameters: {
                'uid': _localPlayers[audioId]?.langameUser.uid
              });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          if (!_localPlayers.containsKey(uid)) return; // TODO
          Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
              'userOffline $uid $reason',
              analyticsMessage: 'langame_user_leave',
              analyticsParameters: {
                'uid': _localPlayers[uid]!.langameUser.uid,
                'reason': reason.index,
              });
          final String? tag = _localPlayers[uid]!.langameUser.tag;

          Provider.of<ContextProvider>(context, listen: false)
              .showSnackBar('$tag left');
          setState(() {
            _localPlayers.remove(uid);
          });
        },
        joinChannelSuccess: (channelName, uid, elapsed) {
          var ap = Provider.of<AuthenticationProvider>(context, listen: false);
          setState(() {
            _localPlayers[uid] = LocalPlayer(ap.user!, false);
            _selfUid = uid;
          });

          Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
            'joinChannelSuccess $channelName $uid $elapsed',
            analyticsMessage: 'langame_user_join_self',
            analyticsParameters: {'uid': _localPlayers[uid]?.langameUser.uid},
          );
        },
        leaveChannel: (stats) {
          Provider.of<CrashAnalyticsProvider>(context, listen: false).log(
            'leaveChannel ${stats.toJson()}',
            analyticsMessage: 'langame_user_leave_self',
          );
        },
      );

  Future<void> _onEnd() async {
    setState(() => done = true);
    try {
      Provider.of<CrashAnalyticsProvider>(context, listen: false)
          .log('langame end', analyticsMessage: 'langame_end');
      Provider.of<AudioProvider>(context, listen: false).stopTimer();
      await Future.wait([
        // mp.sendLangameEnd(langame!.channelName),
        Provider.of<AudioProvider>(context, listen: false).leaveChannel(),
        // mp.deleteNotification(langame!.channelName),
        Provider.of<PaintingProvider>(context, listen: false).stop()
      ]);
    } catch (e, s) {
      Provider.of<CrashAnalyticsProvider>(context, listen: false)
          .crashlytics
          .recordError(e, s);
    }
    Future.delayed(Duration.zero, () => _showEndDialog());
  }

  Widget _buildWaitingScreen(lg.Langame l) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SpinKitPouringHourglass(
          color: Theme.of(context).colorScheme.primary,
          size: AppSize.blockSizeHorizontal * 15,
        ),
        SizedBox(height: AppSize.blockSizeVertical * 5),
        Container(
          padding: EdgeInsets.all(12),
          width: AppSize.blockSizeHorizontal * 85,
          height: AppSize.blockSizeVertical * 60,
          decoration: BoxDecoration(
            color: variantIsLightThenDark(context, reverse: true),
            border: Border.all(
              color: Theme.of(context).colorScheme.primaryVariant,
              width: 5,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(40.0),
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  _buildWaitingText(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextField(
                  controller: notesController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          'You can compare with your actual experience later'),
                ),
              ]),
        ),
      ]),
    );
  }

  String _buildWaitingText() {
    var texts = [];
    texts.add('How do you think they will react to this topic?');

    return texts.pickAny();
  }

  Widget _buildTimerText() {
    var theme = Theme.of(context);

    Widget _loadIfNotStarted(AudioProvider p) {
      p.startTimer(); // TODO: no error handling ^^
      // hack to force rebuild (notifyListeners() in provider cause
      // setState() or markNeedsBuild() called during build)
      _postFrameCallback((_) => setState(() {}));
      return Provider.of<ContextProvider>(context, listen: false)
          .buildLoadingWidget(text: _loadingMessage);
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
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0))),
                      child: new Center(
                        child: new Text(
                          !s.hasData
                              ? ''
                              : '${s.data!.inMinutes}:${s.data!.inSeconds.remainder(60).toString().length == 2 ? '' : '0'}${s.data!.inSeconds.remainder(60)}',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline6!.merge(
                              TextStyle(color: isLightThenDark(context))),
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  Widget _buildMeme(lg.Langame l) {
    var theme = Theme.of(context);
    var tp = Provider.of<TagProvider>(context, listen: false);
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var ctxFutureBuilder = () => FutureBuilder(
        future: tp.getMemeTags(l.memes[l.currentMeme]),
        builder: (ctx, AsyncSnapshot<LangameResponse<List<lg.Tag>>> tags) {
          if (tags.hasData &&
              tags.data!.result != null &&
              tags.data!.result!.length > 0) {
            return IconButton(
              icon: FaIcon(FontAwesomeIcons.brain,
                  color: isLightThenDark(context, reverse: false)),
              onPressed: () => _showContexts(tags.data!.result!
                  .where((e) => e.hasContext())
                  .map((e) => e.context)
                  .toList()),
            );
          }
          return CircularProgressIndicator();
        });
    var memeFutureBuilder = () => FutureBuilder(
        future: tp.getMeme(l.memes[l.currentMeme]),
        builder: (ctx, AsyncSnapshot<LangameResponse<lg.Meme>> s) {
          if (s.hasData && s.data!.result != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      s.data!.result!.content,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headline6!.merge(TextStyle(
                          color: isLightThenDark(context, reverse: false))),
                    ),
                  ),
                ),
                Row(children: [
                  ctxFutureBuilder(),
                  IconButton(
                    icon:
                        Icon(Icons.warning_amber_rounded, color: Colors.orange),
                    onPressed: () => cp.showCustomDialog([
                      Text(
                        'Warning',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headline6,
                      ),
                      Lottie.asset(
                        'animations/warning.json',
                        width: AppSize.safeBlockHorizontal * 50,
                        height: AppSize.safeBlockVertical * 50,
                      ),
                      Text(
                        'Some features are experimental, we are working hard on improving the AI behind it, we are grateful for your understanding 🤍',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headline6,
                      ),
                    ], canBack: true),
                  ),
                ]),
              ],
            );
          }
          return Provider.of<ContextProvider>(context, listen: false)
              .buildLoadingWidget(text: '');
        });

    return Center(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 5,
            ),
            color: isLightThenDark(context, reverse: true),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        height: AppSize.blockSizeVertical * 40,
        width: AppSize.safeBlockHorizontal * 80,
        child: memeFutureBuilder(),
      ),
    );
  }

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
              color: isLightThenDark(context, reverse: true),
            ),
            width: AppSize.safeBlockHorizontal * 70,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _localPlayers.values
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
          SizedBox(height: AppSize.safeBlockVertical * 2),
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

  Future _showContexts(List<lg.Tag_Context> contexts) => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Align(
              child: FaIcon(FontAwesomeIcons.brain,
                  color: isLightThenDark(context, reverse: false))),
          content: Container(
            width: AppSize.safeBlockHorizontal * 70,
            height: AppSize.safeBlockVertical * 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 5,
              ),
              color: isLightThenDark(context, reverse: true),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: PageView(
              children: contexts.length == 0
                  ? [
                      Column(children: [
                        Image(
                          width: AppSize.safeBlockHorizontal * 30,
                          height: AppSize.safeBlockVertical * 30,
                          image: AssetImage('images/logo-colourless.png'),
                        ),
                        Spacer(),
                        Text('No contexts for this!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline4),
                      ]),
                    ]
                  : contexts
                      .map(
                        (c) => SingleChildScrollView(
                          scrollDirection: Axis.vertical, //.horizontal
                          child: Text(
                            c.content,
                            style: TextStyle(
                              color: isLightThenDark(context),
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

  Future<void> _showEndDialog() async {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    cp.showCustomDialog(
      [
        Padding(
          padding: EdgeInsets.all(10),
          child: Consumer<FeedbackProvider>(
            builder: (ctx, s, c) =>
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Langame is over, how was it?',
                style: Theme.of(context).textTheme.headline4,
              ),
              LottieBuilder.asset(
                'animations/congratulations.json',
                width: AppSize.safeBlockHorizontal * 40,
                height: AppSize.safeBlockVertical * 40,
              ),
              Text(
                'How relevant to the topic the conversation starter was?',
                style: Theme.of(context).textTheme.headline6,
              ),
              ToggleButtons(
                children: <Widget>[
                  Icon(FontAwesomeIcons.frown, color: isLightThenDark(context)),
                  Icon(FontAwesomeIcons.meh, color: isLightThenDark(context)),
                  Icon(FontAwesomeIcons.grinTongue,
                      color: isLightThenDark(context)),
                ],
                onPressed: (int i) => s.feedbackMemeRelevanceScore = i,
                isSelected: s.feedbackMemeRelevanceSelected,
              ),
              Text(
                'How would you rate the conversation starter?',
                style: Theme.of(context).textTheme.headline6,
              ),
              ToggleButtons(
                children: <Widget>[
                  Icon(FontAwesomeIcons.frown, color: isLightThenDark(context)),
                  Icon(FontAwesomeIcons.meh, color: isLightThenDark(context)),
                  Icon(FontAwesomeIcons.grinTongue,
                      color: isLightThenDark(context)),
                ],
                onPressed: (int i) => s.feedbackMemeGeneralScore = i,
                isSelected: s.feedbackMemeGeneralScoreSelected,
              ),
              LangameButton(() {
                var currentLg =
                    Provider.of<LangameProvider>(context, listen: false)
                        .runningLangames
                        .values
                        .firstWhere((e) => e.channelName == widget.channelName);
                // TODO: handle multiple memes
                // We don't wait, should not block user
                s.sendMemeFeedback(currentLg.memes[0]);
                cp.showSnackBar('Thank you a lot 🥰');
                _goBackToMainMenu();
              }, 'Leave', FontAwesomeIcons.doorOpen),
            ]),
          ),
        ),
      ],
      canBack: false,
    );
  }
}
