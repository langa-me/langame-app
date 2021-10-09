import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import 'firebase.dart';

abstract class LangameApi {
  final FirebaseApi firebase;

  LangameApi(this.firebase);

  /// Create a [Langame] in Firestore and listen to changes to it
  Future<Stream<DocumentSnapshot<lg.Langame>>> createLangame(
      List<String> recipients, List<String> topics, DateTime date);

  /// Add a note to a [Langame]
  Future<void> addNoteToLangame(String channelName, String note, lg.Note_Type type);

  /// Get [Langame] which current user is part of
  Stream<lg.Langame> getLangames();

  /// Add self to [Langame] ins
  Future<Stream<DocumentSnapshot<lg.Langame>>> joinLangame(String channelName);

  /// Response to a Langame message to say "I am ready and waiting"
  Future<void> notifyPresence(String channelName);
}
