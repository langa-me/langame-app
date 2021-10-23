import {createReflection, createSuggestion}
  from "./onCreateMessageAnalysis";
import "mocha";
import {initFirebaseTest} from "../utils/firestore.spec";
import {ImplAiApi} from "../aiApi/implAiApi";
import * as admin from "firebase-admin";
import {expect} from "chai";
import * as sinon from "sinon";
import {langame} from "../langame/protobuf/langame";
it("suggest", async () => {
  initFirebaseTest({isDev: true});

  const completion = await createSuggestion(
      new ImplAiApi(),
      "775b19ed",
      "qpbGMze6PHb1PPDhnrCVoObosGj2",
  );
  console.log(completion);
});

it("reflect", async () => {
  initFirebaseTest({isDev: true});

  const completion = await createReflection(
      new ImplAiApi(),
      "775b19ed",
      "qpbGMze6PHb1PPDhnrCVoObosGj2",
  );
  console.log(completion);
});

// eslint-disable-next-line max-len
it("onWriteMessageAnalysis should properly add some intelligence to message and Langame, once", async () => {
  // Using firebase-function-test
  sinon.stub(admin, "initializeApp");
  const test = require("firebase-functions-test")();
  const myFunctions = require("../index");
  const wrapped = test.wrap(myFunctions.onWriteMessageAnalysis);
  const childParam = "foo";
  const setParam = "bar";
  const childStub = sinon.stub();
  const setStub = sinon.stub();
  const snap = {
    val: () => "input",
    after: {
      ref: {
        parent: {
          child: childStub,
        },
      },
      exists: true,
      data: () => new langame.protobuf.Message({
        analysis: new langame.protobuf.Message.Analysis({
          error: new langame.protobuf.Message.Analysis.Error({
            developerMessage: "shit happen",
            tries: 4,
          }),
        }),
      }),
    },
  };
  childStub.withArgs(childParam).returns({set: setStub});
  setStub.withArgs(setParam).returns(true);
  // Promise should be rejected
  let err = null;
  (await wrapped(snap) as Promise<any>).catch((e) => err = e);
  expect(err).to.be.not.null;
});
