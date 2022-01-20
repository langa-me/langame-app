
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {Change, EventContext} from "firebase-functions";
import {reportError} from "../errors";
import {shouldDrop} from "../utils/contexts";


export const onWriteToRateLimit = async (
    change: Change<admin.firestore.DocumentSnapshot<any>>,
    ctx: EventContext) => {
  try {
    functions.logger.log(ctx);

    if (!change.after.exists) {
      functions.logger.log("deleted, aborting");
      return;
    }
    if (shouldDrop(ctx)) return;
    const data = change.after.data();
    if (!data) {
      functions.logger.log("have no data, deleting");
      return change.after.ref.delete();
    }
    // Write to the collection "usages" to keep track of the number of times
    // an entity used Langame API or through the app.
    return admin.firestore().collection("usages")
        .doc(change.after.id)
        .set({
          queries: admin.firestore.FieldValue.arrayUnion(
              admin.firestore.Timestamp.now()
          ),
        }, {merge: true});
  } catch (e: any) {
    await reportError(e, ctx);
    return Promise.reject(e);
  }
};
