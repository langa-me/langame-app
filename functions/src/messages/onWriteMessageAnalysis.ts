import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {reportError} from "../errors";
import {shouldDrop} from "../utils/contexts";
import {chunkItems} from "../utils/array";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {FakeAiApi} from "../aiApi/fakeAiApi";
import {Api} from "../aiApi/aiApi";

export const onWriteMessageAnalysis = async (
    change: Change<admin.firestore.DocumentSnapshot>,
    ctx: EventContext) => {
  try {
    // TODO: should probably put more security on this function
    // which call paid apis :)
    functions.logger.log("onWriteMessageAnalysis",
        ctx.eventType, change.after.id);
    // eventType seems to always be "write"?
    if (!change.after.exists) return;
    if (shouldDrop(ctx, {
      eventMaxAgeMs: 120_000, // 2 minutes
    })) return;
    if (change.after.data()?.delivery?.status !== "success") {
      functions.logger.log(
          "delivery failed, aborting");
      return Promise.resolve();
    }
    if (change.after.data()?.analysis?.error?.tries > 3) {
      functions.logger.log(
          "too many failures, aborting");
      return Promise.resolve();
    }
    const langame = (await admin.firestore().collection("langames")
        .where("channelName", "==", change.after.data()?.channelName)
        .withConverter(converter<langame.protobuf.Langame>()).get()).docs[0];
    const api = new FakeAiApi();
    const db = admin.firestore();
    const promises = [];
    if (!change.after.data()!.analysis?.tokens) {
      const tokens = await api.tokenExtraction(change.after.data()!.body);
      if (tokens) {
        promises.push(db.runTransaction(async (t) => t.set(change.after.ref, {
          analysis: {
            tokens: tokens,
          },
        }, {merge: true})));
      }
    }
    if (!change.after.data()!.analysis?.sentiments) {
      const sentiments = await api.sentiment(change.after.data()!.body);
      if (sentiments) {
        promises.push(db.runTransaction(async (t) => t.set(change.after.ref, {
          analysis: {
            sentiments: sentiments,
          },
        }, {merge: true})));
      }
    }
    if (!change.after.data()!.analysis?.topics) {
      // Because API is max 9 classes, split into chunks
      const topics = chunkItems((await admin.firestore()
          .collection("topics").get()).docs.map((e) => e.id), 9);
      const classifiedTopics = await Promise.all(
          topics.map((topicsChunk) => api.classify(
        change.after.data()!.body, topicsChunk, true, 0.5)));
      // Flatten the classifiedTopics 2d array
      const flattenedTopics =
        classifiedTopics.reduce((acc, cur) => acc.concat(cur), []);
      if (flattenedTopics.length > 0) {
        promises.push(db.runTransaction(async (t) => t.set(change.after.ref, {
          analysis: {
            topics: flattenedTopics,
          },
        }, {merge: true})));
      }
    }
    // Here we want to give message suggestions based on previous user messages
    // Only when a suggestions has not already been made
    if (!langame.data()!.suggestions || !langame.data()!.suggestions
        .some((e) => e.lastMessageId === change.after.id)) {
      const suggestions = await createSuggestion(
          api,
        change.after.data()!.channelName,
        change.after.data()!.fromUid,
      );
      if (suggestions) {
        promises.push(db.runTransaction(async (t) => t.set(langame.ref, {
          // @ts-ignore
          suggestions: admin.firestore.FieldValue.arrayUnion(suggestions),
        }, {merge: true})));
      }
    }
    // Here we want to make the user think further about his conversations
    // based on previous user messages
    // Only when a reflection has not already been made
    if (!langame.data()!.reflections || !langame.data()!.reflections
        .some((e) => e.lastMessageId === change.after.id)) {
      const reflections = await createReflection(
          api,
        change.after.data()!.channelName,
        change.after.data()!.fromUid,
      );
      if (reflections) {
        promises.push(db.runTransaction(async (t) => t.set(langame.ref, {
          // @ts-ignore
          reflections: admin.firestore.FieldValue.arrayUnion(reflections),
        }, {merge: true})));
      }
    }
    if (!change.after.data()!.analysis?.filter) {
      const filter = await api.filter(
        change.after.data()!.body, {}
      );
      if (filter) {
        promises.push(db.runTransaction(async (t) => t.set(change.after.ref, {
          analysis: {
            filter: filter,
          },
        }, {merge: true})));
      }
    }
    return Promise.all(promises);
  } catch (e: any) {
    const p1 = reportError(e,
      change.after.data()!.fromUid ? {
        user: change.after.data()!.fromUid,
      } : undefined);
    const p2 = change.after.ref.set({
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
      e.data()!.body).join("\n") + "\nMe:";
  const alternative = await api.hfCompletion(prompt, {
    maxNewTokens: 100,
    repetitionPenalty: 20.1,
  });
  if (!alternative) return Promise.resolve(undefined);
  const filter = await api.filter(alternative, {});
  if (filter === undefined) return Promise.resolve(undefined);
  return {
    userId: fromUid,
    lastMessageId: messages.docs[messages.size-1].id,
    alternatives: [alternative],
    contentFilter: filter,
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
      // eslint-disable-next-line max-len
      "\n\nThis is a question the user should ask himself before answering, which should improve the conversation:";
  const alternative = await api.hfCompletion(prompt, {
    maxNewTokens: 100,
    repetitionPenalty: 20.1,
  });
  if (!alternative) return Promise.resolve(undefined);
  const filter = await api.filter(alternative, {});
  if (filter === undefined) return Promise.resolve(undefined);
  return {
    userId: fromUid,
    lastMessageId: messages.docs[messages.size-1].id,
    alternatives: [alternative],
    contentFilter: filter,
  };
};
