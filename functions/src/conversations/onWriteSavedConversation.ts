import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {Change, EventContext} from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError, reportError} from "../errors";
import {algoliaPrefix} from "../helpers";
import {shouldDrop} from "../utils/contexts";


export const onWriteSavedConversation = async (
    change: Change<admin.firestore.DocumentSnapshot<any>>,
    ctx: EventContext) => {
  functions.logger.log(ctx);

  const api = new ImplAiApi();
  if (shouldDrop(ctx) || change.after.data().errors) return;

  try {
    const i = api.getIndex(algoliaPrefix + "saved_conversations");
    if (!change.after.data()) {
      await i?.deleteObject(change.after.id);
      return reportError(new Error(`${change.after.id} has no data`), ctx);
    }


    functions.logger.log("synchronizing conversations to algolia",
        change.after.data());

    return i?.saveObject({
      ...change.after.data(),
      objectID: change.after.id,
    });
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref, {developerMessage: e}));
    return Promise.reject(e);
  }
};

