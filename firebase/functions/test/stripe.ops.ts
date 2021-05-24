import {createPricesAndProducts} from "../src/stripe/createPricesAndProducts";
import Stripe from "stripe";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import "mocha";

const cred = admin.credential.cert("./langame-dev-8ac76897c7bc.json");
admin.initializeApp({
  credential: cred,
});

describe("some ops", () => {
  it("setup prices and products", async () => {
    const stripeConfig = {
      apiVersion: "2020-08-27",
    };
      // @ts-ignore
    const stripe = new Stripe(functions.config().stripe.key, stripeConfig);
    await createPricesAndProducts(stripe, stripeConfig);
  });

  it("clean payment methods", async () => {
    const stripeConfig = {
      apiVersion: "2020-08-27",
    };
      // @ts-ignore
    const stripe = new Stripe(functions.config().stripe.key, stripeConfig);
    const customers = await stripe.customers.list();
    for (const c of customers.data) {
      const pms = await stripe.paymentMethods.list({
        customer: c.id!,
        type: "card",
      });
      await Promise.all(pms.data.map((e) =>
        stripe.paymentMethods.detach(e.id)));
    }
  });
  it("clean customers", async () => {
    const stripeConfig = {
      apiVersion: "2020-08-27",
    };
      // @ts-ignore
    const stripe = new Stripe(functions.config().stripe.key, stripeConfig);
    const customers = await stripe.customers.list();
    for (const c of customers.data) {
      await stripe.customers.del(c.id);
    }
  });
});
