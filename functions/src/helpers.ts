
export const kUserDoesNotExist = (id: string) => `user ${id} does not exist`;
export const kInvalidRequest: string = "invalid request";
export const kNotAuthenticated: string = "not authenticated";
export const kUsersCollection: string = "users";
export const kNotificationsCollection: string = "notifications";
export const kLangamesCollection: string = "langames";
export const kTagsCollection: string = "tags";
export const kMemesCollection: string = "memes";
export const kBetasCollection: string = "betas";
export const kInteractionsCollection: string = "interactions";
export const kPreferencesCollection: string = "preferences";
export const kStripeCustomersCollection: string = "stripe_customers";
export const kProductsCollection: string = "products";
export const isDev = process.env.GCLOUD_PROJECT?.includes("dev");

// eslint-disable-next-line valid-jsdoc
/**
 * Takes an Array<V>, and a grouping function,
 * and returns a Map of the array grouped by the grouping function.
 *
 * @param{Array<V>} list An array of type V.
 * @param{(input: V) => K} keyGetter A Function that takes the
 * Array type V as an input, and returns a value of type K.
 * K is generally intended to be a property key of V.
 *
 * @return{Map<K, Array<V>>} Map of the array grouped by the grouping function.
 */
export function groupBy<K, V>(list: Array<V>, keyGetter: (input: V) => K):
  Map<K, Array<V>> {
  const map = new Map<K, Array<V>>();
  list.forEach((item) => {
    const key = keyGetter(item);
    const collection = map.get(key);
    if (!collection) {
      map.set(key, [item]);
    } else {
      collection.push(item);
    }
  });
  return map;
}

/**
 * Return Algolia index prefix for the given environment.
 * (prod, dev, emulator)
 */
export const algoliaPrefix =
  !process.env.GCLOUD_PROJECT?.includes("dev") ? "prod_" :
    !process.env.FUNCTIONS_EMULATOR ? "dev_" : "emulator_";


export const isEmulator = process.env.FUNCTIONS_EMULATOR;
