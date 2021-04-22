import {offlineQuestionSearch} from "../src/questions";
import {newFeedback} from "../src/feedback";
import {CompletionType, onlineOpenAiCompletion} from "../src/openai";

const admin = require("firebase-admin");
// const serviceAccount = require("../langame-dev-8ac76897c7bc.json");
const serviceAccount = require("../langame-86ac4-firebase-adminsdk-iojlf-2d6861b97d.json");

// Initialize the app with a service account, granting admin privileges
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
test("check that we can find some questions", async () => {
  // Generated ones
  let questions = await offlineQuestionSearch(["biology"], 5, -1, true);
  console.log(JSON.stringify(questions));
  questions = await offlineQuestionSearch(["health"], 5, -1, true);
  console.log(JSON.stringify(questions));
  questions = await offlineQuestionSearch(["philosophy"], 5, -1, true);
  console.log(JSON.stringify(questions));
  afterAll(() => setTimeout(()=>{}, 1000));
}, 40_000);

test("check", async () => {
  // Generated ones
  let questions = await offlineQuestionSearch(["death"], 1, -1, true);
  console.log(JSON.stringify(questions));
  afterAll(() => setTimeout(()=>{}, 1000));
}, 40_000);


test("create Github issue", async () => {
  await newFeedback("https://foo.bar.com", "foo: bar");
})

test("generate openai question", async () => {
  const t = await admin.remoteConfig().getTemplate();
  const response = await onlineOpenAiCompletion(CompletionType.Question, "politics", t.parameters)
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
