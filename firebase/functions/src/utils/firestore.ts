import * as admin from "firebase-admin";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {kLangamesCollection,
  kUserDoesNotExist,
  kUsersCollection} from "../helpers";
import {langame} from "../langame/protobuf/langame";
import {FirebaseFunctionsResponse, FirebaseFunctionsResponseStatusCode}
  from "../models";
import * as functions from "firebase-functions";
import {reportError, userFacingMessage} from "../errors";

// Make the helper types for updates:
type PathImpl<T, K extends keyof T> =
  K extends string
  ? T[K] extends Record<string, any>
  ? T[K] extends ArrayLike<any>
  ? K | `${K}.${PathImpl<T[K], Exclude<keyof T[K], keyof any[]>>}`
  : K | `${K}.${PathImpl<T[K], keyof T[K]>}`
  : K
  : never
type Path<T> = PathImpl<T, keyof T> | keyof T
type PathValue<T, P extends Path<T>> =
  P extends `${infer K}.${infer Rest}`
  ? K extends keyof T
  ? Rest extends Path<T[K]>
  ? PathValue<T[K], Rest>
  : never
  : never
  : P extends keyof T
  ? T[P]
  : never
export type UpdateData<T extends object> = Partial<{
  [TKey in Path<T>]: PathValue<T, TKey>
}>

export const converter = <T>() => ({
  toFirestore: (data: Partial<T>) => data,
  fromFirestore: (snap: QueryDocumentSnapshot) =>
  snap.data() as T,
});
const dataPoint = <T>(collectionPath: string) =>
  admin.firestore().collection(collectionPath).withConverter(converter<T>());
const db = {
  // list your collections here
  users: dataPoint<langame.protobuf.User>(kUsersCollection),
  langames: dataPoint<langame.protobuf.Langame>(kLangamesCollection),
};
export {db};


export const getUserData = async (id: string):
Promise<FirebaseFunctionsResponse |
admin.firestore.DocumentSnapshot<langame.protobuf.User>> => {
  const recipient = await admin
      .firestore()
      .collection(kUsersCollection)
      .doc(id)
      .withConverter(converter<langame.protobuf.User>())
      .get();
  if (!recipient.exists) {
    functions.logger.error(kUserDoesNotExist(id), "not present in db");
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kUserDoesNotExist(id),
    );
  }


  const data = recipient.data();

  if (!data) {
    functions.logger.error(kUserDoesNotExist(id), "has no data");
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kUserDoesNotExist(id),
    );
  }

  if (!data.uid) {
    functions.logger.error(kUserDoesNotExist(id), "has no uid");
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        `user ${id} has no uid`,
    );
  }

  if (!data.displayName) {
    functions.logger.error(kUserDoesNotExist(id), "has not display name");
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        `user ${id} has no displayName`,
    );
  }
  return recipient;
};


export const getLangame = async (channelName: string):
    Promise<FirebaseFunctionsResponse |
    admin.firestore.QueryDocumentSnapshot<langame.protobuf.Langame>> => {
  const queryResult = await admin.firestore()
      .collection(kLangamesCollection)
      .where("channelName", "==", channelName)
      .withConverter(converter<langame.protobuf.Langame>())
      .get();
  if (queryResult.empty) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "could not find this channel",
    );
  }
  return queryResult.docs[0];
};


export const handleError = (
    snap: QueryDocumentSnapshot,
    msg: string,
    uid: string,
): Promise<any>[] => {
  const e = Error(msg);
  const p1 = snap.ref.set({
    errors: admin.firestore
        .FieldValue
        .arrayUnion(userFacingMessage(e)),
  }, {merge: true});
  const p2 = reportError(e, {user: uid});
  return [p1, p2];
};
