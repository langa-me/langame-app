import * as functions from "firebase-functions";
import {Question} from "./models";
import * as admin from "firebase-admin";
import {kQuestionsCollection, kTagsCollection} from "./helpers";
import {firestore} from "firebase-admin/lib/firestore";
import QuerySnapshot = firestore.QuerySnapshot;
const fetch = require("node-fetch");

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
    async (tags: Array<string>, limit: number,
        minimumThreshold: number,
        generated: boolean):
        Promise<Question[]> => {
      tags = tags.map((t) => t.toLowerCase());
      // Filter questions with highest scores for these tags
      let documents: QuerySnapshot;
      if (generated) {
        documents = await admin
            .firestore()
            .collection(kTagsCollection)
            .where("generated", "==", true)
            .where("content", "in", tags)
            .limit(limit)
            .get();
      } else {
        // TODO should aggregate/whatever u call it score in topic
        documents = await admin
            .firestore()
            .collection(kTagsCollection)
            .orderBy("score", "desc")
            .where("score", ">", minimumThreshold)
            .where("content", "in", tags)
            .limit(limit)
            .get();
      }

      const questions = [];
      for (const d of documents.docs) {
        const q = await admin
            .firestore()
            .collection(kQuestionsCollection)
            .doc(d.data().question)
            .get();
        questions.push(q.data() as Question);
      }
      return questions;
    };

/**
 * Online question generation
 * @param tag
 * @param remoteConfig
 */
// eslint-disable-next-line max-len
export const onlineOpenAiQuestionGeneration = async (tag: string, remoteConfig: any): Promise<Question[] | undefined> => {
  // Filtering out cases where config is invalid
  // TODO: check default value etc, something typed
  if (!("openai_model" in remoteConfig) ||
        !("openai_temperature" in remoteConfig) ||
        !("openai_max_tokens" in remoteConfig) ||
        !("openai_top_p" in remoteConfig) ||
        !("openai_frequency_penalty" in remoteConfig) ||
        !("openai_presence_penalty" in remoteConfig)) {
    return undefined;
  }
  return fetch(`https://api.openai.com/v1/engines/${remoteConfig.openai_model}/completions`, {
    method: "post",
    body: JSON.stringify({
      // eslint-disable-next-line max-len
      "prompt": `What are the hottest questions in ${tag} nowadays?\n1.`,
      "temperature": remoteConfig.temperature.defaultValue.value,
      // eslint-disable-next-line max-len
      "max_tokens": remoteConfig.max_tokens.defaultValue.value, // One token ~4 characters, one average question should be ~40 characters = 10 tokens
      "top_p": remoteConfig.top_p.defaultValue.value,
      "frequency_penalty": remoteConfig.frequency_penalty.defaultValue.value,
      "presence_penalty": remoteConfig.presence_penalty.defaultValue.value,
    }),
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${openAiKey}`,
    },
  }).then((res: any) => res.json())
      .then((res: any) => {
        // Invalid response structure or crappy response from OpenAI
        if (!("choices" in res) ||
            !Array.isArray(res.choices) ||
              res.choices.length === 0 ||
              !res.choices[0].text.includes("?")) {
          return undefined;
          // TODO: might retry on bad OpenAI text (i.e. recursive thing)
        }
        const questionFound = res.choices[0].text.split("?");
        return [new Question(questionFound[0]+"?")];
      })
      .catch((e: any) => {
        functions.logger.error("failed to findQuestionInOpenAI", e);
        return undefined;
      });
};
