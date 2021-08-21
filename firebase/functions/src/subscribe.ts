// Replace the 3 values below with your own
import {https} from "firebase-functions";
import {kBetasCollection} from "./helpers";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {getPerUserlimiter} from "./utils/firestore";
const Mailchimp = require("mailchimp-api-v3");


export const subscribe = async (
    data: any, context: https.CallableContext) => {
  if (!context.rawRequest.ip) {
    throw new functions.https.HttpsError("internal", "unknown error");
  }
  const uidQualifier = "u_" + context.rawRequest.ip;
  const isQuotaExceeded =
  await getPerUserlimiter().isQuotaAlreadyExceeded(uidQualifier);
  if (isQuotaExceeded) {
    throw new functions.https
        .HttpsError("resource-exhausted", "too many requests");
  }

  if (!data) {
    throw new functions.https
        .HttpsError("invalid-argument", "you must provide an email");
  }
  if (!data.email) {
    throw new functions.https
        .HttpsError("invalid-argument", "you must provide an email");
  }

  functions.logger.info("trying to register new beta user", data.email);

  const existing = await admin
      .firestore()
      .collection(kBetasCollection)
      .where("email", "==", data.email)
      .get();

  if (existing.docs.some((d) => d.exists)) {
    throw new functions.https
        .HttpsError("invalid-argument", "already subscribed");
  }
  const mailchimpKey = functions.config().mailchimp.key;
  const listId = functions.config().mailchimp.list;

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

        return;
      }).catch((e) => {
        functions.
            logger.
            error("failed to add new beta user", data.email, e);

        throw new functions.https
            .HttpsError("internal", "unknown error");
      });
};
