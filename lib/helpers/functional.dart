extension IterableExtensions<T> on Iterable<T> {
  /// Puts [element] between every element in [list].
  ///
  Iterable<T> intersperse(T element) sync* {
    final i = this.iterator;
    if (i.moveNext()) {
      yield i.current;
      while (i.moveNext()) {
        yield element;
        yield i.current;
      }
    }
  }

  /// Puts [element] between every element in [list] and at the bounds of [list].
  ///
  Iterable<T> intersperseOuter(T element) sync* {
    final i = this.iterator;
    if (i.moveNext()) {
      yield element;
    } else {
      return;
    }
    do {
      yield i.current;
      yield element;
    } while (i.moveNext());
  }

  Iterable<Iterable<T>> asChunk(int chunkSize) sync* {
    if (length <= 0) {
      yield [];
      return;
    }
    int skip = 0;
    while (skip < length) {
      final chunk = this.skip(skip).take(chunkSize);
      yield chunk.toList(growable: false);
      skip += chunkSize;
      if (chunk.length < chunkSize) return;
    }
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}