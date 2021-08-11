import {reportError} from "../errors";
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
    // Just a (hopefully temporary) hack,
    // need to wait payment method is processed
    // by other function
    await new Promise((resolve) => setTimeout(resolve, 1000));
    const customerDoc = await snap.ref.parent.parent!.get();
    const paymentMethodError = (await customerDoc.ref
        .collection("payment_methods").doc(payment_method).get())
        .data()!.error;
    if (paymentMethodError) {
      // eslint-disable-next-line max-len
      throw Error(`payment method has an error, aborting ${paymentMethodError}`);
    }
    // Look up the Stripe customer id.
    const customerId = customerDoc.data()!.customer_id;
    // Create a charge using the pushId as the idempotency key
    // to protect against double charges.
    const idempotencyKey = context.params.pushId;
    const payment = await stripe.paymentIntents.create(
        {
          amount,
          currency,
          customer: customerId,
          payment_method,
          off_session: false,
          confirm: true,
          confirmation_method: "manual",
          // { // TODO
          //   receipt_email
          // }
        },
        {idempotencyKey}
    );
    // If the result is successful, write it back to the database.
    await snap.ref.set(payment);
  } catch (e) {
    await reportError(e, {user: context.params.userId});
  }
};
