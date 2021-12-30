import * as admin from "firebase-admin";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
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

export const getPerUserlimiter = () =>
  FirebaseFunctionsRateLimiter.withFirestoreBackend({
    name: "per_user_limiter",
    maxCalls: 2,
    periodSeconds: 15,
  },
  admin.firestore(),
  );
