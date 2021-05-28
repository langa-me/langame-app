import 'package:cloud_functions/cloud_functions.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/firebase_functions_protocol.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langame/models/google/protobuf/timestamp.pbserver.dart' as gg;
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/langame_api.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

class ImplLangameApi extends LangameApi {
  ImplLangameApi(FirebaseApi firebase) : super(firebase);


  
    @override
  Stream<QuerySnapshot<lg.Langame>> getLangames({bool unDoneOnly = false}) {
    return firebase.firestore!
        .collection(AppConst.firestoreLangamesCollection)
        .where('initiator', isEqualTo: firebase.auth!.currentUser!.uid)
        .where('players', arrayContains: firebase.auth!.currentUser!.uid)
        // i.e. hack to filter or not only running Langame
        .where('done', whereIn: [unDoneOnly ? false : true, false])
        .withConverter<lg.Langame>(
          fromFirestore: (snapshot, _) =>
              LangameExt.fromObject(snapshot.data()!),
          toFirestore: (user, _) => user.toMapStringDynamic(),
        )
        .snapshots();
  }

  @override
  Future<void> joinLangame(String channelName) async {
    var snap = await firebase.firestore!
        .collection(AppConst.firestoreLangamesCollection)
        .where('channelName', isEqualTo: channelName)
        .get();
    if (snap.docs.isEmpty || !snap.docs.first.exists)
      throw LangameMessageException('invalid_channel_name');
    return snap.docs.first.reference.update({
      'players': FieldValue.arrayUnion([
        {
          'userId': firebase.auth!.currentUser!.uid,
          'timeIn': FieldValue.serverTimestamp()
        }
      ])
    });
  }

  @override
  Future<void> addNoteToLangame(String channelName, String note) async {
    var snap = await firebase.firestore!
        .collection(AppConst.firestoreLangamesCollection)
        .where('channelName', isEqualTo: channelName)
        .get();
    if (!snap.docs.first.exists)
      throw LangameMessageException('invalid_channel_name');
    return snap.docs.first.reference.set({
      'players.notes': FieldValue.arrayUnion([note])
    });
  }


  @override
  Future<Stream<DocumentSnapshot<lg.Langame>>> createLangame(
      List<String> players, List<String> topics, DateTime date) {
    return firebase.firestore!
        .collection(AppConst.firestoreLangamesCollection)
        .withConverter<lg.Langame>(
          fromFirestore: (snapshot, _) =>
              LangameExt.fromObject(snapshot.data()!),
          toFirestore: (user, _) => user.toMapStringDynamic(),
        )
        .add(lg.Langame(
          players: players.map((e) => lg.Langame_Player(userId: e)).toList() +
              [lg.Langame_Player(userId: firebase.auth!.currentUser!.uid)],
          topics: topics,
          initiator: firebase.auth!.currentUser!.uid, // TODO: risky
          date: gg.Timestamp(nanos: date.microsecond * 1000),
        ))
        .then((ref) => ref
            .withConverter<lg.Langame>(
              fromFirestore: (snapshot, _) =>
                  LangameExt.fromObject(snapshot.data()!),
              toFirestore: (user, _) => user.toMapStringDynamic(),
            )
            .snapshots());
  }

  @override
  Future<void> notifyPresence(String channelName) async {
    HttpsCallable callable = firebase.functions!.httpsCallable(
      AppConst.notifyPresenceFunction,
      options: HttpsCallableOptions(
        timeout: Duration(seconds: 10),
      ),
    );

    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'channelName': channelName,
        },
      );
      FirebaseFunctionsResponse response = FirebaseFunctionsResponse.fromJson(
        Map<String, dynamic>.from(result.data),
      );
      switch (response.statusCode) {
        case FirebaseFunctionsResponseStatusCode.OK:
          break;
        case FirebaseFunctionsResponseStatusCode.BAD_REQUEST:
          throw LangameNotifyPresenceException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.BAD_REQUEST.toString());
        case FirebaseFunctionsResponseStatusCode.UNAUTHORIZED:
          throw LangameNotifyPresenceException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.UNAUTHORIZED.toString());
        case FirebaseFunctionsResponseStatusCode.INTERNAL:
          throw LangameNotifyPresenceException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.INTERNAL.toString());
      }
    } catch (e) {
      throw LangameNotifyPresenceException(e.toString());
    }
  }
}