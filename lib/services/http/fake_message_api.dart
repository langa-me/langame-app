import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/message_api.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

class FakeMessageApi extends MessageApi {
  FakeMessageApi(FirebaseApi firebase,
      void Function(lg.Notification?) onBackgroundOrForegroundOpened)
      : super(firebase, onBackgroundOrForegroundOpened);

  @override
  void cancel() {
    // TODO: implement cancel
  }

  @override
  Future<void> delete(String channelName) {
      // TODO: implement delete
      throw UnimplementedError();
    }
  
    @override
    Future<Notification?> fetch(String id) {
      // TODO: implement fetch
      throw UnimplementedError();
    }
  
    @override
    Future<List<Notification>> fetchAll() {
      // TODO: implement fetchAll
      throw UnimplementedError();
    }
  
    @override
    Future<Notification?> getInitialMessage() {
      // TODO: implement getInitialMessage
      throw UnimplementedError();
    }
  
    @override
    Future<LangameResponse> initializePermissions() {
      // TODO: implement initializePermissions
      throw UnimplementedError();
    }

  
    @override
    Future<void> notifyPresence(String channelName) {
      // TODO: implement notifyPresence
      throw UnimplementedError();
    }
  
    @override
    Future<String> send(List<String> recipients, List<String> topics) {
      // TODO: implement send
      throw UnimplementedError();
    }
  
    @override
    Future<void> sendLangameEnd(String channelName) {
    // TODO: implement sendLangameEnd
    throw UnimplementedError();
  }

  @override
  Future<void> listen(void Function(lg.Notification p1) add) {
    // TODO: implement listen
    throw UnimplementedError();
  }

}