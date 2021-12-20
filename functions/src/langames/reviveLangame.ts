import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {createBot} from "../users/bot";
import {reportError} from "../errors";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";
/* eslint-disable max-len */
// This is a bot message to send to the inactive conversation to revive it
// using, for example, a conversation starter
const randomLangameConversationReviverOpenings = [
  "All right, 😃. So how's the conversation going?",
  "Hi there! It seems that it's a bit dying out there!",
  "What's up, guys? I'm here to revive this conversation 😜!",
  "Just a little bit of friendly reminder: don't let the conversation die out!",
  "Oh no! It seems that the conversation is dying out... But I'm here to revive it! 😜",
  "Let's revive the conversation before it dies! 😁",
  "Hi everyone! Time is ticking, don't forget to repl here and keep the conversation alive!",
  "Hello, it's time to write some message and enjoy the conversation!",
  "Is the conversation dead already? Hey, don't leave me alone!!",
  "This conversation is dying! 😞",
  "Do I need to hit someone to make you discuss?",
  "May the power of generic language game revive you!",
  "I think that the conversation is dying... Anyways, time to write messages",
  "So, have you talked a chat yet?",
  "Oh noo! 🙀 The conversation is dying here... So, time to revive them!",
  "Greetings each other, people! Don't let the Langame die down 😜",
  "Help me, save the conversation, someone!!🤔",
  "Beep beep boop. Is this conversation not fun anymore? Laaaangameee!",
  "We all need a good conversation starter! Here is yours for you!",
  "I'm supposed to send this message because the conversation's on fire!",
  "I am here to help you revive the conversation!",
  "One of us has to spike the conversation!",
  "How about we start another conversation? For old times' sake?",
  "Don't let the conversation die out! Remember to reply please!",
  "Hello my fellow conversationalists! Let's keep this interaction rolling!",
  "This is not a weapon, but it helps stab people with your words ;)",
  "Everyone needs a little help sometimes. I am here to help you with that.",
  "I just want to remind you: Don't let this conversation die. Keep them discussions going!",
];

export const reviveLangame =
    async (ctx: functions.EventContext) => {
      functions.logger.log(ctx);
      try {
        const db = admin.firestore();
        const inactiveLangames = await db
            .collection("langames")
            .where("tags", "array-contains", "inactive")
            .withConverter(converter<langame.protobuf.ILangame>())
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
        return Promise.all(inactiveLangames.docs.map(async (e) => {
          // const starterRef = await db.collection("new_memes").add({
          //   state: "to-process",
          //   topics: e.data().topics,
          //   created_at: admin.firestore.FieldValue.serverTimestamp(),
          // });
          // const starterDoc =
          //   await new Promise<admin.firestore.DocumentSnapshot>((resolve, reject) =>
          //     starterRef.onSnapshot((snapshot) => {
          //       if (snapshot.data()!.state === "processed" &&
          //           snapshot.data()!.conversation_starter) {
          //         resolve(snapshot);
          //       } else if (snapshot.data()!.state === "error") {
          //         reject(new Error(snapshot.data()!.error || "unknown"));
          //       }
          //     }));

          // TODO: maybe option to use something else than a conversation starter
          // TODO: maybe something related to conversation?
          // pick random opening
          const botMessage = randomLangameConversationReviverOpenings[
              Math.floor(
                  Math.random() *
                randomLangameConversationReviverOpenings.length)];
          const author: langame.protobuf.Message.IAuthor = {
            id: botUser.id,
            tag: botUser.data()!.tag,
            photoUrl: botUser.data()!.photoUrl,
            bot: true,
            email: botUser.data()!.email,
          };
          return db.collection("messages").add({
            author: author,
            body: botMessage,
            type: 1,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            langameId: e.id,
          });
        }));
      } catch (e: any) {
        await reportError(e, {});
        return Promise.reject(e);
      }
    };
