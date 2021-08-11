import {EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import * as admin from "firebase-admin";
import {reportError} from "../errors";
import {ImplAiApi} from "../aiApi/implAiApi";
import * as functions from "firebase-functions";

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
    if (!snap.data()) return;
    const api = new ImplAiApi();
    let topics = snap.data().topics;
    let label = await api.openAITopicClassify(snap.data().content, {});
    if (label) {
      label = label.toLowerCase();
      topics.push(label);
      // Unique topics
      topics = Array.from(new Set(topics));
      await snap.ref.update({
        topics: topics,
      });
      functions.logger.log("new label detected for", snap.id, label);
    }
    for (const t of topics) {
      await admin.firestore().collection("topics").doc(t).set({});
      await api.getIndex(process.env.GCLOUD_PROJECT?.includes("dev") ?
      "dev_topics" :
      "prod_topics").partialUpdateObject({
        objectID: t,
      }, {
        createIfNotExists: true,
      });
    }
    await api.getIndex(process.env.GCLOUD_PROJECT?.includes("dev") ?
    "dev_memes" :
    "prod_memes").saveObject({
      content: snap.data()!.content,
      objectID: snap.id,
      tags: topics,
    });

    // TODO: sentence similarity -> delete
  } catch (e) {
    await reportError(e, {});
  }
};
