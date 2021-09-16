import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError} from "../errors";
import {isDev} from "../helpers";

export const onWriteTopic = async (
    change: Change<admin.firestore.DocumentSnapshot>,
    ctx: EventContext) => {
  const api = new ImplAiApi();
  try {
    if (isDev) return;
    functions.logger.log("onWriteTopic", change.after);

    if (ctx.eventType === "google.firestore.document.delete") {
      await api.getIndex("prod_topics").deleteObject(change.after.id);
      return;
    }

    await api.getIndex("prod_topics").saveObject(
        {objectID: change.after.id},
    );
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref.parent.parent, {developerMessage: e}));
  }
};
