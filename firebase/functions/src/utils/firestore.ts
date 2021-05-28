import * as admin from "firebase-admin";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {kUsersCollection} from "../helpers";
import {langame} from "../langame/protobuf/langame.gen";

// Initialize admin firebase
admin.initializeApp();
admin.firestore().settings({ignoreUndefinedProperties: true});

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
};
export {db};
