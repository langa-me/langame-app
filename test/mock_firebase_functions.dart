import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';

class MockHttpsCallableResult<T> extends Mock
    implements HttpsCallableResult<T> {
  T get data {
    return _mockData;
  }

  final T _mockData;
  MockHttpsCallableResult(this._mockData);
}

class MockHttpsCallable extends Mock implements HttpsCallable {
  MockHttpsCallable.withResponse(this._expectedResponse);
  final dynamic _expectedResponse;
  @override
  Future<HttpsCallableResult<T>> call<T>([dynamic parameters]) async {
    print(parameters);
    return MockHttpsCallableResult<T>(_expectedResponse as T);
  }
}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {
  MockFirebaseFunctions.withResponses(this._expectedResponses);
  final Map<String, dynamic> _expectedResponses;

  @override
  FirebaseApp get app => throw UnimplementedError();

  @override
  HttpsCallable httpsCallable(String name, {HttpsCallableOptions? options}) {
    return MockHttpsCallable.withResponse(_expectedResponses[name]);
  }

  @override
  Map get pluginConstants => throw UnimplementedError();

}
