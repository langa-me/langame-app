import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/firebase_functions_protocol.dart';
import 'package:langame/models/google/protobuf/timestamp.pbserver.dart' as gg;
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/langame_api.dart';

class ImplLangameApi extends LangameApi {
  ImplLangameApi(FirebaseApi firebase) : super(firebase);

  @override
  Future<Iterable<Stream<DocumentSnapshot<lg.Langame>>>> getLangames(
      {bool unDoneOnly = false}) async {
    var players = await firebase.firestore!
        .collectionGroup('players')
        .where('userId', isEqualTo: firebase.auth!.currentUser!.uid)
        .get();
    return players.docs.map((e) => e.reference.parent.parent!
        .withConverter<lg.Langame>(
          fromFirestore: (snapshot, _) =>
              LangameExt.fromObject(snapshot.data()!),
          toFirestore: (user, _) => user.toMapStringDynamic(),
        )
        .snapshots());
  }

  @override
  Future<Stream<DocumentSnapshot<lg.Langame>>> joinLangame(
      String channelName) async {
    var snap = await firebase.firestore!
        .collection(AppConst.firestoreLangamesCollection)
        .where('channelName', isEqualTo: channelName)
        .withConverter<lg.Langame>(
          fromFirestore: (snapshot, _) =>
              LangameExt.fromObject(snapshot.data()!),
          toFirestore: (user, _) => user.toMapStringDynamic(),
        )
        .get();
    if (snap.docs.isEmpty || !snap.docs.first.exists)
      throw LangameException('invalid_channel_name');
    if (snap.docs.first.data().hasDone())
      throw LangameException('langame_done');
    if (snap.docs.first.data().isLocked)
      throw LangameException('langame_locked');

    // Set time in (whether was in initially invited players or not)
    var snapP = snap.docs.first.reference
        .collection('players')
        .doc(firebase.auth!.currentUser!.uid)
        .withConverter<lg.Player>(
          fromFirestore: (s, _) => PlayerExt.fromObject(s.data()!),
          toFirestore: (s, _) => s.toMapStringDynamic(),
        );
    // No need to await this set as we wait that the server update self
    snapP.set(
      lg.Player(
        userId: firebase.auth!.currentUser!.uid,
        audioId: -1,
      ),
      SetOptions(merge: true),
    );
    // Wait that server assign a audio id
    await snapP
        .snapshots()
        .firstWhere((e) => e.data() != null && e.data()!.audioId != -1)
        .timeout(Duration(seconds: 20));

    return snap.docs.first.reference.snapshots();
  }

  @override
  Future<void> addNoteToLangame(
      String channelName, String note, lg.Note_Type type) async {
    if (note.isEmpty) return;
    var snap = await firebase.firestore!
        .collection(AppConst.firestoreLangamesCollection)
        .where('channelName', isEqualTo: channelName)
        .get();
    if (!snap.docs.first.exists) throw LangameException('invalid_channel_name');
    final noteRef = snap.docs.first.reference
        .collection("players")
        .doc(firebase.auth!.currentUser!.uid)
        .collection('notes')
        .withConverter<lg.Note>(
          fromFirestore: (snapshot, _) => NoteExt.fromObject(snapshot.data()!),
          toFirestore: (user, _) => user.toMapStringDynamic(),
        );
    // TODO: currently notes are unique by type, #to-digest
    switch (type) {
      case lg.Note_Type.generic:
        final genericDoesNotExist =
            (await noteRef.where('generic', isNull: true).get()).docs.length ==
                0;
        if (genericDoesNotExist)
          noteRef.add(lg.Note(
            generic: lg.Note_Generic(content: note),
            createdAt: gg.Timestamp.fromDateTime(DateTime.now()),
          ));
        break;
      case lg.Note_Type.goal:
        final goalDoesNotExist =
            (await noteRef.where('goal', isNull: true).get()).docs.length == 0;
        if (goalDoesNotExist)
          noteRef.add(lg.Note(
            goal: lg.Note_Goal(content: note),
            createdAt: gg.Timestamp.fromDateTime(DateTime.now()),
          ));
        break;
      case lg.Note_Type.definition:
        final definitionDoesNotExist =
            (await noteRef.where('definition', isNull: true).get())
                    .docs
                    .length ==
                0;
        if (definitionDoesNotExist)
          noteRef.add(lg.Note(
            definition: lg.Note_Definition(content: note),
            createdAt: gg.Timestamp.fromDateTime(DateTime.now()),
          ));
        break;
      case lg.Note_Type.notSet:
        throw LangameException('invalid_note_type');
    }
  }

  @override
  Future<Stream<DocumentSnapshot<lg.Langame>>> createLangame(
    List<String> players,
    List<String> topics,
    DateTime date,
  ) =>
      firebase.firestore!.collection(AppConst.firestoreLangamesCollection).add({
        'topics': topics,
        'initiator': firebase.auth!.currentUser!.uid, // TODO: risky
        'date': date,
        'reservedSpots': players,
      }).then((e) => e
          .withConverter<lg.Langame>(
            fromFirestore: (s, _) => LangameExt.fromObject(s.data()!),
            toFirestore: (s, _) => s.toMapStringDynamic(),
          )
          .snapshots()
          .timeout(Duration(seconds: 20)));

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
