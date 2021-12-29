import "mocha";
import * as admin from "firebase-admin";
import {initFirebaseTest} from "../utils/firestore.spec";
import {revive, reviveLangame} from "./reviveLangame";
import {setTagsLangame, tagLangame} from "./setTagsLangame";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";
import {createBot} from "../users/bot";

describe("langames", () => {
  it("tagLangame", async () => {
    initFirebaseTest("prod");
    const db = admin.firestore();
    const langameSnap = await db
        .collection("langames")
        .withConverter(converter<langame.protobuf.ILangame>())
        .doc("2jRCrZqnhGxCzJjrEoUV")
        .get();
    const messages = await db.collection("messages")
        .where("langameId", "==", langameSnap.id)
        .orderBy("createdAt", "desc")
        .get();
    await tagLangame(db, langameSnap, messages);
    console.log("foo");
  });
  it("setTagsLangame", async () => {
    initFirebaseTest("prod");
    setTagsLangame({
      eventId: "eventId",
      eventType: "google.firestore.document.write",
      params: {},
      resource: {
        service: "string",
        name: "string",
      },
      timestamp: "2020-04-01T00:00:00.000Z",
    });
  });
  it("revive", async () => {
    initFirebaseTest("prod");
    const db = admin.firestore();
    const langameSnap = await db
        .collection("langames")
        .withConverter(converter<langame.protobuf.ILangame>())
        .doc("06ZxSrwIpcuVyvYoWwra")
        .get();
    // get a random bot from bots collection
    const botDoc = await db.collection("users")
        .where("disabled", "==", false)
        .where("bot", "==", true)
        .limit(1)
        .withConverter(converter<langame.protobuf.IUser>())
        .get();
    let botUser: admin.firestore.DocumentSnapshot<langame.protobuf.IUser>;
    // if there is no bot, create one
    if (botDoc.empty) {
      botUser = await createBot(db);
    } else {
      botUser = botDoc.docs[0];
    }
    await revive(db, langameSnap, botUser);
    console.log("foo");
  });
  it("reviveLangame", async () => {
    initFirebaseTest("dev");
    reviveLangame({
      eventId: "eventId",
      eventType: "google.firestore.document.write",
      params: {},
      resource: {
        service: "string",
        name: "string",
      },
      timestamp: "2020-04-01T00:00:00.000Z",
    });
  });
});
