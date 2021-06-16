import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {groupBy, kTagsCollection} from "./helpers";
import {converter} from "./utils/firestore";
import {langame} from "./langame/protobuf/langame";
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
        .limit(100) // Maximum 100 tags
        .get();

    // const tagDocsScored = await tagDocs.query
    //     .orderBy("aggregatedFeedback.general.score", "desc")
    //     .orderBy("aggregatedFeedback.relevance.score", "desc")
    //     .get();

    // TODO: should still randomly pick an unfamous meme sometimes

    // Getting the parent Meme DISTINCTLY
    const grouped = groupBy(
        await Promise.all(tagDocs.docs.map((e) => e.ref.parent
            .parent!.withConverter(converter<langame.protobuf.Meme>())
            .get())), (e) => e.id);
    // TODO: is the group by actually properly grouping
    // in a multi topic context?
    const ret = shuffle([...grouped.values()].map((e) => e[0])).slice(0, limit);
    return ret;
  };

