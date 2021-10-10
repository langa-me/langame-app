import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError} from "../errors";
import {isDev} from "../helpers";

export const onWriteUser = async (
    change: Change<admin.firestore.DocumentSnapshot>,
    ctx: EventContext) => {
  const api = new ImplAiApi();
  try {
    functions.logger.log("onWriteUser", change.after.id);

    const i = api.getIndex(isDev ?
      "dev_users" :
      "prod_users");
    if (!change.after.exists) {
      await i.deleteObject(change.after.id);
      return;
    }

    // TODO: might tag user with topics?

    return await i.saveObject({
      ...change.after.data(),
      objectID: change.after.id,
      _tags: [change.after.data()!.tag],
    });
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref.parent.parent, {developerMessage: e}));
    return Promise.reject(e);
  }
};
