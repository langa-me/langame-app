import {expect} from "chai";
import "mocha";
import {initFirebaseTest} from "../utils/firestore.spec";
import {onlineMemeGenerator, offlineMemeSearch} from "./memes";

describe("memes", () => {
  it("offlineMemeSearch", async () => {
    initFirebaseTest("dev");
    const memes = await offlineMemeSearch(["ice breaker", "travel"]);
    expect(memes.length).to.be.greaterThan(0);
    const meme = memes[0];
    console.log(meme);
    expect(meme.data()).to.exist;
    expect(meme.data()!.disabled).to.be.false;
    expect(meme.data()!.content).to.exist;
  });
  it("onlineMemeGenerator", async () => {
    initFirebaseTest("prod");
    const memes = await onlineMemeGenerator(["ice breaker"], 1, false);
    expect(memes.length).to.be.greaterThan(0);
    const meme = memes[0];
    console.log(meme);
    expect(meme.data()).to.exist;
    expect(meme.data()!.disabled).to.be.true;
    expect(meme.data()!.state).to.be.eq("processed");
    expect(meme.data()!.topics).to.be.eq(["ice breaker"]);
    expect(meme.data()!.content).to.exist;
  });
});
