"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.hashFnv32a = exports.generateAgoraRtcToken = exports.handleSendToDevice = exports.getUserData = exports.filterOutSendLangameCalls = exports.kNotificationsCollection = exports.kUsersCollection = exports.kInvalidRequest = exports.kUserDoesNotExist = exports.role = exports.expirationTimeInSeconds = exports.appCertificate = exports.appID = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const agora_access_token_1 = require("agora-access-token");
const models_1 = require("./models");
// Agora config
// Fill the appID and appCertificate key given by Agora.io
exports.appID = functions.config().agora.app.id;
exports.appCertificate = functions.config().agora.app.certificate;
// token expire time, hardcode to 3600 seconds = 1 hour
exports.expirationTimeInSeconds = 3600;
exports.role = agora_access_token_1.RtcRole.PUBLISHER;
const kUserDoesNotExist = (id) => `user ${id} does not exist`;
exports.kUserDoesNotExist = kUserDoesNotExist;
exports.kInvalidRequest = "invalid request";
exports.kUsersCollection = "users";
exports.kNotificationsCollection = "notifications";
const filterOutSendLangameCalls = (data, context) => {
    if (!context.auth) {
        return new models_1.FirebaseFunctionsResponse(401, undefined, "not authenticated");
    }
    if (!data) {
        return new models_1.FirebaseFunctionsResponse(400, undefined, exports.kInvalidRequest);
    }
    if (!data.recipients) {
        return new models_1.FirebaseFunctionsResponse(400, undefined, "invalid recipients");
    }
    if (!data.topic) {
        return new models_1.FirebaseFunctionsResponse(400, undefined, "invalid topic");
    }
    return 0;
};
exports.filterOutSendLangameCalls = filterOutSendLangameCalls;
const getUserData = async (id) => {
    const recipient = await admin
        .firestore()
        .collection(exports.kUsersCollection)
        .doc(id)
        .get();
    if (!recipient.exists) {
        return new models_1.FirebaseFunctionsResponse(400, undefined, exports.kUserDoesNotExist(id));
    }
    const data = recipient.data();
    if (!data) {
        return new models_1.FirebaseFunctionsResponse(400, undefined, exports.kUserDoesNotExist(id));
    }
    if (!models_1.isLangameUser(data)) {
        return new models_1.FirebaseFunctionsResponse(400, undefined, exports.kUserDoesNotExist(id));
    }
    const dataAsLangameUser = data;
    if (!dataAsLangameUser.tokens) {
        return new models_1.FirebaseFunctionsResponse(500, undefined, `user ${id} has no devices (tokens)`);
    }
    if (!dataAsLangameUser.uid) {
        return new models_1.FirebaseFunctionsResponse(500, undefined, `user ${id} has no uid`);
    }
    if (!dataAsLangameUser.displayName) {
        return new models_1.FirebaseFunctionsResponse(500, undefined, `user ${id} has no displayName`);
    }
    return dataAsLangameUser;
};
exports.getUserData = getUserData;
const handleSendToDevice = (recipientData, notificationPayload, promise) => {
    return promise.then((res) => {
        res.results.forEach((r, i) => {
            const t = recipientData.tokens[i];
            functions.logger.warn("failed", t, r.error);
            // Invalid token, remove it
            if (r.error &&
                r.error.code ===
                    "messaging/registration-token-not-registered" &&
                t) {
                admin
                    .firestore()
                    .collection(exports.kUsersCollection)
                    .doc(recipientData.uid)
                    .update({
                    tokens: admin.firestore.FieldValue
                        .arrayRemove(t),
                }).then(() => functions.logger.warn("removed invalid token", t))
                    .catch(() => functions.logger.error("failed to remove invalid token", t));
            }
        });
        return notificationPayload.data.id;
    }).catch((e) => {
        functions.logger.error("sendLangame failed", e);
        return new models_1.FirebaseFunctionsResponse(500, undefined, JSON.stringify(e));
    });
};
exports.handleSendToDevice = handleSendToDevice;
const generateAgoraRtcToken = (channelName, uid) => {
    const currentTimestamp = Math.floor(Date.now() / 1000);
    const privilegeExpiredTs = currentTimestamp + exports.expirationTimeInSeconds;
    return agora_access_token_1.RtcTokenBuilder.buildTokenWithUid(exports.appID, exports.appCertificate, channelName, uid, exports.role, privilegeExpiredTs);
};
exports.generateAgoraRtcToken = generateAgoraRtcToken;
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
const hashFnv32a = (str, asString, seed) => {
    let i;
    let l;
    let hVal = (seed === undefined) ? 0x811c9dc5 : seed;
    for (i = 0, l = str.length; i < l; i++) {
        hVal ^= str.charCodeAt(i);
        hVal += (hVal << 1) +
            (hVal << 4) +
            (hVal << 7) +
            (hVal << 8) +
            (hVal << 24);
    }
    if (asString) {
        // Convert to 8 digit hex string
        return ("0000000" + (hVal >>> 0).toString(16)).substr(-8);
    }
    return hVal >>> 0;
};
exports.hashFnv32a = hashFnv32a;
//# sourceMappingURL=helpers.js.map