import {Change, EventContext} from "firebase-functions";
import {DocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {langame} from "./langame/protobuf/langame";
import {converter} from "./utils/firestore";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {generateAgoraRtcToken} from "./helpers";
import {handleError} from "./errors";

/**
 *
 * @param{Change<DocumentSnapshot>} change
 * @param{EventContext} _
 */
export const onUpdateLangamePlayers =
  async (change: Change<DocumentSnapshot>,
      _: EventContext) => {
    try {
      functions.logger.log("onUpdateLangamePlayers", change.after);
      // Deleted?
      if (!change.after.exists || !change.after.ref.parent.parent) return;
      await admin.firestore().runTransaction(async (t) => {
        const lgAfter =
          await t.get(change.after.ref.parent.parent!
              .withConverter(converter<langame.protobuf.Langame>()));
        const afterPlayer = await t.get(change.after.ref
            .withConverter(converter<langame.protobuf.Player>()));
        const afterPlayers = await t.get(lgAfter.ref.collection("players"));

        // If some player has no audio id
        if (afterPlayer.data()!.audioId === -1) {
          functions.logger.log("updating langame with respective audio id",
              lgAfter);

          const random = (seed: number, digit = 1) => {
            const x = Math.abs(Math.round(Math.sin(seed++) * 10 * digit));
            return x;
          };
          const audioId = random(Date.now(), 100_000);
          const audioToken = generateAgoraRtcToken(
            lgAfter.data()!.channelName,
            audioId,
            36_000, // 10 hour
          );
          t.update(afterPlayer.ref, {
            audioId: audioId,
            audioToken: audioToken,
            timeIn: admin.firestore.FieldValue.serverTimestamp(),
            timeOut: admin.firestore.FieldValue.delete(),
          });
          // eslint-disable-next-line max-len
          functions.logger.log(`updated langame with new player ${afterPlayer.id}, audio id ${audioId}, audio token ${audioToken}`);
        }

        // If the Langame is now full, set locked
        if (!lgAfter.data()!.isLocked &&
            afterPlayers.size >= 5 - lgAfter.data()!.reservedSpots.length) {
          // eslint-disable-next-line max-len
          functions.logger.log(`langame is full, ${afterPlayers.size} players, locking`);

          t.update(lgAfter.ref, {
            isLocked: admin.firestore.FieldValue.delete(),
          });
        }
        // If not started and enough player joined (2),
        // set started Langame properties
        if (!lgAfter.data()!.started &&
          afterPlayers.docs.filter((e) => e.data().timeIn).length > 1) {
          const tmpl = await admin.remoteConfig().getTemplate();

          const d = new Date();
          d.setMinutes(d.getMinutes() +
            // @ts-ignore
            tmpl.parameters.langame_delay_for_next.defaultValue.value * 1);

          t.update(lgAfter.ref, {
            started: admin.firestore.FieldValue.serverTimestamp(),
            nextMeme: admin.firestore.Timestamp.fromDate(d),
          });

          functions.logger.log("Langame started, updated start date");
        }
      });
    } catch (e: any) {
      await Promise.all(handleError(change.after.ref,
          {developerMessage: e, uid: "null"}));
    }
  };
