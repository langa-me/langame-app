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
const stripe = new Stripe(functions.config().stripe.secret, {
  apiVersion: "2020-08-27",
});

/**
 * When a user deletes their account, clean up after them
 * @param{UserRecord} user
 */
export const cleanupUser = async (user: UserRecord) => {
  const db = admin.firestore();
  const dbRef = db.collection("stripe_customers");
  const customer = (await dbRef.doc(user.uid).get()).data();

  const batch = db.batch();
  if (!customer) {
    functions.logger.error("could not retrieve Stripe customer");
  } else {
    await stripe.customers.del(customer.customer_id);
    // Delete the customers payments & payment methods in firestore.
    const paymentsMethodsSnapshot = await dbRef
        .doc(user.uid)
        .collection("payment_methods")
        .get();
    paymentsMethodsSnapshot.forEach((snap) => batch.delete(snap.ref));
    const paymentsSnapshot = await dbRef
        .doc(user.uid)
        .collection("payments")
        .get();
    paymentsSnapshot.forEach((snap) => batch.delete(snap.ref));
  }
  const interactionsToDelete = await db
      .collection(kInteractionsCollection)
      .where("usersArray", "array-contains", user.uid)
      .get();

  const preferencesToDelete = await db
      .collection(kPreferencesCollection)
      .where("userId", "==", user.uid)
      .get();

  const userToDelete = db
      .collection(kUsersCollection)
      .doc(user.uid);

  for (const interactionToDelete of interactionsToDelete.docs) {
    batch.delete(interactionToDelete.ref);
  }
  for (const preferenceToDelete of preferencesToDelete.docs) {
    batch.delete(preferenceToDelete.ref);
  }
  batch.delete(userToDelete);

  await batch.commit();

  return dbRef.doc(user.uid).delete();
};
