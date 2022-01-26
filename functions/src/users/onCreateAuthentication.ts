import {
  isDev,
  isEmulator,
  kUsersCollection,
} from "../helpers";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {reportError} from "../errors";
import {html} from "../utils/html";
import {sample} from "../utils/array";
import {welcomeMessages} from "./welcomeMessages";

const title = "Welcome to Langame 👋";
/* eslint-disable max-len */
const body = `Thank a lot for joining us 😋, start some <strong>Langames</strong> now with your friends!
<br>
If you have any question or want to give a feedback, you can find everything <a href="https://help.langa.me/welcome">here.</a>
<br>
<em>${sample(welcomeMessages)}</em>
`;
/* eslint-disable max-len */


/**
 * When a user deletes their account, clean up after them
 * @param{UserRecord} user
 * @param{functions.EventContext} context
 */
export const onCreateAuthentication = async (user: admin.auth.UserRecord,
    context: functions.EventContext) => {
  const db = admin.firestore();

  try {
    const clone = JSON.parse(JSON.stringify(user));
    const photo = user.photoURL;
    delete clone.metadata;
    delete clone.passwordHash;
    delete clone.passwordSalt;
    delete clone.photoURL;
    clone.photoUrl = photo;
    clone.credits = 50;
    await db.runTransaction(async (t) => {
      return t.set(db.collection(kUsersCollection).doc(user.uid), clone, {merge: true});
    });

    if (isEmulator) return;

    const teamTitle = `Welcome to ${user.uid} 😋`;
    const teamBody = `<h1>${user.uid} joined Langame 😋</h1><br><p>${JSON.stringify(clone)}</p><br><h2>Give her/him a warm welcome!</h2>`;
    const p2 = isDev || user.email?.includes("@langa.me") ? Promise.resolve() : db.collection("mails").add({
      to: "louis.beaumont@langa.me",
      message: {
        subject: teamTitle,
        html: `<code>
          ${html(teamTitle, teamBody, "Have a great day 😇.")}
        </code>`,
      },
    });
    return Promise.all<any>([
      // We don't send welcome email to Langame team :) (because of bots mainly, fake email)
      user.email?.includes("@langa.me") ?
      Promise.resolve() :
      db.collection("mails").add({
        to: user.email,
        message: {
          subject: title,
          html: `<code>
          ${html(title, body, "Have a great day 😇.")}
        </code>`,
        },
      }), p2]);
  } catch (e: any) {
    return reportError(e, {user: context.params.userId});
  }
};
