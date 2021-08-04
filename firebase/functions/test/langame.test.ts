import "mocha";

import * as admin from "firebase-admin";
import {kLangamesCollection} from "../src/helpers";
import {langame} from "../src/langame/protobuf/langame";

// const cred = admin.credential.cert("./langame-dev-8ac76897c7bc.json");
// eslint-disable-next-line max-len
const cred = admin.credential.cert("./langame-86ac4-firebase-adminsdk-iojlf-2d6861b97d.json");
require("firebase-functions-test")({
  credential: cred,
  projectId: "langame-dev",
});
admin.initializeApp({
  credential: cred,
});
import {converter} from "../src/utils/firestore";
import {internalSetUserRecommendation} from "../src/setUserRecommendation";
import {ImplAiApi} from "../src/aiApi/implAiApi";

describe("Langame stuff", async () => {
  before(() => {

  });
  it.skip("get done", async () => {
    const db = admin.firestore();
    const HOUR = 4 * 1000 * 60 * 60;
    const anHourAgo = new Date(Date.now() - HOUR);
    await db.runTransaction(async (t) => {
      const langamesThatStartedMoreThanOneHourAgo = await t.get(db
          .collection(kLangamesCollection)
          .where("done", "==", null)
          .where("started",
              "<",
              admin.firestore.Timestamp.fromDate(anHourAgo))
          .withConverter(converter<langame.protobuf.Langame>()));
      console.log(langamesThatStartedMoreThanOneHourAgo);
    });
  });
  it("onUpdateLangame", async () => {
    // Make snapshot for state of database beforehand
    // const beforeSnap = fft.firestore
    //     .makeDocumentSnapshot({players: []}, "langames");
    // // Make snapshot for state of database after the change
    // const afterSnap = fft.firestore
    //     .makeDocumentSnapshot({players: {
    //       "userId": "foo",
    //       "timeIn": "2021-05-31T19:35:36.171353Z",
    //       "audioId": -1,
    //     }}, "langames");
    // const change = fft.makeChange(beforeSnap, afterSnap);
    // const wrapped = fft.wrap(onUpdateLangame);
    // wrapped(change);
    // const langame =
    //     (await admin.firestore().collection("langames").get()).docs[0];
    // const players = await langame.ref.collection("players")
    //     .withConverter(converter<langame.protobuf.Player>())
    //     .get();
    // console.log(`${players.docs
    //     .map((e) => e.data().audioId)}`);
    //
    // let maxAudioId: number = players
    //     .docs
    //     .map((e) => e.data().audioId)
    //     .reduce((
    //         a,
    //         b,
    //     ) =>
    //       Math.max(a, b)
    //     );
    // console.log(maxAudioId);
    // await Promise.all(players.docs
    //     .filter((p) => p.data().audioId === -1)
    //     .map(async (p) => {
    //       await admin.firestore().runTransaction(async (t) => {
    //         t.update(langame.ref.collection("players").doc(p.id), {
    //           audioId: ++maxAudioId,
    //         });
    //       });
    //     }));
  });
});


describe("Random", async () => {
  it("reco", async () => {
    const db = admin.firestore();
    await internalSetUserRecommendation(db);
  });
  it("meme to algolia", async () => {
    const api = new ImplAiApi();
    // eslint-disable-next-line max-len
    for (const memeDoc of await admin.firestore().collection("memes").listDocuments()) {
      const meme = await memeDoc.get();
      await api.getIndex(
          "dev_memes").partialUpdateObject({
        objectID: meme.id,
        translated: meme.data()!.translated,
      });
    }
  });
  it("rr", async () => {
    const ts = await admin.firestore().collection("topics").get();
    const api = new ImplAiApi();

    for (const t of ts.docs) {
      await api.getIndex("prod_topics").saveObject({
        objectID: t.id,
      });
    }
  });
});

