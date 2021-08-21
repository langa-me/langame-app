/* eslint-disable max-len */
import "mocha";

import * as admin from "firebase-admin";
// import * as functions from "firebase-functions";
import {ImplAiApi} from "./aiApi/implAiApi";
import {initFirebaseTest} from "./utils/firestore.spec";


it("meme to algolia", async () => {
  initFirebaseTest({isDev: false});

  const api = new ImplAiApi();
  const memeDocs = await Promise.all((await admin.firestore().collection("memes").listDocuments())
      .map((e) => e.get()));

  await api.getIndex(
      "prod_memes").saveObjects(memeDocs.map((e) => {
    return {
      objectID: e.id,
      _tags: e.data()!.topics,
      content: e.data()!.content,
      createdAt: e.data()!.createdAt,
    };
  }));
});
it("rr", async () => {
  initFirebaseTest({isDev: true});
  const d = await admin.firestore().collection("users").limit(1).get();
  console.log("yolo", d.docs[0].data());


  // const d = await admin.firestore().collection("memes").listDocuments();
  // const dd = await Promise.all(d.map((e) => e.get()));
  // for (const e of dd) {
  //   if (!e.data()) console.log("is null", e.id);
  // }
  // // const api = new ImplAiApi();

  // await api.getIndex("prod_memes").clearObjects();
  // await api.getIndex("dev_memes").clearObjects();
  // const memes = await admin.firestore().collection("memes").listDocuments();
  // const api = new ImplAiApi();
  // for (const m of memes) {
  //   const meme = await m.get();
  //   let topics = meme.data()!.topics;
  //   if (topics.includes("unknown")) {
  //     topics = topics.filter((e: any) => e !== "unknown");
  //   } else continue;
  //   await meme.ref.update({
  //     topics: topics,
  //   });
  //   await api.getIndex("prod_memes").partialUpdateObject({
  //     objectID: meme.id,
  //     tags: topics,
  //   });
  //   functions.logger.log("fixed label for", meme.id);
  // }
});

