import {Stripe} from "stripe";
import * as admin from "firebase-admin";
import {kProductsCollection} from "../helpers";

/**
 * Create basic products and prices
 * @param{Stripe} stripe
 * @param{any} stripeConfig
 */
export const createPricesAndProducts =
    async (stripe: Stripe, stripeConfig: any) => {
      const product = await stripe.products.create({
        name: "Golden tongue",
        description: "Extra features and kind support for the Langame team",
      });
      const currency = "USD";
      const amount = 1000; // 10$
      const price = await stripe.prices.create({
        product: product.id,
        unit_amount: amount, // TODO:?
        currency: currency,
        recurring: {
          interval: "month",
        },
      });
      await admin.firestore().collection(kProductsCollection).doc(product.id)
          .set({
            product,
            price: price,
          });
      return {product: product, price: price};
    };
