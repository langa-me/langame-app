import 'package:langame/helpers/functional.dart';
import 'package:test/test.dart';

void main() {
  group('intersperse', () {
    test('should properly insert nothing when only one element', () {
      expect(<int>[0].intersperse(2), <int>[0]);
    });
    test('should properly insert nothing when list is empty', () {
      expect(<int>[].intersperse(2), <int>[]);
    });
    test('should properly insert 2 between 0 and 1', () {
      expect(<int>[0, 1].intersperse(2), <int>[0, 2, 1]);
    });
  });

  group('intersperseOut', () {
    test('should properly insert around the only one element', () {
      expect(<int>[0].intersperseOuter(2), <int>[2, 0, 2]);
    });
    test('should properly insert nothing when list is empty', () {
      expect(<int>[].intersperseOuter(2), <int>[]);
    });
    test('should properly insert 2s around & between 0 and 1', () {
      expect(<int>[0, 1].intersperseOuter(2), <int>[2, 0, 2, 1, 2]);
    });
  });

  group('asChunk', () {
    test(
        'Splitting as chunks of 2 should properly split 1 elements into 1 lists',
        () {
      expect(<int>[0].asChunk(2), <Iterable<int>>[
        <int>[0],
      ]);
    });
    test(
        'Splitting as chunks of 2 should properly split 4 elements into 2 lists',
        () {
      expect(<int>[0, 1, 2, 4].asChunk(2), <Iterable<int>>[
        <int>[0, 1],
        <int>[2, 4]
      ]);
    });
    test(
        'Splitting as chunks of 2 should properly split 5 elements into 3 lists',
        () {
      expect(<int>[0, 1, 2, 4, 5].asChunk(2), <Iterable<int>>[
        <int>[0, 1],
        <int>[2, 4],
        <int>[5],
      ]);
    });
  });
}
