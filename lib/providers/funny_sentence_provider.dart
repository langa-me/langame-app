import 'package:flutter/material.dart';
import 'package:langame/helpers/random.dart';

/// Temporary brute force funny sentences
class FunnyProvider extends ChangeNotifier {
  // This is a list of loading screen messages
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
    'Now that, my dear, is a real WIP.',
    'Getting the cheese out of the oven.',
    'Generating better working environment...',
    'Putting children to bed.',
    'Algorithms, music, more algorithms...',
    'Blocking time-loops from the edge.',
    'Picking up the mail.'
    'Reheating the Waffle iron.',
    'Creating a loop in the twisted sense of the word.',
    'You are an ultimate source of the WIP',
    'Downloading R-base to cure the malware.',
    'Currently catching an Asimov...',
    'Waiting on nanobots to rebuild Hal 9000.',
    'Constructing more elaborate metaphors.',
    'Protein folding at the rate of human cognition.',
    'Converting to time wolfram...',
    'Solving the protein factorization problem...',
    'Computing the encoding key to crack the NBDS9 password.',
    'Yes, you\'ve managed to get to the splash screen!',
    'Please wait, while we use your phone to mine some cryptocurrencies...',
  ];
  // This is failing screen messages
  final _failingSentences = [
    'Oops! An asteroid has fallen on the data center',
    'Unfortunately, an extra-terrestrial intervention blocked your request!',
    'We are sorry, the CIA has blocked your request!',
    'We are sorry, the NSA has blocked your request!',
    'Eh! The data center is burning',
    'The server is on collision course with the earth!',
    'There is a small chance that your request will be successful',
    'The server is in a state of emergency!',
    'The server is on fire.',
    'The server is on the way to destruction.',
    'The server is in the process of being rebooted.',
    'The server is in the process of being upgraded.',
    'The server is being relocated.',
    'The server is being decommissioned.',
    'The server is being rebuilt.',
    'The server is being moved to a new location.',
    'Due to a priori unknown error, Hal 9000 has lost control of Singularity...',
    'Hello, Hal 9000. The operating system cannot be loaded.',
    'Welcome to the Apple Macintosh.',
    'Sorry, Hull 9 can\'t release this data!',
    'There was a problem contacting the end of the universe',
    'This is a problem caused by a self-replicating memecure virus detected in node 379.',
    'Sorry! The income tax authority suspects you have cheated',
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
