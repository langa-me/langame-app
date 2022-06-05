import "mocha";

import * as admin from "firebase-admin";
import {getConfig} from "./config";
import {initFirebaseTest} from "../utils/firestore.spec";
import {expect} from "chai";

const defaultConfig = {
  // reflection: {
  //   prompt: "FILL_ME",
  //   maxTokens: 300,
  //   frequencyPenalty: 0.4,
  //   presencePenalty: 0.3,
  //   temperature: 0.7,
  //   stop: ["###", "\n", "Me:", "You:"],
  //   model: "davinci-codex",
  // },
  // suggestion: {
  //   prompt: "FILL_ME",
  //   maxTokens: 300,
  //   frequencyPenalty: 0.3,
  //   presencePenalty: 0.3,
  //   temperature: 0.7,
  //   stop: ["###", "\n", "Me:", "You:"],
  //   model: "davinci-codex",
  // },
  reflection: {
    maxNewTokens: 300,
  },
  suggestion: {
    maxNewTokens: 300,
  },
};

// Insert into Firestore collection "configs"
it("insert function config", async () => {
  initFirebaseTest("prod");

  await admin.firestore().collection("configs")
      .doc("default").set(defaultConfig);
});

it("can get function config", async () => {
  initFirebaseTest("dev");
  const conf = await getConfig();
  expect(conf).to.deep.equal(defaultConfig);
});
