import {SearchIndex} from "algoliasearch";
import * as functions from "firebase-functions";
export const openAiKey = functions.config().openai?.key;
export const huggingfaceKey = functions.config().huggingface?.key;
export const algoliaId = functions.config().algolia?.application.id;
export const algoliaKey = functions.config().algolia?.key;
export interface Api {
  save(indexName: string, objects: {object: any, id: string}[]): Promise<any>;
  getIndex(indexName: string): SearchIndex;
  completion(
    prompt: string,
    skipWhenFinishReasonIsLength: boolean,
    parameters: any,
  ): Promise<string | undefined>;
  streamCompletion(
    prompt: string,
    parameters: any,
  ): Iterable<string>;
  classify(content: string,
    classes: Array<string>,
    multiLabel: boolean,
    ignoreBelowThreshold: number,
    ): Promise<Array<string>>;
  filter(content: string, parameters: any): Promise<ContentFilter>;
}

// TODO: protobuf
export enum ContentFilter {
  // eslint-disable-next-line no-unused-vars
  Safe = 0,
  // eslint-disable-next-line no-unused-vars
  Sensitive = 1,
  // eslint-disable-next-line no-unused-vars
  Unsafe = 2,
}
