import {reportError, userFacingMessage} from "../errors";
import * as functions from "firebase-functions";
import Stripe from "stripe";
import {EventContext} from "firebase-functions";
import {firestore} from "firebase-admin/lib/firestore";
import QueryDocumentSnapshot = firestore.QueryDocumentSnapshot;

/**
 *
 * @param{QueryDocumentSnapshot} snap
 * @param{EventContext} context
 * @param{any} stripeConfig
 */
export const createStripePayment = async (snap: QueryDocumentSnapshot,
    context: EventContext,
    stripeConfig: any) => {
  const stripe =
            new Stripe(functions.config().stripe.key, stripeConfig);
  // eslint-disable-next-line camelcase
  const {amount, currency, payment_method} = snap.data();
  try {
    // Look up the Stripe customer id.
    const customer = (await snap.ref.parent.parent!.get()).data()!.customer_id;
    // Create a charge using the pushId as the idempotency key
    // to protect against double charges.
    const idempotencyKey = context.params.pushId;
    const payment = await stripe.paymentIntents.create(
        {
          amount,
          currency,
          customer,
          payment_method,
          off_session: false,
          confirm: true,
          confirmation_method: "manual",
        },
        {idempotencyKey}
    );
    // If the result is successful, write it back to the database.
    await snap.ref.set(payment);
  } catch (e) {
    await snap.ref.set({error: userFacingMessage(e)}, {merge: true});
    await reportError(e, {user: context.params.userId});
  }
};
