"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const models_1 = require("./models");
const helpers_1 = require("./helpers");
// Initialize admin firebase
admin.initializeApp();
admin.firestore().settings({ ignoreUndefinedProperties: true });
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
// TODO: spawn function in EU!!
/**
 * Generate an audio channel token for the user
 * @type {HttpsFunction & Runnable<any>}
 */
exports.getChannelToken = functions
    .runWith(runtimeOpts)
    .https
    .onCall(async (data, context) => {
    if (!context.auth) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.UNAUTHORIZED, undefined, helpers_1.kNotAuthenticated);
    }
    if (!data) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.BAD_REQUEST, undefined, helpers_1.kInvalidRequest);
    }
    if (!data.channelName) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.BAD_REQUEST, undefined, "you must provide a valid channel name");
    }
    const langame = await helpers_1.getLangame(data.channelName);
    if ("statusCode" in langame)
        return langame;
    const player = langame.players
        .find((p) => p.langameUid === context.auth.uid);
    if (!player) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.BAD_REQUEST, undefined, "could not find user in this channel");
    }
    const agoraRtcToken = helpers_1.generateAgoraRtcToken(data.channelName, player.channelUid);
    return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.OK, [agoraRtcToken], undefined);
});
/**
 * Update user profile (Firebase Auth and Firestore LangameUser)
 * @type {HttpsFunction & Runnable<any>}
 */
exports.updateProfile = functions
    .runWith(runtimeOpts)
    .https
    .onCall(async (data, context) => {
    if (!context.auth) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.UNAUTHORIZED, undefined, helpers_1.kNotAuthenticated);
    }
    if (!data) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.BAD_REQUEST, undefined, helpers_1.kInvalidRequest);
    }
    return await admin
        .firestore()
        .collection(helpers_1.kUsersCollection)
        .doc(context.auth.uid)
        .update(data).then((_) => {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.OK, undefined, undefined);
    }).catch((e) => {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.INTERNAL, undefined, e);
    });
});
/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */ // TODO: rename
exports.saveToken = functions
    .runWith(runtimeOpts)
    .https
    .onCall(async (data, context) => {
    if (!context.auth) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.UNAUTHORIZED, undefined, helpers_1.kNotAuthenticated);
    }
    if (data === null) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.BAD_REQUEST, undefined, helpers_1.kInvalidRequest);
    }
    if (!data.tokens) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.BAD_REQUEST, undefined, "you must provide token(s)");
    }
    // Save user device token(s) to Firestore, used to send notifications
    return await admin
        .firestore()
        .collection(helpers_1.kUsersCollection)
        .doc(context.auth.uid)
        .update({
        "tokens": admin.firestore.FieldValue.arrayUnion(...data.tokens),
    }).then((_) => {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.OK, undefined, undefined);
    }).catch((e) => {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.INTERNAL, undefined, e);
    });
});
/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.sendLangame = functions
    .runWith(runtimeOpts)
    .https
    .onCall(async (data, context) => {
    // Check request body is ok
    const initialChecks = helpers_1.filterOutSendLangameCalls(data, context);
    if (initialChecks !== 0)
        return initialChecks;
    // Get recipients data from firestore
    const recipientsData = [];
    for (const r of data.recipients) {
        const user = await helpers_1.getUserData(r);
        if ("statusCode" in user)
            return user;
        recipientsData.push(user);
    }
    // Get sender data from firestore
    const senderData = await helpers_1.getUserData(context.auth.uid);
    // Failed ? Return error
    if (models_1.isFirebaseFunctionsResponse(senderData))
        return senderData;
    // TODO: is it really 100% atomic?
    const channelName = helpers_1.hashFnv32a(senderData.uid, true, Date.now());
    // Somehow, shouldn't happen
    if (typeof channelName === "number") {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.INTERNAL, undefined, "failed to generate channel name");
    }
    const recipientsUid = recipientsData.map((r) => r.uid);
    const playersLangameUid = recipientsUid.concat([senderData.uid]);
    await admin
        .firestore()
        .collection(helpers_1.kLangamesCollection)
        .add(JSON.parse(JSON.stringify(new models_1.LangameChannel({
        channelName: channelName,
        players: playersLangameUid.map((e, i) => {
            // i.e. mapping channel user id -> Langame user id
            return new models_1.ChannelUserLangameUser({
                channelUid: i + 1,
                langameUid: e,
            });
        }),
        topics: data.topics,
        questions: [],
    })))); // TODO: might check error?
    const results = await recipientsData
        // @ts-ignore
        .map(async (e) => {
        const notificationPayload = new models_1.LangameNotification({
            senderUid: context.auth.uid,
            // @ts-ignore
            recipientsUid: recipientsUid,
            // Topics of the Langame
            topics: data.topics,
            channelName: channelName,
        });
        const notification = await admin
            .firestore()
            .collection(helpers_1.kNotificationsCollection)
            .add(JSON.parse(JSON.stringify(notificationPayload)));
        return await helpers_1.handleSendToDevice(e, notification.id, admin.messaging().sendToDevice(e.tokens, {
            data: { id: notification.id },
            notification: {
                tag: context.auth.uid,
                // eslint-disable-next-line max-len
                body: `${senderData.displayName} invited you to play ${data.topics.join(",")}`,
                // eslint-disable-next-line max-len
                title: `Play ${data.topics.join(",")} with ${senderData.displayName}?`,
            },
        }, {
            // Required for background/quit data-only messages on iOS
            contentAvailable: true,
            // Required for background/quit data-only messages on Android
            priority: "high",
        }));
    });
    const successfulResults = results.filter((r) => !models_1.isFirebaseFunctionsResponse(r));
    // If all failed
    if (successfulResults.length === 0) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.INTERNAL, undefined, "could not send Langame");
    }
    // TODO: might send a notification to the sender to offer joining now?
    // Succeed
    return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.OK, undefined, undefined);
});
/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.sendReadyForLangame = functions
    .runWith(runtimeOpts)
    .https
    .onCall(async (data, context) => {
    if (!context.auth) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.UNAUTHORIZED, undefined, "not authenticated");
    }
    if (!data) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.BAD_REQUEST, undefined, helpers_1.kInvalidRequest);
    }
    if (!data.channelName) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.BAD_REQUEST, undefined, "you must provide a channel name");
    }
    const langame = await helpers_1.getLangame(data.channelName);
    if ("statusCode" in langame)
        return langame;
    // We need to filter players with self,
    // do not want to send self notification
    const playersExceptSelf = langame.players.filter((p) => p.langameUid != context.auth.uid);
    if (playersExceptSelf.length === 0) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.INTERNAL, undefined, "could not find any players in this Langame");
    }
    // Get players data from firestore (need their messaging tokens)
    const recipientsData = [];
    for (const r of playersExceptSelf) {
        const user = await helpers_1.getUserData(r.langameUid);
        if ("statusCode" in user)
            return user;
        recipientsData.push(user);
    }
    // Get sender data from firestore
    const senderData = await helpers_1.getUserData(context.auth.uid);
    // Failed ? Return error
    if ("statusCode" in senderData)
        return senderData;
    const recipientsUid = recipientsData.map((r) => r.uid);
    const results = await recipientsData
        // @ts-ignore
        .map(async (e) => {
        const notificationPayload = new models_1.LangameNotification({
            senderUid: context.auth.uid,
            // @ts-ignore
            recipientsUid: recipientsUid,
            topics: langame.topics,
            channelName: langame.channelName,
            ready: true,
        });
        const notification = await admin
            .firestore()
            .collection(helpers_1.kNotificationsCollection)
            .add(JSON.parse(JSON.stringify(notificationPayload)));
        return helpers_1.handleSendToDevice(e, notification.id, admin.messaging().sendToDevice(e.tokens, {
            data: { id: notification.id },
            notification: {
                tag: context.auth.uid,
                // eslint-disable-next-line max-len
                body: `${senderData.displayName} is waiting you to play ${langame.topics.join(",")}`,
                // eslint-disable-next-line max-len
                title: `Join ${senderData.displayName} to play ${langame.topics.join(",")} now?`,
            },
        }, {
            // Required for background/quit data-only messages on iOS
            contentAvailable: true,
            // Required for background/quit data-only messages on Android
            priority: "high",
        }));
    });
    const successfulResults = results.filter((r) => !models_1.isFirebaseFunctionsResponse(r));
    // If all failed
    if (successfulResults.length === 0) {
        return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.INTERNAL, undefined, "could not send ready for Langame");
    }
    // Succeed
    return new models_1.FirebaseFunctionsResponse(models_1.FirebaseFunctionsResponseStatusCode.OK, undefined, undefined);
});
// const fake = () => {
//   const nbUsers = 12;
//   deleteAllPepes(
//       admin.firestore(),
//       10_000,
//   ).then(() => {
//     console.log("Cleared data");
//     for (let i = 0; i < nbUsers; i++) {
//       const uid = uuidv4();
//       const userDoc = new LangameUser(
//           uid,
//           `pepe${uid}@gmail.com`,
//           "pepe" + uid,
//           "",
//           "https://c.files.bbci.co.uk/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg",
//           false,
//           false,
//           false,
//           false,
//           [],
//           "pepe" + uid,
//           []
//       );
//       admin.firestore()
//           .collection(kUsersCollection)
//           .doc(userDoc.uid!).set(JSON.parse(JSON.stringify(userDoc)));
//     }
//     console.log("Generated", nbUsers, "users");
//   });
// };
// fake();
/**
 *
 * @return {string}
 */
// function uuidv4() {
//   return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
//   .replace(/[xy]/g, function(c) {
//     const r = Math.random() * 16 | 0;
//     const v = c == "x" ? r : (r & 0x3 | 0x8);
//     return v.toString(16);
//   });
// }
/**
 *
 * @param{FirebaseFirestore.Firestore} db
 * @param{number} batchSize
 * @return {Promise<void>}
 */
// async function deleteAllPepes(db: firestore.Firestore,
//     batchSize: number) {
//   const collectionRef = db.collection(kUsersCollection);
//   const query = collectionRef
//       .where("photoUrl", "==", "https://c.files.bbci.co.uk/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg")
//       .orderBy("__name__")
//       .limit(batchSize);
//
//   return new Promise((resolve, reject) => {
//     deleteQueryBatch(db, query, resolve).catch(reject);
//   });
// }
/**
 *
 * @param{Firestore} db
 * @param{DocumentData} query
 * @param{number} resolve
 * @return {Promise<void>}
 */
// async function deleteQueryBatch(db: firestore.Firestore,
//     query: firestore.Query<firestore.DocumentData>,
//     // eslint-disable-next-line no-undef
//     resolve: any) {
//   const snapshot = await query.get();
//
//   const batchSize = snapshot.size;
//   if (batchSize === 0) {
//     // When there are no documents left, we are done
//     // @ts-ignore
//     resolve();
//     return;
//   }
//
//   // Delete documents in a batch
//   const batch = db.batch();
//   snapshot.docs
//   .forEach((doc: { ref: firestore.DocumentReference<any>; }) => {
//     batch.delete(doc.ref);
//   });
//   await batch.commit();
//
//   // Recurse on the next process tick, to avoid
//   // exploding the stack.
//   process.nextTick(() => {
//     deleteQueryBatch(db, query, resolve);
//   });
// }
//# sourceMappingURL=index.js.map