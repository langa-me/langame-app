import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError, reportError} from "../errors";
import {algoliaPrefix} from "../helpers";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";
import {shouldDrop} from "../utils/contexts";
import {setRecommendations} from "./recommendations";

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
      // Ignore bots
      !change.after.data()!.bot &&
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

