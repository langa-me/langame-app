import * as functions from "firebase-functions";
import {
  FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode,
} from "./models";

import * as admin from "firebase-admin";
import {
  handleSendToDevice,
  kInvalidRequest,
  kUserDoesNotExist,
} from "./helpers";
import {getLangame, getUserData} from "./utils/firestore";
import {langame} from "./langame/protobuf/langame";
import FirebaseFunctionsRateLimiter from "firebase-functions-rate-limiter";

const perUserlimiter = FirebaseFunctionsRateLimiter.withFirestoreBackend(
    {
      name: "per_user_limiter",
      maxCalls: 2,
      periodSeconds: 15,
    },
    admin.firestore(),
);

export const notifyPresence = async (data: any,
    context: functions.https.CallableContext) => {
  if (!context.auth) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
        undefined,
        "not authenticated",
    );
  }

  const uidQualifier = "u_" + context.auth.uid;
  const isQuotaExceeded =
  await perUserlimiter.isQuotaAlreadyExceeded(uidQualifier);
  if (isQuotaExceeded) {
    return new FirebaseFunctionsResponse(
        429,
        undefined,
        undefined,
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
  const playersExceptSelf = langame.data()!.players.filter((p: string) =>
    p != context.auth!.uid);
  if (playersExceptSelf.length === 0) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "could not find any players in this Langame",
    );
  }
  // Get players data from firestore (need their messaging tokens)
  const recipientsData: Array<
  admin.firestore.DocumentSnapshot<langame.protobuf.User>> = [];
  for (const r of playersExceptSelf) {
    const user = await getUserData(r);
    if ("statusCode" in user) {
      // TODO: better handle this use case error
      functions.logger.error("invalid user");
      continue;
    }
    if (!user.data()!.tokens) {
      functions.logger
          .error(kUserDoesNotExist(r), "has no devices");
      return new FirebaseFunctionsResponse(
          FirebaseFunctionsResponseStatusCode.INTERNAL,
          undefined,
          `user ${r} has no devices (tokens)`,
      );
    }
    recipientsData.push(user);
  }
  // Get sender data from firestore
  const senderData: FirebaseFunctionsResponse | any =
    await getUserData(context.auth!.uid);
  // Failed ? Return error
  if ("statusCode" in senderData) return senderData;

  const results = recipientsData
      .map(async (e) => {
        return handleSendToDevice(e,
            admin.messaging().sendToDevice(
          e.data()!.tokens!,
          {
            notification: {
              tag: langame.data()!.channelName,
              // eslint-disable-next-line max-len
              body: `${senderData.displayName} is waiting you to play ${langame.data()!.topics.join(",")}`,
              // eslint-disable-next-line max-len
              title: `Join ${senderData.displayName} to play ${langame.data()!.topics.join(",")} now?`,
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
