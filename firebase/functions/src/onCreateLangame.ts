import {EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {userFacingMessage, reportError} from "./errors";
import {kUsersCollection, hashFnv32a} from "./helpers";
import * as admin from "firebase-admin";
import {offlineQuestionSearch} from "./questions";
import * as functions from "firebase-functions";
import {google} from "./compiled";

const handleError = (
    snap: QueryDocumentSnapshot,
    msg: string,
    uid: string,
): Promise<any>[] => {
  const e = Error(msg);
  const p1 = snap.ref.set({
    errors: admin.firestore
        .FieldValue
        .arrayUnion(userFacingMessage(e)),
  });
  const p2 = reportError(e, {user: uid});
  return [p1, p2];
};

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
  try {
    // TODO: maximum firestore rule check filters on the created langame
    const db = admin.firestore();
    const senderData = await db
        .collection(kUsersCollection)
    // Firestore rules should already filter non-auth
        .doc(snap.data().initiator)
        .get();
    // TODO: is it really 100% atomic?
    const channelName: string | number =
      hashFnv32a(snap.data().initiator, true, Date.now());

    functions
        .logger
        .info("langame created by",
            snap.data().initiator,
            "named",
            channelName);

    if (typeof channelName === "number") {
      await Promise.all(
          handleError(
              snap,
              // eslint-disable-next-line max-len
              `failed to create channel name, requested by ${snap.data().initiator}`,
              snap.data().initiator,
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
              snap.data().initiator,
          )
      );
      return;
    }
    let questions: any[] | undefined;
    if (t.parameters.question_engine.defaultValue.value === "offline") {
      questions = await offlineQuestionSearch(snap.data().topics,
          // @ts-ignore
          t.parameters.question_count.defaultValue.value*1, // Casting to number
          0.1,
          t.parameters.offline_use_generated.defaultValue.value === "true");
    } else if (t.parameters.question_engine.defaultValue.value === "online") {
      throw Error("unimplemented");
      // questions =
      //         await onlineOpenAiCompletion(data.topics, t.parameters);
    }

    if (!questions || questions.length === 0) {
      await Promise.all(
          handleError(
              snap,
              `failed to find question for topics, ${snap.data().topics}`,
              snap.data().initiator,
          )
      );
      return;
    }

    functions
        .logger
        .info("found questions for topics", snap.data().topics, questions);
    snap.ref.set({
      questions: questions,
      channelName: channelName,
    }, {merge: true});

    for (const playerUid of snap.data().players) {
      const player = await db
          .collection(kUsersCollection)
          .doc(playerUid)
          .get();
      if (!player.data() || !player.data()!.tokens) {
        // Need to wait the promise to avoid concurrency issues on the db
        await Promise.all(handleError(
            snap,
            `${playerUid}, has no devices`,
            playerUid,
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
            body: `${senderData.data()!.displayName} invited you to play ${snap.data()!.topics.join(",")}`,
            // eslint-disable-next-line max-len
            title: `Play ${snap.data()!.topics.join(",")} with ${senderData.data()!.displayName}?`,
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
              .doc(playerUid)
              .update({
                tokens: admin.firestore.FieldValue.arrayRemove(t),
              }).then(() => functions.logger.info("removed invalid token", t))
              .catch(() =>
                handleError(snap, "failed to remove invalid token", playerUid));
        }
      });
    }
  } catch (e) {
    await Promise.all(handleError(snap, e, snap.data().initiator));
  }
};
