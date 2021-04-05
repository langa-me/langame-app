import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';

class MockHttpsCallableResult<T> extends Mock
    implements HttpsCallableResult<T> {
  MockHttpsCallableResult(Future<dynamic> r);
}

class MockHttpsCallable extends Mock implements HttpsCallable {
  @override
  Future<HttpsCallableResult<T>> call<T>([dynamic parameters]) async {
    print(parameters);
    return MockHttpsCallableResult(Future.value({
      'data': {
        'statusCode': 200,
        'errorMessage': null,
        'result': null,
      }
    } as dynamic));
  }
}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {
  @override
  // TODO: implement app
  FirebaseApp get app => throw UnimplementedError();

  // @override
  // // TODO: implement delegate
  // FirebaseFunctionsPlatform get delegate => throw UnimplementedError();

  @override
  HttpsCallable httpsCallable(String name, {HttpsCallableOptions? options}) {
    return MockHttpsCallable();
  }

  @override
  // TODO: implement pluginConstants
  Map get pluginConstants => throw UnimplementedError();

  @override
  void useFunctionsEmulator({required String origin}) {
    // TODO: implement useFunctionsEmulator
  }
}
