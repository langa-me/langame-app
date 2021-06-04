import Stripe from "stripe";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {auth} from "firebase-admin/lib/auth";
import UserRecord = auth.UserRecord;
import {kStripeCustomersCollection} from "../helpers";
import {reportError, userFacingMessage} from "../errors";

/**
 * When a user is created, create a Stripe customer object for them.
 * @param{UserRecord} user
 * @param{functions.EventContext} context
 * @param{any} config
 * @see https://stripe.com/docs/payments/save-and-reuse#web-create-customer
 */
export const createStripeCustomer =
    async (user: UserRecord, context: functions.EventContext, config: any) => {
      const doc = admin.firestore()
          .collection(kStripeCustomersCollection).doc(user.uid);
      try {
        const stripe = new Stripe(functions.config().stripe.key, config);
        const customer = await stripe.customers.create({email: user.email});
        const intent = await stripe.setupIntents.create({
          customer: customer.id,
        });
        await doc.set({
          customer_id: customer.id,
          setup_secret: intent.client_secret,
        });
      } catch (e) {
        await doc.set({error: userFacingMessage(e)}, {merge: true});
        await reportError(e, {user: context.params.userId});
      }
    };
