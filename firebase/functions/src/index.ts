import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Initialize admin firebase
admin.initializeApp();
const kUserDoesNotExist = (id: string) => `user ${id} does not exist`;
const kInvalidRequest: string = "invalid request";
const kUsersCollection: string = "users";
const kNotificationsCollection: string = "notifications";

/**
 * LangameUser represents a Langame user
 */
class LangameUser {
    // / [uid] is set by Firebase authentication
    uid?: string; // TODO: shouldn't be nullable
    email?: string;
    displayName?: string;
    // bool emailVerified = false;
    phoneNumber?: string;
    photoUrl?: string;

    // / Is the user [online]?
    online: boolean = false;

    // / Google account linked?
    google: boolean = false;

    // / Facebook account linked?
    facebook: boolean = false;

    // / Apple account linked?
    apple: boolean = false;

    // / Favourite topics the user has picked, should impact recommendations
    favouriteTopics?: string[];

    // / [isALangameUser] signifies whether this user is an imported contact
    // / or really someone who registered on Langame
    isALangameUser: boolean = false;

    // / Twitter-like [tag] i.e. @steveTheApple
    tag?: string;

    // / Device [tokens] used for Cloud Messaging
    tokens?: string[];

    /**
     *
     * @param{string} uid
     * @param{string} email
     * @param{string} displayName
     * @param{string} phoneNumber
     * @param{string} photoUrl
     * @param{boolean} online
     * @param{boolean} google
     * @param{boolean} facebook
     * @param{boolean} apple
     * @param{array} favouriteTopics
     * @param{string} tag
     * @param{array} tokens
     */
    constructor(uid: string,
        email: string,
        displayName: string,
        phoneNumber: string,
        photoUrl: string,
        online: boolean = false,
        google: boolean = false,
        facebook: boolean = false,
        apple: boolean = false,
        favouriteTopics: string[],
        tag: string,
        tokens: string[]) {
      this.uid = uid;
      this.email = email;
      this.displayName = displayName;
      this.phoneNumber = phoneNumber;
      this.photoUrl = photoUrl;
      this.online = online;
      this.google = google;
      this.facebook = facebook;
      this.apple = apple;
      this.favouriteTopics = favouriteTopics;
      this.tag = tag;
      this.tokens = tokens;
    }
}

/**
 * Check if object is a LangameUser
 * @param{any} obj
 * @return{boolean}
 */
function isLangameUser(obj: any): obj is LangameUser {
  // Checking typical LangameUser properties
  return typeof obj.uid === "string" && typeof obj.google === "boolean";
}

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
    return {
      statusCode: 401,
      errorMessage: "not authenticated",
    };
  }
  if (data === null) {
    return {
      statusCode: 400,
      errorMessage: kInvalidRequest,
    };
  }

  if (!data.tokens) {
    return {
      statusCode: 400,
      errorMessage: "you must provide token(s)",
    };
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

const filterOutSendLangameCalls =
    (data: any, context: functions.https.CallableContext) => {
      if (!context.auth) {
        return {
          result: null,
          statusCode: 401,
          errorMessage: "not authenticated",
        };
      }

      if (!data) {
        return {
          statusCode: 400,
          errorMessage: kInvalidRequest,
        };
      }

      if (!data.recipient) {
        return {
          result: null,
          statusCode: 400,
          errorMessage: "invalid recipient",
        };
      }

      if (!data.topic) {
        return {
          result: null,
          statusCode: 400,
          errorMessage: "invalid topic",
        };
      }
      return 0;
    };

const getUserData = async (id: string) => {
  const recipient = await admin
      .firestore()
      .collection(kUsersCollection)
      .doc(id)
      .get();
  if (!recipient.exists) {
    return {
      result: null,
      statusCode: 400,
      errorMessage: kUserDoesNotExist(id),
    };
  }


  const data = recipient.data();

  if (!data) {
    return {
      result: null,
      statusCode: 400,
      errorMessage: kUserDoesNotExist(id),
    };
  }

  if (!isLangameUser(data)) {
    return {
      result: null,
      statusCode: 400,
      errorMessage: kUserDoesNotExist(id),
    };
  }

  const dataAsLangameUser = data as LangameUser;

  if (!dataAsLangameUser.tokens) {
    return {
      result: null,
      statusCode: 500,
      errorMessage: `user ${id} has no devices (tokens)`,
    };
  }

  if (!dataAsLangameUser.uid) {
    return {
      result: null,
      statusCode: 500,
      errorMessage: `user ${id} has no uid`,
    };
  }

  if (!dataAsLangameUser.displayName) {
    return {
      result: null,
      statusCode: 500,
      errorMessage: `user ${id} has no displayName`,
    };
  }
  return dataAsLangameUser;
};

const handleSendToDevice = (recipientData: LangameUser,
    notificationPayload: any,
    promise: Promise<admin.messaging.MessagingDevicesResponse>) => {
  return promise.then((res) => {
    res.results.forEach((r, i) => {
      const t = recipientData.tokens![i];
      functions.logger.warn("failed", t, r.error);
      // Invalid token, remove it
      if (r.error &&
                r.error.code ===
                "messaging/registration-token-not-registered" &&
                t) {
        admin
            .firestore()
            .collection(kUsersCollection)
            .doc(recipientData.uid!)
            .update({
              tokens: admin.firestore.FieldValue
                  .arrayRemove(t),
            }).then(() => functions.logger.warn("removed invalid token", t))
            .catch(() =>
              functions.logger.error("failed to remove invalid token", t));
      }
    });
    return {
      result: notificationPayload.data.id,
      statusCode: 200,
      errorMessage: null,
    };
  }).catch((e) => {
    functions.logger.error("sendLangame failed", e);
    return {result: null, statusCode: 500, errorMessage: JSON.stringify(e)};
  });
};

/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.sendLangame = functions.https.onCall(async (data, context) => {
  const initialChecks = filterOutSendLangameCalls(data, context);
  if (initialChecks !== 0) return initialChecks;
  const recipientData = await getUserData(data.recipient);
  // Failed ? Return error
  if ("statusCode" in recipientData) return recipientData;
  // @ts-ignore
  const senderData = await getUserData(context.auth.uid);
  // Failed ? Return error
  if ("statusCode" in senderData) return senderData;

  const notificationPayload = {
    data: {
      id: "",
      // @ts-ignore
      senderUid: context.auth.uid,
      recipientUid: recipientData.uid,
      topic: data.topic,
    },
    notification: {
      // Notification is tagged by sender uid
      // If specified and a notification with the same tag is a
      // already being shown, the new notification replaces
      // the existing one in the notification drawer.
      // Android only
      // @ts-ignore
      tag: context.auth.uid,
      body: `${senderData.displayName} invited you to play ${data.topic}`,
      title: `Play ${data.topic} with ${senderData.displayName}?`,
    },
  };

  const notification = await admin
      .firestore()
      .collection(kNotificationsCollection)
      .add(notificationPayload);
  notificationPayload.data.id = notification.id;

  return handleSendToDevice(recipientData,
      notificationPayload,
      admin.messaging().sendToDevice(
        recipientData.tokens!,
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


/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.sendReadyForLangame = functions.https.onCall(async (data, context) => {
  const initialChecks = filterOutSendLangameCalls(data, context);
  if (initialChecks !== 0) return initialChecks;
  const recipientData = await getUserData(data.recipient);
  // Failed ? Return error
  if ("statusCode" in recipientData) return recipientData;
  // @ts-ignore
  const senderData = await getUserData(context.auth.uid);
  // Failed ? Return error
  if ("statusCode" in senderData) return senderData;

  if (!data.question) {
    return {
      result: null,
      statusCode: 400,
      errorMessage: "invalid question",
    };
  }

  const notificationPayload = {
    data: {
      id: "",
      // @ts-ignore
      senderUid: context.auth.uid,
      recipientUid: recipientData.uid,
      topic: data.topic,
      question: data.question,
    },
    notification: {
      // Notification is tagged by sender uid
      // If specified and a notification with the same tag is a
      // already being shown, the new notification replaces
      // the existing one in the notification drawer.
      // Android only
      // @ts-ignore
      tag: context.auth.uid,
      body: `${senderData.displayName} is waiting you to play ${data.topic}`,
      title: `Join ${senderData.displayName} to play ${data.topic} now?`,
    },
  };
  const notification = await admin
      .firestore()
      .collection(kNotificationsCollection)
      .add(notificationPayload);
  notificationPayload.data.id = notification.id;

  return handleSendToDevice(recipientData,
      notificationPayload,
      admin.messaging().sendToDevice(
        recipientData.tokens!,
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
