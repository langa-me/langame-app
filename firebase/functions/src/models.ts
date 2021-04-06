/**
 * Enum representing status code
 */
export enum FirebaseFunctionsResponseStatusCode {
    OK = 200,
    BAD_REQUEST = 400,
    UNAUTHORIZED = 401,
    INTERNAL = 500,
}

/**
 * Response to all firebase functions
 */
export class FirebaseFunctionsResponse {
    results?: any[];
    statusCode: FirebaseFunctionsResponseStatusCode;
    errorMessage?: string;

    /**
     * Constructor ...
     * @param{FirebaseFunctionsResponseStatusCode} statusCode
     * @param{any[]} results
     * @param{string} errorMessage
     */
    constructor(
        statusCode: FirebaseFunctionsResponseStatusCode,
        results?: any[],
        errorMessage?: string) {
      this.results = results;
      this.statusCode = statusCode;
      this.errorMessage = errorMessage;
    }
}

/**
 * Check if object is a FirebaseFunctionsResponse
 * @param{any} obj
 * @return{boolean}
 */
export function isFirebaseFunctionsResponse(obj: any):
    obj is FirebaseFunctionsResponse {
  // Checking typical FirebaseFunctionsResponse properties
  return typeof obj.errorMessage === "string" &&
        typeof obj.statusCode === "number";
  // TODO: is it correct, is enum number?
}


/**
 * LangameUser represents a Langame user
 */
export class LangameUser {
    // / [uid] is set by Firebase authentication
    uid?: string; // TODO: shouldn't be nullable
    email?: string;
    displayName?: string;
    // bool emailVerified = false;
    phoneNumber?: string;
    photoUrl?: string;

    // / Is the user [online]?
    online: boolean = false;

    // / Google account linked?
    google: boolean = false;

    // / Facebook account linked?
    facebook: boolean = false;

    // / Apple account linked?
    apple: boolean = false;

    // / Favourite topics the user has picked, should impact recommendations
    favouriteTopics?: string[];

    // / [isALangameUser] signifies whether this user is an imported contact
    // / or really someone who registered on Langame
    isALangameUser: boolean = false;

    // / Twitter-like [tag] i.e. @steveTheApple
    tag?: string;

    // / Device [tokens] used for Cloud Messaging
    tokens?: string[];

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
    constructor(uid: string,
        email: string,
        displayName: string,
        phoneNumber: string,
        photoUrl: string,
        online: boolean = false,
        google: boolean = false,
        facebook: boolean = false,
        apple: boolean = false,
        favouriteTopics: string[],
        tag: string,
        tokens: string[]) {
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

/**
 * Check if object is a LangameUser
 * @param{any} obj
 * @return{boolean}
 */
export function isLangameUser(obj: any): obj is LangameUser {
  // Checking typical LangameUser properties
  return typeof obj.uid === "string" && typeof obj.google === "boolean";
}
