import {expect} from "chai";
import * as admin from "firebase-admin";
import {initFirebaseTest} from "../utils/firestore.spec";
import {ImplAiApi} from "../aiApi/implAiApi";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";
import {onboardUserWithBot} from "./bot";
import {setRecommendations} from "./recommendations";


describe("user", () => {
  it("test recommendations", async () => {
    initFirebaseTest("dev");

    const me = (await admin.firestore().collection("users")
        .withConverter(converter<langame.protobuf.IUser>())
        .where("tag", "==", "lou").get()).docs[0];
    const mePref = await admin.firestore().collection("preferences")
        .doc(me.id)
        .withConverter(converter<langame.protobuf.IUserPreference>())
        .get();
    await setRecommendations(
        admin.firestore(),
        me,
        mePref,
    );
    expect(true).to.be.true;
  });

  it("onBoardUserWithBot", async () => {
    initFirebaseTest("dev");

    const me = (await admin.firestore().collection("users")
        .withConverter(converter<langame.protobuf.IUser>())
        .where("tag", "==", "lou").get()).docs[0];
    const mePref = await admin.firestore().collection("preferences").
        doc(me.id)
        .withConverter(converter<langame.protobuf.IUserPreference>())
        .get();
    await onboardUserWithBot(mePref);
  });
});

it("search", async () => {
  const api = new ImplAiApi();

  const i = api.getIndex("prod_users");
  const result = await i.search("", {
    filters: "louu",
  });
  console.log(result);
});
