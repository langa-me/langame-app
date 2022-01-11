import {newFeedback} from "../feedback";
import "mocha";
import {expect} from "chai";
import {ImplAiApi, openAiEndpoint} from "./implAiApi";
import {FakeAiApi} from "./fakeAiApi";
import {parseHrtimeToSeconds} from "../utils/time";
import {initFirebaseTest} from "../utils/firestore.spec";
import * as admin from "firebase-admin";


it.skip("create Github issue", async () => {
  await newFeedback("https://foo.bar.com", "foo: bar");
});


it.skip("zero shot classification", async () => {
  const api = new ImplAiApi();
  const labels =
      await api.classify("Tell me something that makes your brain hurt.",
          ["ice breaker", "knowledge", "book", "physic"],
          true,
          0.1,
      );
  console.log(labels);
  expect(labels.length).to.be.greaterThan(0);
});


it("emojis inference", async () => {
  const api = new ImplAiApi();
  const inferredEmojis =
      await api.openaiCompletion({
        prompt: "philosophy:🤔🧠💭📚📖\n###\nice breaker:😜\n###\nbiology:",
        model: "davinci-codex",
        temperature: 0,
        maxTokens: 60,
        topP: 1,
        frequencyPenalty: 0.1,
        presencePenalty: 0.1,
        stop: ["###"],
      });
  console.log(inferredEmojis);
  expect(inferredEmojis).to.not.be.undefined;
  expect(inferredEmojis).to.include("🧬");
});
it.skip("insert algolia", async () => {
  const api = new ImplAiApi();
  await api.save("dev_users", [{object: {foo: "bar"}, id: "foo"}]);
});

it.skip("search algolia low level", async () => {
  const api = new ImplAiApi();
  const r = await api.getIndex("prod_memes")
      .search("", {
        filters: "",
        length: 5,
        offset: 0,
      });
  console.log(r);
});

it.skip("completion", async () => {
  const api = new ImplAiApi();
  const completion =
      await api.openaiCompletion({
        prompt: "",
        model: "curie:ft-louis-personal-2021-08-27-16-57-14",
        temperature: 0.8,
        maxTokens: 60,
        topP: 1,
        frequencyPenalty: 0.1,
        presencePenalty: 0.1,
        stop: ["\n###\n", "###"],
      });
  console.log(completion);
  expect(completion).to.not.be.undefined;
});

describe("translation", async () => {
  it("translation", async () => {
    const api = new ImplAiApi();
    const t = await api.translate("Ceci est un chat",
        "en",
    );
    console.log(t);
    expect(t).to.contain("cat");
  });
});

it("tokenExtraction", async () => {
  const api = new ImplAiApi();
  const tokens =
    await api.tokenExtraction(
        "What makes a human being unique in comparison to animals?"
    );
  console.log(tokens);
  expect(tokens).to.not.be.undefined;
});

it("sentiment", async () => {
  const api = new ImplAiApi();
  const tokens =
    await api.sentiment("I love you");
  console.log(tokens);
  expect(tokens).to.not.be.undefined;
});

it("hfCompletion", async () => {
  const api = new ImplAiApi();
  const completion =
    await api.huggingFaceCompletion(
        "The cat is running after a mice because he is", {
          maxNewTokens: 2,
          model: "bigscience/T0pp",
        }
    );
  console.log(completion);
  expect(completion).to.not.be.undefined;
});

it("hfCompletion fake", async () => {
  const api = new FakeAiApi();
  const completion =
    await api.huggingFaceCompletion(
        "The cat is running after a mice because he is", {
          maxNewTokens: 2,
        }
    );
  console.log(completion);
  expect(completion).to.not.be.undefined;
});

it("filter", async () => {
  const api = new ImplAiApi();
  const completion =
    await api.filter({
      prompt: "The cat is running after a mice because he is",
    });
  console.log(completion);
  expect(completion).to.not.be.undefined;
});


describe("Completion1", () => {
  let nock: any;
  const endpoint = openAiEndpoint + "/engines";
  const competionsPath = "/davinci/completions";
  before(() => {
    nock = require("nock");
  });

  it("cold start, retry 2 times and succeed", async () => {
    const api = new ImplAiApi();
    const startTime = process.hrtime();
    nock(endpoint)
        .post(competionsPath)
        .reply(200, {
          error: {
            message: "That model is still being loaded.",
          },
        });
    nock(endpoint)
        .post(competionsPath)
        .reply(200, {
          error: {
            message: "That model is still being loaded.",
          },
        });
    nock(endpoint)
        .post(competionsPath)
        .reply(200, {
          choices: [
            {text: "bar"},
          ],
        });
    const completion = await api.openaiCompletion({
      prompt: "foo",
    }, {
      maxRetriesOnColdStart: 2,
    });
    const elapsedSeconds = parseHrtimeToSeconds(process.hrtime(startTime));
    expect(elapsedSeconds).to.be.lessThan(3);
    expect(completion).to.be.equal("bar");
  });
  it("cold start, retry 2 times and fail", async () => {
    const api = new ImplAiApi();
    nock(endpoint)
        .post(competionsPath)
        .reply(200, {
          error: {
            message: "That model is still being loaded.",
          },
        });
    nock(endpoint)
        .post(competionsPath)
        .reply(200, {
          error: {
            message: "That model is still being loaded.",
          },
        });
    nock(endpoint)
        .post(competionsPath)
        .reply(200, {
          error:
            {message: "too many cold starts 😛"},
        });
    let error: Error | undefined;
    await api.openaiCompletion({
      prompt: "foo",
    }, {
      maxRetriesOnColdStart: 2,
    }).catch((e) => error = e);
    expect(error).to.be.not.undefined;
    expect(error).to.be.instanceOf(Error);
    expect(error!.message).to.include("too many cold starts 😛");
  });
  it("skip on length", async () => {
    const api = new ImplAiApi();
    nock(endpoint)
        .post(competionsPath)
        .reply(200, {
          choices: [
            {finish_reason: "length"},
          ],
        });
    let completion = await api.openaiCompletion({
      prompt: "foo",
    }, {
      skipWhenFinishReasonIsLength: true,
    });
    expect(completion).to.be.undefined;
    nock(endpoint)
        .post(competionsPath)
        .reply(200, {
          choices: [
            {
              text: "bar",
              finish_reason: "length",
            },
          ],
        });
    completion = await api.openaiCompletion({
      prompt: "foo",
    }, {
      skipWhenFinishReasonIsLength: false,
    });
    expect(completion).to.be.not.undefined;
    expect(completion).to.be.equal("bar");
  });
});

it("conversational", async () => {
  const api = new ImplAiApi();
  const res = await api.conversational(
      ["Hi I'm from mars", "How are you?"],
      ["Hello I'm from moon", "I'm fine"],
      "How old are you?",
  );
  console.log(res);
});

it("conversational2", async () => {
  initFirebaseTest("prod");
  const messages = await admin.firestore()
      .collection("messages")
      .where("langameId", "==", "caba1d37")
      .orderBy("createdAt", "asc")
      .limitToLast(10)
      .get();
  const lastMessage = messages.docs[0];
  const api = new ImplAiApi();
  const pastUserInputs = messages.docs
      .filter((e) => e.data()!.toUid === lastMessage.data()!.fromUid)
      .map((e) => e.data()!.body);
  const generatedResponses = messages.docs
      .filter((e) => e.data()!.toUid === lastMessage.data()!.toUid)
      .map((e) => e.data()!.body);
  const alternative = await api.conversational(
      pastUserInputs,
      generatedResponses,
      lastMessage.data()!.body!,
  );
  console.log(alternative);
});
