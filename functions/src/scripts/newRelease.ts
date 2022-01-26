import * as admin from "firebase-admin";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {initFirebaseTest} from "../utils/firestore.spec";


export const release = async () => {
  // TODO: notify email new version
  admin.firestore().collection("preferences")
      .withConverter(converter<langame.protobuf.IUserPreference>())
      .get().then(async (docs) => {
        await Promise.all(docs.docs.map((doc) => {
          // check has the property hasDoneOnboarding
          if (doc.data().hasDoneOnBoarding !== undefined) {
            // set to false
            return doc.ref.update({
              hasDoneOnBoarding: false,
              sawWhatsNew: false,
            });
          }
          return Promise.resolve();
        }));
      });
};
initFirebaseTest("dev", "./");
release();
