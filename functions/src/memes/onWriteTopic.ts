import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError} from "../errors";
import {algoliaPrefix} from "../helpers";

export const onWriteTopic = async (
    change: Change<admin.firestore.DocumentSnapshot>,
    ctx: EventContext) => {
  const api = new ImplAiApi();
  try {
    functions.logger.log("onWriteTopic", change.after);
    const i = api.getIndex(algoliaPrefix+"topics");
    if (!change.after.exists) {
      await i.deleteObject(change.after.id);
      return;
    }

    await i.saveObject({objectID: change.after.id},
    );
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref.parent.parent, {developerMessage: e}));
  }
};
