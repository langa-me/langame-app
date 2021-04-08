"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isLangameNotification = exports.LangameNotification = exports.isLangameChannel = exports.LangameChannel = exports.ChannelUserLangameUser = exports.isLangameUser = exports.LangameUser = exports.isFirebaseFunctionsResponse = exports.FirebaseFunctionsResponse = exports.FirebaseFunctionsResponseStatusCode = void 0;
/**
 * Enum representing status code
 */
var FirebaseFunctionsResponseStatusCode;
(function (FirebaseFunctionsResponseStatusCode) {
    // eslint-disable-next-line no-unused-vars
    FirebaseFunctionsResponseStatusCode[FirebaseFunctionsResponseStatusCode["OK"] = 200] = "OK";
    // eslint-disable-next-line no-unused-vars
    FirebaseFunctionsResponseStatusCode[FirebaseFunctionsResponseStatusCode["BAD_REQUEST"] = 400] = "BAD_REQUEST";
    // eslint-disable-next-line no-unused-vars
    FirebaseFunctionsResponseStatusCode[FirebaseFunctionsResponseStatusCode["UNAUTHORIZED"] = 401] = "UNAUTHORIZED";
    // eslint-disable-next-line no-unused-vars
    FirebaseFunctionsResponseStatusCode[FirebaseFunctionsResponseStatusCode["INTERNAL"] = 500] = "INTERNAL";
})(FirebaseFunctionsResponseStatusCode = exports.FirebaseFunctionsResponseStatusCode || (exports.FirebaseFunctionsResponseStatusCode = {}));
// TODO: might extends (functions.https.) HttpsError
/**
 * Response to all firebase functions
 */
class FirebaseFunctionsResponse {
    /**
     * Constructor ...
     * @param{FirebaseFunctionsResponseStatusCode} statusCode
     * @param{any[]} results
     * @param{string} errorMessage
     */
    constructor(statusCode, results, errorMessage) {
        this.results = results;
        this.statusCode = statusCode;
        this.errorMessage = errorMessage;
    }
}
exports.FirebaseFunctionsResponse = FirebaseFunctionsResponse;
/**
 * Check if object is a FirebaseFunctionsResponse
 * @param{any} obj
 * @return{boolean}
 */
function isFirebaseFunctionsResponse(obj) {
    // Checking typical FirebaseFunctionsResponse properties
    return typeof obj.errorMessage === "string" &&
        typeof obj.statusCode === "number";
    // TODO: is it correct, is enum number?
}
exports.isFirebaseFunctionsResponse = isFirebaseFunctionsResponse;
/**
 * LangameUser represents a Langame user
 */
class LangameUser {
    /**
     *
     * @param{string} uid
     * @param{string} email
     * @param{string} displayName
     * @param{string} phoneNumber
     * @param{string} photoUrl
     * @param{boolean} online
     * @param{boolean} google
     * @param{boolean} facebook
     * @param{boolean} apple
     * @param{array} favouriteTopics
     * @param{string} tag
     * @param{array} tokens
     */
    constructor(uid, email, displayName, phoneNumber, photoUrl, online = false, google = false, facebook = false, apple = false, favouriteTopics, tag, tokens) {
        // / Is the user [online]?
        this.online = false;
        // / Google account linked?
        this.google = false;
        // / Facebook account linked?
        this.facebook = false;
        // / Apple account linked?
        this.apple = false;
        // / [isALangameUser] signifies whether this user is an imported contact
        // / or really someone who registered on Langame
        this.isALangameUser = false;
        this.uid = uid;
        this.email = email;
        this.displayName = displayName;
        this.phoneNumber = phoneNumber;
        this.photoUrl = photoUrl;
        this.online = online;
        this.google = google;
        this.facebook = facebook;
        this.apple = apple;
        this.favouriteTopics = favouriteTopics;
        this.tag = tag;
        this.tokens = tokens;
    }
}
exports.LangameUser = LangameUser;
/**
 * Check if object is a LangameUser
 * @param{any} obj
 * @return{boolean}
 */
function isLangameUser(obj) {
    // Checking typical LangameUser properties
    return typeof obj.uid === "string" && typeof obj.google === "boolean";
}
exports.isLangameUser = isLangameUser;
/**
 * ChannelUserLangameUser is the mapping between channel uid (number)
 * and langame uid (string)
 */
class ChannelUserLangameUser {
    /**
     * Constructor of ChannelUserLangameUser...
     * @param{number} channelUid
     * @param{string} langameUid
     */
    constructor({ channelUid, langameUid }) {
        this.channelUid = channelUid;
        this.langameUid = langameUid;
    }
}
exports.ChannelUserLangameUser = ChannelUserLangameUser;
/**
 * Contains information about a Langame
 */
class LangameChannel {
    /**
     * Constructor of LangameChannel...
     * @param{string} channelName
     * @param{Array<ChannelUserLangameUser>} players
     * @param{Array<string>} topics
     * @param{Array<string>} questions
     */
    constructor({ channelName, players, topics, questions }) {
        this.channelName = channelName;
        this.players = players;
        this.topics = topics;
        this.questions = questions;
    }
}
exports.LangameChannel = LangameChannel;
/**
 * Check if object is a LangameChannel
 * @param{any} obj
 * @return{boolean}
 */
function isLangameChannel(obj) {
    // Checking typical LangameChannel properties
    return typeof obj.channelName === "string";
}
exports.isLangameChannel = isLangameChannel;
/**
 * Contains information about a Langame notification
 */
class LangameNotification {
    /**
     * Constructor..
     * @param{string} id
     * @param{string} senderUid
     * @param{string} recipientsUid
     * @param{string} topics
     * @param{string} channelName
     * @param{string} ready
     */
    constructor({ id, senderUid, recipientsUid, topics, channelName, ready }) {
        this.id = id;
        this.senderUid = senderUid;
        this.recipientsUid = recipientsUid;
        this.topics = topics;
        this.channelName = channelName;
        this.ready = ready;
    }
}
exports.LangameNotification = LangameNotification;
/**
 * Check if object is a LangameNotification
 * @param{any} obj
 * @return{boolean}
 */
function isLangameNotification(obj) {
    // Checking typical LangameNotification properties
    return typeof obj.senderUid === "string" && obj.id === "string";
}
exports.isLangameNotification = isLangameNotification;
//# sourceMappingURL=models.js.map