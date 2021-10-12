import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {reportError} from "../errors";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";

export const setUserRecommendation =
  async (_: functions.EventContext) => {
    const db = admin.firestore();
    try {
      return internalSetUserRecommendation(db);
    } catch (e: any) {
      return reportError(e);
    }
  };

export const internalSetUserRecommendation = (
    db: admin.firestore.Firestore) => {
  return db.runTransaction(async (t) => {
    const users = await db.collection("users").listDocuments();
    // TODO: use algolia...
    await Promise.all(users.map(async (e) => {
      const preferences = await t.get(db.collection("preferences")
          // .withConverter(converter<langame.protobuf.UserPreference>())
          .doc(e.id));
      if (
        // eslint-disable-next-line max-len
        !langame.protobuf.UserPreference.RecommendationType[langame.protobuf.UserPreference.RecommendationType.COMPOUND].includes(preferences.data()?.userRecommendations) ||
        // eslint-disable-next-line max-len
        langame.protobuf.UserPreference.RecommendationType[langame.protobuf.UserPreference.RecommendationType.ALL].includes(preferences.data()?.userRecommendations)
      ) {
        // eslint-disable-next-line max-len
        console.log(langame.protobuf.UserPreference.RecommendationType[langame.protobuf.UserPreference.RecommendationType.COMPOUND]);
        return Promise.resolve();
        // TODO: new is not implemented yet
      }
      const p =
        await t.get(db.collectionGroup("players")
            .where("userId", "==", e.id));
      if (p.empty) return Promise.resolve();
      let siblings = (await Promise.all(p.docs.map((u) =>
        u.ref.parent.parent!.collection("players").listDocuments())))
      // Flatten
          .reduce((acc, val) => acc.concat(val), []).map((e) => e.id);
      const messagesToMe = await db.collection("messages")
          .withConverter(converter<langame.protobuf.Message>())
          .where("toUid", "==", e.id).get();
      const messagesFromMe = await db.collection("messages")
          .withConverter(converter<langame.protobuf.Message>())
          .where("fromUid", "==", e.id).get();
      siblings = siblings.concat(
          messagesToMe.docs.map((e) => e.data().fromUid));
      siblings = siblings.concat(
          messagesFromMe.docs.map((e) => e.data().toUid));
      if (siblings.length === 0) return Promise.resolve();
      // Distinct values
      // @ts-ignore
      const uniqueSiblings = [...new Set(
          siblings
          // Ignore self
              .filter((u) => u !== e.id)
              .map((e) => e))];
      if (uniqueSiblings.length === 0) return Promise.resolve();
      return t.set(db.collection("recommendations").doc(e.id), {
        // TODO: give fitness recommendation
        //  (say, nb of messages, depend on goal)
        users: admin.firestore.FieldValue.arrayUnion(...uniqueSiblings),
      });
    }));
  });
};
