import * as admin from "firebase-admin";
import {ImplAiApi} from "../aiApi/implAiApi";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {promiseRetry} from "../utils/promises";

export const onSendMessageToBot = async (
    snap: admin.firestore.DocumentSnapshot<langame.protobuf.IMessage>,
    player: langame.protobuf.Langame.IPlayer,
): Promise<any> => {
  // Get all messages between these two
  const messages = await admin.firestore()
      .collection("messages")
      .where("langameId", "==", snap.data()!.langameId)
      .orderBy("createdAt", "asc")
      .withConverter(converter<langame.protobuf.IMessage>())
      .limitToLast(4) // Tune according to model
      .get();

  const api = new ImplAiApi();
  const alternative = await promiseRetry(() => api.conversational(
      messages.docs
          .filter((e) => e.data()!.author!.bot! == false)
          .map((e) => e.data()!.body!),
      messages.docs
          .filter((e) => e.data()!.author!.bot! == true)
          .map((e) => e.data()!.body!),
        snap.data()!.body!,
  ), 5, 1000, undefined);

  if (!alternative) return Promise.resolve(undefined);
  const filter = await api.filter({prompt: alternative});
  if (filter === undefined) return Promise.resolve(undefined);
  const data: langame.protobuf.IMessage = {
    body: alternative,
    type: langame.protobuf.Message.Type.MESSAGE,
    // @ts-ignore
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    author: player as langame.protobuf.Message.IAuthor,
    langameId: snap.data()!.langameId,
  };
  return admin.firestore().collection("messages")
      .withConverter(converter<langame.protobuf.IMessage>())
      .add(data);
};
