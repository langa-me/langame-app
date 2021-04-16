import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {RtcRole, RtcTokenBuilder} from "agora-access-token";
import {
  FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode,
  isLangameUser,
  LangameChannel,
  LangameUser, Question,
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
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kUserDoesNotExist(id),
    );
  }


  const data = recipient.data();

  if (!data) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kUserDoesNotExist(id),
    );
  }

  if (!isLangameUser(data)) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kUserDoesNotExist(id),
    );
  }

  const dataAsLangameUser = data as LangameUser;

  if (!dataAsLangameUser.tokens) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        `user ${id} has no devices (tokens)`,
    );
  }

  if (!dataAsLangameUser.uid) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        `user ${id} has no uid`,
    );
  }

  if (!dataAsLangameUser.displayName) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        `user ${id} has no displayName`,
    );
  }
  return dataAsLangameUser;
};

export const handleSendToDevice = (recipientData: LangameUser,
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
    Promise<FirebaseFunctionsResponse | LangameChannel> => {
  const queryResult = await admin.firestore()
      .collection(kLangamesCollection)
      .where("channelName", "==", channelName)
      .get();
  if (queryResult.docs.length === 0 ||
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
    return new LangameChannel({
      channelName: data.channelName,
      players: data.players,
      topics: data.topics,
      questions: data.questions,
    });
  } catch (e) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "failed to build langame object",
    );
  }
};

/**
 * findQuestionsInTopics Find questions in topic ordered by score, filtering
 * low scores
 * @param{Array<string>} tags
 * @param{number} limit
 * @param{number} minimumThreshold
 */
export const findQuestionsInTopics =
    async (tags: Array<string>, limit: number, minimumThreshold: number):
        Promise<Question[]> => {
      tags = tags.map((t) => t.toLowerCase());
      // TODO should aggregate/whatever u call it score in topic
      // Filter questions with highest scores for these tags
      const documents = await admin
          .firestore()
          .collection(kTagsCollection)
          .orderBy("score", "desc")
          .where("score", ">", minimumThreshold)
          .where("content", "in", tags)
          .limit(limit)
          .get();

      const questions = [];
      for (const d of documents.docs) {
        const q = await admin
            .firestore()
            .collection(kQuestionsCollection)
            .doc(d.data().question)
            .get();
        questions.push(q.data() as Question);
      }
      return questions;
    };
