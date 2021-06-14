import * as functions from "firebase-functions";
import {openAiKey} from "./memes";
const fetch = require("node-fetch");

const callOpenAiCompletionBase = async (remoteConfig: any, prompt: string) => {
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
  return fetch(`https://api.openai.com/v1/engines/${remoteConfig.openai_model.defaultValue.value}/completions`, {
    method: "post",
    body: JSON.stringify({
      // eslint-disable-next-line max-len
      "prompt": prompt,
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
  });
};

export enum CompletionType {
    // eslint-disable-next-line no-unused-vars
    Question = "question",
    // eslint-disable-next-line no-unused-vars
    About = "about",
}

/**
 * Online completion of different types
 * @param type
 * @param topic
 * @param remoteConfig
 */
// eslint-disable-next-line max-len
export const onlineOpenAiCompletion = async (type: CompletionType,
    topic: string,
    remoteConfig: any):
    Promise<any[] | undefined> => {
  const prompt = type === CompletionType.Question ?
      `What are the hottest questions in ${topic} nowadays?\n1.` :
      `${topic} is about...`;
  return callOpenAiCompletionBase(remoteConfig, prompt)
      .then((res: any) => res.json())
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
        return [{content: questionFound[0]+"?", contexts: []}];
      })
      .catch((e: any) => {
        functions.logger.error("failed to findQuestionInOpenAI", e);
        return undefined;
      });
};
