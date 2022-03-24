
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {EventContext} from "firebase-functions";
import {reportError} from "../errors";
import {shouldDrop} from "../utils/contexts";


export const onCreateOrganization = async (
    snap: admin.firestore.DocumentSnapshot<any>,
    ctx: EventContext) => {
  try {
    functions.logger.log(ctx);
    if (!snap.exists) {
      functions.logger.log("organization have been deleted, aborting");
      return;
    }
    if (shouldDrop(ctx)) return;
    const data = snap.data();
    if (!data) {
      functions.logger.log("organization have no data, deleting");
      return snap.ref.delete();
    }
    // Update preferences for the user (might have a b2c account)
    await admin.firestore().collection("preferences").doc(data.members[0]).set({
      currentOrganization: snap.id,
    }, {merge: true});
    return admin.firestore().runTransaction(async (t) => {
      return t.set(snap.ref, {
        credits: 2000,
      }, {merge: true});
    });
  } catch (e: any) {
    await reportError(e, ctx);
    return Promise.reject(e);
  }
};
