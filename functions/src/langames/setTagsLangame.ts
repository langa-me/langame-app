import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {reportError} from "../errors";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";

const MINUTES_THRESHOLD_TO_CONSIDER_INACTIVE = 24 * 60;

export const setTagsLangame =
  async (ctx: functions.EventContext) => {
    functions.logger.log(ctx);
    try {
      const db = admin.firestore();
      const langameSnap = await db
          .collection("langames")
          .withConverter(converter<langame.protobuf.ILangame>())
          .get();
      // [langameId]: {langame, messages}
      const langamesMap: {
        [id: string]: {
          langame: admin.firestore.QueryDocumentSnapshot<
            langame.protobuf.ILangame>,
          messages: admin.firestore.QuerySnapshot<langame.protobuf.IMessage>,
        }
      } = {};
      await Promise.all(
          langameSnap.docs.map(async (langame) => {
            langamesMap[langame.id] = {
              messages: await db.collection("messages")
                  .where("langameId", "==", langame.id)
                  .orderBy("createdAt", "desc")
                  .get(),
              langame: langame,
            };
          }));

      // get langames where there haven't had a message in the last X minutes
      return Promise.all(
          Object.values(langamesMap).map(({langame, messages}) => {
            if (messages.empty) return;
            const lastMessage = messages.docs[0];
            let inactive = false;

            if (lastMessage &&
            Date.now() - lastMessage.createTime.toDate().getTime() >
            MINUTES_THRESHOLD_TO_CONSIDER_INACTIVE * 60 * 1000) {
              inactive = true;
            }
            // TODO: degree of inactiveness? stale? delete langame?
            return db.runTransaction(async (transaction) => {
              return transaction.update(langame.ref, {
                tags: admin.firestore.FieldValue.arrayUnion(
                inactive ? "inactive" : "active"),
              });
            });
          }));
    } catch (e: any) {
      await reportError(e, {});
      return Promise.reject(e);
    }
  };
