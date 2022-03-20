import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/grpc_interceptors.dart';
import 'package:langame/models/langame/socialis/api.pbgrpc.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'authentication_provider.dart';

class SocialisProvider extends ChangeNotifier {
  FirebaseApi firebase;
  CrashAnalyticsProvider _cap;
  AuthenticationProvider _ap;

  String? _socialisApiUrl;
  ClientChannelBase? _socialisChannel;
  SocialisClient? _socialisClient;
  Stream<Game>? _socialisStream;
  int _socialisFailCount = 0;
  bool _isLocalSocialisApi = false;

  SocialisProvider(
      this.firebase, this._cap, this._ap, this._isLocalSocialisApi) {
    _ap.userStream.listen((e) async {
      if (e.type == UserChangeType.NewAuthentication) {
      } else if (e.type == UserChangeType.Disconnection) {
        terminatesocialisClient();
      }
    });
  }

  Future<LangameResponse<void>> play() async {
    await initializateSocialisApi();
    return LangameResponse.succeed();
  }

  Future<LangameResponse<Game>> talk(GameState state) async {
    try {
      stt.SpeechToText speech = stt.SpeechToText();
      bool available = await speech.initialize(onError: (e) {
        _cap.recordError(e, null);
      });
      if (available) {
        speech.listen();
      } else {
        _cap.log("The user has denied the use of speech recognition.");
        return LangameResponse.failed(
            error: "Speech recognition not available");
      }
      await Future.delayed(Duration(seconds: 5));
      // some time later...
      speech.stop();
      Game? game;
      if (state == GameState.PLAYER_ADD) {
        game = await _socialisClient!.addPlayers(
          AddPlayersRequest(
            text: speech.lastRecognizedWords,
          ),
        );
      } else if (state == GameState.PLAYER_VALIDATE) {
        game = await _socialisClient!.validatePlayers(
          ValidatePlayersRequest(
            valid: speech.lastRecognizedWords.contains('yes'),
          ),
        );
      }
      if (game == null) return LangameResponse.failed(error: "No game found");
      return LangameResponse.succeed(result: game);
    } catch (e, s) {
      _cap.log('socialist_provider: failed to add players $e $s');
      _socialisFailCount++;
      if (_socialisFailCount > 5) {
        terminatesocialisClient();
        _cap.recordError(e, s);
      }
      return LangameResponse.failed();
    }
  }

  Future<void> initializateSocialisApi() async {
    final token = await firebase.auth!.currentUser!.getIdToken(true);
    _socialisApiUrl =
        // TODO: ip???
        _isLocalSocialisApi
            ? '192.168.5.169'
            : (await firebase.firestore!
                    .collection('apis')
                    .doc('socialis')
                    .get())
                .data()!['url'];
    final channelOptions = ChannelOptions(
        backoffStrategy: (d) => d ?? Duration(seconds: 1) * 2,
        credentials: _isLocalSocialisApi
            ? ChannelCredentials.insecure()
            : ChannelCredentials.secure());
    // _socialisChannel =
    // GrpcWebClientChannel.xhr(Uri.parse('http://0.0.0.0:8080'));
    _socialisChannel = ClientChannel(
      _socialisApiUrl!,
      options: channelOptions,
      port: _isLocalSocialisApi ? 8080 : 443,
    );

    _socialisClient = SocialisClient(
      _socialisChannel!,
      options: CallOptions(
        timeout: Duration(seconds: 30),
      ),
      interceptors: [
        ClientFirebaseAuthInterceptor(token),
      ],
    );
    _cap.log(
        'message_provider:socialis api initialized with url ${_socialisApiUrl}');
  }

  // Call the sentiment api to get the sentiment of the message
  void terminatesocialisClient() {
    _socialisChannel?.shutdown();
    _socialisChannel = null;
    _socialisClient = null;
    _socialisApiUrl = null;
    _socialisStream = null;
    _socialisFailCount = 0;
  }
}
