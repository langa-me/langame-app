import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {createBot} from "../users/bot";
import {reportError} from "../errors";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";
import {sample} from "../utils/array";
import {onlineMemeGenerator} from "../memes/memes";
import {promiseRetry} from "../utils/promises";
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

// This is a list of messages that a bot will pick from to send to users during a dying conversation,
// to announce that it will end the conversation if there is no more activity
const conversationClosureMessages = [
  "Despite my attempts to revive this conversation, it seems to be beyond my power 😢, I will close it in a couple of hours",
  "I'm afraid I can't do anything to keep this conversation alive, I will close it in a couple of hours 😭",
  "This conversation does not seem to be interesting enough to keep alive, I will close it in a couple of hours",
  "I don't see any reason to keep this conversation alive, I will close it in a couple of hours",
  "I'm afraid there is not much left to talk about, I will close this conversation in a couple of hours",
  "I believe it is time to end this conversation, I will close in a couple of hours",
  "Unfortunately, I don't see any reason to keep this conversation alive. I will close it in a couple of hours",
  "I don't believe there is anything left to learn from this conversation, I will close it in a couple of hours",
  "This conversation does not seem to still hold any potential, I will close it in a couple of hours",
  "This conversation seems to be dying quietly, I could even close it in a couple of hours",
  "It does not seem that this conversation has enough potential to be worth the effort of keeping it alive, I will close it in a couple of hours",
];

export const reviveLangame =
  async (ctx: functions.EventContext) => {
    functions.logger.log(ctx);
    try {
      const db = admin.firestore();
      const langames = await db
          .collection("langames")
          .where("tags", "array-contains-any", ["inactive", "dead", "to-terminate"])
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


      for (const e of langames.docs) {
        const presences = await db
            .collection("langame_presences")
            .where("presences", "array-contains", e.data().players?.map((e) => e.id))
            .get();
        if (presences.empty) {
          functions.logger.info(`No presences for langame ${e.id}, skipping`);
          continue;
        }
        const hasGenerated = await revive(db, e, botUser);
        // if has generated add a bit of delay
        if (hasGenerated) {
          await new Promise((resolve) => setTimeout(resolve, 2000));
        }
      }
      return Promise.resolve();
    } catch (e: any) {
      await reportError(e, {});
      return Promise.reject(e);
    }
  };


export const revive = async (
    db: admin.firestore.Firestore,
    langame: admin.firestore.QueryDocumentSnapshot<langame.protobuf.ILangame> |
      admin.firestore.DocumentSnapshot<langame.protobuf.ILangame>,
    botUser: admin.firestore.DocumentSnapshot<langame.protobuf.IUser>,
): Promise<boolean> => {
  let hasGenerated = false;
  if (langame.data()!.tags?.includes("to-terminate")) {
    functions.logger.log(`langame ${langame.id} is tagged as to-terminate`,
        ", terminating it");
    // Remove player from presence
    await Promise.all(langame.data()!.players!.map((player) =>
      db.collection("langame_presences").doc(player!.id!).set({
        presences: admin.firestore.FieldValue.arrayRemove(langame.id),
      }, {merge: true})));
    await langame.ref.set({
      tags: ["terminated"],
    }, {merge: true});
    return hasGenerated;
  }

  // pick random opening
  let botMessage;
  if (langame.data()!.tags?.includes("dead")) {
    botMessage = sample(conversationClosureMessages);
  } else if (langame.data()!.tags?.includes("inactive")) {
    hasGenerated = true;
    // Try to add a conversation starter, could fail in case of profane
    // or such online generation error
    try {
      // TODO: might also offline search
      // Maybe classify last messages and create starter accordingly
      const newConversationStarter = await promiseRetry(() => onlineMemeGenerator(
        langame.data()!.topics!, 1, false, false, 3, 80_000
      ), 2, 3000, undefined);
      botMessage = sample(randomLangameConversationReviverOpenings)+
       `\n\n${newConversationStarter[0].data()!.content!}`;
    } catch (e: any) {
      await reportError(e, {});
    }
  }
  if (!botMessage) {
    functions.logger.log("Conversation is alive, no need to revive");
    return Promise.resolve(hasGenerated);
  }
  const author: langame.protobuf.Message.IAuthor = {
    id: botUser.id,
    tag: botUser.data()!.tag,
    photoUrl: botUser.data()!.photoUrl,
    bot: true,
    email: botUser.data()!.email,
  };
  await db.collection("messages").add({
    author: author,
    body: botMessage,
    type: 1,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    langameId: langame.id,
  });
  return Promise.resolve(hasGenerated);
};
