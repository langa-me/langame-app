import {EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {reportError} from "../errors";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {shouldDrop} from "../utils/contexts";
import {notifyUser} from "./messages";

export const onCreateMessage = async (
    snap: admin.firestore.DocumentSnapshot<langame.protobuf.IMessage>,
    ctx: EventContext) => {
  try {
    functions.logger.log(
        "attempts", snap.data()?.delivery?.attempts || 0,
        "status", snap.data()?.delivery?.status || "none",
    );
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
        .withConverter(converter<langame.protobuf.IUser>())
        .doc(snap.data()!.author!.id!)
        .get();
    await db.runTransaction(async (t) => {
      t.set(from.ref, {
        // @ts-ignore // TODO: fix
        rateLimits: {
          message: admin.firestore.FieldValue.serverTimestamp(),
        },
      }, {merge: true});
    });
    const channel = await db
        .collection("langames")
        .withConverter(converter<langame.protobuf.ILangame>())
        .doc(snap.data()!.langameId!)
        .get();
    const toNotify = channel.data()!.players!.filter((e) =>
      e.id !== snap.data()!.author!.id);
    return Promise.all(toNotify.map(async (player) => {
      return notifyUser(snap, from.data()!.tag!, player);
    }));
  } catch (e: any) {
    await reportError(e,
      snap.data()!.author!.id! ? {
        user: snap.data()!.author!.id!,
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
