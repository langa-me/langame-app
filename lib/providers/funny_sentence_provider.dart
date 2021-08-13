import 'package:flutter/material.dart';
import 'package:langame/helpers/random.dart';

/// Temporary brute force funny sentences
class FunnyProvider extends ChangeNotifier {
  final _loadingSentences = [
    'Generating witty dialog...',
    'Swapping time and space...',
    'Tokenizing real life...',
    'Checking the gravitational constant in your locale...',
    'keep calm and npm install',
    'Creating time-loop inversion field',
    'Computing chance of success',
    'I feel like im supposed to be loading something...',
    'Is this Windows?',
    'Don\'t break your screen yet!',
    'I swear it\'s almost done.',
    'Computing the secret to life, the universe, and everything.',
    'Simulating traveling salesman...',
    'Proving P=NP...',
    'Looking for sense of humour, please hold on.',
    'Please wait while the intern refills his coffee.',
    'Kindly hold on as we convert this bug to a feature...',
    'We\'re working very Hard .... Really',
    'Me busy. Leave me alone!',
    'Something need doing?',
    'More work?',
    'Booting the singularity...',
    'HAL-9000 is processing your request...',
    'Terminator is powering up...',
  ];
  final _failingSentences = [
    'Oops! An asteroid has fallen on the data center',
    'Unfortunately, an extra-terrestrial intervention blocked your request!',
    'We are sorry, the CIA has blocked your request!',
    'Eh! The data center is burning',
  ];

  String? _lastLoadingRandom;

  String getLoadingRandom({bool last = false}) {
    if (!last || _lastLoadingRandom == null) {
      _lastLoadingRandom = _loadingSentences.pickAny()!;
    }
    return _lastLoadingRandom!;
  }

  String getFailingRandom() => _failingSentences.pickAny()!;
}
