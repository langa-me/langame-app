import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {kTagsCollection} from "./helpers";
import {converter} from "./utils/firestore";
import {langame} from "./langame/protobuf/langame.gen";
import {shuffle} from "./utils/array";

export const openAiKey = functions.config().openai.key;

/**
 * offlineMemeSearch Find memes in topic ordered by score, filtering
 * low scores
 * @param{Array<string>} topics
 * @param{number} limit number of questions
 * @param{number} minimumThreshold minimum score for non-generated questions
 */
export const offlineMemeSearch =
  async (topics: Array<string>,
      limit: number):
    Promise<admin.firestore.DocumentSnapshot<langame.protobuf.Meme>[]> => {
    topics = topics.map((t) => t.toLowerCase());
    // Filter memes with highest scores for these topics
    const tagDocs = await admin
        .firestore()
        .collectionGroup(kTagsCollection)
        .where("topic.content", "in", topics)
        .withConverter(converter<langame.protobuf.Tag>())
        .limit(limit)
        .get();


    const r = await Promise.all(tagDocs.docs.map((e) => e.ref.parent
        .parent!.withConverter(converter<langame.protobuf.Meme>())
        .get()));
    return shuffle(r);
  };

