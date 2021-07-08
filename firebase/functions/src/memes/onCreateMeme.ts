import {EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import * as admin from "firebase-admin";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {reportError} from "../errors";
import {classifyTag} from "./utils";

/**
 *
 * @param{QueryDocumentSnapshot} snap
 * @param{EventContext} _
 */
export const onCreateMeme = async (
    snap: QueryDocumentSnapshot,
    _: EventContext
) => {
  let m: admin.firestore.DocumentSnapshot<langame.protobuf.Meme>;
  try {
    m =
      await snap.ref.withConverter(converter<langame.protobuf.Meme>()).get();
    if (!m.data()) {
      await reportError(new Error("empty meme"), {});
      return;
    }
    await classifyTag(m);
    // eslint-disable-next-line max-len
    // functions.logger.log(`new tags for meme ${m.id}:${tags.map((e) => e.id).join(",")}`);
    // TODO: sentence similarity -> delete
  } catch (e) {
    await reportError(e, {});
  }
};
