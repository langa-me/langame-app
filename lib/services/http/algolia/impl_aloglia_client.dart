import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/firebase_functions_protocol.dart';
import 'package:langame/models/google/protobuf/timestamp.pbserver.dart' as gg;
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/algolia/algolia_client.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/langame_api.dart';
import 'package:http/http.dart' as http;

class ImplAlgoliaClient extends AlgoliaClient {
  ImplAlgoliaClient(FirebaseApi firebase) : super(firebase);

  @override
  Future<void> pushEvents(
      String eventType, String eventName, String index) async {
    final r = await http.post(
      Uri.parse('https://insights.algolia.io/1/events'),
      headers: <String, String>{
        'x-algolia-api-key': '',
        'x-algolia-application-id': '',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'events': [
          {
            'eventType': eventType,
            'eventName': eventName,
            'index': index,
            'timestamp': DateTime.now(),
            'userToken': firebase.auth!.currentUser!.uid,
          }
        ]
      }),
    );
    if (r.statusCode != 200) throw LangameException(r.body);
  }
}
