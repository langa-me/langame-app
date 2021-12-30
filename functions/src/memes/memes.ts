import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {ImplAiApi} from "../aiApi/implAiApi";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {shuffle} from "../utils/array";
import {algoliaPrefix} from "../helpers";
/**
 * offlineMemeSearch Find memes in topic ordered by score, filtering
 * low scores
 * @param{Array<string>} topics
 * @param{number} limit number of questions
 * @param{string[]} objectIDsFilteredOut
 * @param{boolean} useRandomIfEmpty
 */
export const offlineMemeSearch =
    async (
        topics: Array<string>,
        limit: number,
        objectIDsFilteredOut: string[],
        useRandomIfEmpty: boolean = false
    ):
        Promise<admin.firestore.DocumentSnapshot<langame.protobuf.IMeme>[]> => {
      topics = topics.map((t) => t.toLowerCase());
      if (topics.length === 0) topics = [""];
      // eslint-disable-next-line max-len
      functions.logger.log(`searching meme ${topics.join(",")}, limit: ${limit}, filters:${objectIDsFilteredOut}`);

      const api = new ImplAiApi();
      const reqOptions = {
        filters: "",
        length: limit,
        offset: 0,
      };


      const call = async () => await Promise.all(topics.map(async (e) => {
        reqOptions.filters = e.length > 0 ? `_tags:'${e}'` : "";
        reqOptions.filters += reqOptions.filters.length > 0 ?
          // Yes could do disabled:false but
          // just in case we don't have disabled property
          " AND NOT disabled:true" :
          "NOT disabled:true"; // TODO: now not sure it works
        if (objectIDsFilteredOut.length > 0) {
          reqOptions.filters +=
          (reqOptions.filters.length > 0 ? " AND " : "") +
              objectIDsFilteredOut
                  .map((e) => `NOT objectID:${e}`)
                  .join(" AND ");
        }
        functions.logger.log("searching topic", reqOptions);
        const r = await api.getIndex(algoliaPrefix+"memes")
            .search("", reqOptions);
        return Promise.all(r.hits.map(async (e) =>
          admin.firestore().collection("memes")
              .doc(e.objectID)
              .withConverter(converter<langame.protobuf.IMeme>())
              .get()
        ));
      }));
      let memes = await call();
      if (useRandomIfEmpty && memes.length === 0) {
        topics = [""];
        memes = await call();
      }
      const flattennedAndEnabled = memes.reduce((p, c) => p.concat(c))
          .filter((e) => e.data() && !e.data()!.disabled);


      // flatten array
      return shuffle(flattennedAndEnabled).slice(0, limit);
    };

export const onlineMemeGenerator = async (
    topics: Array<string>,
): Promise<admin.firestore.DocumentSnapshot<
langame.protobuf.IMeme>> => {
  const starterRef = await admin.firestore().collection("memes")
      .withConverter(converter<langame.protobuf.IMeme>())
      .add({
        state: "to-process",
        topics: topics,
        // @ts-ignore
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        disabled: true,
        tweet: false,
      });
  return new Promise<admin.firestore.DocumentSnapshot<
      langame.protobuf.IMeme>>((resolve, reject) =>
        starterRef.onSnapshot((snapshot) => {
          setTimeout(() => reject(new Error("timeout")), 20_000);
          if (snapshot.data()!.state === "processed" &&
                  snapshot.data()!.content) {
            resolve(snapshot);
          } else if (snapshot.data()!.state === "error") {
            reject(new Error(snapshot.data()!.error || "unknown"));
          }
        }));
};
