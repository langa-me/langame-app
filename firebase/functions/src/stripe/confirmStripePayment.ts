import * as functions from "firebase-functions";
import {firestore} from "firebase-admin/lib/firestore";
import QueryDocumentSnapshot = firestore.QueryDocumentSnapshot;
import {Change, EventContext} from "firebase-functions";
import Stripe from "stripe";
import {reportError} from "../errors";

/**
 * When 3D Secure is performed, we need to reconfirm the payment
 * after authentication has been performed.
 * Also this step finalize the sub for the customer.
 *
 * @see https://stripe.com/docs/payments/accept-a-payment-synchronously#web-confirm-payment
 * @param{Change<QueryDocumentSnapshot>} change
 * @param{EventContext} context
 * @param{any} stripeConfig
 */
export const confirmStripePayment =
  async (change: Change<QueryDocumentSnapshot>,
      context: EventContext,
      stripeConfig: any) => {
    const stripe =
      new Stripe(functions.config().stripe.key, stripeConfig);
    try {
      if (change.after.data().error) {
        // eslint-disable-next-line max-len
        throw Error(`payment has an error, aborting ${change.after.data().error}`);
      }
      if (change.after.data().status === "requires_confirmation") {
        const payment = await stripe.paymentIntents.confirm(
            change.after.data().id,
            // { // TODO
            //   receipt_email
            // }
        );
        await change.after.ref.set(payment);
      }
      const customer = (await change.after.ref.parent.parent!.get())
          .data()!.customer_id;
      // const t = await admin.remoteConfig().getTemplate();
      // TODO: temporarily use first active price, should use remote config
      const prices = await stripe.prices!.list({
        active: true,
      });
      functions.logger.info("creating subscription on price",
          prices.data[0],
          "for",
          customer);
      const sub = await stripe.subscriptions.create({
        customer: customer,
        items: [
          {
            price: prices.data[0].id, // TODO
            // For metered billing, do not pass quantity
            quantity: 1,
          },
        ],
      });
      functions.logger.info("subscription", sub);
      if (sub.status !== "active") {
        functions.logger.error("subscription is still not active");
        return;
      }
      // Once the subscription is created, add it to customer data
      return change.after.ref.parent.parent!
          .collection("subscriptions")
          .doc(sub.id)
          .set(
              Object.fromEntries(Object.entries(sub))
          );
    } catch (e) {
      await reportError(e, {user: context.params.userId});
      return stripe.refunds!.create({
        payment_intent: change.after.id,
        metadata: {
          error: `failed to created subscription, ${e}`,
        },
      });
      // TODO: test refund
    }
  };
