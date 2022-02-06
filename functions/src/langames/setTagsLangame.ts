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
          langameSnap.docs
              .filter((e) => e.data() && e.data().errors === undefined)
              .map(async (langame) => {
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
          Object.values(langamesMap).map(({langame, messages}) =>
            tagLangame(db, langame, messages)));
    } catch (e: any) {
      await reportError(e, {});
      return Promise.reject(e);
    }
  };


export const tagLangame = (
    db: admin.firestore.Firestore,
    langame: admin.firestore.QueryDocumentSnapshot<langame.protobuf.ILangame> |
      admin.firestore.DocumentSnapshot<langame.protobuf.ILangame>,
    messages: admin.firestore.QuerySnapshot<langame.protobuf.IMessage>,
): Promise<any> => {
  if (messages.empty) return Promise.resolve();
  const lastMessage = messages.docs[0];
  let tag = "active";

  const isInactive =
      Date.now() - lastMessage.createTime.toDate().getTime() >
      MINUTES_THRESHOLD_TO_CONSIDER_INACTIVE * 60 * 1000;

  if (lastMessage &&
      isInactive &&
      langame.data() &&
      langame.data()!.tags &&
      langame.data()!.tags!.includes("dead") &&
      lastMessage.data() &&
      lastMessage.data().author &&
      lastMessage.data()!.author!.bot === true) {
    // If last message is an announcement
    // of the deadness of the langame
    // set it to to-terminate
    tag = "to-terminate";
  } else if (lastMessage &&
      langame.data() &&
      langame.data()!.tags &&
      langame.data()!.tags!.includes("inactive") &&
      lastMessage.data() &&
      lastMessage.data().author &&
      lastMessage.data()!.author!.bot === true) {
    // If last message is an attempt to revive
    // the conversation by a bot
    // and still no messages have been sent, then the langame is dead
    tag = "dead";
  } else if (lastMessage &&
      isInactive &&
      lastMessage.data() &&
      lastMessage.data().author &&
      lastMessage.data()!.author!.bot === false) {
    tag = "inactive";
  }
  return db.runTransaction(async (transaction) => {
    return transaction.update(langame.ref, {
      // TODO: currently only overwrite everything
      tags: [tag],
    });
  });
};
