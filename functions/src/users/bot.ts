import {waitUntil} from "async-wait-until";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {names, uniqueNamesGenerator} from "unique-names-generator";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";

export const onboardUserWithBot = async (
    userPreferenceSnap: admin.firestore.DocumentSnapshot<
    langame.protobuf.IUserPreference>,
) => {
  const db = admin.firestore();

  let botTag: string | undefined = undefined;
  let tries = 0;
  const maxTries = 5;
  while (!botTag && tries < maxTries) {
    tries++;
    botTag =
              uniqueNamesGenerator({
                dictionaries: [names],
                length: 1,
                style: "lowerCase",
              });

    functions.logger.log("generated tag for bot", botTag);

    if (botTag.length > 8) continue;

    // Check that this tag is not taken
    const userWithSameTag =
            await admin.firestore().collection("users")
                .where("tag", "==", botTag).get();
    if (userWithSameTag.empty) {
      break;
    }
    botTag = undefined;
  }
  if (!botTag) {
    return Promise.reject(
        new Error("failed to find a tag for bot"));
  }
  const randomPassword = Math.random().toString(36).slice(-8);
  const bot = await admin.auth().createUser({
    email: botTag + "@langa.me",
    displayName: botTag,
    password: randomPassword,
  });
  await db.collection("bots").doc(bot.uid).set({
    assignedUser: userPreferenceSnap.id,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    disabled: false,
  });
  // Wait that the functions create a "users" for the bot
  // When it's done, set him a tag
  let done = false;
  const snapshotListener = admin.firestore().collection("users")
      .doc(bot.uid).onSnapshot(async (doc) => {
        if (doc.exists) {
          await db.collection("users").doc(bot.uid).update({
            tag: botTag,
            human: false,
          });
          done = true;
        }
      }, (e) => {
        throw (e);
      });
  await waitUntil(() => done, {
    timeout: 10_000,
  });
  // Un-listen
  snapshotListener();
  const add = await db!
      .collection("langames")
      .withConverter(converter<langame.protobuf.ILangame>())
      .add({
      // Select 3 random topics from user's preferences
        topics: userPreferenceSnap.data()!.favoriteTopics?.slice(0, 3),
        initiator: bot.uid,
        // @ts-ignore
        date: admin.firestore.FieldValue.serverTimestamp(),
        reservedSpots: [userPreferenceSnap.id],
        isText: true,
      });

  // TODO: might check if not failed
  const langame = await add.get();

  const snapP = langame
      .ref
      .collection("players")
      .doc(bot.uid)
      .withConverter(converter<langame.protobuf.IPlayer>());
  const p = {
    userId: bot.uid,
    audioId: -1,
  };
  return snapP.set(
      p,
      {merge: true},
  );
};
