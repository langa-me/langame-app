import {EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {hashFnv32a} from "./helpers";
import * as admin from "firebase-admin";
import {offlineMemeSearch} from "./memes/memes";
import * as functions from "firebase-functions";
import {converter} from "./utils/firestore";
import {langame} from "./langame/protobuf/langame";
import {handleError} from "./errors";

/**
 *
 * @param{QueryDocumentSnapshot} snap
 * @param{EventContext} _
 */
// @ts-ignore
export const onCreateLangame = async (
    snap: QueryDocumentSnapshot,
    _: EventContext
) => {
  let lg: admin.firestore.DocumentSnapshot<langame.protobuf.Langame>;
  try {
    lg =
      await snap.ref.withConverter(converter<langame.protobuf.Langame>()).get();
    if (!lg.data()) {
      await Promise.all(
          handleError(
              snap, {
                userMessage: "you did not provide any data",
                code: "invalid-argument",
              }
          )
      );
      return;
    }
    const db = admin.firestore();
    const senderData = await db.collection("users")
        .doc(snap.data().initiator)
        .get();
    // TODO: is it really 100% atomic?
    const channelName: string | number =
      hashFnv32a(lg.data()!.initiator, true, Date.now());

    functions
        .logger
        .info("langame created by",
        lg.data()!.initiator,
        "named",
        channelName);

    if (typeof channelName === "number") {
      await Promise.all(
          handleError(
              snap, {
              // eslint-disable-next-line max-len
                developerMessage: `failed to create channel name, requested by ${lg.data()!.initiator}`,
                uid: lg.data()!.initiator,
              })
      );
      return;
    }


    const t = await admin.remoteConfig().getTemplate();
    if (!t.parameters.question_engine.defaultValue ||
      !("value" in t.parameters.question_engine.defaultValue) ||
      !t.parameters.offline_use_generated.defaultValue ||
      !("value" in t.parameters.offline_use_generated.defaultValue)) {
      await Promise.all(
          handleError(
              snap, {
                developerMessage: "invalid remote config",
                uid: lg.data()!.initiator,
              })
      );
      return;
    }
    const memesSeenDoc =
        await admin.firestore()
            .collection("seenMemes")
            .doc(snap.data().initiator)
            .get();
    let memesToFilter = memesSeenDoc.data() && memesSeenDoc.data()!.seen ?
        memesSeenDoc.data()!.seen :
        [];

    const memes = await offlineMemeSearch(lg.data()!.topics,
        // @ts-ignore
        t.parameters.meme_count.defaultValue.value * 1, // Casting to number
        memesToFilter.map((e: any) => e.meme),
        true,
    );


    if (memes.length === 0) {
      await Promise.all(
          handleError(
              snap, {
                // eslint-disable-next-line max-len
                developerMessage: `failed to find meme for topics, ${lg.data()!.topics}`,
                uid: lg.data()!.initiator,
                // eslint-disable-next-line max-len
                userMessage: "you have seen already everything in these topics!",
              })
      );
      return;
    }


    functions
        .logger
        .info("found memes for topics", lg.data()!.topics, memes);


    await snap.ref.set({
      memes: memes
          .filter((e) => e.data())
          .map((e) => {
            return {...e.data()!, id: e.id};
          }),
      channelName: channelName,
      currentMeme: 0,
      done: null,
      isLocked: false,
    }, {merge: true});

    const toNotify = lg.data()!.reservedSpots;
    const title =
    // eslint-disable-next-line max-len
    `${senderData.data()!.tag} invited you to play ${snap.data().isText === true? "a text" : "an audio"} Langame`;
    for (const p of toNotify) {
      admin.firestore().collection("messages").add({
        fromUid: snap.data().initiator,
        toUid: p,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        channelName: channelName,
        type: langame.protobuf.Message.Type.INVITE,
        title: title,
        // eslint-disable-next-line max-len
        body: `Topics:${memes[0].data()!.topics.join(", ")}\n${memes[0].data()!.content}`,
      });
    }


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
    const promises = [
      senderData.ref.update({
        credits: admin.firestore.FieldValue.increment(-1),
        lastSpent: admin.firestore.FieldValue.serverTimestamp(),
      })];
    promises.push(memesSeenDoc.ref.set({
      seen: memesToFilter,
    }, {merge: true}));
    return Promise.all(promises);
  } catch (e: any) {
    await Promise.all(
        // @ts-ignore
        handleError(snap, e, typeof lg !== "undefined" ?
        lg!.data()!.initiator :
        "null"));
    return Promise.reject(e);
  }
};
