import {expect} from "chai";
import * as admin from "firebase-admin";
import "mocha";
import * as sinon from "sinon";
import {ImplAiApi} from "../aiApi/implAiApi";
import {getConfig} from "../functionConfig/config";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {initFirebaseTest} from "../utils/firestore.spec";
import {createReflection, createSuggestion} from "./onCreateMessageAnalysis";
import {onSendMessageToBot} from "./onSendMessageToBot";
it("suggest", async () => {
  initFirebaseTest("dev");
  const conf = await getConfig();
  const completion = await createSuggestion(
      new ImplAiApi(),
      "775b19ed",
      "qpbGMze6PHb1PPDhnrCVoObosGj2",
      conf.suggestion,
  );
  console.log(completion);
});

it("reflect", async () => {
  initFirebaseTest("dev");
  const completion = await createReflection(
      new ImplAiApi(),
      "edadfcd2",
      "cpTqkDjLtoX926OZXpcLyv3bzWA2",
      {
        maxNewTokens: 200,
        model: "bigscience/T0pp",
      }
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

it("onSendMessageToBot", async () => {
  initFirebaseTest("dev");
  const botSnap = (await admin.firestore().collection("users")
      .withConverter(converter<langame.protobuf.IUser>())
      .where("human", "==", false).get()).docs[0];
  expect(botSnap).to.be.not.undefined;
  const messageSnap = (await admin.firestore().collection("messages")
      .withConverter(converter<langame.protobuf.IMessage>())
      .where("toUid", "==", botSnap.id).get()).docs[0];
  await onSendMessageToBot((await messageSnap.ref.get()));
});
