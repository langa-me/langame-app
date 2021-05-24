import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {RtcRole, RtcTokenBuilder} from "agora-access-token";
import {
  FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode,
} from "./models";

// Agora config
// Fill the appID and appCertificate key given by Agora.io
export const appID = functions.config().agora.id;
export const appCertificate = functions.config().agora.certificate;

// token expire time, hardcode to 3600 seconds = 1 hour
export const expirationTimeInSeconds = 3600;
export const role = RtcRole.PUBLISHER;


export const kUserDoesNotExist = (id: string) => `user ${id} does not exist`;
export const kInvalidRequest: string = "invalid request";
export const kNotAuthenticated: string = "not authenticated";
export const kUsersCollection: string = "users";
export const kNotificationsCollection: string = "notifications";
export const kLangamesCollection: string = "langames";
export const kTagsCollection: string = "tags";
export const kQuestionsCollection: string = "questions";
export const kBetasCollection: string = "betas";
export const kInteractionsCollection: string = "interactions";
export const kPreferencesCollection: string = "preferences";
export const kStripeCustomersCollection: string = "stripe_customers";
export const kProductsCollection: string = "products";

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

export const getUserData = async (id: string) => {
  const recipient = await admin
      .firestore()
      .collection(kUsersCollection)
      .doc(id)
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
  return data;
};

export const handleSendToDevice = (recipientData: any,
    notificationId: string,
    promise: Promise<admin.messaging.MessagingDevicesResponse>)
    : Promise<string | FirebaseFunctionsResponse> => {
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
    return notificationId;
  }).catch((e) => {
    functions.logger.error("sendLangame failed", JSON.stringify(e));
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        JSON.stringify(e));
  });
};

export const generateAgoraRtcToken = (channelName: string,
    uid: number): string => {
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

export const getLangame = async (channelName: string):
    Promise<FirebaseFunctionsResponse | any> => {
  const queryResult = await admin.firestore()
      .collection(kLangamesCollection)
      .where("channelName", "==", channelName)
      .get();
  if (queryResult.empty ||
      queryResult.docs.some((d) =>
        !d.exists || !("players" in d.data()))) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "could not find this channel",
    );
  }
  try {
    const data = queryResult.docs[0].data();
    return {
      id: queryResult.docs[0].id,
      channelName: data.channelName,
      players: data.players,
      topics: data.topics,
      questions: data.questions,
    };
  } catch (e) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "failed to build langame object",
    );
  }
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
