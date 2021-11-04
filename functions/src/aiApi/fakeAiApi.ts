/* eslint-disable max-len */
/* eslint-disable require-jsdoc */
import {SearchIndex} from "algoliasearch";
import {langame} from "../langame/protobuf/langame";
import {Api, ConversationalParameters, HuggingFaceCompletionParameters, OpenaiCompletionOptions, OpenaiCompletionParameters} from "./aiApi";

/**
 *
 */
export class FakeAiApi implements Api {
    faker = require("faker");
    save(indexName: string, objects: { object: any; id: string; }[]): Promise<any> {
      throw new Error("Method not implemented.");
    }
    getIndex(indexName: string): SearchIndex {
      throw new Error("Method not implemented.");
    }
    openaiCompletion(
        parameters: OpenaiCompletionParameters,
        options: OpenaiCompletionOptions
    ): Promise<string | undefined> {
      return Promise.resolve(this.faker.lorem.sentence());
    }
    classify(content: string, classes: string[], multiLabel: boolean, ignoreBelowThreshold: number): Promise<string[]> {
      // Return any of classes
      return Promise.resolve([classes[Math.floor(Math.random() * classes.length)]]);
    }
    openAITopicClassify(content: string, parameters: any): Promise<string | undefined> {
      throw new Error("Method not implemented.");
    }
    filter(parameters: OpenaiCompletionParameters): Promise<langame.protobuf.ContentFilter | undefined> {
      // Return random langame.protobuf.ContentFilter
      const rand = Math.floor(Math.random() * Object.keys(langame.protobuf.ContentFilter).length);
      return Promise.resolve(langame.protobuf.ContentFilter[
          // @ts-ignore
          Object.keys(langame.protobuf.ContentFilter)[rand]]);
    }
    translate(content: string, targetLanguageCode: string): Promise<string | undefined> {
      throw new Error("Method not implemented.");
    }
    tokenExtraction(content: string): Promise<any> {
      return Promise.resolve([]);
    }
    sentiment(content: string): Promise<any> {
      return Promise.resolve([
        {
          "sentiment": "POSITIVE",
          "score": Math.random(),
        },
        {
          "sentiment": "NEGATIVE",
          "score": Math.random(),
        },
      ]);
    }
    huggingFaceCompletion(content: string,
        parameters: HuggingFaceCompletionParameters): Promise<string | undefined> {
      return Promise.resolve(this.faker.lorem.sentence());
    }
    conversational(pastUserInputs: string[], generatedResponses: string[], text: string, parameters?: ConversationalParameters): Promise<string | undefined> {
      throw new Error("Method not implemented.");
    }
}
