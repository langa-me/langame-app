import {newFeedback} from "../feedback";
import "mocha";
import {expect} from "chai";
import {ImplAiApi} from "./implAiApi";
import {offlineMemeSearch} from "../memes/memes";
import {FakeAiApi} from "./fakeAiApi";


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


it.skip("emojis inference", async () => {
  const api = new ImplAiApi();
  const inferredEmojis =
      await api.completion("philosophy:🤔🧠💭📚📖\nice breaker:😜\nphysics:",
          {
            model: "davinci",
            temperature: 0.8,
            maxTokens: 60,
            topP: 1,
            frequencyPenalty: 0.1,
            presencePenalty: 0.1,
            stop: ["\n"],
          });
  console.log(inferredEmojis);
  expect(inferredEmojis).to.not.be.undefined;
});
it.skip("insert algolia", async () => {
  const api = new ImplAiApi();
  await api.save("dev_users", [{object: {foo: "bar"}, id: "foo"}]);
});

it.skip("search algolia", async () => {
  const out = ["KRSKDgI2rsscN8U38v5V", "kGApNE1CNmEzb5uzFPw7"];
  let r = await offlineMemeSearch(["biology"], 5, out);
  expect(r.map((e) => e.id).filter((e) => out.includes(e)).length)
      .to.be.equal(0);
  r = await offlineMemeSearch(["biology"], 3,
      []);
  expect(r.length).to.be.equal(3);
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
      await api.completion("",
          {
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
    await api.hfCompletion(
        "The cat is running after a mice because he is", {
          maxNewTokens: 2,
        }
    );
  console.log(completion);
  expect(completion).to.not.be.undefined;
});

it("hfCompletion fake", async () => {
  const api = new FakeAiApi();
  const completion =
    await api.hfCompletion(
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
    await api.filter(
        "The cat is running after a mice because he is",
        {}
    );
  console.log(completion);
  expect(completion).to.not.be.undefined;
});
