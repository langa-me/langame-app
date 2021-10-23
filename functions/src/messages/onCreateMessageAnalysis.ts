import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {EventContext} from "firebase-functions";
import {Api} from "../aiApi/aiApi";
import {ImplAiApi} from "../aiApi/implAiApi";
import {reportError} from "../errors";
import {langame} from "../langame/protobuf/langame";
import {shouldDrop} from "../utils/contexts";
import {converter} from "../utils/firestore";

export const onCreateMessageAnalysis = async (
    snap: admin.firestore.DocumentSnapshot,
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
    const messageData = snap.data() as langame.protobuf.Message;
    if (messageData?.analysis?.error?.tries &&
      messageData?.analysis?.error?.tries! > 3) {
      return Promise.reject(reportError(
          new Error("too many failures, aborting")));
    }
    const lg = (await admin.firestore().collection("langames")
        .where("channelName", "==", snap.data()?.channelName)
        .withConverter(converter<langame.protobuf.Langame>()).get()).docs[0];
    const api = new ImplAiApi();
    const db = admin.firestore();
    const promises = [];
    // Here we want to give message suggestions based on previous user messages
    // Only when a suggestions has not already been made
    if (!lg.data()!.suggestions || !lg.data()!.suggestions
        .some((e) => e.lastMessageId === snap.id)) {
      const suggestions = await createSuggestion(
          api,
        messageData!.channelName,
        messageData!.fromUid,
      );
      // Check that no suggestion with similar text appear
      if (suggestions &&
        (!lg.data()!.suggestions || !lg.data()!.suggestions!.some((e) =>
          e.alternatives![0] === suggestions!.alternatives![0]))) {
        functions.logger.log("suggestions", suggestions);
        promises.push(db.runTransaction(async (t) => t.set(lg.ref, {
          // @ts-ignore
          suggestions: admin.firestore.FieldValue.arrayUnion(suggestions),
        }, {merge: true})));
      }
    }
    // Here we want to make the user think further about his conversations
    // based on previous user messages
    // Only when a reflection has not already been made
    if (!lg.data()!.reflections || !lg.data()!.reflections
        .some((e) => e.lastMessageId === snap.id)) {
      const reflections = await createReflection(
          api,
        messageData!.channelName,
        messageData!.fromUid,
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
    if (!messageData!.analysis?.filter) {
      const filter = await api.filter({
        prompt: messageData!.body,
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
      snap.data()!.fromUid ? {
        user: snap.data()!.fromUid,
      } : undefined);
    const p2 = snap.ref.set({
      analysis: {
        error: {
          developerMessage: e.toString(),
          tries: admin.firestore.FieldValue.increment(1),
        },
      },
    }, {merge: true});
    return Promise.all([p1, p2]);
  }
};

export const createSuggestion = async (
    api: Api,
    channelName: string,
    fromUid: string
): Promise<langame.protobuf.Langame.ISuggestion | undefined> => {
  // Get all messages between these two
  const messages = await admin.firestore()
      .collection("messages")
  // .where("fromUid", "==", change.after.data()!.fromUid)
  // .where("toUid", "==", change.after.data()!.toUid)
      .where("channelName", "==", channelName)
      .orderBy("createdAt", "asc")
      .limitToLast(10)
      .get();

  // Now we want to give suggestions to the user based on this conversation
  // Using GPT completion
  // Prompt should look like:
  // Me: Hello Bob I am Louis
  // You: Hello Louis, how are you?
  // ...
  const prompt = messages.docs.map((e) => (e.data()!.fromUid ===
    fromUid ? "Me: " : "You: ") +
    e.data()!.body).join("\n") +
    "\nSuggestion:";
  // const alternative = await api.hfCompletion(prompt, {
  //   maxNewTokens: 100,
  //   repetitionPenalty: 20.1,
  // });
  const alternative = await api.openaiCompletion({
    prompt:
      "This is a suggestion of answer given to the user in a conversation " +
      "to help him have more meaningful exchanges, think " +
      "further before talking and overall having better conversations.\n\n" +
      "You: Do you think we should all become vegan?\n\n" +
      "Me: Why? After all other animals eat eachother\n\n" +
      "You: Can't we be better than other animals?\n\n" +
      "Suggestion: Thank you for changing my opinion on this.\n###\n" +
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
  // TODO: classification, further quality filtering
  return {
    userId: fromUid,
    lastMessageId: messages.docs[messages.size - 1].id,
    alternatives: [alternative],
    contentFilter: filter,
    // @ts-ignore
    createdAt: new Date(),
  };
};

export const createReflection = async (
    api: Api,
    channelName: string,
    fromUid: string
): Promise<langame.protobuf.Langame.IReflection | undefined> => {
  // Get all messages between these two
  const messages = await admin.firestore()
      .collection("messages")
  // .where("fromUid", "==", change.after.data()!.fromUid)
  // .where("toUid", "==", change.after.data()!.toUid)
      .where("channelName", "==", channelName)
      .orderBy("createdAt", "asc")
      .limitToLast(10)
      .get();

  // Now we want to give a reflection to the user based on this conversation
  // Using GPT completion
  // Prompt should look like:
  // Me: Hello Bob I am Louis
  // You: Hello Louis, how are you?
  // ...
  const prompt = messages.docs.map((e) => (e.data()!.fromUid ===
    fromUid ? "Me: " : "You: ") +
    e.data()!.body).join("\n") +
    "\nReflection:";
  // const alternative = await api.hfCompletion(prompt, {
  //   maxNewTokens: 100,
  //   repetitionPenalty: 20.1,
  // });
  const alternative = await api.openaiCompletion({
    prompt:
      "This is a reflection given to the user in a conversation " +
      "to help him have more meaningful exchanges, think " +
      "further before talking and overall having better conversations.\n\n" +
      "You: Do you think we all become vegan?\n\n" +
      "Me: Why? After all other animals eat eachother\n\n" +
      "You: Can't we be better than other animals?\n\n" +
      "Reflection: What are your ethical principles?\n###\n" +
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
  // TODO: classification, further quality filtering
  return {
    userId: fromUid,
    lastMessageId: messages.docs[messages.size - 1].id,
    alternatives: [alternative],
    contentFilter: filter,
    // @ts-ignore
    createdAt: new Date(),
  };
};
