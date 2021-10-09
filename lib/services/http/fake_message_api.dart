import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/message_api.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

class FakeMessageApi extends MessageApi {
  FakeMessageApi(FirebaseApi firebase,
      void Function(dynamic) onBackgroundOrForegroundOpened)
      : super(firebase, onBackgroundOrForegroundOpened);

  @override
  Future<void> cancel() async {
  }


  @override
  Future<lg.Message?> getInitialMessage() async {
  }



  @override
  Future<void> initializePermissions() async {
  }

  @override
  Future<void> listen(Function(lg.Message)? add) async {
  }

}
