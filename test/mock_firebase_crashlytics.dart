import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {
  @override
  Future<Function> setCrashlyticsCollectionEnabled(bool enabled) =>
      Future.value();
}
