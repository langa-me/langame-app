import {findQuestionsInTopics} from "../src/helpers";
import {newFeedback} from "../src/feedback";

const admin = require("firebase-admin");
const serviceAccount = require("../langame-dev-8ac76897c7bc.json");

// Initialize the app with a service account, granting admin privileges
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
test("check that we can find some questions", async () => {
  const minimumThreshold = 0.2;
  let questions = await findQuestionsInTopics(["philosophy", "physics"],
      5,
      minimumThreshold);
  console.log(JSON.stringify(questions));
  questions = await findQuestionsInTopics(["biology"], 5, minimumThreshold);
  console.log(JSON.stringify(questions));
  questions = await findQuestionsInTopics(["health"], 5, minimumThreshold);
  console.log(JSON.stringify(questions));
  questions = await findQuestionsInTopics(["mind"], 5, minimumThreshold);
  console.log(JSON.stringify(questions));
  afterAll(() => setTimeout(()=>{}, 1000));
});


test("create Github issue", async () => {
  await newFeedback("https://foo.bar.com", "foo: bar");
})

