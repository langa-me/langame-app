
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {EventContext} from "firebase-functions";
import {reportError} from "../../errors";
import {shouldDrop} from "../../utils/contexts";


export const onCreateKey = async (
    snap: admin.firestore.DocumentSnapshot<any>,
    ctx: EventContext) => {
  try {
    functions.logger.log(ctx);
    if (!snap.exists) {
      functions.logger.log("key have been deleted, aborting");
      return;
    }
    if (shouldDrop(ctx)) return;
    const data = snap.data();
    if (!data) {
      functions.logger.log("key have no data, deleting");
      return snap.ref.delete();
    }
    if (!data.apiKey) {
      // Generate a key and save it
      const key = admin.firestore().collection("api_keys").doc();
      return admin.firestore().runTransaction(async (t) => {
        return t.set(snap.ref, {
          apiKey: key.id,
        }, {merge: true});
      });
    }
    return Promise.resolve();
  } catch (e: any) {
    await reportError(e, ctx);
    return Promise.reject(e);
  }
};
