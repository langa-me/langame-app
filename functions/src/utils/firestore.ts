import * as admin from "firebase-admin";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {
  kUserDoesNotExist,
  kUsersCollection} from "../helpers";
import {langame} from "../langame/protobuf/langame";
import {FirebaseFunctionsResponse, FirebaseFunctionsResponseStatusCode}
  from "../models";
import * as functions from "firebase-functions";
import FirebaseFunctionsRateLimiter from "firebase-functions-rate-limiter";

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


export const getPerUserlimiter = () =>
  FirebaseFunctionsRateLimiter.withFirestoreBackend({
    name: "per_user_limiter",
    maxCalls: 2,
    periodSeconds: 15,
  },
  admin.firestore(),
  );
