import {FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode} from "./models";
import {kInteractionsCollection,
  kInvalidRequest,
  kLangamesCollection,
  kNotAuthenticated} from "./helpers";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {https} from "firebase-functions";
import {firestore} from "firebase-admin/lib/firestore";
import DocumentData = firestore.DocumentData;

export const sendLangameEnd = async (data: any,
    context: https.CallableContext) => {
  if (!context.auth) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
        undefined,
        kNotAuthenticated,
    );
  }
  if (!data) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kInvalidRequest,
    );
  }
  if (!data.channelName) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "you must provide a valid channel name",
    );
  }

  const db = admin.firestore();

  let langame: DocumentData;
  const lgQueryResult = db
      .collection(kLangamesCollection)
      .where("channelName", "==", data.channelName);
  try {
    langame = await db.runTransaction(async (t) => {
      const innerLg = await t.get(lgQueryResult);
      if (innerLg.empty) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            "could not find this channel",
        );
      }
      const innerLgData = innerLg.docs[0].data();
      const lgRef = db
          .collection(kLangamesCollection)
          .doc(innerLg.docs[0].id);
      // TODO: might increase interaction by length of langame
      await t.update(lgRef, {
        lefts: admin.firestore.FieldValue.arrayUnion(context.auth!.uid),
      });

      // Everybody left, clean-up, TODO: might save statistics somewhere maybe
      if (innerLgData.lefts.length + 1 -
          innerLgData.players.length === 0) {
        await t.delete(lgRef);
        functions.logger
            .info("langame", innerLgData.channelName, "is over, deleted it");
      }
      return innerLgData;
    });
  } catch (e) {
    functions.logger.error("sendLangameEnd, langame write error, err", e);
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "langame_write_error",
    );
  }

  // failed
  if ("statusCode" in langame) return langame;

  if (langame.lefts.includes(context.auth!.uid)) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "you already sent langame end",
    );
  }

  functions.logger.info("updating interactions for user",
          context.auth!.uid);

  // Difference between 2 arrays, i.e. which players didn't leave yet
  // and remove self
  const stillPlaying = langame.players.filter((p: any) =>
    p.langameUid !== context.auth!.uid && // Not self
              !langame.lefts.includes(p.langameUid)); // And still playing


  return db.runTransaction(async (t) => {
    // Update interactions with all users still playing
    // (those who have left already done that with current one)
    for (const e of stillPlaying) {
      let intRef = db
          .collection(kInteractionsCollection)
          // Yes, array in key because
          // firestore doesn't support "array-contains-all"
          .where("users", "==", `${context.auth!.uid},${e.langameUid}`);


      let i = await t.get(intRef);

      if (!i.docs.some((d) => d.exists)) {
        intRef = admin
            .firestore()
            .collection(kInteractionsCollection)
            .where("users", "==", `${e.langameUid},${context.auth!.uid}`);
        i = await t.get(intRef);
      }

      // TODO: might increase interaction by length of langame
      // TODO use try-catch & stuff in case it fail to send proper response?
      if (i.docs.some((d) => d.exists)) {
        const intRef = db
            .collection(kInteractionsCollection)
            .doc(i.docs[0].id);
        await t.update(intRef, {
          interactions: admin.firestore.FieldValue.increment(1),
        });

        functions.logger
            .info("updating interaction with",
                e.langameUid,
                "interactions",
                i.docs.map((e) => e.data()),
            );
      } else {
        const intRef = db
            .collection(kInteractionsCollection).doc();
        t.create(intRef, {
          users: `${context.auth!.uid},${e.langameUid}`,
          interactions: admin.firestore.FieldValue.increment(1),
        });
        functions.logger
            .info("creating new interaction with", e.langameUid);
      }
    }
  }).then(() => new FirebaseFunctionsResponse(
      FirebaseFunctionsResponseStatusCode.OK,
      undefined,
      undefined,
  )).catch((e) => {
    functions.logger
        .error("sendLangameEnd error, failed to write interactions, err", e);
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "send_langame_end_internal",
    );
  });
};
