import {SearchIndex} from "algoliasearch";
import * as functions from "firebase-functions";
import {langame} from "../langame/protobuf/langame";
export const openAiKey = () => functions.config().openai?.key;
export const huggingfaceKey = () => functions.config().huggingface?.key;
export const algoliaId = () => functions.config().algolia?.application.id;
export const algoliaKey = () => functions.config().algolia?.key;


/**
 * @interface OpenaiCompletionParameters
 * @member {string} prompt is used to generate completions,
 * encoded as a string, a list of strings, or a list of token lists.
 * Note that <|endoftext|> is the document separator
 * that the model sees during training, so if a prompt
 * is not specified the model will generate as if from
 * the beginning of a new document.
 * @member {number} temperature What sampling temperature to use.
 * Higher values means the model will take more risks.
 * Try 0.9 for more creative applications, and 0 (argmax sampling)
 * for ones with a well-defined answer.
 * We generally recommend altering this or top_p but not both.
 * @member {number} maxTokens The maximum number of tokens
 * to generate in the completion.
 * The token count of your prompt plus max_tokens cannot
 * exceed the model's context length. Most models have a context
 * length of 2048 tokens (except davinci-codex, which supports 4096).
 * @member {number} top_p An alternative to sampling with temperature,
 * called nucleus sampling, where the model considers the results
 * of the tokens with top_p probability mass. So 0.1 means only
 * the tokens comprising the top 10% probability mass are considered.
 * We generally recommend altering this or temperature but not both.
 * @member {number} frequencyPenalty Number between -2.0 and 2.0.
 * Positive values penalize new tokens based on their existing
 * frequency in the text so far, decreasing the model's
 * likelihood to repeat the same line verbatim
 * @member {number} presencePenalty Number between -2.0 and 2.0.
 * Positive values penalize new tokens based on whether they appear
 * in the text so far, increasing the model's likelihood to
 * talk about new topics.
 * @member {number} stream Whether to stream back partial progress.
 * If set, tokens will be sent as data-only server-sent events as
 * they become available, with the stream terminated by a data: [DONE] message
 * @member {number} stop Up to 4 sequences where the API will stop generating
 * further tokens. The returned text will not contain the stop sequence.
 */
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

