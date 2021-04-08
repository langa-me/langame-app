/**
 * Enum representing status code
 */
export enum FirebaseFunctionsResponseStatusCode {
    // eslint-disable-next-line no-unused-vars
    OK = 200,
    // eslint-disable-next-line no-unused-vars
    BAD_REQUEST = 400,
    // eslint-disable-next-line no-unused-vars
    UNAUTHORIZED = 401,
    // eslint-disable-next-line no-unused-vars
    INTERNAL = 500,
}

// TODO: might extends (functions.https.) HttpsError
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

/**
 * ChannelUserLangameUser is the mapping between channel uid (number)
 * and langame uid (string)
 */
export class ChannelUserLangameUser {
    channelUid: number;
    langameUid: string;

    /**
     * Constructor of ChannelUserLangameUser...
     * @param{number} channelUid
     * @param{string} langameUid
     */
    constructor({channelUid, langameUid}:{
        channelUid: number,
        langameUid: string
    }) {
      this.channelUid = channelUid;
      this.langameUid = langameUid;
    }
}

/**
 * Contains information about a Langame
 */
export class LangameChannel {
    channelName: string;
    players: Array<ChannelUserLangameUser>;
    topics: Array<string>;
    questions: Array<string>;

    /**
     * Constructor of LangameChannel...
     * @param{string} channelName
     * @param{Array<ChannelUserLangameUser>} players
     * @param{Array<string>} topics
     * @param{Array<string>} questions
     */
    constructor({channelName, players, topics, questions}:{channelName: string,
        players: Array<ChannelUserLangameUser>,
        topics: Array<string>,
        questions: Array<string>}) {
      this.channelName = channelName;
      this.players = players;
      this.topics = topics;
      this.questions = questions;
    }
}

/**
 * Check if object is a LangameChannel
 * @param{any} obj
 * @return{boolean}
 */
export function isLangameChannel(obj: any): obj is LangameChannel {
  // Checking typical LangameChannel properties
  return typeof obj.channelName === "string";
}


/**
 * Contains information about a Langame notification
 */
export class LangameNotification {
    id?: string;
    senderUid: string;
    recipientsUid: Array<string>;
    topics?: Array<string>;
    channelName?: string;
    ready?: boolean;

    /**
     * Constructor..
     * @param{string} id
     * @param{string} senderUid
     * @param{string} recipientsUid
     * @param{string} topics
     * @param{string} channelName
     * @param{string} ready
     */
    constructor({id, senderUid, recipientsUid, topics, channelName, ready}:
                    {id: string,
        senderUid: string,
        recipientsUid: Array<string>,
        topics: Array<string>,
        channelName: string,
        ready: boolean}) {
      this.id = id;
      this.senderUid = senderUid;
      this.recipientsUid = recipientsUid;
      this.topics = topics;
      this.channelName = channelName;
      this.ready = ready;
    }
}

/**
 * Check if object is a LangameNotification
 * @param{any} obj
 * @return{boolean}
 */
export function isLangameNotification(obj: any): obj is LangameNotification {
  // Checking typical LangameNotification properties
  return typeof obj.senderUid === "string" && obj.id === "string";
}
