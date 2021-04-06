import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {RtcRole, RtcTokenBuilder} from "agora-access-token";
import {FirebaseFunctionsResponse, isLangameUser, LangameUser} from "./models";


// Agora config
// Fill the appID and appCertificate key given by Agora.io
export const appID = functions.config().agora.app.id;
export const appCertificate = functions.config().agora.app.certificate;

// token expire time, hardcode to 3600 seconds = 1 hour
export const expirationTimeInSeconds = 3600;
export const role = RtcRole.PUBLISHER;


export const kUserDoesNotExist = (id: string) => `user ${id} does not exist`;
export const kInvalidRequest: string = "invalid request";
export const kUsersCollection: string = "users";
export const kNotificationsCollection: string = "notifications";

export const filterOutSendLangameCalls =
    (data: any, context: functions.https.CallableContext) => {
      if (!context.auth) {
        return new FirebaseFunctionsResponse(
            401,
            undefined,
            "not authenticated",
        );
      }

      if (!data) {
        return new FirebaseFunctionsResponse(
            400,
            undefined,
            kInvalidRequest,
        );
      }

      if (!data.recipients) {
        return new FirebaseFunctionsResponse(
            400,
            undefined,
            "invalid recipients",
        );
      }

      if (!data.topic) {
        return new FirebaseFunctionsResponse(
            400,
            undefined,
            "invalid topic",
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
        400,
        undefined,
        kUserDoesNotExist(id),
    );
  }


  const data = recipient.data();

  if (!data) {
    return new FirebaseFunctionsResponse(
        400,
        undefined,
        kUserDoesNotExist(id),
    );
  }

  if (!isLangameUser(data)) {
    return new FirebaseFunctionsResponse(
        400,
        undefined,
        kUserDoesNotExist(id),
    );
  }

  const dataAsLangameUser = data as LangameUser;

  if (!dataAsLangameUser.tokens) {
    return new FirebaseFunctionsResponse(
        500,
        undefined,
        `user ${id} has no devices (tokens)`,
    );
  }

  if (!dataAsLangameUser.uid) {
    return new FirebaseFunctionsResponse(
        500,
        undefined,
        `user ${id} has no uid`,
    );
  }

  if (!dataAsLangameUser.displayName) {
    return new FirebaseFunctionsResponse(
        500,
        undefined,
        `user ${id} has no displayName`,
    );
  }
  return dataAsLangameUser;
};

export const handleSendToDevice = (recipientData: LangameUser,
    notificationPayload: any,
    promise: Promise<admin.messaging.MessagingDevicesResponse>)
    : Promise<string | FirebaseFunctionsResponse> => {
  return promise.then((res) => {
    res.results.forEach((r, i) => {
      const t = recipientData.tokens![i];
      functions.logger.warn("failed", t, r.error);
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
    return notificationPayload.data.id;
  }).catch((e) => {
    functions.logger.error("sendLangame failed", e);
    return new FirebaseFunctionsResponse(500, undefined, JSON.stringify(e));
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
