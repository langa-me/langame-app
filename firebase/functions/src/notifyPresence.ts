import * as functions from "firebase-functions";
import {FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode} from "./models";

import * as admin from "firebase-admin";
import {getLangame,
  getUserData,
  handleSendToDevice,
  kInvalidRequest,
  kNotificationsCollection,
  kUserDoesNotExist} from "./helpers";

export const notifyPresence = async (data: any,
    context: functions.https.CallableContext) => {
  if (!context.auth) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
        undefined,
        "not authenticated",
    );
  }

  if (!data) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kInvalidRequest,
    );
  }

  if (!data.channelName) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "you must provide a channel name",
    );
  }

  const langame = await getLangame(data.channelName);
  if ("statusCode" in langame) return langame;
  // We need to filter players with self,
  // do not want to send self notification
  const playersExceptSelf = langame.players.filter((p: any) =>
    p.langameUid != context.auth!.uid);
  if (playersExceptSelf.length === 0) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "could not find any players in this Langame",
    );
  }
  // Get players data from firestore (need their messaging tokens)
  const recipientsData: Array<FirebaseFunctionsResponse | any> = [];
  for (const r of playersExceptSelf) {
    const user = await getUserData(r.langameUid);
    if ("statusCode" in user) return user;
    if (!user.tokens) {
      functions.logger
          .error(kUserDoesNotExist(r.langameUid), "has no devices");
      return new FirebaseFunctionsResponse(
          FirebaseFunctionsResponseStatusCode.INTERNAL,
          undefined,
          `user ${r.langameUid} has no devices (tokens)`,
      );
    }
    recipientsData.push(user);
  }
  // Get sender data from firestore
  const senderData: FirebaseFunctionsResponse | any =
      await getUserData(context.auth!.uid);
  // Failed ? Return error
  if ("statusCode" in senderData) return senderData;

  const recipientsUid = recipientsData.map((r) => r.uid);

  const results = await recipientsData
      // @ts-ignore
      .map(async (e) => {
        const notificationPayload =
            {
              senderUid: context.auth!.uid,
              // @ts-ignore
              recipientsUid: recipientsUid,
              topics: langame.topics,
              channelName: langame.channelName,
              ready: true,
            };
        const notification = await admin
            .firestore()
            .collection(kNotificationsCollection)
            .add(JSON.parse(JSON.stringify(notificationPayload)));

        return handleSendToDevice(e,
            notification.id,
            admin.messaging().sendToDevice(
            e.tokens!,
            {
              data: {id: notification.id},
              notification: {
                tag: langame.channelName,
                // eslint-disable-next-line max-len
                body: `${senderData.displayName} is waiting you to play ${langame.topics.join(",")}`,
                // eslint-disable-next-line max-len
                title: `Join ${senderData.displayName} to play ${langame.topics.join(",")} now?`,
              },
            },
            {
              // Required for background/quit data-only messages on iOS
              contentAvailable: true,
              // Required for background/quit data-only messages on Android
              priority: "high",
            }
            ));
      });

  const successfulResults = results.filter((r) =>
    !("statusCode" in r));
  // If all failed
  if (successfulResults.length === 0) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "could not send ready for Langame");
  }
  // Succeed
  return new FirebaseFunctionsResponse(
      FirebaseFunctionsResponseStatusCode.OK,
      undefined,
      undefined);
};
