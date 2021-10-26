import {expect} from "chai";
import {internalSetUserRecommendation} from "./setUserRecommendation";
import * as admin from "firebase-admin";
import {initFirebaseTest} from "../utils/firestore.spec";
import {ImplAiApi} from "../aiApi/implAiApi";


describe.skip("user", () => {
  initFirebaseTest({isDev: true});

  it("test recommendations", async () => {
    await internalSetUserRecommendation(admin.firestore());
    expect(true).to.be.true;
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


it("hack", async () => {
  initFirebaseTest({isDev: false});
  const users = await admin.firestore().collection("users").get();
  for (const user of users.docs) {
    if (!user.data()!.tag) {
      console.log(user.id, user.data()!.email, "has no tag");
    }
  }
});
