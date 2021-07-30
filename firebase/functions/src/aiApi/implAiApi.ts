import {
  algoliaId, algoliaKey, Api, ContentFilter,
  huggingfaceKey, openAiKey,
} from "./aiApi";
import algoliasearch, {SearchClient, SearchIndex} from "algoliasearch";

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

const openAiEndpoint = "https://api.openai.com/v1/engines";
const huggingfaceEndpoint = "https://api-inference.huggingface.co/models";

/**
 */
export class ImplAiApi implements Api {
    private algolia: SearchClient;
    private indexes: Map<string, SearchIndex> = new Map();

    /**
     * Initialize the AI API
     */
    constructor() {
      this.algolia = algoliasearch(algoliaId, algoliaKey);
      this.indexes.set("dev_users", this.algolia.initIndex("dev_users"));
      this.indexes.set("prod_users", this.algolia.initIndex("prod_users"));
      this.indexes.set("dev_memes", this.algolia.initIndex("dev_memes"));
      this.indexes.set("prod_memes", this.algolia.initIndex("prod_memes"));
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
     * @param{boolean} skipWhenFinishReasonIsLength
     * @param{any} parameters
     */
    async completion(prompt: string,
        skipWhenFinishReasonIsLength: boolean,
        parameters: any): Promise<string | undefined> {
      const r =
          await fetch(`${openAiEndpoint}/${parameters.model}/completions`, {
            method: "POST",
            body: JSON.stringify({
              "prompt": prompt.trim(),
              "temperature": parameters.temperature,
              "max_tokens": parameters.maxTokens,
              "top_p": parameters.topP,
              "frequency_penalty": parameters.frequencyPenalty,
              "presence_penalty": parameters.presencePenalty,
              "stop": parameters.stop,
              "stream": false,
            }),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": `Bearer ${openAiKey}`,
            },
          });
      const data = await r.json();
      if (data.error) throw new Error(data.error);
      if (!data.choices ||
          data.choices.length === 0 ||
          (skipWhenFinishReasonIsLength &&
          data.choices[0].finish_reason === "length")) return undefined;
      return data.choices[0].text;
    }

    /**
     * Stream OpenAI completion
     * @param{string} prompt
     * @param{any} parameters
     */
    async* streamCompletion(prompt: string,
        parameters: any): any {
      const r =
          await fetch(`${openAiEndpoint}/${parameters.model}/completions`, {
            method: "POST",
            body: JSON.stringify({
              "prompt": prompt,
              "temperature": parameters.temperature,
              "max_tokens": parameters.maxTokens,
              "top_p": parameters.topP,
              "frequency_penalty": parameters.frequencyPenalty,
              "presence_penalty": parameters.presencePenalty,
              "stop": parameters.stop,
              "stream": true,
            }),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": `Bearer ${openAiKey}`,
            },
          });
      for await (const chunk of r.body) {
        if (chunk.toString().includes("DONE")) return;
        yield JSON.parse(chunk.toString()
            .replace("data: ", "")).choices[0].text;
      }
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
                "Authorization": `Bearer ${openAiKey}`,
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
            headers: {Authorization: `Bearer ${huggingfaceKey}`},
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
}
