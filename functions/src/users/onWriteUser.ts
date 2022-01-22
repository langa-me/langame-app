import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError, reportError} from "../errors";
import {algoliaPrefix, isEmulator} from "../helpers";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";
import {shouldDrop} from "../utils/contexts";
import {setRecommendations} from "./recommendations";
import {SearchIndex} from "algoliasearch";
import {generateTag} from "./tag";

export const onWriteUser = async (
    change: Change<admin.firestore.DocumentSnapshot<langame.protobuf.IUser>>,
    ctx: EventContext) => {
  const api = new ImplAiApi();
  try {
    functions.logger.log(ctx);

    let i: SearchIndex | undefined = undefined;
    if (!isEmulator) {
      i = api.getIndex(algoliaPrefix + "users");
      if (!change.after.exists) {
        await i.deleteObject(change.after.id);
        return;
      }
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

    // If user has no tag, generate one
    let tag = change.after.data()!.tag;
    if (!tag) {
      functions.logger.log("user has no tag, generating one");
      tag = await generateTag({maxTries: 10});
      if (!tag) {
        throw new Error(`failed to generated tag for ${change.after.id}`);
      }
      functions.logger.log("generated tag", tag);
      await db.runTransaction(async (transaction) => {
        return transaction.set(change.after.ref, {
          tag: tag,
        }, {merge: true});
      });
    }
    functions.logger.log("synchronizing user to algolia", change.after.data());

    if (i) {
      await i.saveObject({
        ...change.after.data(),
        objectID: change.after.id,
        _tags: [tag],
        favoriteTopics: prefDoc.data()?.favoriteTopics || [],
      });
    }

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

