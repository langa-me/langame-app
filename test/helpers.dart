import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_functions_platform_interface/src/platform_interface/platform_interface_firebase_functions.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langame/models/user.dart';
import 'package:mockito/mockito.dart';

typedef Callback(MethodCall call);

setupFirebaseMocks({Callback? customHandlers}) {
  TestWidgetsFlutterBinding.ensureInitialized();
  // BasicMessageChannel().
  // MethodChannelFirebaseFirestore.channel
  //     .setMockMethodCallHandler((MethodCall methodCall) async {
  //   switch (methodCall.method) {
  //     case 'Query#get':
  //       MethodChannelQuery query = methodCall.arguments['query'];
  //       if (query.path == 'foo/unknown') {
  //         throw PlatformException(
  //             code: 'ERROR', details: {'code': 'UNKNOWN_PATH'});
  //       }
  //
  //       return <String, dynamic>{
  //         'paths': <String>['${query.path}/0'],
  //         'documents': <dynamic>[kMockDocumentSnapshotDocument],
  //         'metadatas': <Map<String, dynamic>>[kMockSnapshotMetadata],
  //         'metadata': kMockSnapshotMetadata,
  //         'documentChanges': <dynamic>[
  //           <String, dynamic>{
  //             'oldIndex': -1,
  //             'newIndex': 0,
  //             'path': 'foo/bar',
  //             'metadata': kMockSnapshotMetadata,
  //             'type': 'DocumentChangeType.added',
  //             'data': kMockDocumentSnapshotDocument['data'],
  //           },
  //         ]
  //       };
  //     default:
  //       return null;
  //   }
  // });

  MethodChannelFirebase.appInstances['plugins.flutter.io/firebase_firestore'] =
      MethodChannelFirebaseApp(
          'plugins.flutter.io/firebase_firestore',
          FirebaseOptions.fromMap({
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          }));
  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': {},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return {
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': {},
      };
    }

    if (customHandlers != null) {
      customHandlers(call);
    }

    return null;
  });
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {
  @override
  // TODO: implement app
  FirebaseApp get app => throw UnimplementedError();

  @override
  // TODO: implement delegate
  FirebaseFunctionsPlatform get delegate => throw UnimplementedError();

  @override
  HttpsCallable httpsCallable(String name, {HttpsCallableOptions? options}) {
    // TODO: implement httpsCallable
    throw UnimplementedError();
  }

  @override
  // TODO: implement pluginConstants
  Map get pluginConstants => throw UnimplementedError();

  @override
  void useFunctionsEmulator({required String origin}) {
    // TODO: implement useFunctionsEmulator
  }
}

MockUser getMockUser() => MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );

extension mockUserExtension on MockUser {
  LangameUser toLangameUser() => LangameUser(
      uid: this.uid, email: this.email, displayName: this.displayName);
}
