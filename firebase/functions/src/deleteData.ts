import {https} from "firebase-functions";
import {FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode} from "./models";
import {kInteractionsCollection,
  kNotAuthenticated,
  kUsersCollection} from "./helpers";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

export const deleteData = async (data: any,
    context: https.CallableContext) => {
  if (!context.auth) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
        undefined,
        kNotAuthenticated,
    );
  }

  const db = admin.firestore();
  const interactionsToDelete = await db
      .collection(kInteractionsCollection)
      .where("usersArray", "array-contains", context.auth.uid)
      .get();

  const userToDelete = db
      .collection(kUsersCollection)
      .doc(context.auth.uid);

  // Get a new write batch
  const batch = db.batch();

  for (const interactionToDelete of interactionsToDelete.docs) {
    batch.delete(interactionToDelete.ref);
  }
  batch.delete(userToDelete);
  return batch.commit().then(async () => {
    return admin.auth().deleteUser(context.auth!.uid).then(() => {
      functions.logger.info("successfully deleted user data",
          context.auth!.uid);
      return new FirebaseFunctionsResponse(
          FirebaseFunctionsResponseStatusCode.OK,
          undefined,
          undefined,
      );
    }).catch((e) => {
      functions.logger.error("failed to delete user data",
          context.auth!.uid,
          e);
      return new FirebaseFunctionsResponse(
          FirebaseFunctionsResponseStatusCode.INTERNAL,
          undefined,
          "delete_data_failed",
      );
    });
  }).catch((e) => {
    functions.logger.error("failed to delete user data", context.auth!.uid, e);
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "delete_data_failed",
    );
  });
};
