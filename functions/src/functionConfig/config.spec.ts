import "mocha";

import * as admin from "firebase-admin";
import {FunctionConfig, getConfig} from "./config";
import {initFirebaseTest} from "../utils/firestore.spec";
import {expect} from "chai";

const defaultConfig: FunctionConfig = {
  reflection: {
    prompt: "FILL_ME",
    maxTokens: 300,
    frequencyPenalty: 0.4,
    presencePenalty: 0.3,
    temperature: 0.7,
    stop: ["###", "\n", "Me:", "You:"],
    model: "davinci-codex",
  },
  suggestion: {
    prompt: "FILL_ME",
    maxTokens: 300,
    frequencyPenalty: 0.3,
    presencePenalty: 0.3,
    temperature: 0.7,
    stop: ["###", "\n", "Me:", "You:"],
    model: "davinci-codex",
  },
};
// Insert into Firestore collection "configs"
it("insert function config", async () => {
  initFirebaseTest({isDev: true});

  await admin.firestore().collection("configs")
      .doc("default").set(defaultConfig);
});

it("can get function config", async () => {
  initFirebaseTest({isDev: true});
  const conf = await getConfig();
  expect(conf).to.deep.equal(defaultConfig);
});
