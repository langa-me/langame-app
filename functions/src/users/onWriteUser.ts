import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError, reportError} from "../errors";
import {algoliaPrefix} from "../helpers";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";
import {shouldDrop} from "../utils/contexts";

export const onWriteUser = async (
    change: Change<admin.firestore.DocumentSnapshot<langame.protobuf.IUser>>,
    ctx: EventContext) => {
  const api = new ImplAiApi();
  try {
    functions.logger.log(ctx);

    const i = api.getIndex(algoliaPrefix+"users");
    if (!change.after.exists) {
      await i.deleteObject(change.after.id);
      return;
    }
    if (shouldDrop(ctx)) return;

    if (!change.after.data()) {
      return reportError(new Error(`${change.after.id} has no data`), ctx);
    }

    const db = admin.firestore();

    const prefDoc = await db
        .collection("preferences")
        .doc(change.after.id)
        .withConverter(converter<langame.protobuf.IUserPreference>())
        .get();

    functions.logger.log("synchronizing user to algolia", change.after.data());

    await i.saveObject({
      ...change.after.data(),
      objectID: change.after.id,
      _tags: [change.after.data()!.tag],
      favoriteTopics: prefDoc.data()?.favoriteTopics || [],
    });

    // Only run recommendations on new login
    if (
      change.before.data()?.lastLogin !== change.after.data()?.lastLogin
    ) {
      return setRecommendations(
          db,
          change.after,
          prefDoc,
      );
    }
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref, {developerMessage: e}));
    return Promise.reject(e);
  }
};


export const setRecommendations = (
    db: admin.firestore.Firestore,
    user: admin.firestore.DocumentSnapshot<langame.protobuf.IUser>,
    userPreference:
      admin.firestore.DocumentSnapshot<langame.protobuf.IUserPreference>,
): Promise<void | admin.firestore.Transaction> => {
  return db.runTransaction(async (t) => {
    // TODO: enum to string is fucking verbose in TS, thats why
    if (
      !userPreference.data()?.userRecommendations
    ) {
      functions.logger.info(`User ${user.id} does not want recommendations`);
      return Promise.resolve();
    }
    const recommendations = new Set<string>();


    const p =
      await t.get(db.collectionGroup("players")
          .where("userId", "==", user.id));
    if (p.empty) return Promise.resolve();
    let siblings = (await Promise.all(p.docs.map((u) =>
      u.ref.parent.parent!.collection("players").listDocuments())))
    // Flatten
        .reduce((acc, val) => acc.concat(val), []).map((e) => e.id);
    const messagesToMe = await db.collection("messages")
        .withConverter(converter<langame.protobuf.Message>())
        .where("toUid", "==", user.id).get();
    const messagesFromMe = await db.collection("messages")
        .withConverter(converter<langame.protobuf.Message>())
        .where("fromUid", "==", user.id).get();
    siblings = siblings.concat(
        messagesToMe.docs.map((e) => e.data().fromUid));
    siblings = siblings.concat(
        messagesFromMe.docs.map((e) => e.data().toUid));
    if (siblings.length === 0) return Promise.resolve();
    // Distinct values
    siblings
    // Ignore self
        .filter((u) => u !== user.id)
        .forEach((e) => recommendations.add(e));

    if (userPreference.data()?.favoriteTopics) {
    // Find recommendations according to similar interests
      const usersWithSimilarInterests = await db.collection("preferences")
          .withConverter(converter<langame.protobuf.IUserPreference>())
          .where("favoriteTopics",
              "array-contains-any",
            userPreference.data()!.favoriteTopics)
          .get();
      usersWithSimilarInterests.docs.forEach((e) => recommendations.add(e.id));
      // TODO: might only add if 3+ similar fav topics?
    }

    if (recommendations.size === 0) {
      functions.logger.info("didn't find any recommendations");
      return Promise.resolve();
    }
    return t.set(db.collection("recommendations").doc(user.id), {
      // TODO: give fitness recommendation
      //  (say, nb of messages, depend on goal)
      // TODO: reason of reco (say, he has similar interests...)
      users: admin.firestore.FieldValue.arrayUnion(...recommendations),
    });
  });
};
