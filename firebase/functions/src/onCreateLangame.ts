import {EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {kUsersCollection, hashFnv32a} from "./helpers";
import * as admin from "firebase-admin";
import {offlineMemeSearch} from "./memes/memes";
import * as functions from "firebase-functions";
import {converter, db} from "./utils/firestore";
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
              snap,
              {
                userMessage: "you did not provide any data",
                code: "invalid-argument",
              }
          )
      );
      return;
    }
    // TODO: maximum firestore rule check filters on the created langame
    // const db = admin.firestore();
    const senderData = await db.users
    // Firestore rules should already filter non-auth
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
    for (const p of toNotify) {
      const player = await db
          .users
          .doc(p)
          .get();
      if (!player.data() || !player.data()!.tokens) {
        // Need to wait the promise to avoid concurrency issues on the db
        await Promise.all(handleError(
            snap, {
              developerMessage: `${p}, has no devices`,
              uid: p,
            }));
        continue;
      }
      // eslint-disable-next-line max-len
      let body = `${senderData.data()!.tag} invited you to play ${lg.data()!.topics.join(",")}`;
      // @ts-ignore
      if (lg.data()!.date && lg.data()!.date!.toDate === "function") {
        // @ts-ignore
        body += `at ${lg.data()!.date!.toDate().toLocaleDateString("en-US")}`;
      }
      const messagingResponse = await admin.messaging().sendToDevice(
        player.data()!.tokens!,
        {
          data: {channelName: channelName},
          notification: {
            tag: channelName,
            body: body,
            // eslint-disable-next-line max-len
            title: `Play ${lg.data()!.topics.join(",")} with ${senderData.data()!.tag}?`,
          },
        },
        {
          // Required for background data-only messages on iOS
          contentAvailable: true,
          // Required for background data-only messages on Android
          priority: "high",
        }
      );
      messagingResponse.results.forEach((messagingResult, i) => {
        const t = player.data()!.tokens![i];
        // Invalid token, remove it
        if (messagingResult.error &&
          messagingResult.error.code ===
          "messaging/registration-token-not-registered" &&
          t) {
          admin
              .firestore()
              .collection(kUsersCollection)
              .doc(p)
              .update({
                tokens: admin.firestore.FieldValue.arrayRemove(t),
              }).then(() => functions.logger.info("removed invalid token", t))
              .catch(() =>
                handleError(snap, {
                  developerMessage: "failed to remove invalid token",
                  uid: p}));
        }
      });

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
    }
  } catch (e) {
    await Promise.all(
        // @ts-ignore
        handleError(snap, e, typeof lg !== "undefined" ?
        lg!.data()!.initiator :
        "null"));
  }
};
