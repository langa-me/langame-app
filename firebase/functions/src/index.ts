import * as admin from "firebase-admin";
// Initialize admin firebase
admin.initializeApp();
admin.firestore().settings({ignoreUndefinedProperties: true});

import * as functions from "firebase-functions";
import {newFeedback} from "./feedback";
import {interactionsDecrement, setLangamesDone} from "./scheduledFunctions";
import {onDeleteAuthentication} from "./onDeleteAuthentication";
import {subscribe} from "./subscribe";
import {notifyPresence} from "./notifyPresence";
import {addPaymentMethodDetails} from "./stripe/addPaymentMethodDetails";
import {confirmStripePayment} from "./stripe/confirmStripePayment";
import {createStripeCustomer} from "./stripe/createStripeCustomer";
import {kLangamesCollection, kStripeCustomersCollection} from "./helpers";
import {createStripePayment} from "./stripe/createStripePayment";
import {onCreateLangame} from "./onCreateLangame";
import {onUpdateLangamePlayers} from "./onUpdateLangamePlayers";

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

exports.subscribe = functions // TODO: transaction!!! // RENAME
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(subscribe);

exports.interactionsDecrement = functions
    .pubsub
    .schedule("1 * * * *")
    .onRun(interactionsDecrement);

exports.setLangamesDone = functions
    .pubsub
    .schedule("1 * * * *")
    .onRun(setLangamesDone);


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

// Langame //

exports.onCreateLangame = functions.firestore
    .document(`${kLangamesCollection}/{pushId}`)
    .onCreate(onCreateLangame);

exports.onUpdateLangamePlayers = functions.firestore
    .document(`${kLangamesCollection}/{langameId}/players/{playerId}`)
    .onUpdate(onUpdateLangamePlayers);

// Authentication //

exports.onDeleteAuthentication =
    functions.auth.user().onDelete(onDeleteAuthentication);
