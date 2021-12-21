import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {EventContext} from "firebase-functions";
import {Api, HuggingFaceCompletionParameters,
  OpenaiCompletionParameters} from "../aiApi/aiApi";
import {ImplAiApi} from "../aiApi/implAiApi";
import {reportError} from "../errors";
import {getConfig} from "../functionConfig/config";
import {langame} from "../langame/protobuf/langame";
import {shouldDrop} from "../utils/contexts";
import {converter} from "../utils/firestore";

export const onCreateMessageAnalysis = async (
    snap: admin.firestore.DocumentSnapshot<langame.protobuf.IMessage>,
    ctx: EventContext
) => {
  try {
    // TODO: should probably put more security on this function
    // which call paid apis :)
    functions.logger.log(ctx);
    // Skip if deleted
    if (!snap.exists) return;
    if (shouldDrop(ctx, {
      eventMaxAgeMs: 120_000, // 2 minutes
    })) return;
    if (snap.data()?.analysis?.error?.tries &&
      snap.data()?.analysis?.error?.tries! > 3) {
      return Promise.reject(reportError(
          new Error("too many failures, aborting")));
    }
    const lg = await admin.firestore().collection("langames")
        .doc(snap.data()!.langameId!)
        .withConverter(converter<langame.protobuf.Langame>()).get();
    const config = await getConfig();
    const api = new ImplAiApi();
    const db = admin.firestore();
    const promises = [];
    // Here we want to make the user think further about his conversations
    // based on previous user messages
    // Only when a reflection has not already been made
    if (!lg.data()!.reflections || !lg.data()!.reflections
        .some((e) => e.lastMessageId === snap.id)) {
      const reflections = await createReflection(
          api,
        snap.data()!.langameId!,
        snap.data()!.author!.id!,
        config.reflection!
      );
      // Check that no reflection with similar text appear
      if (reflections && (!lg.data()!.reflections || !lg.data()!.reflections
          .some((e) => e.alternatives![0] === reflections!.alternatives![0]))
      ) {
        functions.logger.log("reflections", reflections);
        promises.push(db.runTransaction(async (t) => t.set(lg.ref, {
          // @ts-ignore
          reflections: admin.firestore.FieldValue.arrayUnion(reflections),
        }, {merge: true})));
      }
    }
    if (!snap.data()!.analysis?.filter) {
      const filter = await api.filter({
        prompt: snap.data()!.body!,
      });
      if (filter) {
        functions.logger.log("filter", filter);
        promises.push(db.runTransaction(async (t) => t.set(snap.ref, {
          analysis: {
            filter: filter,
          },
        }, {merge: true})));
      }
    }
    return Promise.all(promises);
  } catch (e: any) {
    const p1 = reportError(e,
      snap.data()!.author!.id! ? {
        user: snap.data()!.author!.id!,
      } : undefined);
    const p2 = snap.ref.set({
      analysis: {
        error: {
          developerMessage: e.toString(),
          // @ts-ignore
          tries: admin.firestore.FieldValue.increment(1),
        },
      },
    }, {merge: true});
    return Promise.all([p1, p2]);
  }
};

export const createReflection = async (
    api: Api,
    langameId: string,
    authorId: string,
    config: OpenaiCompletionParameters | HuggingFaceCompletionParameters,
): Promise<langame.protobuf.Langame.IReflection | undefined> => {
  // Get all messages between these two
  const messages = await admin.firestore()
      .collection("messages")
      .where("langameId", "==", langameId)
      .withConverter(converter<langame.protobuf.IMessage>())
      .orderBy("createdAt", "asc")
      .limitToLast(10)
      .get();

  // Now we want to give a reflection to the user based on this conversation
  // Using GPT completion
  // Prompt should look like:
  // Me: Hello Bob I am Louis
  // You: Hello Louis, how are you?
  // ...
  const prompt =
      "This is a reflection given to the user in a conversation " +
      "to help him have more meaningful exchanges, think " +
      "further before talking and overall having better conversations.\n\n" +
      "You: Do you think we all become vegan?\n\n" +
      "Me: Why? After all other animals eat eachother\n\n" +
      "You: Can't we be better than other animals?\n\n" +
      "Reflection: What are your ethical principles?\n###\n" +
  messages.docs.map((e) => (e.data()!.author!.id ===
    authorId ? "Me: " : "You: ") +
    e.data()!.body).join("\n") +
    "\nReflection:";

  const alternative = await (
    "stream" in config ||
    config.model === "davinci-codex" ?
     api.openaiCompletion({
       ...config as OpenaiCompletionParameters,
       prompt: prompt,
     }) :
     api.huggingFaceCompletion(
         prompt,
      config as HuggingFaceCompletionParameters,
     ));

  if (!alternative) return Promise.resolve(undefined);
  const filter = await api.filter({prompt: alternative});
  if (filter === undefined) return Promise.resolve(undefined);
  if (alternative.includes("What are your ethical principles")) {
    return Promise.resolve(undefined);
  }

  // TODO: classification, further quality filtering
  return {
    userId: authorId,
    lastMessageId: messages.docs[messages.size - 1].id,
    alternatives: [alternative],
    contentFilter: filter,
    // @ts-ignore
    createdAt: new Date(),
  };
};
