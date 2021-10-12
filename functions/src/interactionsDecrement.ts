import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {kInteractionsCollection} from "./helpers";

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

