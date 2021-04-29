import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {
  FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode,
  isFirebaseFunctionsResponse,
  LangameNotification,
  LangameUser,
} from "./models";
import {
  generateAgoraRtcToken, getLangame,
  getUserData,
  handleSendToDevice,
  kBetasCollection,
  kInvalidRequest,
  kNotAuthenticated,
  kNotificationsCollection, kUsersCollection,
} from "./helpers";
import {newFeedback} from "./feedback";
import {sendLangameEnd} from "./sendLangameEnd";
import {sendLangame} from "./sendLangame";
import {interactionsDecrement} from "./scheduledFunctions";
// Initialize admin firebase
admin.initializeApp();
admin.firestore().settings({ignoreUndefinedProperties: true});
console.log("refresh");
/*
 admin.auth() // TODO: should kick everyone
     .listUsers()
     .then((r) => r.users.forEach((u) =>
     functions.logger.info(u.displayName)
     /* admin.auth().revokeRefreshTokens(u.uid)* /));
*/

// see https://firebase.google.com/docs/reference/functions/function_configuration_.runtimeoptions
const runtimeOpts = {
  maxInstances: 10,
};
// TODO: somehow doesn't work then on client
const region = "us-central1";

const callers = new Map();
const maxCalls = 10;
// TODO: wtf how can it work?
// Every 10 seconds, reduce the rate limit of every caller by one
setInterval(() => {
  callers.forEach(function(part, index, callers) {
    if (part === 0) return;
    callers.set(index, part-1);
  });
}, 10_00);

/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.subscribe = functions // TODO: transaction!!!
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(async (data, context) => {
      const caller = callers.get(context.rawRequest.headers.origin);
      if (caller > maxCalls) {
        return new FirebaseFunctionsResponse(
            429,
            undefined,
            "too many requests",
        );
      }
      callers.set(context.rawRequest.headers.origin, caller ? caller+1 : 1);

      if (!data) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            kInvalidRequest,
        );
      }
      if (!data.email) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            "you must provide a valid email",
        );
      }

      functions.logger.info("trying to register new beta user", data.email);

      const existing = await admin
          .firestore()
          .collection(kBetasCollection)
          .where("email", "==", data.email)
          .get();

      if (existing.docs.some((d) => d.exists)) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            "already subscribed",
        );
      }


      return admin
          .firestore()
          .collection(kBetasCollection)
          .add({email: data.email, date: Date.now()})
          .then((_) => {
            functions.logger.info("new beta user", data.email);
            return new FirebaseFunctionsResponse(
                FirebaseFunctionsResponseStatusCode.OK,
                undefined,
                undefined,
            );
          }).catch((e) => {
            functions.
                logger.
                error("failed to add new beta user", data.email, e);

            return new FirebaseFunctionsResponse(
                FirebaseFunctionsResponseStatusCode.INTERNAL,
                undefined,
                "failed to add beta email",
            );
          });
    });


exports.interactionsDecrement = functions
    .pubsub
    .schedule("1 * * * *")
    .onRun(interactionsDecrement);

/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.sendLangameEnd = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(sendLangameEnd);

/**
 * Generate an audio channel token for the user
 * @type {HttpsFunction & Runnable<any>}
 */
exports.getChannelToken = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(async (data, context) => {
      if (!context.auth) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
            undefined,
            kNotAuthenticated,
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
            "you must provide a valid channel name",
        );
      }

      const langame = await getLangame(data.channelName);
      if ("statusCode" in langame) return langame;
      const player = langame.players
          .find((p: any) => p.langameUid === context.auth!.uid);

      if (!player) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            "could not find user in this channel",
        );
      }
      const agoraRtcToken =
      generateAgoraRtcToken(data.channelName, player.channelUid);
      return new FirebaseFunctionsResponse(
          FirebaseFunctionsResponseStatusCode.OK,
          {channelToken: agoraRtcToken},
          undefined,
      );
    });

/**
 * Update user profile (Firebase Auth and Firestore LangameUser)
 * @type {HttpsFunction & Runnable<any>}
 */
exports.updateProfile = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(async (data, context) => {
      if (!context.auth) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
            undefined,
            kNotAuthenticated,
        );
      }
      if (!data) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            kInvalidRequest,
        );
      }
      return await admin
          .firestore()
          .collection(kUsersCollection)
          .doc(context.auth.uid)
          .update(data).then((_) => {
            return new FirebaseFunctionsResponse(
                FirebaseFunctionsResponseStatusCode.OK,
                undefined,
                undefined,
            );
          }).catch((e) => {
            return new FirebaseFunctionsResponse(
                FirebaseFunctionsResponseStatusCode.INTERNAL,
                undefined,
                e,
            );
          });
    });

/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */ // TODO: rename
exports.saveToken = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(async (data, context) => {
      if (!context.auth) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
            undefined,
            kNotAuthenticated,
        );
      }
      if (data === null) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            kInvalidRequest,
        );
      }

      if (!data.tokens) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
            undefined,
            "you must provide token(s)",
        );
      }

      // Save user device token(s) to Firestore, used to send notifications
      return await admin
          .firestore()
          .collection(kUsersCollection)
          .doc(context.auth.uid)
          .update({
            "tokens": admin.firestore.FieldValue.arrayUnion(...data.tokens),
          }).then((_) => {
            return new FirebaseFunctionsResponse(
                FirebaseFunctionsResponseStatusCode.OK,
                undefined,
                undefined,
            );
          }).catch((e) => {
            return new FirebaseFunctionsResponse(
                FirebaseFunctionsResponseStatusCode.INTERNAL,
                undefined,
                e,
            );
          });
    });


/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.sendLangame = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(sendLangame);


/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.notifyPresence = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(async (data, context) => {
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
      const playersExceptSelf = langame.players.filter((p) =>
        p.langameUid != context.auth!.uid);
      if (playersExceptSelf.length === 0) {
        return new FirebaseFunctionsResponse(
            FirebaseFunctionsResponseStatusCode.INTERNAL,
            undefined,
            "could not find any players in this Langame",
        );
      }
      // Get players data from firestore (need their messaging tokens)
      const recipientsData: Array<FirebaseFunctionsResponse | LangameUser> = [];
      for (const r of playersExceptSelf) {
        const user = await getUserData(r.langameUid);
        if ("statusCode" in user) return user;
        recipientsData.push(user);
      }
      // Get sender data from firestore
      const senderData: FirebaseFunctionsResponse | LangameUser =
      await getUserData(context.auth!.uid);
      // Failed ? Return error
      if ("statusCode" in senderData) return senderData;

      const recipientsUid = recipientsData.map((r) => (r as LangameUser).uid);

      const results = await recipientsData
      // @ts-ignore
          .map(async (e: LangameUser) => {
            const notificationPayload = new LangameNotification(
                {
                  senderUid: context.auth!.uid,
                  // @ts-ignore
                  recipientsUid: recipientsUid,
                  topics: langame.topics,
                  channelName: langame.channelName,
                  ready: true,
                });
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
        !isFirebaseFunctionsResponse(r));
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
    });

// https://firebase.google.com/docs/functions/gcp-storage-events
exports.onFeedback = functions
    .region(region)
    .storage.object()
    .onFinalize(async (object) => {
      if (!object.name?.startsWith("feedbacks") ||
          !object.mediaLink ||
            !object.metadata) {
        return;
      }
      functions.logger.info("new feedback", JSON.stringify(object));
      await newFeedback(object.mediaLink, object.metadata);
    }
    );
