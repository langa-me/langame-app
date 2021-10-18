import {SearchIndex} from "algoliasearch";
import * as functions from "firebase-functions";
import {langame} from "../langame/protobuf/langame";
export const openAiKey = () => functions.config().openai?.key;
export const huggingfaceKey = () => functions.config().huggingface?.key;
export const algoliaId = () => functions.config().algolia?.application.id;
export const algoliaKey = () => functions.config().algolia?.key;


export interface OpenaiCompletionParameters {
  prompt: string;
  temperature?: number;
  maxTokens?: number;
  topP?: number;
  frequencyPenalty?: number;
  presencePenalty?: number;
  stream?: boolean;
  stop?: string[];
  model?: OpenaiModel | string;
}
export interface OpenaiCompletionOptions {
  maxRetriesOnColdStart?: number;
  skipWhenFinishReasonIsLength?: boolean;
}
export type OpenaiModel = "babbage" | "ada" | "curie" |
  "davinci" | "davinci-codex";
export const isFineTunedModel = (model: string): model is OpenaiModel =>
  (model as OpenaiModel).length === 0;
export interface Api {
  save(indexName: string, objects: { object: any, id: string }[]): Promise<any>;
  getIndex(indexName: string): SearchIndex;
  /**
   *
   * @param prompt
   * @param model OpenaiModel or fine-tuned model name
   * @param parameters
   */
  openaiCompletion(
    parameters: OpenaiCompletionParameters,
    options?: OpenaiCompletionOptions,
  ): Promise<string | undefined>;
  classify(content: string,
    classes: Array<string>,
    multiLabel: boolean,
    ignoreBelowThreshold: number,
  ): Promise<Array<string>>;
  filter(parameters: OpenaiCompletionParameters
  ): Promise<langame.protobuf.ContentFilter | undefined>;
  translate(
    content: string,
    targetLanguageCode: string
  ): Promise<string | undefined>;
  tokenExtraction(
    content: string,
  ): Promise<any | undefined>;
  sentiment(
    content: string,
  ): Promise<any | undefined>;
  hfCompletion(
    content: string,
    parameters: any,
  ): Promise<string | undefined>;
}

