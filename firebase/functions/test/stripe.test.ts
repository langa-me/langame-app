import "mocha";

import * as admin from "firebase-admin";

import {expect} from "chai";
import {
  kStripeCustomersCollection,
} from "../src/helpers";
import Stripe from "stripe";
import * as functions from "firebase-functions";
import {addPaymentMethodDetails} from "../src/stripe/addPaymentMethodDetails";
import {confirmStripePayment} from "../src/stripe/confirmStripePayment";
import {createStripePayment} from "../src/stripe/createStripePayment";
import {cleanup, createAndReturnCustomer} from "./stripe.helpers";
import {createPricesAndProducts} from "../src/stripe/createPricesAndProducts";
const cred = admin.credential.cert("./langame-dev-8ac76897c7bc.json");
const fft = require("firebase-functions-test")({
  credential: cred,
  projectId: "langame-dev",
});

admin.initializeApp({
  credential: cred,
});

describe("Cloud Functions", () => {
  describe("stripe", () => {
    const useStripeMocked = false;

    const stripeConfig = {
      apiVersion: "2020-08-27",
    };
    if (useStripeMocked) {
      // @ts-ignore
      stripeConfig["host"] = "0.0.0.0";
      // @ts-ignore
      stripeConfig["protocol"] = "http";
      // @ts-ignore
      stripeConfig["port"] = 12111;
    }
    // @ts-ignore
    const stripe = new Stripe(functions.config().stripe.key, stripeConfig);
    const db = admin.firestore();
    beforeEach(() =>
      cleanup(stripe, useStripeMocked, fft, stripeConfig));

    it("Create Stripe customer", () =>
      createAndReturnCustomer(stripe,
          stripeConfig,
          useStripeMocked));
    // TODO: negative response: deleted
    // TODO: negative response: already sub
    // TODO: negative response: sub throws
    // TODO: negative response: sub status not "incomplete"
    it("Sub & pay", async () => {
      // stripe-mock has different behaviour, skip
      if (useStripeMocked) return;

      const {userDoc, customerId} =
          await createAndReturnCustomer(stripe, stripeConfig, useStripeMocked);

      const {product, price} =
          await createPricesAndProducts(stripe, stripeConfig);
      const currency = price.currency;
      const amount = price.unit_amount;
      expect(product.active).to.be.true;
      expect(price.active).to.be.true;
      let paymentMethodStripe = await stripe.paymentMethods.create({
        type: "card",
        card: {
          number: "4242424242424242",
          exp_month: 5,
          exp_year: 2022,
          cvc: "314",
        },
      });
      expect(paymentMethodStripe.type).to.exist;
      expect(paymentMethodStripe.card).to.exist;
      expect(paymentMethodStripe.type!).to.be.equal("card");
      expect(paymentMethodStripe.card!.last4).to.be.equal("4242");
      paymentMethodStripe =
          await stripe.paymentMethods.attach(paymentMethodStripe.id,
              {
                customer: customerId,
              });
      expect(paymentMethodStripe.customer)
          .to.be.equal(customerId);
      await db
          // eslint-disable-next-line max-len
          .doc(`${kStripeCustomersCollection}/${userDoc.id}/payment_methods/${paymentMethodStripe.id}`)
          .create({
            id: paymentMethodStripe.id,
          });
      let paymentMethodDoc = await db
          // eslint-disable-next-line max-len
          .doc(`${kStripeCustomersCollection}/${userDoc.id}/payment_methods/${paymentMethodStripe.id}`)
          .get();
      const secretDoc = await paymentMethodDoc.ref.parent.parent!.get();
      expect(secretDoc.exists).to.be.true;
      expect(secretDoc.data()).to.exist;
      expect(secretDoc.data()!.setup_secret).to.exist;
      // @ts-ignore
      await addPaymentMethodDetails({
        data(): any {
          return {id: paymentMethodStripe.id};
        },
        exists: true,
        id: paymentMethodStripe.id,
        ref: paymentMethodDoc.ref,
      }, {
        params: {
          userId: userDoc.id,
        },
      }, stripeConfig);
      const newSecretDoc = await paymentMethodDoc.ref.parent.parent!.get();
      expect(newSecretDoc.exists).to.be.true;
      expect(newSecretDoc.data()).to.exist;
      expect(newSecretDoc.data()!.setup_secret).to.exist;
      // Ensuring a new setup intent have been created if the customer
      // Wish to add new payment method in the future
      expect(newSecretDoc.data()!.setup_secret)
          .to.be.not.equal(secretDoc.data()!.setup_secret);
      // Retrieve the payment method from firestore to check
      // if it properly changed
      paymentMethodDoc = await paymentMethodDoc.ref.get();
      expect(paymentMethodDoc.exists).to.be.true;
      expect(paymentMethodDoc.data()).to.exist;
      expect(paymentMethodDoc.data()!.type).to.exist;
      expect(paymentMethodDoc.data()!.card).to.exist;
      expect(paymentMethodDoc.data()!.type).to.be.equal("card");
      expect(paymentMethodDoc.data()!.card.last4).to.be.equal("4242");

      let paymentDoc = await (await db
          // eslint-disable-next-line max-len
          .collection(kStripeCustomersCollection)
          .doc(userDoc.id)
          .collection("payments")
          .add({
            payment_method: paymentMethodDoc.data(),
            currency,
            amount: amount,
            status: "new",
          }))
          .get();
      // @ts-ignore
      await createStripePayment({
        data(): any {
          return {
            id: paymentDoc.id,
            payment_method: paymentMethodDoc.id,
            currency: currency,
            amount: amount,
          };
        },
        exists: true,
        id: paymentDoc.id,
        ref: paymentDoc.ref,
      }, {
        params: {
          pushId: paymentDoc.id,
        },
      }, stripeConfig);

      // Should now a payment intent created in Stripe
      // Should have payment updated in firestore document
      const paymentIntents = await stripe.paymentIntents.list({
        customer: customerId,
      });
      expect(paymentIntents.data.length).to.be.equal(1);
      const paymentIntentData = paymentIntents.data[0];
      // In 3D-secure scenario, this would be "require-confirmation"
      expect(paymentIntentData.status).to.be.equal("succeeded");
      expect(paymentIntentData.customer).to.be.equal(customerId);
      // stripe convert to lower case
      expect(paymentIntentData.currency).to.be.equal(currency.toLowerCase());
      expect(paymentIntentData.charges.data.length).to.be.equal(1);
      expect(paymentIntentData.charges.data[0].amount_captured)
          .to.be.equal(amount);
      expect(paymentIntentData.amount_received).to.be.equal(amount);

      // Checking that it properly updated document with the payment
      paymentDoc = await paymentDoc.ref.get();
      const checkPayment = () => {
        expect(paymentDoc.exists).to.be.true;
        expect(paymentDoc.data()).to.exist;

        expect(paymentDoc.data()!.id).to.exist;
        expect(paymentDoc.data()!.customer).to.exist;
        expect(paymentDoc.data()!.amount_received).to.exist;
        expect(paymentDoc.data()!.currency).to.exist;
        expect(paymentDoc.data()!.status).to.exist;
        expect(paymentDoc.data()!.id).to.be.equal(paymentIntentData.id);
        expect(paymentDoc.data()!.customer).to.be
            .equal(paymentIntentData.customer);
        expect(paymentDoc.data()!.amount_received).to.be
            .equal(paymentIntentData.amount_received);
        expect(paymentDoc.data()!.currency).to.be
            .equal(paymentIntentData.currency);
        expect(paymentDoc.data()!.status).to.be
            .equal(paymentIntentData.status);
      };
      checkPayment();
      await confirmStripePayment({
        // @ts-ignore
        before: {},
        // @ts-ignore
        after: {
          data(): any {
            return {
              id: paymentDoc.id,
              status: paymentDoc.data()!.status,
            };
          },
          ref: paymentDoc.ref,
        },
      }, {}, stripeConfig);
      paymentDoc = await paymentDoc.ref.get();
      // In 3D secure use case, payment intent would be
      // confirmed by confirmStripePayment, not the case here
      checkPayment();

      // We now have to check that the subscriptions has properly been created
      // And the customer has everything right
      const subs =
          await stripe.subscriptions.list({
            status: "active",
            customer: customerId,
          });
      expect(subs.data.length).to.be.equal(1);
      expect(subs.data[0].customer).to.be.equal(customerId);
      const subDoc = await db
          // eslint-disable-next-line max-len
          .doc(`${kStripeCustomersCollection}/${userDoc.id}/subscriptions/${subs.data[0].id}`)
          .get();
      expect(subDoc.exists).to.be.true;
      expect(subDoc.data()).to.exist;
      expect(subDoc.data()!.id).to.exist;
      expect(subDoc.data()!.start).to.exist;
      expect(subDoc.data()!.status).to.exist;

      expect(subDoc.data()!.id).to.be.equal(subs.data[0].id);
      expect(subDoc.data()!.start).to.be.equal(subs.data[0].start_date);
      expect(subDoc.data()!.status).to.be.equal(subs.data[0].status);
    });
    // TODO: negative addPaymentMethodDetails
    // TODO: un-cancel cancelled sub
  });
});
