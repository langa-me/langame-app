import * as functions from "firebase-functions";
import {firestore} from "firebase-admin/lib/firestore";
import QueryDocumentSnapshot = firestore.QueryDocumentSnapshot;
import {EventContext} from "firebase-functions";
import Stripe from "stripe";
import {reportError} from "../errors";


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
        const paymentMethodId = snap.id;
        // Retrieve the payment method
        const paymentMethod = await stripe.paymentMethods.retrieve(
            paymentMethodId
        );
        // Retrieve the customer
        const customerId = (await snap.ref.parent.parent!.get())
            .data()!.customer_id;
        const customer = await stripe.customers?.retrieve(
            customerId,
        ) as Stripe.Customer;
        functions.logger.info("attaching payment method",
            paymentMethodId,
            "to customer",
            customerId);
        // Attaching the payment method to this customer
        await stripe.paymentMethods.attach(paymentMethodId,
            {customer: customerId});
        // If the customer has no default source, set this one as default
        if (customer.default_source == null) {
          functions.logger.info("setting this payment method as default");
          // Note the use of customer.invoice_setting.default_payment_method
          // instead of directly customer.default_payment_method,
          // it's necessary when it's the back-end that set the default source
          // on behalf of the customer
          // https://stripe.com/docs/api/customers/update#update_customer-invoice_settings-default_payment_method
          await stripe.customers!.update(customerId, {
            invoice_settings: {
              default_payment_method: paymentMethod.id,
            },
          });
        }
        await snap.ref.set(paymentMethod);
        // Create a new SetupIntent so the
        // customer can add a new method next time.
        const intent = await stripe.setupIntents.create({
          customer: customerId,
        });
        await snap.ref.parent.parent?.set(
            {
              setup_secret: intent.client_secret,
            },
            {merge: true}
        );
        functions.logger.info("new setup intent created for",
            customerId,
            ", ",
            intent
        );
      } catch (e: any) {
        await reportError(e, {user: context.params.userId});
      }
    };
