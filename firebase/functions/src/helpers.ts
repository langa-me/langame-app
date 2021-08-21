import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {RtcRole, RtcTokenBuilder} from "agora-access-token";
import {
  FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode,
} from "./models";


export const role = RtcRole.PUBLISHER;

export const kUserDoesNotExist = (id: string) => `user ${id} does not exist`;
export const kInvalidRequest: string = "invalid request";
export const kNotAuthenticated: string = "not authenticated";
export const kUsersCollection: string = "users";
export const kNotificationsCollection: string = "notifications";
export const kLangamesCollection: string = "langames";
export const kTagsCollection: string = "tags";
export const kMemesCollection: string = "memes";
export const kBetasCollection: string = "betas";
export const kInteractionsCollection: string = "interactions";
export const kPreferencesCollection: string = "preferences";
export const kStripeCustomersCollection: string = "stripe_customers";
export const kProductsCollection: string = "products";
export const isDev = process.env.GCLOUD_PROJECT?.includes("dev");


export const filterOutSendLangameCalls =
    (data: any, context: functions.https.CallableContext) => {
      if (!context.auth) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
            undefined,
            "not authenticated",
        );
      }

      if (!data) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            kInvalidRequest,
        );
      }

      if (!data.recipients) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            "invalid recipients",
        );
      }

      if (!data.topics || data.topics.length === 0) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            "invalid topics",
        );
      }
      return 0;
    };


export const handleSendToDevice = (recipientData: any,
    promise: Promise<admin.messaging.MessagingDevicesResponse>)
    : Promise<any | FirebaseFunctionsResponse> => {
  return promise.then((res) => {
    res.results.forEach((r, i) => {
      const t = recipientData.tokens![i];
      // Invalid token, remove it
      if (r.error &&
                r.error.code ===
                "messaging/registration-token-not-registered" &&
                t) {
        admin
            .firestore()
            .collection(kUsersCollection)
            .doc(recipientData.uid!)
            .update({
              tokens: admin.firestore.FieldValue
                  .arrayRemove(t),
            }).then(() => functions.logger.warn("removed invalid token", t))
            .catch(() =>
              functions.logger.error("failed to remove invalid token", t));
      }
    });
    return Promise.resolve();
  }).catch((e) => {
    functions.logger.error("sendLangame failed", JSON.stringify(e));
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        JSON.stringify(e));
  });
};

export const generateAgoraRtcToken = (channelName: string,
    uid: number, expirationTimeInSeconds: number = 3600): string => {
  // Agora config
  // Fill the appID and appCertificate key given by Agora.io
  const appID = functions.config().agora.id;
  const appCertificate = functions.config().agora.certificate;

  const currentTimestamp = Math.floor(Date.now() / 1000);
  const privilegeExpiredTs = currentTimestamp + expirationTimeInSeconds;

  return RtcTokenBuilder.buildTokenWithUid(
      appID,
      appCertificate,
      channelName,
      uid,
      role,
      privilegeExpiredTs);
};

/**
 * Calculate a 32 bit FNV-1a hash
 * Found here: https://gist.github.com/vaiorabbit/5657561
 * Ref.: http://isthe.com/chongo/tech/comp/fnv/
 *
 * @param {string} str the input value
 * @param {boolean} [asString=false] set to true to return the hash value as
 *     8-digit hex string instead of an integer
 * @param {number} [seed] optionally pass the hash of the previous chunk
 * @return {number | string}
 */
export const hashFnv32a = (str: string, asString: boolean, seed: number):
    number | string => {
  let i; let l;
  let hVal = (seed === undefined) ? 0x811c9dc5 : seed;

  for (i = 0, l = str.length; i < l; i++) {
    hVal ^= str.charCodeAt(i);
    hVal += (hVal << 1) +
        (hVal << 4) +
        (hVal << 7) +
        (hVal << 8) +
        (hVal << 24);
  }
  if ( asString ) {
    // Convert to 8 digit hex string
    return ("0000000" + (hVal >>> 0).toString(16)).substr(-8);
  }
  return hVal >>> 0;
};


/**
 *
 * @param{admin.firestore.Firestore} db
 * @param{string} collectionPath
 * @param{number} batchSize
 * @return{Promise<any>}
 */
export async function deleteCollection(db: admin.firestore.Firestore,
    collectionPath: string,
    batchSize: number) {
  const collectionRef = db.collection(collectionPath);
  const query = collectionRef.orderBy("__name__").limit(batchSize);

  return new Promise((resolve, reject) => {
    deleteQueryBatch(db, query, resolve).catch(reject);
  });
}

/**
 *
 * @param{admin.firestore.Firestore} db
 * @param{admin.firestore.Query} query
 * @param{any} resolve
 * @return{void}
 */
async function deleteQueryBatch(db: admin.firestore.Firestore,
    query: admin.firestore.Query,
    resolve: any) {
  const snapshot = await query.get();

  const batchSize = snapshot.size;
  if (batchSize === 0) {
    // When there are no documents left, we are done
    resolve();
    return;
  }

  // Delete documents in a batch
  const batch = db.batch();
  snapshot.docs.forEach((doc) => {
    batch.delete(doc.ref);
  });
  await batch.commit();

  // Recurse on the next process tick, to avoid
  // exploding the stack.
  process.nextTick(() => {
    deleteQueryBatch(db, query, resolve);
  });
}

// eslint-disable-next-line valid-jsdoc
/**
 * Takes an Array<V>, and a grouping function,
 * and returns a Map of the array grouped by the grouping function.
 *
 * @param{Array<V>} list An array of type V.
 * @param{(input: V) => K} keyGetter A Function that takes the
 * Array type V as an input, and returns a value of type K.
 * K is generally intended to be a property key of V.
 *
 * @return{Map<K, Array<V>>} Map of the array grouped by the grouping function.
 */
export function groupBy<K, V>(list: Array<V>, keyGetter: (input: V) => K):
  Map<K, Array<V>> {
  const map = new Map<K, Array<V>>();
  list.forEach((item) => {
    const key = keyGetter(item);
    const collection = map.get(key);
    if (!collection) {
      map.set(key, [item]);
    } else {
      collection.push(item);
    }
  });
  return map;
}
