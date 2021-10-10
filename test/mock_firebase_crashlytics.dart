import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {
  @override
  Future<Function> setCrashlyticsCollectionEnabled(bool enabled) =>
      // ignore: null_argument_to_non_null_type
      Future.value();
}
