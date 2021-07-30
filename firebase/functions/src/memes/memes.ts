import * as functions from "firebase-functions";
import {shuffle} from "../utils/array";
import {ImplAiApi} from "../aiApi/implAiApi";

export const openAiKey = functions.config().openai.key;

export interface AlgoliaMeme {
    objectID: string;
    content: string;
    tags: string[];
    translated: any;
}

/**
 * offlineMemeSearch Find memes in topic ordered by score, filtering
 * low scores
 * @param{Array<string>} topics
 * @param{number} limit number of questions
 * @param{string[]} objectIDsFilteredOut
 */
export const offlineMemeSearch =
    async (
        topics: Array<string>,
        limit: number,
        objectIDsFilteredOut: string[],
    ):
        Promise<AlgoliaMeme[]> => {
      topics = topics.map((t) => t.toLowerCase());
      // eslint-disable-next-line max-len
      functions.logger.log(`searching meme ${topics.join(",")}, limit: ${limit}, filters:${objectIDsFilteredOut}`);

      const api = new ImplAiApi();
      const res: AlgoliaMeme[] = [];
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
      for (const topic of topics) {
        const r = await api.getIndex("prod_memes")
            .search(topic, reqOptions);
        r.hits.forEach((e) => {
          // @ts-ignore
          res.push({content: e.content,
            // @ts-ignore
            tags: e.tags,
            objectID:
            e.objectID,
            // @ts-ignore
            translated: e.translated});
        });
      }
      return shuffle(res).slice(0, limit);
    };

