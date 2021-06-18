import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {kInteractionsCollection, kLangamesCollection} from "./helpers";
import {converter} from "./utils/firestore";
import {langame} from "./langame/protobuf/langame";
import {reportError} from "./errors";

export const interactionsDecrement =
    async (_: functions.EventContext) => {
      const db = admin.firestore();
      const toDecrement = await db
          .collection(kInteractionsCollection)
          .where("interactions", ">", 0)
          .get();

      // Get a new write batch
      const batch = db.batch();

      // eslint-disable-next-line max-len
      for (const doc of toDecrement.docs) {
        batch.update(db.collection(kInteractionsCollection).doc(doc.id), {
          interactions: admin.firestore.FieldValue.increment(-1),
        });
        functions.logger.info("going to decrement interaction", doc.data());
      }

      // Commit the batch
      return batch.commit();
    };

export const setLangamesDone =
    async (_: functions.EventContext) => {
      const db = admin.firestore();
      const HOUR = 4 * 1000 * 60 * 60;
      const anHourAgo = new Date(Date.now() - HOUR);
      // TODO: delete non-started too old ones?
      try {
        db.runTransaction(async (t) => {
          const langamesThatStartedMoreThanOneHourAgo = await t.get(db
              .collection(kLangamesCollection)
              .where("done", "==", null)
              .where("started",
                  "<",
                  admin.firestore.Timestamp.fromDate(anHourAgo))
              .withConverter(converter<langame.protobuf.Langame>()));

          for (const doc of langamesThatStartedMoreThanOneHourAgo.docs) {
            // const players = await t.get(doc.ref.collection("players")
            //     .withConverter(converter<langame.protobuf.Player>()));
            // // TODO: does not work if player does not signal
            // // time out properly obviously
            // const isEmpty =
            // players.docs
            //     .filter((e) => e.data().timeOut !== undefined).length ===
            // players.docs.length;
            // if (!isEmpty) continue;
            t.update(doc.ref, {
              done: admin.firestore.FieldValue.serverTimestamp(),
            });
            // eslint-disable-next-line max-len
            functions.logger.info("langame is empty for too long, setting done", doc.data());
          }
        });
      } catch (e) {
        reportError(e);
      }
    };
