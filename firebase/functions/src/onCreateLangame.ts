import {EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {kUsersCollection, hashFnv32a} from "./helpers";
import * as admin from "firebase-admin";
import {offlineMemeSearch} from "./questions";
import * as functions from "firebase-functions";
import {converter, db, handleError} from "./utils/firestore";
import {langame} from "./langame/protobuf/langame.gen";

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
              "Langame is null",
              "",
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
              snap,
              // eslint-disable-next-line max-len
              `failed to create channel name, requested by ${lg.data()!.initiator}`,
          lg.data()!.initiator,
          )
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
              snap,
              "invalid remote config",
          lg.data()!.initiator,
          )
      );
      return;
    }
    let memes: admin.firestore.DocumentSnapshot<langame.protobuf.Meme>[]
    | undefined;
    if (t.parameters.question_engine.defaultValue.value === "offline") {
      memes = await offlineMemeSearch(lg.data()!.topics,
          // @ts-ignore
          // eslint-disable-next-line max-len
          t.parameters.question_count.defaultValue.value * 1, // Casting to number
      );
    } else if (t.parameters.question_engine.defaultValue.value === "online") {
      throw Error("unimplemented");
      // questions =
      //         await onlineOpenAiCompletion(data.topics, t.parameters);
    }

    if (!memes || memes.length === 0) {
      await Promise.all(
          handleError(
              snap,
              `failed to find meme for topics, ${lg.data()!.topics}`,
          lg.data()!.initiator,
          )
      );
      return;
    }

    functions
        .logger
        .info("found memes for topics", lg.data()!.topics, memes);
    const playersSnap = await snap.ref.collection("players")
        .withConverter(converter<langame.protobuf.Player>()).get();
    await snap.ref.set({
      memes: memes.map((e) => e.id),
      channelName: channelName,
      currentMeme: 0,
    }, {merge: true});

    const toNotify = playersSnap
        .docs
        .filter((pl) => pl.data()!.userId !== lg.data()!.initiator);
    for (const p of toNotify) {
      const player = await db
          .users
          .doc(p.data()!.userId)
          .get();
      if (!player.data() || !player.data()!.tokens) {
        // Need to wait the promise to avoid concurrency issues on the db
        await Promise.all(handleError(
            snap,
            `${p.data()!.userId}, has no devices`,
          p.data()!.userId!,
        ));
        continue;
      }
      const messagingResponse = await admin.messaging().sendToDevice(
        player.data()!.tokens!,
        {
          data: {channelName: channelName},
          notification: {
            tag: channelName,
            // TODO: date in notification?
            // eslint-disable-next-line max-len
            body: `${senderData.data()!.displayName} invited you to play ${lg.data()!.topics.join(",")}`,
            // eslint-disable-next-line max-len
            title: `Play ${lg.data()!.topics.join(",")} with ${senderData.data()!.displayName}?`,
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
              .doc(p.data().userId)
              .update({
                tokens: admin.firestore.FieldValue.arrayRemove(t),
              }).then(() => functions.logger.info("removed invalid token", t))
              .catch(() =>
                handleError(snap, "failed to remove invalid token",
                p.data().userId!));
        }
      });
    }
  } catch (e) {
    await Promise.all(
        // @ts-ignore
        handleError(snap, e, typeof lg !== "undefined" ?
        lg!.data()!.initiator :
        "null"));
  }
};