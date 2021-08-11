import * as functions from "firebase-functions";
import {shuffle} from "../utils/array";
import {ImplAiApi} from "../aiApi/implAiApi";
import {langame} from "../langame/protobuf/langame";
import * as admin from "firebase-admin";
import {converter} from "../utils/firestore";

export const openAiKey = functions.config().openai.key;


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
        Promise<admin.firestore.DocumentSnapshot<langame.protobuf.Meme>[]> => {
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
      if (objectIDsFilteredOut.length > 0) {
        reqOptions.filters = objectIDsFilteredOut
            .map((e) => `NOT objectID:${e}`)
            .join(" AND ");
      }
      const call = async () => await Promise.all(topics.map(async (e) => {
        const r = await api.getIndex("prod_memes")
            .search(e, reqOptions);
        return Promise.all(r.hits.map(async (e) =>
          admin.firestore().collection("memes")
              .doc(e.objectID)
              .withConverter(converter<langame.protobuf.Meme>())
              .get()
        ));
      }));
      let memes = await call();
      if (useRandomIfEmpty && memes.length === 0) {
        topics = [""];
        memes = await call();
      }

      // flatten array
      return shuffle(memes.reduce((p, c) => p.concat(c))).slice(0, limit);
    };

