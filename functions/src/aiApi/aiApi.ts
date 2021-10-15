import {SearchIndex} from "algoliasearch";
import * as functions from "firebase-functions";
import {langame} from "../langame/protobuf/langame";
export const openAiKey = () => functions.config().openai?.key;
export const huggingfaceKey = () => functions.config().huggingface?.key;
export const algoliaId = () => functions.config().algolia?.application.id;
export const algoliaKey = () => functions.config().algolia?.key;
export interface Api {
  save(indexName: string, objects: { object: any, id: string }[]): Promise<any>;
  getIndex(indexName: string): SearchIndex;
  completion(
    prompt: string,
    parameters: any,
  ): Promise<string | undefined>;
  classify(content: string,
    classes: Array<string>,
    multiLabel: boolean,
    ignoreBelowThreshold: number,
  ): Promise<Array<string>>;
  openAITopicClassify(
    content: string,
    parameters: any
  ): Promise<string | undefined>;
  filter(content: string, parameters: any
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

