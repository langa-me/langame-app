// Replace the 3 values below with your own
import {https} from "firebase-functions";
import {FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode} from "./models";
import {kBetasCollection, kInvalidRequest} from "./helpers";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import FirebaseFunctionsRateLimiter from "firebase-functions-rate-limiter";
const Mailchimp = require("mailchimp-api-v3");
const mailchimpKey = functions.config().mailchimp.key;
const listId = functions.config().mailchimp.list;
const perUserlimiter = FirebaseFunctionsRateLimiter.withFirestoreBackend(
    {
      name: "per_user_limiter",
      maxCalls: 2,
      periodSeconds: 15,
    },
    admin.firestore(),
);


export const subscribe = async (
    data: any, context: https.CallableContext) => {
  if (!context.rawRequest.headers.origin) {
    return new FirebaseFunctionsResponse(
        500,
        undefined,
        undefined,
    );
  }
  const uidQualifier = "u_" + context.rawRequest.headers.origin;
  const isQuotaExceeded =
  await perUserlimiter.isQuotaAlreadyExceeded(uidQualifier);
  if (isQuotaExceeded) {
    return new FirebaseFunctionsResponse(
        429,
        undefined,
        "too many requests",
    );
  }

  if (!data) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kInvalidRequest,
    );
  }
  if (!data.email) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "you must provide a valid email",
    );
  }

  functions.logger.info("trying to register new beta user", data.email);

  const existing = await admin
      .firestore()
      .collection(kBetasCollection)
      .where("email", "==", data.email)
      .get();

  if (existing.docs.some((d) => d.exists)) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "already subscribed",
    );
  }


  return admin
      .firestore()
      .collection(kBetasCollection)
      .add({email: data.email, date: Date.now()})
      .then(async (_) => {
        const mailchimp = new Mailchimp(mailchimpKey);
        const res = await mailchimp.post(`/lists/${listId}/members`, {
          email_address: data.email,
          status: "pending",
          // tags: ["incomplete_purchase"],
        }); // TODO: get language ...
        functions.logger.info("new beta user",
            data.email,
            JSON.stringify(res));

        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.OK,
            undefined,
            undefined,
        );
      }).catch((e) => {
        functions.
            logger.
            error("failed to add new beta user", data.email, e);

        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.INTERNAL,
            undefined,
            "failed to add beta email",
        );
      });
};
