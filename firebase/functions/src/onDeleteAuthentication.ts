import {
  kInteractionsCollection,
  kPreferencesCollection,
  kUsersCollection,
} from "./helpers";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {auth} from "firebase-admin/lib/auth";
import UserRecord = auth.UserRecord;
import Stripe from "stripe";
import {reportError} from "./errors";
import {html} from "./utils/html";
import Mailchimp = require("mailchimp-api-v3");


const title = "Farewell from Langame 😥";
/* eslint-disable max-len */
const body = `We are saddened by your departure, we will miss you.
<br>
Please do not hesitate to give us feedback <a href="https://help.langa.me/feedback">here.</a>, thank you!`;
/* eslint-disable max-len */


/**
 * When a user deletes their account, clean up after them
 * @param{UserRecord} user
 * @param{functions.EventContext} context
 */
export const onDeleteAuthentication = async (user: UserRecord,
    context: functions.EventContext) => {
  const stripe = new Stripe(functions.config().stripe.key, {
    apiVersion: "2020-08-27",
  });
  const db = admin.firestore();
  const customerCollection = db.collection("stripe_customers");
  const customerDoc = customerCollection.doc(user.uid);
  const customer = (await customerDoc.get()).data();
  const userDocToDelete = db
      .collection(kUsersCollection)
      .doc(user.uid);
  // TODO: update according to new user data model
  const batch = db.batch();
  // TODO: shouldn't we use transaction for read too?
  try {
    if (!customer) {
      await reportError(new Error("could not retrieve Stripe customer"),
          {user: context.params.userId});
    } else {
      functions.logger.info("preparing customer deletion", customerDoc.id);
      await stripe.customers.del(customer.customer_id);
      // Delete the customers payments & payment methods in firestore.
      const paymentsMethodsSnapshot = await customerDoc
          .collection("payment_methods")
          .get();
      paymentsMethodsSnapshot.forEach((snap) => batch.delete(snap.ref));
      const paymentsSnapshot = await customerDoc
          .collection("payments")
          .get();
      paymentsSnapshot.forEach((snap) => batch.delete(snap.ref));
      const subscriptionsSnapshot = await customerDoc
          .collection("subscriptions")
          .get();
      subscriptionsSnapshot.forEach((snap) => batch.delete(snap.ref));
      batch.delete(customerDoc);
    }
    const interactionsToDelete = await db
        .collection(kInteractionsCollection)
        .where("usersArray", "array-contains", user.uid)
        .get();

    const preferencesToDelete = await db
        .collection(kPreferencesCollection)
        .where("userId", "==", user.uid)
        .get();

    for (const interactionToDelete of interactionsToDelete.docs) {
      batch.delete(interactionToDelete.ref);
    }
    for (const preferenceToDelete of preferencesToDelete.docs) {
      batch.delete(preferenceToDelete.ref);
    }

    const presenceInLangames = await db
        .collectionGroup("players")
        .where("userId", "==", user.uid).get();

    for (const p of presenceInLangames.docs) {
      batch.delete(p.ref);
    }

    batch.delete(db.collection("recommendations").doc(user.uid));
    batch.delete(db.collection("seenMemes").doc(user.uid));

    functions.logger.info("preparing interactions, preferences, recommendations, seenMemes, user deletion");

    batch.delete(userDocToDelete).commit();
    return db.collection("mails").add({
      to: user.email,
      message: {
        subject: title,
        html: `<code>
          ${html(title, body, "Have a great day 😇.")}
        </code>`,
      },
    }).then(() => {
      const mailchimp = new Mailchimp(functions.config().mailchimp.key);
      mailchimp.post(`/lists/${functions.config().mailchimp.list}/members`, {
        email_address: user.email,
        status: "unsubscribed",
      });
    });
  } catch (e: any) {
    return reportError(e, {user: context.params.userId});
  }
};
