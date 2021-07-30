import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {reportError} from "./errors";

export const setUserRecommendation =
    async (_: functions.EventContext) => {
      const db = admin.firestore();
      try {
        return internalSetUserRecommendation(db);
      } catch (e) {
        return reportError(e);
      }
    };

export const internalSetUserRecommendation = (
    db: admin.firestore.Firestore) => {
  return db.runTransaction(async (t) => {
    const users = await db.collection("users").listDocuments();
    await Promise.all(users.map(async (e) => {
      const p =
                await t.get(db.collectionGroup("players")
                    .where("userId", "==", e.id));
      if (p.empty) return Promise.resolve();
      const siblings = (await Promise.all(p.docs.map((u) =>
                u.ref.parent.parent!.collection("players").listDocuments())))
      // Flatten
          .reduce((acc, val) => acc.concat(val), []);
      if (siblings.length === 0) return Promise.resolve();
      // Distinct values
      // @ts-ignore
      const uniqueSiblings = [...new Set(
          siblings
              .filter((u) => u.id !== e.id)
              .map((e) => e.id))];
      if (uniqueSiblings.length === 0) return Promise.resolve();
      return t.set(db.collection("recommendations").doc(e.id), {
        users: admin.firestore.FieldValue.arrayUnion(...uniqueSiblings),
      });
    }));
  });
};
