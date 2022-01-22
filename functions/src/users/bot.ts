import {waitUntil} from "async-wait-until";
import * as admin from "firebase-admin";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {generateTag} from "./tag";


export const createBot = async (db: admin.firestore.Firestore
): Promise<admin.firestore.DocumentSnapshot<langame.protobuf.IUser>> => {
  const botTag = await generateTag();
  if (!botTag) {
    throw new Error("Could not generate bot tag");
  }
  const randomPassword = Math.random().toString(36).slice(-8);
  const bot = await admin.auth().createUser({
    email: botTag + "@langa.me",
    displayName: botTag,
    password: randomPassword,
  });
  // Wait that the functions create a "users" for the bot
  // When it's done, set him a tag
  let done = false;
  const botDocRef = db.collection("users")
      .withConverter(converter<langame.protobuf.IUser>())
      .doc(bot.uid);
  const snapshotListener = admin.firestore().collection("users")
      .doc(bot.uid).onSnapshot(async (doc) => {
        if (doc.exists) {
          await botDocRef.update({
            tag: botTag,
            bot: true,
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
  return botDocRef.get();
};

export const onboardUserWithBot = async (
    userPreferenceSnap: admin.firestore.DocumentSnapshot<
    langame.protobuf.IUserPreference>,
) => {
  const db = admin.firestore();
  const bot = await createBot(db);
  const user = await db.collection("users")
      .withConverter(converter<langame.protobuf.IUser>())
      .doc(userPreferenceSnap.id).get();
  return db
      .collection("langames")
      .withConverter(converter<langame.protobuf.ILangame>())
      .add({
        topics: userPreferenceSnap.data()!.favoriteTopics ?
        userPreferenceSnap.data()!.favoriteTopics!.slice(0, 3) :
        ["ice breaker"],
        initiator: bot.id,
        // @ts-ignore
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        tags: ["bot"],
        players: [
          {
            id: bot.id,
            tag: bot.data()!.tag,
            photoUrl: bot.data()!.photoUrl,
            bot: true,
            email: bot.data()!.email,
          }, {
            id: user.id,
            tag: user.data()!.tag,
            photoUrl: user.data()!.photoUrl,
            bot: false,
            email: user.data()!.email,
          },
        ],
      });
};
