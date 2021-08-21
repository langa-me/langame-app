import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {kLangamesCollection} from "./helpers";
import {converter} from "./utils/firestore";
import {langame} from "./langame/protobuf/langame";
import {reportError} from "./errors";
import {ImplAiApi} from "./aiApi/implAiApi";

export const setLangamesDone =
  async (_: functions.EventContext) => {
    const db = admin.firestore();
    const HOUR = 4 * 1000 * 60 * 60;
    const anHourAgo = new Date(Date.now() - HOUR);
    try {
      return db.runTransaction(async (t) => {
        const langamesOlderThanOneHourAgo = await t.get(db
            .collection(kLangamesCollection)
            .where("date",
                "<",
                admin.firestore.Timestamp.fromDate(anHourAgo))
            .withConverter(converter<langame.protobuf.Langame>()));

        // TODO: filter done above instead
        for (const doc of langamesOlderThanOneHourAgo.docs
            .filter((e) => !e.data().done)) {
          t.update(doc.ref, {
            done: admin.firestore.FieldValue.serverTimestamp(),
          });
          // eslint-disable-next-line max-len
          functions.logger.info("langame is empty for too long, setting done", doc.data());
          const players = await doc.ref.collection("players").listDocuments();
          const api = new ImplAiApi();
          const index = process.env.GCLOUD_PROJECT?.includes("dev") ?
            "dev_users" :
            "prod_users";
          // eslint-disable-next-line max-len
          // TODO: should only add recent interactions up to 10 days or something
          return api.getIndex(index).saveObjects(players.map((e) => {
            return {
              recentInteractions: {
                _operation: "AddUnique",
                value: players.filter((o) => e.id !== o.id),
              },
              objectID: e.id,
            };
          }));
        }
        return Promise.resolve();
      });
    } catch (e) {
      return reportError(e);
    }
  };
