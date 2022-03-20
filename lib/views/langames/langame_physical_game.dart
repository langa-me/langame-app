import 'package:after_layout/after_layout.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/socialis/api.pbenum.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/soclialis_provider.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class LangamePhysicalGame extends StatefulWidget {
  final Function onStop;
  LangamePhysicalGame(this.onStop);
  @override
  _State createState() => _State();
}

class _State extends State<LangamePhysicalGame>
    with AfterLayoutMixin<LangamePhysicalGame> {
  String _userText = "";
  Codec _codec = Codec.aacMP4;

  FlutterSoundPlayer? _player = FlutterSoundPlayer();

  FlutterSoundRecorder? _recorder = FlutterSoundRecorder(
    logLevel: Level.info,
  );
  final tts = FlutterTts();
  GameState _state = GameState.PLAYER_ADD;
  bool _started = false;

  bool _isConnectedToSocialis = false;

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    if (!_started) {
      handleState();
    }

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _userText,
                style: Theme.of(context).textTheme.headline6,
              ),
              SpinKitDoubleBounce(color: getBlackAndWhite(context, 1)),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _player?.closePlayer();
    _recorder?.closeRecorder();
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _recorder!.openRecorder();
    if (!await _recorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  Future<void> talkToTheUser(String text) async {
    setState(() {
      _userText = text;
    });
    await tts.speak(text);
  }

  void handleState() async {
    setState(() => _started = true);
    var cp = Provider.of<ContextProvider>(context);
    var fp = Provider.of<FunnyProvider>(context);
    var sp = Provider.of<SocialisProvider>(context, listen: false);

    if (!_isConnectedToSocialis) {
      final playResponse = await sp.play();
      if (playResponse.status != LangameStatus.succeed) {
        await talkToTheUser(fp.getFailingRandom());
        return;
      }
      setState(() {
        _isConnectedToSocialis = true;
      });
    }

    await talkToTheUser('Who is playing?');
    // await openTheRecorder();
    // _player!.onProgress?.listen((e) {
    //   print(e);
    // });
    // List<Uint8List> players = [];
    // var recordingDataController = StreamController<Food>();
    // var _mRecordingDataSubscription =
    //     recordingDataController.stream.listen((buffer) {
    //   if (buffer is FoodData) {
    //     players.add(buffer.data!);
    //   }
    // });
    // await _recorder!.startRecorder(
    //   toStream: recordingDataController.sink,
    //   codec: Codec.pcm16,
    //   numChannels: 1,
    //   audioSource: AudioSource.microphone,
    //   sampleRate: 16000,
    // );

    // await Future.delayed(Duration(seconds: 10));
    // await _recorder!.stopRecorder();
    // _mRecordingDataSubscription.cancel();
    final playersNameResponse =
        await Provider.of<SocialisProvider>(context, listen: false)
            .talk(_state);

    if (playersNameResponse.status != LangameStatus.succeed) {
      widget.onStop();
      await talkToTheUser(fp.getFailingRandom());
      return;
    }
    await talkToTheUser(playersNameResponse.result!.text);
    setState(() {
      _state = playersNameResponse.result!.state;
    });
    final playerValidationResponse =
        await Provider.of<SocialisProvider>(context, listen: false)
            .talk(_state);
    if (playerValidationResponse.status != LangameStatus.succeed) {
      widget.onStop();
      await talkToTheUser(fp.getFailingRandom());
      return;
    }
    await talkToTheUser(playerValidationResponse.result!.text);

    // _player!.openPlayer();
    // _player!.startPlayerFromStream();
    // players.map(_player!.feedFromStream);
  }
}
