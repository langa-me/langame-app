// generates a new Random object
import 'dart:math';

final _random = new Random();

extension RandomIterableExtensions<T> on List<T> {
  /// Returns a random item within the [list].
  ///
  T? pickAny() {
    return this.length > 0 ? this[_random.nextInt(this.length)] : null;
  }
}
