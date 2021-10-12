import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const resetCredits =
    async (_: functions.EventContext) => {
      const db = admin.firestore();
      const users = await db
          .collection("users")
          .listDocuments();

      const promises = [];
      for (const bulk of chunks(users, 400)) {
      // Get a new write batch
        const batch = db.batch();

        for (const doc of bulk) {
          batch.update(db.collection("users").doc(doc.id), {
            credits: 5,
          });
        }
        functions.logger.log("bulk credit reset size", bulk.length);

        // Commit the batch
        promises.push(batch.commit());
      }
      return Promise.all(promises);
    };


// eslint-disable-next-line require-jsdoc
function* chunks<T>(arr: T[], n: number) {
  for (let i = 0; i < arr.length; i += n) {
    yield arr.slice(i, i + n);
  }
}
