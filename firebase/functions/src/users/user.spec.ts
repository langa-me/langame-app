import {expect} from "chai";
import {internalSetUserRecommendation} from "./setUserRecommendation";
import * as admin from "firebase-admin";
import {initFirebaseTest} from "../utils/firestore.spec";


describe.skip("user", () => {
  initFirebaseTest({isDev: true});

  it("test recommendations", async () => {
    await internalSetUserRecommendation(admin.firestore());
    expect(true).to.be.true;
  });
});
