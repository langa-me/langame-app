import {deleteCollection, kStripeCustomersCollection, kUsersCollection} from "../src/helpers";
import {createStripeCustomer} from "../src/stripe/createStripeCustomer";
import {expect} from "chai";
import * as admin from "firebase-admin";
import {Stripe} from "stripe";
const portfinder = require("portfinder");

export const cleanup = async (stripe: Stripe,
    useStripeMocked: boolean,
    fft: any,
    stripeConfig: any) => {
  if (useStripeMocked) {
    portfinder.getPort({
      // @ts-ignore
      host: stripeConfig.host,
      // @ts-ignore
      port: stripeConfig.port,
    }, (err: Error, port: number) =>
    // @ts-ignore
      expect(port).to.be.not.equal(stripeConfig.port,
          "Did you forgot to run stripe-mock?"));
    fft.mockConfig({stripe: {
      key: "sk_test_123"+(+new Date).toString(36).slice(-5),
    }});
  } else {
    fft.mockConfig({stripe: {
      // eslint-disable-next-line max-len
      key: "sk_test_51IlVpjLXXrxWbxsYCdaClUoJJjUcLlSOjC6upmJJ41UiHswI4mcEnPBRjmYN8krOixFhGxEEjUJ0d9LyJvjEl7Fx00jXhGirc6",
    }});
  }
  await deleteCollection(admin.firestore(),
      kUsersCollection, 64);
  await deleteCollection(admin.firestore(),
      kStripeCustomersCollection, 64);
  let customers = await stripe.customers.list();
  for (const c of customers.data) {
    const del = await stripe.customers.del(c.id);
    expect(del.deleted).to.be.true;
  }
  if (!useStripeMocked) {
    customers = await stripe.customers.list();
    expect(customers.data.length).to.be.equal(0);
  }
  let subs = await stripe.subscriptions.list();
  for (const s of subs.data) {
    const del = await stripe.subscriptions.del(s.id);
    expect(del.cancel_at).to.exist;
    expect(del.canceled_at).to.exist;
  }
  // stripe-mock is stateless
  if (!useStripeMocked) {
    subs = await stripe.subscriptions.list();
    for (const s of subs.data) {
      expect(s.status).to.be.equal("cancelled");
    }
  }
  const prices = await stripe.prices.list();
  for (const p of prices.data) {
    // TODO: until Stripe API allow price deleting
    // https://github.com/stripe/stripe-python/issues/658
    const del = await stripe.prices.update(p.id, {active: false});
    expect(del.active).to.be.false;
  }
  const products = await stripe.products.list();
  for (const p of products.data) {
    // Can't delete because it belongs to a price that we
    // can't delete :)
    const del = await stripe.products.update(p.id, {active: false});
    expect(del.active).to.be.false;
  }
};

export const createAndReturnCustomer = async (stripe: Stripe,
    stripeConfig: any,
    useStripeMocked: boolean) => {
  const db = admin.firestore();
  const userDoc = await db
      .collection(kUsersCollection)
      .add({
        email: "bar",
        displayName: "fooBar",
      });

  await db.collection(kUsersCollection).doc(userDoc.id).update({
    uid: userDoc.id,
  });


  await createStripeCustomer(
      // @ts-ignore
      {
        uid: userDoc.id,
      },
      {},
      stripeConfig,
  );
  const customerDoc =
        await db.collection(kStripeCustomersCollection)
            .doc(userDoc.id).get();
  expect(customerDoc.exists).to.be.true;
  expect(customerDoc.data()).to.exist;
  expect(customerDoc.data()!.customer_id).to.exist;
  expect(customerDoc.data()!.setup_secret).to.exist;
  const stripeApiCustomers = await stripe.customers.list();
  expect(stripeApiCustomers.data.length).to.be.greaterThan(0);
  // stripe-mock is stateless
  if (!useStripeMocked) {
    expect(customerDoc.data()!.customer_id)
        .to.be.equal(stripeApiCustomers.data[0].id);
  }
  return {userDoc: userDoc, customerId: customerDoc.data()!.customer_id};
};
