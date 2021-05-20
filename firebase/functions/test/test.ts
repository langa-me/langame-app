import {offlineQuestionSearch} from "../src/questions";
import {newFeedback} from "../src/feedback";
import {CompletionType, onlineOpenAiCompletion} from "../src/openai";
import * as admin from "firebase-admin";
import "mocha";
import {expect} from "chai";

before(() => {
  const serviceAccount = require("../langame-dev-8ac76897c7bc.json");
  // eslint-disable-next-line max-len
  // const serviceAccount = require("../langame-86ac4-firebase-adminsdk-iojlf-2d6861b97d.json");

  // Initialize the app with a service account, granting admin privileges
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });
});

it.skip("check that we can find some questions", async () => {
  // Generated ones
  let questions = await offlineQuestionSearch(["biology"], 5, -1, true);
  console.log(JSON.stringify(questions));
  questions = await offlineQuestionSearch(["health"], 5, -1, true);
  console.log(JSON.stringify(questions));
  questions = await offlineQuestionSearch(["philosophy"], 5, -1, true);
  console.log(JSON.stringify(questions));
  after(() => setTimeout(()=>{}, 1000));
});

it.skip("check", async () => {
  // Generated ones
  const questions = await offlineQuestionSearch(["death"], 1, -1, true);
  console.log(JSON.stringify(questions));
  after(() => setTimeout(()=>{}, 1000));
});


it.skip("create Github issue", async () => {
  await newFeedback("https://foo.bar.com", "foo: bar");
});

it.skip("generate openai question", async () => {
  const t = await admin.remoteConfig().getTemplate();
  const response = await onlineOpenAiCompletion(CompletionType.Question,
      "politics",
      t.parameters);
  console.log(JSON.stringify(response));
  expect(response !== undefined).to.be.true;
  expect(response!.length).to.be.greaterThan(0);
  expect(response![0].content.length).to.be.greaterThan(0);
});

it.skip("", async () => {
  const t = await admin.remoteConfig().getTemplate();
  console.log(JSON.stringify(t.parameters));
  // @ts-ignore
  console.log(t.parameters.offline_use_generated
      .defaultValue["value"] === "true");
});
