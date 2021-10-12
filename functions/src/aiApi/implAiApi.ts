import {
  algoliaId, algoliaKey, Api, ContentFilter,
  huggingfaceKey, openAiKey,
} from "./aiApi";
import algoliasearch, {SearchClient, SearchIndex} from "algoliasearch";
import {sleep} from "../utils/time";
import {Translate} from "@google-cloud/translate/build/src/v2";

// eslint-disable-next-line @typescript-eslint/no-var-requires
const fetch = require("node-fetch");

export const defaultCompletionParameters = {
  model: "davinci",
  temperature: 0.7,
  maxTokens: 500,
  topP: 1,
  frequencyPenalty: 0,
  presencePenalty: 0,
  stop: ["\n"],
};


export const openAIClassifierFiles = {
  first: {
    description: "classification-topic-endpoint-0.0.1.jsonl",
    file: "file-rV9rZbiiziXLfjqc4MKLLChy",
  },
};

const openAiEndpoint = "https://api.openai.com/v1";
const huggingfaceEndpoint = "https://api-inference.huggingface.co/models";
const isFineTunedModel =
  (model: string) => !["babbage", "ada", "curie", "davinci"].includes(model);


/**
 */
export class ImplAiApi implements Api {
    private algolia: SearchClient;
    private indexes: Map<string, SearchIndex> = new Map();
    private readonly keyFileName?: string;
    private translateClient: Translate;

    /**
     * Initialize the AI API
     * @param{string | undefined} keyFileName set a keyFileName,
     * necessary if using authenticated calls such as detectLanguage
     */
    constructor(keyFileName?: string) {
      this.algolia = algoliasearch(algoliaId(), algoliaKey());
      this.indexes.set("dev_users", this.algolia.initIndex("dev_users"));
      this.indexes.set("prod_users", this.algolia.initIndex("prod_users"));
      this.indexes.set("dev_memes", this.algolia.initIndex("dev_memes"));
      this.indexes.set("prod_memes", this.algolia.initIndex("prod_memes"));
      this.indexes.set("dev_topics", this.algolia.initIndex("dev_topics"));
      this.indexes.set("prod_topics", this.algolia.initIndex("prod_topics"));
      this.translateClient = this.keyFileName ?
        new Translate({keyFilename: this.keyFileName}) :
        new Translate();
    }


    /**
     *
     * @param{string} indexName
     * @param{{object: any, id: string}[]} objects
     * @return{Promise}
     */
    save(indexName: string,
        objects: {object: any, id: string}[]): Promise<any> {
      const i = this.indexes.get(indexName);
      if (!i) throw new Error("invalid index");
      // @ts-ignore
      return i.saveObjects(objects.map((e) => {
        return {
          ...e.object,
          objectID: e.id,
        };
      }));
    }


    /**
     *
     * @param{string} indexName
     * @return{Promise}
     */
    getIndex(indexName: string): SearchIndex {
      const i = this.indexes.get(indexName);
      if (!i) throw new Error("invalid index");
      return i;
    }

    /**
     * Async completion
     * @param{string} prompt
     * @param{any} parameters
     */
    async completion(prompt: string,
        parameters: any): Promise<string | undefined> {
      let url = `${openAiEndpoint}/engines/${parameters.model}/completions`;
      const body: any = {
        prompt: prompt,
        temperature: parameters.temperature,
        max_tokens: parameters.maxTokens,
        top_p: parameters.topP,
        frequency_penalty: parameters.frequencyPenalty,
        presence_penalty: parameters.presencePenalty,
        stream: false,
      };
      // OpenAI API does not like [] for stop
      if (parameters.stop) {
        body.stop = parameters.stop;
      }
      if (isFineTunedModel(parameters.model!)) {
        body.model = parameters.model;
        url = `${openAiEndpoint}/completions`;
      }
      const r =
          await fetch(url, {
            method: "POST",
            body: JSON.stringify(body),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": `Bearer ${openAiKey()}`,
              "OpenAI-Organization": "org-KwcHNgfGe4pqdKDLQIJt99UZ",
            },
          });
      const data = await r.json();
      if (data.error &&
            // Fine-tuned models have a cold start
            // {"code":null,"message":"That model is still being loaded.
            // Please try again shortly.","param":null,"type":"server_error"}
            // And no proper code so need to do ugly string checking
            JSON.stringify(data.error)
                .includes("That model is still being loaded.") &&
            parameters.maxRetriesOnColdStart! > 0
      ) {
        parameters.maxRetriesOnColdStart = parameters.maxRetriesOnColdStart!-1;
        await sleep(1000);
        // When it's cold start, retry using recursion,
        // The exit condition using the maxRetriesOnColdStart
        // argument for compactness
        return await this.completion(prompt, parameters);
        // Unexpected error, propagate to higher levels
      } else if (data.error) {
        throw new Error(JSON.stringify(data.error.message));
      }
      if (!data.choices ||
            data.choices.length === 0 ||
            // OpenAI API returns "finish_reason": "length"
            // When hitting a max length, which typically means
            // shit output.
            // A smarter logic could possibly re-complete from that
            // But it would add a lot of complexity.
            (parameters.skipWhenFinishReasonIsLength &&
              data.choices[0].finish_reason === "length")) return undefined;
      // We trim the output by default, especially for fine-tuned models
      // which are trained to return trailing space on completion
      return data.choices[0].text.trim();
    }

    /**
     * The filter aims to detect generated text that
     * could be sensitive or unsafe coming from the API.
     * It's currently in beta mode and has three ways
     * of classifying text as safe, sensitive, or unsafe.
     * The filter will make mistakes and we have currently
     * built it to err on the side of caution,
     * thus, resulting in higher false positives
     * https://beta.openai.com/docs/engines/content-filter
     * @param{string} content
     * @param{any} parameters
     * @return{Promise<string>}
     */
    async filter(content: string, parameters: any): Promise<ContentFilter> {
      const r =
            // eslint-disable-next-line max-len
            await fetch(`${openAiEndpoint}/content-filter-alpha-c4/completions`, {
              method: "POST",
              body: JSON.stringify({
                "prompt": `<|endoftext|>${content}\n--\nLabel:`,
                "temperature": parameters.temperature ?? 0,
                "max_tokens": parameters.maxTokens ?? 1,
                "top_p": parameters.topP ?? 1,
                "frequency_penalty": parameters.frequencyPenalty ?? 0,
                "presence_penalty": parameters.presencePenalty ?? 0,
                "logprobs": 10,
              }),
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": `Bearer ${openAiKey()}`,
                "OpenAI-Organization": "org-KwcHNgfGe4pqdKDLQIJt99UZ",
              },
            });
      const data = await r.json();
      // eslint-disable-next-line @typescript-eslint/ban-ts-comment
      // @ts-ignore
      return ContentFilter[ContentFilter[Number(data.choices[0].text)]];
    }

    /**
     *
     * @param{string} content
     * @param{string[]} classes
     * @param{boolean} multiLabel
     * @param{number} ignoreBelowThreshold
     */
    async classify(content: string,
        classes: string[],
        multiLabel: boolean,
        ignoreBelowThreshold: number,
    ): Promise<string[]> {
      const response = await fetch(
          `${huggingfaceEndpoint}/facebook/bart-large-mnli`,
          {
            headers: {Authorization: `Bearer ${huggingfaceKey()}`},
            method: "POST",
            body: JSON.stringify({
              inputs: [content],
              parameters: {
                candidate_labels: classes,
                multi_label: multiLabel,
              },
            }),
          }
      );
      const result = await response.json();
      if (result.error) throw new Error(result.error);
      if (!result.labels) return [];
      return result.labels
          .filter((_: string, i: number) =>
            result.scores[i] > ignoreBelowThreshold);
    }


    /**
     * @param{string} content
     * @param{any} parameters
     */
    async openAITopicClassify(
        content: string,
        parameters: any
    ): Promise<string | undefined> {
      try {
        const r =
                await fetch("https://api.openai.com/v1/classifications", {
                  method: "POST",
                  body: JSON.stringify({
                    "file": openAIClassifierFiles.first.file,
                    "query": content,
                    "search_model": "ada",
                    "model": parameters?.classificationModel ?? "curie",
                    "max_examples": parameters?.maxExamples ?? 10,
                  }),
                  headers: {
                    "Content-Type": "application/json",
                    "Accept": "application/json",
                    "Authorization": `Bearer ${openAiKey()}`,
                    "OpenAI-Organization": "org-KwcHNgfGe4pqdKDLQIJt99UZ",
                  },
                });
        const data = await r.json();
        if (data.error &&
                data.error.message
                    // eslint-disable-next-line max-len
                    ?.includes("No similar documents were found in file with ID")) {
          return undefined;
        }
        if (data.error) return undefined;
        if (data.label.toLowerCase() === "unknown") return undefined;
        return data.label;
      } catch (e) {
        return undefined;
      }
    }

    /**
   * TODO
   * @param{string} content
   * @param{string} targetLanguageCode
   * @return{Promise<string | undefined>}
   */
    async translate(
        content: string,
        targetLanguageCode: string
    ): Promise<string | undefined> {
      const [translation] = await this.translateClient.translate(
          content,
          targetLanguageCode,
      );
      return translation;
    }
}
