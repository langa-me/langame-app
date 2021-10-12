import {HttpsError} from "firebase-functions/lib/providers/https";

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
// TODO: generic response data
/**
 * Response to all firebase functions
 */
export class FirebaseFunctionsResponse {
    result?: any[];
    statusCode: FirebaseFunctionsResponseStatusCode;
    errorMessage?: string;

    /**
     * Constructor ...
     * @param{FirebaseFunctionsResponseStatusCode} statusCode
     * @param{any} result
     * @param{string} errorMessage
     */
    constructor(
        statusCode: FirebaseFunctionsResponseStatusCode,
        result?: any,
        errorMessage?: string) {
      this.result = result;
      this.statusCode = statusCode;
      this.errorMessage = errorMessage;
    }
}

/**
 * Functions error
 */
export class LangameFunctionsError extends HttpsError {

}
