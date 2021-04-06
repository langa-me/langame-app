"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isLangameUser = exports.LangameUser = exports.isFirebaseFunctionsResponse = exports.FirebaseFunctionsResponse = exports.FirebaseFunctionsResponseStatusCode = void 0;
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
//# sourceMappingURL=models.js.map