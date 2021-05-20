import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {newFeedback} from "./feedback";
import {sendLangameEnd} from "./sendLangameEnd";
import {sendLangame} from "./sendLangame";
import {interactionsDecrement} from "./scheduledFunctions";
import {cleanupUser} from "./deleteData";
import {subscribe} from "./subscribe";
import {notifyPresence} from "./notifyPresence";
import {getChannelToken} from "./getChannelToken";
import {saveToken} from "./saveToken";
import {addPaymentMethodDetails} from "./stripe/addPaymentMethodDetails";
import {confirmStripePayment} from "./stripe/confirmStripePayment";
import {createStripeCustomer} from "./stripe/createStripeCustomer";
import {kStripeCustomersCollection} from "./helpers";
import {createStripePayment} from "./stripe/createStripePayment";
// Initialize admin firebase
admin.initializeApp();
admin.firestore().settings({ignoreUndefinedProperties: true});
/*
 admin.auth() // TODO: should kick everyone
     .listUsers()
     .then((r) => r.users.forEach((u) =>
     functions.logger.info(u.displayName)
     /* admin.auth().revokeRefreshTokens(u.uid)* /));
*/

// see https://firebase.google.com/docs/reference/functions/function_configuration_.runtimeoptions
const runtimeOpts = {
  maxInstances: 10,
};
// TODO: somehow doesn't work then on client
const region = "us-central1";


exports.subscribe = functions // TODO: transaction!!!
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(subscribe);

exports.interactionsDecrement = functions
    .pubsub
    .schedule("1 * * * *")
    .onRun(interactionsDecrement);

exports.sendLangameEnd = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(sendLangameEnd);

exports.cleanupUser = functions.auth.user().onDelete(cleanupUser);


exports.getChannelToken = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(getChannelToken);

exports.saveToken = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(saveToken);

exports.sendLangame = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(sendLangame);

exports.notifyPresence = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(notifyPresence);

// https://firebase.google.com/docs/functions/gcp-storage-events
exports.onFeedback = functions
    .region(region)
    .storage.object()
    .onFinalize(async (object) => {
      if (!object.name?.startsWith("feedbacks") ||
          !object.mediaLink ||
            !object.metadata) {
        return;
      }
      functions.logger.info("new feedback", JSON.stringify(object));
      await newFeedback(object.mediaLink, object.metadata);
    }
    );


// Stripe //
const prodStripeConfig = {
  apiVersion: "2020-08-27",
};
exports.createStripeCustomer =
    functions.auth.user().onCreate((u, ctx) =>
      createStripeCustomer(u, ctx, prodStripeConfig));

exports.addPaymentMethodDetails = functions.firestore
    // eslint-disable-next-line max-len
    .document(`${kStripeCustomersCollection}/{userId}/payment_methods/{pushId}`)
    .onCreate((s, c) => addPaymentMethodDetails(s, c, prodStripeConfig));

exports.createStripePayment = functions.firestore
    .document(`${kStripeCustomersCollection}/{userId}/payments/{pushId}`)
    .onCreate((s, c) => createStripePayment(s, c, prodStripeConfig));

exports.confirmStripePayment = functions.firestore
    .document(`${kStripeCustomersCollection}/{userId}/payments/{pushId}`)
    .onUpdate((ch, c) =>
      confirmStripePayment(ch, c, prodStripeConfig));
