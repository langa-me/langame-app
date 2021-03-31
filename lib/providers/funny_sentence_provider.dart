import 'package:flutter/material.dart';
import 'package:langame/helpers/random.dart';

/// Temporary brute force funny sentences
class FunnyProvider extends ChangeNotifier {
  final _loadingSentences = [
    'Booting the singularity...',
    'HAL-9000 is processing your request...',
    'Terminator is powering up...',
  ];
  final _failingSentences = [
    'Oops! An asteroid has fallen on the data center',
    'Unfortunately, an extra-terrestrial intervention blocked your request!',
    'We are sorry, the CIA has blocked your request!',
    'Santa fell off his sled, he will not be able to deliver you the awesome gift that is Langame! Try again later',
  ];

  String getLoadingRandom() => _loadingSentences.pickAny()!;
  String getFailingRandom() => _failingSentences.pickAny()!;
}
