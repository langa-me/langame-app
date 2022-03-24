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
// eslint-disable-next-line @typescript-eslint/no-var-requires
const fetch = require("node-fetch");

const title = "Welcome to Langame 👋";
/* eslint-disable max-len */
const body = `Thank a lot for joining us 😋, start some <strong>Langames</strong> now with your friends!
<br>
Please do not hesitate to give us feedback <a href="https://help.langa.me/feedback">here.</a>
<br>
<em>${sample(welcomeMessages)}</em>
`;
/* eslint-disable max-len */


/**
 * When a user creates their account, clean up after them
 * @param{UserRecord} user
 * @param{functions.EventContext} context
 */
export const onCreateAuthentication = async (user: admin.auth.UserRecord,
    context?: functions.EventContext) => {
  const db = admin.firestore();
  functions.logger.log("new user", user.uid);

  try {
    const clone = JSON.parse(JSON.stringify(user));
    const photo = user.photoURL;
    delete clone.metadata;
    delete clone.passwordHash;
    delete clone.passwordSalt;
    delete clone.photoURL;
    clone.photoUrl = photo;
    const configDoc = await admin.firestore().collection("configs")
        .doc("business").get();
    clone.credits = configDoc.data()?.base_user_credits || 2000;
    const batch = db.batch();
    const discordGuild = await admin.firestore().collection("discords").doc(user.uid).get();
    if (discordGuild.exists) {
      functions.logger.log("discord guild exists");
      // get discord bot token from function config
      const discordToken = functions.config().discord.bot.token;
      // const discordAppId = functions.config().discord.appId;
      // gather information about the discord guild into the user
      const url = "https://discord.com/api/v8/guilds/"+user.uid;
      const guildInfo = await fetch(url, {
        headers: {
          Authorization: `Bot ${discordToken}`,
        },
      });
      const guildInfoJson = await guildInfo.json();
      clone.discord = {
        ...guildInfoJson,
      };
      // create organization
      batch.set(db.collection("organizations").doc(user.uid), {
        credits: clone.credits,
        members: [user.uid],
        membersRole: {
          [user.uid]: "owner",
        },
        name: guildInfoJson.name,
      });
      functions.logger.log("organization created, key now");
      batch.set(db.collection("api_keys").doc(), {
        owner: user.uid,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // const dm = await fetch(
      //     "https://discord.com/api/v8/users/@me/channels",
      //     {
      //       method: "POST",
      //       headers: {
      //         "Content-Type": "application/json",
      //       },
      //       body: JSON.stringify({
      //         recipient_id: guildInfoJson.owner_id,
      //       }),
      //     },
      // );
      // // POST/channels/{channel.id}/messages
      // const dmJson = await dm.json();
      // functions.logger.log("created dm channel", dmJson);
      // const dmId = dmJson.id;
      // const dmMessage = await fetch(
      //     "https://discord.com/api/v8/channels/"+dmId+"/messages",
      //     {
      //       method: "POST",
      //       headers: {
      //         "Content-Type": "application/json",
      //       },
      //       body: JSON.stringify({
      //         content: "Thank you for inviting me to the party 😛!\n\n"+
      //             "I'm a bot that helps you to get into wonderful conversations.\n\n"+
      //             "You can learn more about me using /about or by heading to https://langa.me.",
      //       }),
      //     },
      // );
      // const dmMessageJson = await dmMessage.json();
      // functions.logger.log("dmed Discord owner", dmMessageJson);
    }


    batch.set(db.collection(kUsersCollection).doc(user.uid), clone, {merge: true});
    await batch.commit();
    if (!user.email) {
      functions.logger.log("user has no email, aborting");
      return;
    }
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
    return reportError(e, {user: context?.params.userId});
  }
};
