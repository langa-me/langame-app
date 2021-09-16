import {EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import * as admin from "firebase-admin";
import {reportError} from "../errors";
import {ImplAiApi} from "../aiApi/implAiApi";
import * as functions from "firebase-functions";
import {isDev} from "../helpers";

/**
 *
 * @param{QueryDocumentSnapshot} snap
 * @param{EventContext} _
 */
export const onCreateMeme = async (
    snap: QueryDocumentSnapshot,
    _: EventContext
) => {
  try {
    if (isDev) return;
    if (!snap.data()) return;
    const api = new ImplAiApi();
    let topics = snap.data().topics;
    let label = await api.openAITopicClassify(snap.data().content, {});
    if (label) {
      label = label.toLowerCase();
      topics.push(label);
      // Unique topics
      topics = Array.from(new Set(topics));
      if (topics === snap.data()!.topics) return;
      await snap.ref.update({
        topics: topics,
      });
      functions.logger.log("new label detected for", snap.id, label);
    }
    // TODO: only update if it's new
    await Promise.all(topics.map((t: string) =>
      admin.firestore().collection("topics").doc(t).set({})));

    // TODO: sentence similarity -> delete
  } catch (e: any) {
    await reportError(e, {});
  }
};
