import {
  algoliaId, algoliaKey, Api,
  huggingfaceKey, isFineTunedModel, OpenaiCompletionParameters,
  OpenaiCompletionOptions, openAiKey,
  ConversationalParameters, HuggingFaceCompletionParameters,
} from "./aiApi";
import algoliasearch, {SearchClient, SearchIndex} from "algoliasearch";
import {sleep} from "../utils/time";
import {Translate} from "@google-cloud/translate/build/src/v2";
import {langame} from "../langame/protobuf/langame";
import {converCamelCaseToSnake} from "../utils/object";
import {algoliaPrefix} from "../helpers";

// eslint-disable-next-line @typescript-eslint/no-var-requires
const fetch = require("node-fetch");


export const openAIClassifierFiles = {
  first: {
    description: "classification-topic-endpoint-0.0.1.jsonl",
    file: "file-rV9rZbiiziXLfjqc4MKLLChy",
  },
};

export const openAiEndpoint = "https://api.openai.com/v1";
const huggingfaceEndpoint = "https://api-inference.huggingface.co/models";

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
    const existingIndexes = ["users", "memes", "topics", "langames",
      "saved_conversations"];
    existingIndexes.forEach((indexName) => {
      const i = algoliaPrefix + indexName;
      this.indexes.set(i, this.algolia.initIndex(i));
    });
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
      objects: { object: any, id: string }[]): Promise<any> {
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
   * @param{OpenaiCompletionParameters} parameters
   * @param{OpenaiCompletionOptions} options
   */
  async openaiCompletion(
      parameters: OpenaiCompletionParameters,
      options?: OpenaiCompletionOptions,
  ): Promise<string | undefined> {
    if (!parameters.model) parameters.model = "davinci";
    let url = `${openAiEndpoint}/engines/${parameters.model}/completions`;
    if (parameters.model && isFineTunedModel(parameters.model!)) {
      url = `${openAiEndpoint}/completions`;
    } else if (parameters.model) {
      delete parameters.model;
    }
    const r =
      await fetch(url, {
        method: "POST",
        body: JSON.stringify(
            converCamelCaseToSnake(parameters)
        ),
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
      options?.maxRetriesOnColdStart! > 0
    ) {
      options!.maxRetriesOnColdStart = options!.maxRetriesOnColdStart! - 1;
      await sleep(1000);
      // When it's cold start, retry using recursion,
      // The exit condition using the maxRetriesOnColdStart
      // argument for compactness
      return await this.openaiCompletion(parameters, options);
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
      (options?.skipWhenFinishReasonIsLength &&
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
   * @param{OpenaiCompletionParameters} parameters
   * @return{Promise<string>}
   */
  async filter(parameters: OpenaiCompletionParameters
  ): Promise<langame.protobuf.ContentFilter | undefined> {
    const r =
      // eslint-disable-next-line max-len
      await fetch("https://api.openai.com/v1/engines/content-filter-alpha-c4/completions", {
        method: "POST",
        body: JSON.stringify({
          "prompt": `<|endoftext|>${parameters.prompt}\n--\nLabel:`,
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
    const result = await r.json();
    if (result.error) {
      return undefined;
    }
    if (result.error) throw new Error(result.error);
    return langame.protobuf.ContentFilter[
        // @ts-ignore
        langame.protobuf.ContentFilter[Number(result.choices[0].text)]];
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
            options: {
              wait_for_model: true,
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

  /**
   *
   * @param{string} content
   */
  async tokenExtraction(
      content: string,
  ): Promise<any | undefined> {
    const response = await fetch(
        // eslint-disable-next-line max-len
        `${huggingfaceEndpoint}/elastic/distilbert-base-uncased-finetuned-conll03-english`,
        {
          headers: {Authorization: `Bearer ${huggingfaceKey()}`},
          method: "POST",
          body: JSON.stringify({
            inputs: [content],
            options: {
              wait_for_model: true,
            },
          }),
        }
    );
    const result = await response.json();
    if (result.error) throw new Error(result.error);
    return result.length === 0 ? undefined : result[0];
  }

  /**
   *
   * @param{string} content
   * @return{Promise}
   */
  async sentiment(
      content: string,
  ): Promise<any | undefined> {
    const response = await fetch(
        `${huggingfaceEndpoint}/siebert/sentiment-roberta-large-english`,
        {
          headers: {Authorization: `Bearer ${huggingfaceKey()}`},
          method: "POST",
          body: JSON.stringify({
            inputs: [content],
            options: {
              wait_for_model: true,
            },
          }),
        }
    );
    const result = await response.json();
    if (result.error) throw new Error(result.error);
    return result.length === 0 ? undefined : result[0];
  }

  /**
   *
   * @param{string} content
   * @param{any} parameters see https://api-inference.huggingface.co/docs/python/html/detailed_parameters.html#text-generation-task
   * @return{Promise}
   */
  async huggingFaceCompletion(
      content: string,
      parameters: HuggingFaceCompletionParameters,
  ): Promise<string | undefined> {
    let body = {
      inputs: [content],
      parameters: {
        top_k: parameters.topK || undefined,
        top_p: parameters.topP || undefined,
        temperature: parameters.temperature || 1.1,
        repetition_penalty: parameters.repetitionPenalty || undefined,
        max_new_tokens: parameters.maxNewTokens || undefined,
        max_time_steps: parameters.maxTimeSteps || undefined,
        return_full_text: parameters.returnFullText || false,
        num_return_sequences: parameters.numReturnSequences || 1,
      },
      options: {
        wait_for_model: true,
      },
    };
    // HACK T0 does not take parameters
    if (parameters.model === "bigscience/T0pp") {
      body = {
        // @ts-ignore
        inputs: content,
      };
    }
    const response = await fetch(
        `${huggingfaceEndpoint}/${parameters.model || "bigscience/T0pp"}`,
        {
          headers: {Authorization: `Bearer ${huggingfaceKey()}`},
          method: "POST",
          body: JSON.stringify(body),
        });
    const result = await response.json();
    if (result.error) throw new Error(result.error);
    if (parameters.model === "bigscience/T0pp") {
      return result[0].generated_text;
    }
    return result.length === 0 || result[0].length === 0 ?
      undefined : result[0][0].generated_text;
  }

  // eslint-disable-next-line valid-jsdoc
  /**
   *
   * @param pastUserInputs
   * @param generateResponses
   * @param text
   * @param parameters
   * @returns
   */
  async conversational(
      pastUserInputs: string[],
      generatedResponses: string[],
      text: string,
      parameters?: ConversationalParameters
  ): Promise<string | undefined> {
    const response = await fetch(
        `${huggingfaceEndpoint}/facebook/blenderbot-3B`,
        {
          headers: {Authorization: `Bearer ${huggingfaceKey()}`},
          method: "POST",
          body: JSON.stringify({
            inputs: {
              past_user_inputs: pastUserInputs,
              generated_responses: generatedResponses,
              text,
            },
            parameters: {
              min_length: parameters?.minLength || undefined,
              max_length: parameters?.maxLength || undefined,
              top_k: parameters?.topK || undefined,
              top_p: parameters?.topP || undefined,
              temperature: parameters?.temperature || undefined,
              repetition_penalty: parameters?.repetitionPenalty || undefined,
              max_time: parameters?.maxTime || undefined,
            },
            options: {
              wait_for_model: true,
            },
          }),
        });
    const result = await response.json();
    if (result.error) throw new Error(result.error);
    return result.generated_text;
  }
}
