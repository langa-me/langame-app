import {expect} from "chai";
import "mocha";
import {chunkItems} from "./array";
import {converCamelCaseToSnake} from "./object";

describe.skip("Utils", () => {
  it("Test google timestamp", () => {
    // const t = google.protobuf.Timestamp.fromObject(new Date());
    // console.log(t);
  });
});

it("chunk", () => {
  const l = ["foo", "bar", "baz", "bam"];
  const chunked = chunkItems(l, 2);
  expect(chunked).to.deep.equal([["foo", "bar"], ["baz", "bam"]]);
  // Generate list of size 23 and split into chunks of 9
  const l2 = Array.from({length: 23}, (_, i) => i);
  const chunked2 = chunkItems(l2, 9);
  expect(chunked2).to.deep.equal([
    [0, 1, 2, 3, 4, 5, 6, 7, 8],
    [9, 10, 11, 12, 13, 14, 15, 16, 17],
    [18, 19, 20, 21, 22],
  ]);
  // I love you copilot
});

it("convert to snake case", () => {
  const foo = {
    barBam: "barBam",
    bazBiz: "bazBiz",
  };
  const snake = converCamelCaseToSnake(foo);
  expect(snake).to.deep.equal({
    bar_bam: "barBam",
    baz_biz: "bazBiz",
  });
});
