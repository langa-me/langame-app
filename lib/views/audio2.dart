import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Example app.
class PlayFromMic extends StatefulWidget {
  @override
  _PlayFromMicState createState() => _PlayFromMicState();
}

class _PlayFromMicState extends State<PlayFromMic> {
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;
  stt.SpeechToText speech;
  bool _speechAvailable = false;
  final List<String> entries = <String>[];
  final List<int> colorCodes = <int>[];

  Future<void> open() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    // Be careful : openAudioSession returns a Future.
    // Do not access your FlutterSoundPlayer or FlutterSoundRecorder before the completion of the Future
    _mPlayer
        .openAudioSession(
      device: AudioDevice.blueToothA2DP,
      audioFlags: allowHeadset | allowEarPiece | allowBlueToothA2DP,
      category: SessionCategory.playAndRecord,
    )
        .then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
    speech = stt.SpeechToText();
    _speechAvailable = await speech.initialize(onStatus: (s) {
      print('status: $s');
    }, onError: (e) {
      print('error: $e');
    });
  }

  @override
  void initState() {
    super.initState();
    open();
  }

  @override
  void dispose() {
    stopPlayer();
    // Be careful : you must `close` the audio session when you have finished with it.
    _mPlayer.closeAudioSession();
    _mPlayer = null;

    super.dispose();
  }

  // -------  Here is the code to play from the microphone -----------------------

  void play() async {
    // await _mPlayer.startPlayerFromMic();
    if (_speechAvailable) {
      speech.listen(onResult: (r) {
        if (r.confidence < 0.8) return;
        print('result: $r');

        setState(() {
          colorCodes.add(Colors
              .primaries[Random().nextInt(Colors.primaries.length)].value);
          entries.add(r.recognizedWords);
        });
      });
    } else {
      print("The user has denied the use of speech recognition.");
    }
    setState(() {});
  }

  Future<void> stopPlayer() async {
    speech.stop();
    // if (_mPlayer != null) {
    //   await _mPlayer.stopPlayer();
    // }
  }

  // ---------------------------------------

  void Function() getPlaybackFn() {
    if (!_mPlayerIsInited) {
      return null;
    }
    return _mPlayer.isStopped
        ? play
        : () {
            stopPlayer().then((value) => setState(() {}));
          };
  }

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: getPlaybackFn(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer.isPlaying ? 'Stop' : 'Play'),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                speech != null && speech.isListening
                    ? Icons.mic
                    : Icons.mic_none,
                color: Colors.pink,
                size: 24.0,
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 400,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.amber[colorCodes[index]],
                  child: Center(child: Text('${entries[index]}')),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Play from Mic'),
      ),
      body: makeBody(),
    );
  }
}
