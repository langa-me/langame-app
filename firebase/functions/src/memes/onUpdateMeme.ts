import {Change, EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {reportError} from "../errors";
import {ImplAiApi} from "../aiApi/implAiApi";
import * as admin from "firebase-admin";

/**
 *
 * @param{QueryDocumentSnapshot} change
 * @param{EventContext} e
 */
export const onUpdateMeme = async (
    change: Change<QueryDocumentSnapshot>,
    e: EventContext
) => {
  // TODO: should translate etc only when meme is enabled
  try {
    if (!change.after.data() ||
      e.eventType === "google.firestore.document.delete") return;
    const doc = await change.after.ref.get();

    const api = new ImplAiApi();

    await api.getIndex("prod_memes").partialUpdateObject({
      "objectID": change.after.id,
      "disabled": change.after.data().disabled,
      "tags": doc.data()!.topics,
    },
    {
      createIfNotExists: true,
    });
    // TODO: only update if it's new
    await Promise.all(doc.data()!.topics.map((t: string) =>
      admin.firestore().collection("topics").doc(t).set({})));


    // TODO: sentence similarity -> delete
  } catch (e) {
    await reportError(e, {});
  }
};
