// TODO: Typescript interfaces, types, definitions and functions to manage
// configuration of Firebase functions stored in Firestore, for example
// OpenAI completion parameters for reflection generation.


import * as admin from "firebase-admin";
import {HuggingFaceCompletionParameters,
  OpenaiCompletionParameters} from "../aiApi/aiApi";
import {converter} from "../utils/firestore";

export interface FunctionConfig {
    reflection: OpenaiCompletionParameters | HuggingFaceCompletionParameters,
    suggestion: OpenaiCompletionParameters | HuggingFaceCompletionParameters,
}

// type ConfigType = "reflection" | "suggestion" | "reply";
export const getConfig = async (): Promise<FunctionConfig> => {
  const snap = await admin.firestore().collection("configs")
      .withConverter(converter<FunctionConfig>())
      .doc("default").get();
  return snap.data()!;
};
