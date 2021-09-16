
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

import {reportError} from "../errors";
import {ImplAiApi} from "../aiApi/implAiApi";
import {isDev} from "../helpers";


/**
   * @param{admin.firestore.QueryDocumentSnapshot} s
   * @param{functions.EventContext} context
   */
export const onDeleteMeme = async (s: admin.firestore.QueryDocumentSnapshot,
    context: functions.EventContext) => {
  try {
    if (isDev) return;
    const api = new ImplAiApi();
    await api.getIndex("prod_memes").deleteObject(
        s.id,
    );
    // TODO: delete topic if disappeared
    functions.logger.log("deleted", s.id);
  } catch (e) {
    return reportError(e, {user: context.params.userId});
  }
};
