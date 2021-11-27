import * as admin from "firebase-admin";
import {ImplAiApi} from "../aiApi/implAiApi";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";

export const onSendMessageToBot = async (
    snap: admin.firestore.DocumentSnapshot<langame.protobuf.IMessage>,
): Promise<any> => {
  // Get all messages between these two
  const messages = await admin.firestore()
      .collection("messages")
      .where("channelName", "==", snap.data()!.channelName)
      .orderBy("createdAt", "asc")
      .limitToLast(4) // Tune according to model
      .get();

  const currentLg = (await admin.firestore().collection("langames")
      .where("channelName", "==", snap.data()!.channelName)
      .get()).docs[0];

  // const config = await getConfig();

  const botPlayer = await currentLg.ref.collection("players")
      .doc(snap.data()!.toUid!)
      .withConverter(converter<langame.protobuf.IPlayer>())
      .get();

  if (!botPlayer.exists) {
    const p = {
      userId: snap.data()!.toUid,
      audioId: -1,
    };
    botPlayer.ref.set(
        p,
        {merge: true},
    );
  }
  const api = new ImplAiApi();
  const alternative = await api.conversational(
      messages.docs
          .filter((e) => e.data()!.toUid === snap.data()!.fromUid)
          .map((e) => e.data()!.body),
      messages.docs
          .filter((e) => e.data()!.toUid === snap.data()!.toUid)
          .map((e) => e.data()!.body),
        snap.data()!.body!,
  );

  if (!alternative) return Promise.resolve(undefined);
  const filter = await api.filter({prompt: alternative});
  if (filter === undefined) return Promise.resolve(undefined);
  const data: langame.protobuf.IMessage = {
    body: alternative,
    type: langame.protobuf.Message.Type.MESSAGE,
    // @ts-ignore
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    fromUid: snap.data()!.toUid,
    toUid: snap.data()!.fromUid,
    channelName: snap.data()!.channelName,
  };
  return admin.firestore().collection("messages")
      .withConverter(converter<langame.protobuf.IMessage>())
      .add(data);
};
