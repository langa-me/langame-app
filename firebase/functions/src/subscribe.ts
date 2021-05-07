// Replace the 3 values below with your own
import {https} from "firebase-functions";
import {FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode} from "./models";
import {kBetasCollection, kInvalidRequest} from "./helpers";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
const Mailchimp = require("mailchimp-api-v3");
const mailchimpKey = functions.config().mailchimp.key;
const listId = functions.config().mailchimp.list;

const callers = new Map();
const maxCalls = 10;
// TODO: wtf how can it work?
// Every 10 seconds, reduce the rate limit of every caller by one
setInterval(() => {
  callers.forEach(function(part, index, callers) {
    if (part === 0) return;
    callers.set(index, part-1);
  });
}, 10_00);

export const subscribe = async (
    data: any, context: https.CallableContext) => {
  const caller = callers.get(context.rawRequest.headers.origin);
  if (caller > maxCalls) {
    return new FirebaseFunctionsResponse(
        429,
        undefined,
        "too many requests",
    );
  }
  callers.set(context.rawRequest.headers.origin, caller ? caller+1 : 1);

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
