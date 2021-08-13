import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError} from "../errors";

export const onWriteTopic = async (
    change: Change<admin.firestore.DocumentSnapshot>,
    ctx: EventContext) => {
  const api = new ImplAiApi();
  try {
    functions.logger.log("onWriteTopic", change.after);

    if (ctx.eventType === "google.firestore.document.delete") {
      await api.getIndex("prod_topics").deleteObject(change.after.id);
      return;
    }

    await api.getIndex("prod_topics").partialUpdateObject(
        {objectID: change.after.id},
        {
          createIfNotExists: true,
        }
    );
  } catch (e) {
    await Promise.all(handleError(
        change.after.ref.parent.parent, {developerMessage: e}));
  }
};
