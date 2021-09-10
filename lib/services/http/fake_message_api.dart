import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/message_api.dart';

class FakeMessageApi extends MessageApi {
  FakeMessageApi(FirebaseApi firebase,
      void Function(dynamic) onBackgroundOrForegroundOpened)
      : super(firebase, onBackgroundOrForegroundOpened);

  @override
  Future<void> cancel() async {
    // TODO: implement cancel
  }


  @override
  Future<Map<String, String>?> getInitialMessage() async {
    // TODO: implement getInitialMessage
    // throw UnimplementedError();
  }



  @override
  Future<void> initializePermissions() async {
    // TODO: implement initializePermissions
    // throw UnimplementedError();
  }

  @override
  Future<void> listen(Function(dynamic)? add) async {
    // TODO: implement listen
    // throw UnimplementedError();
  }

}
