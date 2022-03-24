import {
  kInteractionsCollection,
  kPreferencesCollection,
  kUsersCollection,
} from "../helpers";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {reportError} from "../errors";
import {html} from "../utils/html";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";


const title = "Farewell from Langame 😥";
/* eslint-disable max-len */
const body = `We are saddened by your departure, we will miss you.
<br>
Please do not hesitate to give us feedback <a href="https://help.langa.me/feedback">here.</a>, thank you!`;
/* eslint-enable max-len */


/**
 * When a user deletes their account, clean up after them
 * @param{UserRecord} user
 * @param{functions.EventContext} context
 */
export const onDeleteAuthentication = async (user: admin.auth.UserRecord,
    context: functions.EventContext) => {
  const db = admin.firestore();
  const userDocToDelete = db
      .collection(kUsersCollection)
      .doc(user.uid);
  // TODO: update according to new user data model
  const batch = db.batch();
  // TODO: shouldn't we use transaction for read too?
  try {
    const interactionsToDelete = await db
        .collection(kInteractionsCollection)
        .where("usersArray", "array-contains", user.uid)
        .get();

    const preferencesToDelete = await db
        .collection(kPreferencesCollection)
        .where("userId", "==", user.uid)
        .get();

    functions.logger.log("interactions to delete", interactionsToDelete.size);
    functions.logger.log("preferences to delete", preferencesToDelete.size);
    for (const interactionToDelete of interactionsToDelete.docs) {
      batch.delete(interactionToDelete.ref);
    }
    for (const preferenceToDelete of preferencesToDelete.docs) {
      batch.delete(preferenceToDelete.ref);
    }

    const presenceInLangames = await db
        .collectionGroup("players")
        .where("userId", "==", user.uid).get();

    functions.logger.log("presence in langames", presenceInLangames.size);
    for (const p of presenceInLangames.docs) {
      batch.delete(p.ref);
    }

    const presenceInLangamesTwo = await db
        .collection("langames")
        .where("reservedSpots", "array-contains", user.uid).get();

    functions.logger.log("presence in langames two",
        presenceInLangamesTwo.size);
    for (const p of presenceInLangamesTwo.docs) {
      if (p.data().isText) {
        batch.delete(p.ref);
        const childs = await p.ref.collection("players").get();
        childs.forEach((c) => batch.delete(c.ref));
      } else {
        batch.update(p.ref, {
          reservedSpots: admin.firestore.FieldValue.arrayRemove(user.uid),
        });
      }
    }

    const presenceInLangamesThree = await db
        .collection("langame_presences")
        .doc(user.uid)
        .get();
    functions.logger.log("presence in langames three",
        presenceInLangamesThree.exists);
    for (const lgId of presenceInLangamesThree.data()?.presences || []) {
      const lgDoc = await db.collection("langames")
          .withConverter(converter<langame.protobuf.ILangame>())
          .doc(lgId)
          .get();
      // remove all players in this langame from langame_presences
      lgDoc.data()?.players?.map((p) =>
        batch.set(
            db.collection("langame_presences").doc(p.id!), {
              presences: admin.firestore.FieldValue.arrayRemove(user.uid),
            }, {merge: true},
        ),
      );
    }

    const messagesSent = await db
        .collection("messages")
        .where("author.id", "==", user.uid).get();

    functions.logger.log("messages sent", messagesSent.size);
    for (const message of messagesSent.docs) {
      batch.delete(message.ref);
    }

    batch.delete(db.collection("recommendations").doc(user.uid));
    batch.delete(db.collection("seenMemes").doc(user.uid));

    // In case it's a bot, delete the bot's data
    batch.delete(db.collection("bots").doc(user.uid));

    functions.logger.info(
        "preparing interactions, preferences, " +
        "recommendations, seenMemes, user deletion"
    );

    await batch.delete(userDocToDelete).commit();
    return db.collection("mails").add({
      to: user.email,
      message: {
        subject: title,
        html: `<code>
          ${html(title, body, "Have a great day 😇.")}
        </code>`,
      },
    });
  } catch (e: any) {
    return reportError(e, {user: context.params.userId});
  }
};
