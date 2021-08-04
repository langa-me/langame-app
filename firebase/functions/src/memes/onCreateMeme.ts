import {EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import * as admin from "firebase-admin";
import {reportError} from "../errors";
import {ImplAiApi} from "../aiApi/implAiApi";

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

    for (const t of snap.data().topics) {
      admin.firestore().collection("topics").doc(t).set({});
      await api.getIndex(process.env.GCLOUD_PROJECT?.includes("dev") ?
      "dev_topics" :
      "prod_topics").saveObject({
        objectID: t,
      });
    }
    await api.getIndex(process.env.GCLOUD_PROJECT?.includes("dev") ?
    "dev_memes" :
    "prod_memes").saveObject({
      content: snap.data()!.content,
      objectID: snap.id,
      tags: [],
    });
    // const tags = await classifyTag(m);
    // eslint-disable-next-line max-len
    // functions.logger.log(`new tags for meme ${m.id}:${tags.map((e) => e.id).join(",")}`);
    // TODO: sentence similarity -> delete
  } catch (e) {
    await reportError(e, {});
  }
};
