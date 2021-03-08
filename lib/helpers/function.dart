import 'dart:async';

// Stolen from
// https://github.com/google/dart-neats/blob/master/retry/lib/retry.dart

/// Call [fn] retrying so long as [retryIf] return `true` for the exception
/// thrown.
///
/// At every retry the [onRetry] function will be called (if given). The
/// function [fn] will be invoked at-most [this.attempts] times.
///
/// If no [retryIf] function is given this will retry any for any [Exception]
/// thrown. To retry on an [Error], the error must be caught and _rethrown_
/// as an [Exception].
Future<T> retry<T>(
  FutureOr<T> Function() fn, {
  int maxAttempts = 5,
  Duration delay = const Duration(milliseconds: 200),
  FutureOr<bool> Function(Exception) retryIf,
  FutureOr<void> Function(Exception) onRetry,
}) async {
  var attempt = 0;
  // ignore: literal_only_boolean_expressions
  while (true) {
    attempt++; // first invocation is the first attempt
    try {
      return await fn();
    } on Exception catch (e) {
      if (attempt >= maxAttempts || (retryIf != null && !(await retryIf(e)))) {
        rethrow;
      }
      if (onRetry != null) {
        await onRetry(e);
      }
    }

    // Sleep for a delay
    await Future.delayed(delay);
  }
}
