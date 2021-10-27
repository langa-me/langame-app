import {EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {handleError, reportError} from "../errors";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {html} from "../utils/html";
import {shouldDrop} from "../utils/contexts";

export const onCreateMessage = async (
    snap: admin.firestore.DocumentSnapshot<langame.protobuf.IMessage>,
    ctx: EventContext) => {
  try {
    functions.logger.log(ctx);
    if (!snap.exists) return;
    if (shouldDrop(ctx, {
      eventMaxAgeMs: 60_000, // 1 minutes
    })) return;
    if (
      snap.data()?.delivery?.attempts &&
      snap.data()!.delivery!.attempts! >= 3
    ) {
      functions.logger.log(
          "delivery attempts >= 3, aborting"
      );
      return Promise.reject(Error("delivery attempts >= 3, aborting"));
    }
    if (snap.data()?.delivery?.status === "success") {
      functions.logger.log(
          "delivery succeed, aborting"
      );
      return Promise.resolve();
    }
    const db = admin.firestore();
    const from = await db
        .collection("users")
        .doc(snap.data()!.fromUid!)
        .get();
    await db.runTransaction(async (t) => {
      t.set(from.ref, {
        rateLimits: {
          message: admin.firestore.FieldValue.serverTimestamp(),
        },
      }, {merge: true});
    });
    const to = await db
        .collection("users")
        .doc(snap.data()!.toUid!)
        .get();
    if (!to.data() || !to.data()!.tokens) {
      const e = "No tokens for user " + to.id;
      await snap.ref.set({
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
        snap.data()!.fromUid ? {
          user: snap.data()!.fromUid,
        } : undefined);
      return Promise.reject(error);
    }

    const message = snap.data()! as langame.protobuf.Message;
    let title = message!.title;

    // Build a title ourselves if it's not set. (message)
    if (message.type !== langame.protobuf.Message.Type.INVITE) {
      const notificationSubjectClipSize = 30;
      const bodyClipped = message.body!.substr(0, notificationSubjectClipSize) +
        (message.body!.length > notificationSubjectClipSize ? "..." : "");
      title = `${from.data()!.tag} says: ${bodyClipped}...`;
    }
    const toPreferences = await db
        .collection("preferences")
        .withConverter(converter<langame.protobuf.UserPreference>())
        .doc(message.toUid)
        .get();
    const payload: admin.messaging.MessagingPayload = {
      data: {
        fromUid: message.fromUid,
        toUid: message.toUid,
        channelName: message.channelName,
        type: message.type.toString(),
        body: message.body,
        title: title,
        // Hack because messaging only take string
        createdAt: snap.data()!.createdAt!.toString(),
      },
    };
    if (
      message.type === langame.protobuf.Message.Type.INVITE &&
      toPreferences.data()!.notification?.invite?.push === true ||
      message.type === langame.protobuf.Message.Type.MESSAGE &&
      toPreferences.data()!.notification?.message?.push === true
    ) {
      payload.notification = {
        // I think tag is used to group notifications
        tag: message.fromUid,
        body: message!.body!,
        title: title!,
      };
    }
    functions.logger.log("onWriteMessage", "sending message",
      "data" in payload ? "silently, as user has push notification off": "");
    const messagingResponse = await admin.messaging().sendToDevice(
      to.data()!.tokens!,
      payload,
      {
        // Required for background data-only messages on iOS and Web
        contentAvailable: true,
        // Required for background data-only messages on Android
        priority: "high",
      }
    );
    // TODO: parallelize
    if (
      message.type === langame.protobuf.Message.Type.INVITE &&
      toPreferences.data()!.notification?.invite?.email === true ||
      message.type === langame.protobuf.Message.Type.MESSAGE &&
      toPreferences.data()!.notification?.message?.email === true
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
                }).then(() => functions.logger.info("removed invalid token", t))
                .catch(() =>
                  handleError(to.ref, {
                    developerMessage: "failed to remove invalid token",
                    uid: to.id,
                  }));
          } else {
            return snap.ref.set({
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
  } catch (e: any) {
    await reportError(e,
      snap.data()!.fromUid ? {
        user: snap.data()!.fromUid,
      } : undefined);
    await snap.ref.set({
      delivery: {
        // @ts-ignore
        attempts: admin.firestore.FieldValue.increment(1),
        // @ts-ignore
        endTime: admin.firestore.FieldValue.serverTimestamp(),
        error: e.toString(),
        status: "failed",
      },
    }, {merge: true});
    return Promise.reject(e);
  }
};
