import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError, reportError} from "../errors";
import {algoliaPrefix} from "../helpers";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";
import {shouldDrop} from "../utils/contexts";
import {offlineMemeSearch, onlineMemeGenerator} from "../memes/memes";
import {sample} from "../utils/array";
import {faillingMessages} from "../utils/userMessages";

export const onWriteLangame = async (
    change: Change<admin.firestore.DocumentSnapshot<langame.protobuf.ILangame>>,
    ctx: EventContext) => {
  const api = new ImplAiApi();
  try {
    functions.logger.log(ctx);

    const i = api.getIndex(algoliaPrefix + "langames");
    if (!change.after.exists) {
      await i.deleteObject(change.after.id);
      await admin.firestore().collection("langame_presences")
          .where("presences", "array-contains", change.after.id)
          .get().then(async (presences) => {
            const promises: Promise<any>[] = [];
            presences.forEach((e) => {
              promises.push(e.ref.update({
                presences:
                admin.firestore.FieldValue.arrayRemove(change.after.id),
              }));
            });
            return Promise.all(promises);
          });
    }
    if (shouldDrop(ctx)) return;
    if (
      change.after.data()?.errors
    ) {
      functions.logger.log(
          "langame has errors, skipping", change.after.data()
      );
      return Promise.reject(Error("langame has errors, skipping"));
    }
    if (!change.after.data()) {
      return reportError(new Error(`${change.after.id} has no data`), ctx);
    }
    const promises: Promise<any>[] = [];
    if (!change.before.exists) {
      promises.push(onCreateLangame(change));
    }

    functions.logger.log("synchronizing langame to algolia",
        change.after.data());

    promises.push(i.saveObject({
      ...change.after.data(),
      objectID: change.after.id,
      _tags: [change.after.data()!.tags],
    }));
    return Promise.all(promises);
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref, {developerMessage: e}));
    return Promise.reject(e);
  }
};

const onCreateLangame = async (
    change: Change<admin.firestore.DocumentSnapshot<langame.protobuf.ILangame>>,
) => {
  functions.logger.log("handling logic for created langame");
  const langameData = change.after.data()!;
  const db = admin.firestore();

  await change.after.ref.update({
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  const memesSeenDoc =
      await admin.firestore()
          .collection("seenMemes")
          .doc(langameData.initiator!)
          .get();
  let memesToFilter = memesSeenDoc.data() && memesSeenDoc.data()!.seen ?
      memesSeenDoc.data()!.seen :
      [];

  functions.logger.log("searching for a conversation starter");
  let memes = await offlineMemeSearch(langameData.topics || ["ice breaker"],
      1,
      memesToFilter.map((e: any) => e.meme),
      true,
  );


  if (memes.length === 0) {
    functions.logger.log("could not find a conversation starter, generating");
    memes = [await onlineMemeGenerator(langameData.topics || ["ice breaker"])];
  }

  if (memes.length === 0) {
    return Promise.all(
        handleError(
            change.after.ref, {
              developerMessage:
          `failed to find meme for topics, ${langameData.topics}`,
              uid: langameData.initiator!,
              userMessage: sample(faillingMessages),
            }));
  }


  functions
      .logger
      .info("found memes for topics", langameData.topics, memes);


  const toNotify = langameData.players!.filter((e: any) =>
    e.uid !== langameData.initiator);
  const senderData = toNotify.find((e) => e.id === langameData.initiator!)!;
  const title =
      `${senderData.tag} invited you to play a Langame`;
  let promises: Promise<any>[] = [];
  promises.push(admin.firestore().collection("messages")
      .withConverter(converter<langame.protobuf.IMessage>())
      .add({
        author: senderData as langame.protobuf.Message.IAuthor,
        // @ts-ignore
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        langameId: change.after.id,
        type: langame.protobuf.Message.Type.INVITE,
        title: title,
        // eslint-disable-next-line max-len
        body: `Topics:${memes[0].data()!.topics!.join(", ")}\n${memes[0].data()!.content}`,
      }));


  const oneWeek = 7 * 24 * 1000 * 60 * 60;
  const oneWeekAgo = new Date(Date.now() - oneWeek);
  const newMemesSeen = memes.map((e) => {
    return {
      meme: e.id,
      date: new Date(),
    };
  });
    // Filter out memes already seen X time ago
    // TODO: currently only support initiator
  memesToFilter =
      memesToFilter!
          .filter((e: any) => e.date < oneWeekAgo).concat(newMemesSeen);
  promises = [
    db.collection("users").doc(senderData.id!).update({
      credits: admin.firestore.FieldValue.increment(-1),
      lastSpent: admin.firestore.FieldValue.serverTimestamp(),
    })];
  promises.push(memesSeenDoc.ref.set({
    seen: memesToFilter,
  }, {merge: true}));

    langameData.players!.map((e) =>
      promises.push(db.collection("langame_presences").doc(e.id!).set({
        presences: admin.firestore.FieldValue.arrayUnion(change.after.id),
      }, {merge: true})));
    return Promise.all(promises);
};
