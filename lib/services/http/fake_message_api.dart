import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/message_api.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

class FakeMessageApi extends MessageApi {
  FakeMessageApi(FirebaseApi firebase,
      void Function(dynamic) onBackgroundOrForegroundOpened)
      : super(firebase, onBackgroundOrForegroundOpened);

  @override
  void cancel() {
    // TODO: implement cancel
  }


  @override
  Future getInitialMessage() {
    // TODO: implement getInitialMessage
    throw UnimplementedError();
  }



  @override
  Future<LangameResponse> initializePermissions() {
    // TODO: implement initializePermissions
    throw UnimplementedError();
  }

  @override
  Future<void> listen(Function(dynamic)? add) {
    // TODO: implement listen
    throw UnimplementedError();
  }

}
