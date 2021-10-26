import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError} from "../errors";
import {algoliaPrefix} from "../helpers";

export const onWriteUser = async (
    change: Change<admin.firestore.DocumentSnapshot>,
    ctx: EventContext) => {
  const api = new ImplAiApi();
  try {
    functions.logger.log(ctx);

    const i = api.getIndex(algoliaPrefix+"users");
    if (!change.after.exists) {
      await i.deleteObject(change.after.id);
      return;
    }

    // TODO: quick hack, make something more maintainable
    // If user has no tag, assign random tag of 7 letters
    let tag = change.after.data()!.tag;
    let tries = 0;
    const maxTries = 10;
    while (!tag && tries < maxTries) {
      tag = Math.random().toString(36).substring(2, 7);
      const result = await i.search("", {
        filters: tag,
      });
      if (result.hits.length === 0) {
        await change.after.ref.set({
          tag: tag,
        }, {
          merge: true,
        });
        break;
      }
      tries++;
    }
    // If couldn't find a tag for him, disable his account
    if (tries >= maxTries) {
      await change.after.ref.update({
        disabled: true,
        disabledReason: "invalid-tag",
      });
    }
    // TODO: might tag user with topics?

    const data = tries > 0 ?
      (await change.after.ref.get()).data()! :
      change.after.data()!;
    return await i.saveObject({
      ...data,
      objectID: change.after.id,
      _tags: [data.tag],
    });
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref.parent.parent, {developerMessage: e}));
    return Promise.reject(e);
  }
};
