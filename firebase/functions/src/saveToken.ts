import {https} from "firebase-functions";
import {kNotAuthenticated,
  kInvalidRequest,
  kUsersCollection} from "./helpers";
import {FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode} from "./models";
import * as admin from "firebase-admin";

export const saveToken = async (data: any,
    context: https.CallableContext) => {
  if (!context.auth) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
        undefined,
        kNotAuthenticated,
    );
  }
  if (data === null) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kInvalidRequest,
    );
  }

  if (!data.tokens) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "you must provide token(s)",
    );
  }

  // Save user device token(s) to Firestore, used to send notifications
  return await admin
      .firestore()
      .collection(kUsersCollection)
      .doc(context.auth.uid)
      .update({
        "tokens": admin.firestore.FieldValue.arrayUnion(...data.tokens),
      }).then((_) => {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.OK,
            undefined,
            undefined,
        );
      }).catch((e) => {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.INTERNAL,
            undefined,
            e,
        );
      });
};
