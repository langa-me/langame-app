import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {kQuestionsCollection, kTagsCollection} from "./helpers";
import {firestore} from "firebase-admin/lib/firestore";
import QuerySnapshot = firestore.QuerySnapshot;
import {converter} from "./utils/firestore";
import {langame} from "./langame/protobuf/langame.gen";

export const openAiKey = functions.config().openai.key;

/**
 * findQuestionsInTopics Find questions in topic ordered by score, filtering
 * low scores
 * @param{Array<string>} tags
 * @param{number} limit number of questions
 * @param{number} minimumThreshold minimum score for non-generated questions
 * @param{boolean} generated whether to use only generated questions
 */
export const offlineQuestionSearch =
    async (tags: Array<string>,
        limit: number,
        minimumThreshold: number,
        generated: boolean):
        Promise<langame.protobuf.Question[]> => {
      tags = tags.map((t) => t.toLowerCase());
      // Filter questions with highest scores for these tags
      let tagDocs: QuerySnapshot<langame.protobuf.Tag>;
      if (generated) {
        tagDocs = await admin
            .firestore()
            .collection(kTagsCollection)
            .where("generated", "==", true)
            .where("content", "in", tags)
            .withConverter(converter<langame.protobuf.Tag>())
            .limit(limit)
            .get();
      } else {
        // TODO should aggregate/whatever u call it score in topic
        tagDocs = await admin
            .firestore()
            .collection(kTagsCollection)
            .orderBy("score", "desc")
            .where("score", ">", minimumThreshold)
            .where("content", "in", tags)
            .withConverter(converter<langame.protobuf.Tag>())
            .limit(limit)
            .get();
      }

      const questions: langame.protobuf.Question[] = [];
      for (const t of tagDocs.docs) {
        const q = await admin
            .firestore()
            .collection(kQuestionsCollection)
            .doc(t.data().question)
            .withConverter(converter<langame.protobuf.Question>())
            .get();
        if (t.data()) questions.push(q.data()!);
      }
      return questions;
    };

