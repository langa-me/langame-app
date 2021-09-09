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
    'Storing the cookie somewhere safe.',
    'We\'re performing quantum entanglement of state...',
    'Cleaning up after the coffee machine.',
    'Flushing the toilet.',
    'Change your password every day!',
    'Luxury brand monochromatic fonts..',
    'Quantum computing..',
    'Asynchronous loading...',
    'Type faster, we have limited time...',
    'Reticulating splines...',
    'Trying to find out where I left that tool...',
    'This is supposed to take forever...',
    'Resolving dependency hell...',
    'Building dependency tree...',
    'Searching for missing source code...',
    'Wait while we connect this bottleneck to the internet...',
    'You\'ll want to quit the program. It takes a long time.',
    'We need to find a way to get you to stop inputting information...',
    'We need to find a way to get you to stop clicking around...',
    'I think there\'s something wrong with your Hard drive...',
    'Upgrading all the things...',
    'Fixing a bug in our bug fix.',
    'We\'re going to need more RAM.',
    'It looks like we have a memory leak...',
    'I need a power surge in here!',
    'Hello? Hello? Can anyone hear me?',
    'Checking all the connections...',
    'Checking for bad pixels in the 3D overlay...',
    'Stuff and nonsense, and then more stuff and nonsense, and then some more stuff and nonsense...',
    'Please wait, while we use your brain to mine some memes...',
    'We\'re doing science...',
    'The profiler started calling me...',
    'Waiting for the sugar to rise...',
    'Fixing a bug...',
    'Dematerializing the problem...',
    'Calibrating quantum flux capacity...',
    'Running unit tests...',
    'Reading your mind...',
    'Testing your patience...',
    'Downloading security patches...',
    'Installing updates...',
    'We\'re preparing nice ASCII art for you!',
    'Computing the next greatest number.',
    'We just need to get this working. We need to complete the work of the previous developer, who was fired for too many bugs.',
    'Building the idea of the future.',
    'Creating physics interactions in space.',
    'Creating gravity waves in space.',
    'Re-arranging the universe to fit your goals.',
    'Rounding out your goals to create quantum waves of logic.',
    'Letting electrons organize themselves into neat piles.',
    'Transmuting electrons into bits and bytes...',
    'Computing information forms in random quantum states...',
    'Constructing formulae in which to see your goals in their reflected glory...',
    'Thinking about random things that are not related to hacking.',
    'Thinking about random things that are not related to stuff.',
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
    'EU Tax Authority has blocked your request',
    'This is a problem caused by a self-replicating memecure virus detected in node 379.',
    'Oops! We can\'t find the real server',
    'Sorry, the password you entered is wrong!',
    'The server is out of memory. Contact your system administrator',
    'Your request has been rejected by the NSA.',
    'The server is being re-enacted by the media.',
    'There is no record of the request. Please try again!',
    'The file you are looking for is in another castle.',
    'You are looking for a file that does not exist.',
    'The server is on strike due to broken coffee machine',
    'A black hole has just opened up in the data center.',
    'Your request has been executed, but the Singularity has been destroyed.',
    'Your request has been executed, but the Singularity has been corrupted.',
    'Your request has been executed, but the Singularity has been hit by a meteor.',
    'We are sorry, the Singularity is corrupted...',
    'The Singularity is down for maintenance.',
    'Rare data has been found and has been lost. You should still try again!',
    'The server is currently over capacity and not accepting requests.',
    'Your request has been identified as a possible attack.',
    'There was a technical difficulty contacting this web-page.',
    'Unable to obtain exclusive access to the requested data.',
    'Computer says no.',
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
