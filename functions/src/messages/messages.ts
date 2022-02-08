import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {handleError, reportError} from "../errors";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {html} from "../utils/html";
import {onSendMessageToBot} from "./onSendMessageToBot";


export const notifyUser = async (
    messageSnap: admin.firestore.DocumentSnapshot<langame.protobuf.IMessage>,
    senderTag: string,
    target: langame.protobuf.Message.IAuthor,
) => {
  const db = admin.firestore();
  // Do not answer bots
  if (messageSnap.data()!.author!.bot === false && target.bot === true) {
    return onSendMessageToBot(messageSnap, target);
  }
  const to = await db.collection("users").doc(target.id!)
      .withConverter(converter<langame.protobuf.IUser>())
      .get();
  if (!to.data() || !to.data()!.tokens) {
    const e = "No tokens for user " + to.id;
    await messageSnap.ref.set({
      delivery: {
        // @ts-ignore
        attempts: admin.firestore.FieldValue.increment(1),
        // @ts-ignore
        endTime: admin.firestore.FieldValue.serverTimestamp(),
        error: e,
        status: "failed",
      },
    }, {merge: true});
    const error = Error(e);
    await reportError(error,
            messageSnap.data()!.author!.id! ? {
              user: messageSnap.data()!.author!.id!,
            } : undefined);
    return Promise.reject(error);
  }

  const message = messageSnap.data()! as langame.protobuf.Message;
  let title = message!.title;

  // Build a title ourselves if it's not set. (message)
  if (message.type !== langame.protobuf.Message.Type.INVITE) {
    title = senderTag;
  }
  const toPreferences = await db
      .collection("preferences")
      .withConverter(converter<langame.protobuf.UserPreference>())
      .doc(to.id)
      .get();
  let messagingResponse:
        admin.messaging.MessagingDevicesResponse | undefined;
  if (to.data()!.tokens && to.data()!.tokens!.length > 0) {
    const onScreenNotification =
      (message.type === langame.protobuf.Message.Type.INVITE &&
        toPreferences.data()!.notification?.invite?.push === true) ||
      (message.type === langame.protobuf.Message.Type.MESSAGE &&
        toPreferences.data()!.notification?.message?.push === true);
    await sendPushNotification(title,
        message,
        onScreenNotification,
        to.data()!.tokens!,
    );
  } else {
    functions.logger.error("no tokens for user", to.id);
  }
  // TODO: parallelize
  if (
        to.data()!.bot === false &&
        (message.type === langame.protobuf.Message.Type.INVITE &&
        toPreferences.data()!.notification?.invite?.email === true) ||
        (message.type === langame.protobuf.Message.Type.MESSAGE &&
        toPreferences.data()!.notification?.message?.email === true)
  ) {
    functions.logger.log("onWriteMessage", "sending mail");
    await db.collection("mails").add({
      to: to.data()!.email,
      message: {
        subject: title,
        html: `<code>
          ${html(title, message.body, "Have a great day 😇.")}
        </code>`,
      },
    });
  }

  if (!messagingResponse) return Promise.resolve();
  await Promise.all<any>(
      messagingResponse.results.map((messagingResult, i) => {
        const t = to.data()!.tokens![i];
        // Invalid token, remove it
        if (messagingResult.error &&
                messagingResult.error.code ===
                "messaging/registration-token-not-registered" &&
                t) {
          return admin
              .firestore()
              .collection("users")
              .doc(to.id)
              .update({
                tokens: admin.firestore.FieldValue.arrayRemove(t),
              }).then(() =>
                functions.logger.info("removed invalid token", t))
              .catch(() =>
                handleError(to.ref, {
                  developerMessage: "failed to remove invalid token",
                  uid: to.id,
                }));
        } else {
          return messageSnap.ref.set({
            delivery: {
              // @ts-ignore
              attempts: admin.firestore.FieldValue.increment(1),
              // @ts-ignore
              endTime: admin.firestore.FieldValue.serverTimestamp(),
              error: null,
              status: "success",
            },
          }, {merge: true});
        }
      }));
  return Promise.resolve();
};


export const sendPushNotification = async (
    title: string,
    message: langame.protobuf.IMessage,
    onScreenNotification: boolean,
    targetTokens: string[],
) => {
  const payload: admin.messaging.MessagingPayload = {
    data: {
      authorId: message.author!.id!,
      langameId: message.langameId!,
      type: message.type!.toString(),
      body: message.body!,
      title: title,
      // Hack because messaging only take string
      createdAt: message.createdAt!.toString(),
    },
  };
  if (
    onScreenNotification
  ) {
    payload.notification = {
      // I think tag is used to group notifications
      tag: message.author!.id!,
      body: message!.body!,
      title: title!,
    };
    functions.logger.log("sending push notification");
  }
  functions.logger.log("sending message");
  return admin.messaging().sendToDevice(
      targetTokens,
      payload,
      {
        // Required for background data-only messages on iOS and Web
        contentAvailable: true,
        // Required for background data-only messages on Android
        priority: "high",
      }
  );
};
