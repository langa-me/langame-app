import * as functions from "firebase-functions";
import {firestore} from "firebase-admin/lib/firestore";
import QueryDocumentSnapshot = firestore.QueryDocumentSnapshot;
import {EventContext} from "firebase-functions";
import Stripe from "stripe";
import {reportError, userFacingMessage} from "../errors";


/**
 * When adding the payment method ID on the client,
 * this function is triggered to retrieve the payment method details.
 * @param{QueryDocumentSnapshot} snap
 * @param{EventContext} context
 * @param{any} stripeConfig
 */
export const addPaymentMethodDetails =
    async (snap: QueryDocumentSnapshot,
        context: EventContext,
        stripeConfig: any) => {
      try {
        const stripe =
            new Stripe(functions.config().stripe.key, stripeConfig);
        const paymentMethodId = snap.data().id;
        // Retrieve the payment method
        const paymentMethod = await stripe.paymentMethods.retrieve(
            paymentMethodId
        );
        // Retrieve the customer
        const customer = await stripe.customers?.retrieve(
            paymentMethod.customer as string,
        ) as Stripe.Customer;
        // If the customer has no default source, set this one as default
        if (!customer.default_source) {
          // Note the use of customer.invoice_setting.default_payment_method
          // instead of directly customer.default_payment_method,
          // it's necessary when it's the back-end that set the default source
          // on behalf of the customer
          // https://stripe.com/docs/api/customers/update#update_customer-invoice_settings-default_payment_method
          await stripe.customers?.update(customer.id, {
            invoice_settings: {
              default_payment_method: paymentMethod.id,
            },
          });
        }
        await snap.ref.set(paymentMethod);
        // Create a new SetupIntent so the
        // customer can add a new method next time.
        const intent = await stripe.setupIntents.create({
          customer: `${paymentMethod.customer}`,
        });
        await snap.ref.parent.parent?.set(
            {
              setup_secret: intent.client_secret,
            },
            {merge: true}
        );
      } catch (e) {
        await snap.ref.set({error: userFacingMessage(e)}, {merge: true});
        await reportError(e, {user: context.params.userId});
      }
    };
