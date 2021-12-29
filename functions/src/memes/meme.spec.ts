import {expect} from "chai";
import "mocha";
import {initFirebaseTest} from "../utils/firestore.spec";
import {onlineMemeGenerator} from "./memes";

describe("memes", () => {
  it.skip("onlineMemeGenerator", async () => {
    initFirebaseTest("prod");
    const meme = await onlineMemeGenerator(["ice breaker"]);
    console.log(meme);
    expect(meme.data()).to.exist;
    expect(meme.data()!.disabled).to.be.true;
    expect(meme.data()!.state).to.be.eq("processed");
    expect(meme.data()!.topics).to.be.eq(["ice breaker"]);
    expect(meme.data()!.content).to.exist;
  });
});
