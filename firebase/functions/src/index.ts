import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {FirebaseFunctionsResponse,
  isFirebaseFunctionsResponse,
  LangameUser} from "./models";
import {
  filterOutSendLangameCalls, generateAgoraRtcToken, getUserData,
  handleSendToDevice, hashFnv32a,
  kInvalidRequest,
  kNotificationsCollection,
  kUsersCollection,
} from "./helpers";
// Initialize admin firebase
admin.initializeApp();


/**
 * Update user profile (Firebase Auth and Firestore LangameUser)
 * @type {HttpsFunction & Runnable<any>}
 */
exports.updateProfile = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    return {
      statusCode: 401,
      errorMessage: "not authenticated",
    };
  }
  functions.logger.info(data);
  if (data === null) {
    return {
      statusCode: 400,
      errorMessage: kInvalidRequest,
    };
  }
  return await admin
      .firestore()
      .collection(kUsersCollection)
      .doc(context.auth.uid)
      .update(data).then((_) => {
        return {
          statusCode: 200,
          errorMessage: null,
        };
      }).catch((e) => {
        return {
          statusCode: 500,
          errorMessage: e,
        };
      });
});

/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.saveToken = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    return new FirebaseFunctionsResponse(
        401,
        undefined,
        "not authenticated",
    );
  }
  if (data === null) {
    return new FirebaseFunctionsResponse(
        400,
        undefined,
        kInvalidRequest,
    );
  }

  if (!data.tokens) {
    return new FirebaseFunctionsResponse(
        400,
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
        return {
          statusCode: 200,
          errorMessage: null,
        };
      }).catch((e) => {
        return {
          statusCode: 500,
          errorMessage: e,
        };
      });
});


/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.sendLangame = functions.https.onCall(async (data, context) => {
  // Check request body is ok
  const initialChecks = filterOutSendLangameCalls(data, context);
  if (initialChecks !== 0) return initialChecks;
  // Get recipients data from firestore
  const recipientsData: Array<FirebaseFunctionsResponse | LangameUser> =
      data.recipients.map(async (r: string) => await getUserData(r));
  // Failed ? Return error
  if (recipientsData
      .some((r: FirebaseFunctionsResponse | LangameUser) =>
        isFirebaseFunctionsResponse(r))) {
    return recipientsData.find((e: FirebaseFunctionsResponse | LangameUser) =>
      isFirebaseFunctionsResponse(e)); // TODO: how to aggregate errors?
  }
  // Get sender data from firestore
  const senderData: FirebaseFunctionsResponse | LangameUser =
      await getUserData(context.auth!.uid);
  // Failed ? Return error
  if (isFirebaseFunctionsResponse(senderData)) return senderData;

  // TODO: is it really 100% atomic?
  const channelName: string | number =
      hashFnv32a(senderData.uid!, true, Date.now());
  // Somehow, shouldn't happen
  if (typeof channelName === "number") {
    return new FirebaseFunctionsResponse(500,
        undefined,
        "failed to generate agora channel name");
  }


  const results = await recipientsData
      // @ts-ignore
      .map(async (e: LangameUser, i: number) => {
        // Generate the Agora token
        const agoraRtcToken = generateAgoraRtcToken(channelName, i);
        const notificationPayload = {
          data: {
            // Assigning notification id later
            id: "",
            senderUid: context.auth!.uid,
            recipientUid: e.uid,
            // Topic of the Langame
            topic: data.topic,
            // Channel user id number required for agora
            agoraUid: i,
            // A channel is created for this Langame
            agoraChannelName: channelName,
            // A token is generated for these users for this channel
            agoraRtcToken: agoraRtcToken,
          },
          notification: {
            // Notification is tagged by sender uid
            // If specified and a notification with the same tag is a
            // already being shown, the new notification replaces
            // the existing one in the notification drawer.
            // Android only
            tag: context.auth!.uid,
            body: `${senderData.displayName} invited you to play ${data.topic}`,
            title: `Play ${data.topic} with ${senderData.displayName}?`,
          },
        };

        const notification = await admin
            .firestore()
            .collection(kNotificationsCollection)
            .add(notificationPayload);
        notificationPayload.data.id = notification.id;

        return await handleSendToDevice(e,
            notificationPayload,
            admin.messaging().sendToDevice(
                e.tokens!,
                // @ts-ignore
                notificationPayload,
                {
                  // Required for background/quit data-only messages on iOS
                  contentAvailable: true,
                  // Required for background/quit data-only messages on Android
                  priority: "high",
                }
            ),
        );
      });

  // Failed ? Return error
  if (results
      // @ts-ignore
      .some((r: FirebaseFunctionsResponse | LangameUser) =>
        isFirebaseFunctionsResponse(r))) {
    return recipientsData.find((e: FirebaseFunctionsResponse | LangameUser) =>
      isFirebaseFunctionsResponse(e)); // TODO: how to aggregate errors?
  }
  // Succeed, results is string[]
  return new FirebaseFunctionsResponse(200, results, undefined);
});


/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.sendReadyForLangame = functions.https.onCall(async (data, context) => {
  const initialChecks = filterOutSendLangameCalls(data, context);
  if (initialChecks !== 0) return initialChecks;
  // Get recipients data from firestore
  const recipientsData: Array<FirebaseFunctionsResponse | LangameUser> =
      data.recipients.map(async (r: string) => await getUserData(r));
  // Failed ? Return error
  if (recipientsData
      .some((r: FirebaseFunctionsResponse | LangameUser) =>
        isFirebaseFunctionsResponse(r))) {
    return recipientsData.find((e: FirebaseFunctionsResponse | LangameUser) =>
      isFirebaseFunctionsResponse(e)); // TODO: how to aggregate errors?
  }
  // Get sender data from firestore
  const senderData: FirebaseFunctionsResponse | LangameUser =
      await getUserData(context.auth!.uid);
  // Failed ? Return error
  if (isFirebaseFunctionsResponse(senderData)) return senderData;

  if (!data.question) {
    return new FirebaseFunctionsResponse(
        400,
        undefined,
        "invalid question",
    );
  }
  const results = await recipientsData
      // @ts-ignore
      .map(async (e: LangameUser) => {
        const notificationPayload = {
          data: {
            id: "",
            senderUid: context.auth!.uid,
            recipientUid: e.uid,
            topic: data.topic,
            question: data.question,
          },
          notification: {
            tag: context.auth!.uid,
            // eslint-disable-next-line max-len
            body: `${senderData.displayName} is waiting you to play ${data.topic}`,
            title: `Join ${senderData.displayName} to play ${data.topic} now?`,
          },
        };
        const notification = await admin
            .firestore()
            .collection(kNotificationsCollection)
            .add(notificationPayload);
        notificationPayload.data.id = notification.id;

        return handleSendToDevice(e,
            notificationPayload,
            admin.messaging().sendToDevice(
            e.tokens!,
            // @ts-ignore
            notificationPayload,
            {
              // Required for background/quit data-only messages on iOS
              contentAvailable: true,
              // Required for background/quit data-only messages on Android
              priority: "high",
            }
            ));
      });

  // Failed ? Return error
  if (results
      // @ts-ignore
      .some((r: FirebaseFunctionsResponse | LangameUser) =>
        isFirebaseFunctionsResponse(r))) {
    return recipientsData.find((e: FirebaseFunctionsResponse | LangameUser) =>
      isFirebaseFunctionsResponse(e)); // TODO: how to aggregate errors?
  }
  // Succeed, results is string[]
  return new FirebaseFunctionsResponse(200, results, undefined);
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
