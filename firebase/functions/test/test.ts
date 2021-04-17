import {onlineOpenAiQuestionGeneration, offlineQuestionSearch} from "../src/questions";
import {newFeedback} from "../src/feedback";

const admin = require("firebase-admin");
// const serviceAccount = require("../langame-dev-8ac76897c7bc.json");
const serviceAccount = require("../langame-86ac4-firebase-adminsdk-iojlf-2d6861b97d.json");

// Initialize the app with a service account, granting admin privileges
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
test("check that we can find some questions", async () => {
  const minimumThreshold = 0.2;
  let questions = await offlineQuestionSearch(["philosophy", "physics"],
      5,
    minimumThreshold,
      false);
  console.log(JSON.stringify(questions));
  questions = await offlineQuestionSearch(["biology"], 5, minimumThreshold, false);
  console.log(JSON.stringify(questions));
  questions = await offlineQuestionSearch(["health"], 5, minimumThreshold, false);
  console.log(JSON.stringify(questions));
  questions = await offlineQuestionSearch(["mind"], 5, minimumThreshold, false);
  console.log(JSON.stringify(questions));

  // Generated ones
  questions = await offlineQuestionSearch(["biology"], 5, -1, true);
  console.log(JSON.stringify(questions));
  questions = await offlineQuestionSearch(["health"], 5, -1, true);
  console.log(JSON.stringify(questions));
  questions = await offlineQuestionSearch(["philosophy"], 5, -1, true);
  console.log(JSON.stringify(questions));
  afterAll(() => setTimeout(()=>{}, 1000));
}, 40_000);


test("create Github issue", async () => {
  await newFeedback("https://foo.bar.com", "foo: bar");
})

test("generate openai question", async () => {
  const response = await onlineOpenAiQuestionGeneration("politics", {
    "question_engine": "openai",
    "openai_model": "davinci",
    "openai_temperature": 0.7,
    "openai_max_tokens": 32,
    "openai_top_p": 1,
    "openai_frequency_penalty": 0.0,
    "openai_presence_penalty": 0.1
  })
  console.log(JSON.stringify(response))
  expect(response !== undefined).toBeTruthy();
  expect(response.length).toBeGreaterThan(0);
  expect(response[0].content.length).toBeGreaterThan(0);
}, 40_000)

test("", async () => {
  const t = await admin.remoteConfig().getTemplate();
  console.log(JSON.stringify(t.parameters));
  console.log(t.parameters.offline_use_generated.defaultValue.value === "true")
})
