import * as admin from "firebase-admin";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";

export const resetOnboarding = async (
): Promise<any> => {
  const db = admin.firestore();
  const preferences = await db.collection("preferences")
      .withConverter(converter<langame.protobuf.IUserPreference>())
      .get();
  return await Promise.all(preferences.docs.map((doc) => doc.ref.set({
    hasDoneOnBoarding: false,
  }, {merge: true})));
};
