import {https} from "firebase-functions";
import {FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode} from "./models";
import {kInvalidRequest, kNotAuthenticated} from "./helpers";
export const getOnlineOpenAi = async (data: any,
    context: https.CallableContext) => {
  if (!context.auth) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
        undefined,
        kNotAuthenticated,
    );
  }
  if (!data) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kInvalidRequest,
    );
  }
  if (!data.type) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "you must provide a valid type of completion",
    );
  }

  // const db = admin.firestore();
  // const t = await admin.remoteConfig().getTemplate();
  // const response = await onlineOpenAiCompletion("politics", t);

  return new FirebaseFunctionsResponse(
      FirebaseFunctionsResponseStatusCode.INTERNAL,
      undefined,
      undefined,
  );
};
