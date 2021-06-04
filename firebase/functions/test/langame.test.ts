import "mocha";

import * as admin from "firebase-admin";

const cred = admin.credential.cert("./langame-dev-8ac76897c7bc.json");
// @ts-ignore
// const fft = require("firebase-functions-test")({
//   credential: cred,
//   projectId: "langame-dev",
// });
admin.initializeApp({
  credential: cred,
});

describe("Langame stuff", async () => {
  before(() => {

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
