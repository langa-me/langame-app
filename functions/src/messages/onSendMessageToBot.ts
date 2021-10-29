import * as admin from "firebase-admin";
import {ImplAiApi} from "../aiApi/implAiApi";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";

export const onSendMessageToBot = async (
    messageSnap: admin.firestore.DocumentSnapshot<langame.protobuf.IMessage>,
): Promise<admin.firestore.DocumentReference<
    admin.firestore.DocumentData> | undefined> => {
  // Get all messages between these two
  const messages = await admin.firestore()
      .collection("messages")
      .where("channelName", "==", messageSnap.data()!.channelName)
      .orderBy("createdAt", "asc")
      .limitToLast(10)
      .get();

  const currentLg = (await admin.firestore().collection("langames")
      .where("channelName", "==", messageSnap.data()!.channelName)
      .get()).docs[0];

  const botPlayer = await currentLg.ref.collection("players")
      .doc(messageSnap.data()!.toUid!)
      .withConverter(converter<langame.protobuf.IPlayer>())
      .get();

  if (!botPlayer.exists) {
    const p = {
      userId: messageSnap.data()!.toUid,
      audioId: -1,
    };
    botPlayer.ref.set(
        p,
        {merge: true},
    );
  }

  // Now we want to give suggestions to the user based on this conversation
  // Using GPT completion
  // Prompt should look like:
  // Me: Hello Bob I am Louis
  // You: Hello Louis, how are you?
  // ...
  const prompt = messages.docs.map((e) => (e.data()!.toUid ===
  messageSnap.data()!.toUid ? "Me: " : "You: ") +
e.data()!.body).join("\n") +
"\nMe:";
  const api = new ImplAiApi();
  const alternative = await api.openaiCompletion({
    prompt:
  "This is an open ended answer given in a conversation " +
  "which leads to meaningful, reciprocal exchanges, " +
  "and overall great conversation.\n\n" +
  "You: Do you think we should all become vegan?\n\n" +
  "Me: Why? After all other animals eat eachother\n\n" +
  "You: Can't we be better than other animals?\n\n" +
  "Me: Thank you for changing my opinion on this, " +
  "you are very intelligent\n###\n" +
  prompt,
    maxTokens: 300,
    frequencyPenalty: 0.3,
    presencePenalty: 0.3,
    temperature: 0.7,
    stop: ["###", "\n", "Me:", "You:"],
    model: "davinci-codex",
  });
  if (!alternative) return Promise.resolve(undefined);
  const filter = await api.filter({prompt: alternative});
  if (filter === undefined) return Promise.resolve(undefined);
  const data = {
    "body": alternative,
    "type": langame.protobuf.Message.Type.MESSAGE,
    "createdAt": admin.firestore.FieldValue.serverTimestamp(),
    "fromUid": messageSnap.data()!.toUid,
    "toUid": messageSnap.data()!.fromUid,
    "channelName": messageSnap.data()!.channelName,
  };
  return admin.firestore().collection("messages").add(data);
};
