import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const resetCredits =
    async (_: functions.EventContext) => {
      const db = admin.firestore();
      const users = await db
          .collection("users")
          .listDocuments();

      const promises = [];
      functions.logger.log("bulk credit reset size", users.length);

      for (const user of users) {
      // Get a new write batch
        const batch = db.batch();

        batch.update(db.collection("users").doc(user.id), {
          credits: 5,
        });

        // Commit the batch
        promises.push(batch.commit());
      }
      return Promise.all(promises);
    };
