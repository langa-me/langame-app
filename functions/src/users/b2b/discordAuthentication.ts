/* eslint-disable max-len */
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {isDev, isEmulator} from "../../helpers";
import {onCreateAuthentication} from "../onCreateAuthentication";

export const discordAuthentication = async (
    data: any,
    context: functions.https.CallableContext
) => {
  functions.logger.log("data", data);
  functions.logger.log("context", context.rawRequest);

  try {
    if (!data) {
      const base = isEmulator ||
        // origin is localhost
        context.rawRequest?.headers?.origin?.includes("localhost") ?
        "http%3A%2F%2Flocalhost%3A3000" : isDev ? "https%3A%2F%2Flangame-dev-website.web.app" : "https%3A%2F%2Flanga.me";
      const clientId = isDev ? "920612693864493066" : "912000855186751489";
      const url = `https://discord.com/api/oauth2/authorize?client_id=${clientId}&permissions=2147699776&redirect_uri=${base}%2Fsignin&response_type=code&scope=bot%20identify%20applications.commands%20guilds`;
      return {
        redirect: url,
      };
    } else if (data.guildId) {
      const guildId = data.guildId;
      const token = await admin.auth().createCustomToken(guildId);
      await admin.firestore().collection("discords").doc(guildId).set({
        token: token,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      }, {merge: true});
      return {
        token: token,
      };
    } else if (data.uid) {
      const uid = data.uid;
      const user = await admin.auth().getUser(uid);
      await onCreateAuthentication(user);
      return {
        uid: uid,
      };
    }
    throw new functions.https.HttpsError("invalid-argument", "Invalid arguments");
  } catch (e: any) {
    functions.logger.error(e);
    throw new functions.https.HttpsError("internal", e.message);
  }
};
