// The Cloud Functions for Firebase SDK to create Cloud Functions
// and setup triggers.
const functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");

// Initialize admin firebase
admin.initializeApp();

const kUserDoesNotExist = (id) => `user ${id} does not exist`;
const kInvalidRequest = "invalid request";
const kUsersCollection = "users";
const kNotificationsCollection = "notifications";
//
// class LangameUser {
//   // / [uid] is set by Firebase authentication
//   uid = "";
//   email = "";
//   displayName = "";
//   // bool emailVerified = false;
//   phoneNumber = "";
//   photoUrl = "";
//
//   // / Is the user [online]?
//   online = false;
//
//   // / Google account linked?
//   google = false;
//
//   // / Facebook account linked?
//   facebook = false;
//
//   // / Apple account linked?
//   apple = false;
//
//   // / Favourite topics the user has picked, should impact recommendations
//   favouriteTopics = [];
//
//   // / [isALangameUser] signifies whether this user is an imported contact
//   // / or really someone who registered on Langame
//   isALangameUser = false;
//
//   // / Twitter-like [tag] i.e. @steveTheApple
//   tag = "";
//
//   // / Device [tokens] used for Cloud Messaging
//   tokens = [];
//   // constructor(height, width) {
//   //   this.height = height;
//   //   this.width = width;
//   // }
// }


/**
 * Update user profile (Firebase Auth and Firestore LangameUser)
 * @type {HttpsFunction & Runnable<any>}
 */
exports.updateProfile = functions.https.onCall(async (data, context) => {
  if (context.auth === null) {
    return {
      statusCode: 401,
      errorMessage: "not authenticated",
    };
  }

  console.log(data);
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
  if (context.auth === null) {
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

const filterOutSendLangameCalls = (data, context) => {
  if (context.auth === null) {
    return {
      result: null,
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

const getUserData = async (id) => {
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

  if (!data.tokens) {
    return {
      result: null,
      statusCode: 500,
      errorMessage: `user ${id} has no devices (tokens)`,
    };
  }

  if (!data.uid) {
    return {
      result: null,
      statusCode: 500,
      errorMessage: `user ${id} has no uid`,
    };
  }

  if (!data.displayName) {
    return {
      result: null,
      statusCode: 500,
      errorMessage: `user ${id} has no displayName`,
    };
  }
  return data;
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
  if (recipientData.statusCode) return recipientData;
  const senderData = await getUserData(context.auth.uid);
  // Failed ? Return error
  if (senderData.statusCode) return senderData;
  const notificationPayload = {
    data: {
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

  return admin.messaging().sendToDevice(
      recipientData.tokens,
      notificationPayload,
      {
      // Required for background/quit data-only messages on iOS
        contentAvailable: true,
        // Required for background/quit data-only messages on Android
        priority: "high",
      }
  ).then((res) => {
    res.results.forEach((r, i) => {
      const t = recipientData.tokens[i];
      console.warn(`failed ${t}: ${JSON.stringify(r.error)}`);
      // Invalid token, remove it
      if (r.error &&
        r.error.code ===
        "messaging/registration-token-not-registered" &&
        t) {
        admin
            .firestore()
            .collection(kUsersCollection)
            .doc(recipientData.uid)
            .update({
              tokens: admin.firestore.FieldValue
                  .arrayRemove(t),
            }).then(() => console.warn(`removed invalid token ${t}`))
            .catch(() => console.error(`failed to remove invalid token ${t}`));
      }
    });
    return {
      result: notificationPayload.id,
      statusCode: 200,
      errorMessage: null,
    };
  }).catch((e) => {
    console.error(`sendLangame failed: ${JSON.stringify(e)}`);
    return {result: null, statusCode: 500, errorMessage: JSON.stringify(e)};
  });
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
  if (recipientData.statusCode) return recipientData;
  const senderData = await getUserData(context.auth.uid);
  // Failed ? Return error
  if (senderData.statusCode) return senderData;

  if (!data.question) {
    return {
      result: null,
      statusCode: 400,
      errorMessage: "invalid question",
    };
  }

  const notificationPayload = {
    data: {
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

  return admin.messaging().sendToDevice(
      recipientData.tokens,
      notificationPayload,
      {
      // Required for background/quit data-only messages on iOS
        contentAvailable: true,
        // Required for background/quit data-only messages on Android
        priority: "high",
      }
  ).then((res) => {
    res.results.forEach((r, i) => {
      const t = recipientData.tokens[i];
      console.warn(`failed ${t}: ${JSON.stringify(r.error)}`);
      // Invalid token, remove it
      if (r.error &&
        r.error.code ===
        "messaging/registration-token-not-registered" &&
        t) {
        admin
            .firestore()
            .collection(kUsersCollection)
            .doc(recipientData.uid)
            .update({
              tokens: admin.firestore.FieldValue
                  .arrayRemove(t),
            }).then(() => console.warn(`removed invalid token ${t}`))
            .catch(() => console.error(`failed to remove invalid token ${t}`));
      }
    });
    return {
      result: notificationPayload.id,
      statusCode: 200,
      errorMessage: null,
    };
  }).catch((e) => {
    console.error(`sendLangame failed: ${JSON.stringify(e)}`);
    return {result: null, statusCode: 500, errorMessage: JSON.stringify(e)};
  });
});

if (process.env.FUNCTIONS_EMULATOR && process.env.FIRESTORE_EMULATOR_HOST) {
  const nbUsers = 10;
  deleteAllPepes(
      admin.firestore(),
      "users",
      10_000,
  ).then(() => {
    console.log("Cleared data");
    for (let i = 0; i < nbUsers; i++) {
      const uid = uuidv4();
      const userDoc = {
        "uid": uid,
        "email": null,
        "displayName": "pepe" + uid,
        "tag": "pepe" + uid,
        // "emailVerified": false,
        "phoneNumber": null,
        "photoUrl": "https://c.files.bbci.co.uk/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg",
        "online": true,
        "google": false,
        "apple": false,
        "facebook": false,
        "favouriteTopics": [],
        "isALangameUser": true,
        "tokens": [],
        // "friends": [],
      };
      admin.firestore()
          .collection(kUsersCollection)
          .doc(userDoc.uid).set(userDoc);
    }
    console.log("Generated", nbUsers, "users");
  });
}

/**
 *
 * @return {string}
 */
function uuidv4() {
  return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function(c) {
    const r = Math.random() * 16 | 0;
    const v = c == "x" ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

/**
 *
 * @param{FirebaseFirestore.Firestore} db
 * @param{string} collectionPath
 * @param{number} batchSize
 * @return {Promise<void>}
 */
// eslint-disable-next-line no-unused-vars,require-jsdoc
async function deleteCollection(db, collectionPath, batchSize) {
  const collectionRef = db.collection(collectionPath);
  const query = collectionRef.orderBy("__name__").limit(batchSize);

  return new Promise((resolve, reject) => {
    deleteQueryBatch(db, query, resolve).catch(reject);
  });
}

/**
 *
 * @param{FirebaseFirestore.Firestore} db
 * @param{string} collectionPath
 * @param{number} batchSize
 * @param{string} tag
 * @return {Promise<void>}
 */
async function deleteAllPepes(db,
    collectionPath,
    batchSize) {
  const collectionRef = db.collection(collectionPath);
  const query = collectionRef
      .where("photoUrl", "==", "https://c.files.bbci.co.uk/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg")
      .orderBy("__name__")
      .limit(batchSize);

  return new Promise((resolve, reject) => {
    deleteQueryBatch(db, query, resolve).catch(reject);
  });
}

/**
 *
 * @param{any} db
 * @param{any} query
 * @param{any} resolve
 * @return {Promise<void>}
 */
async function deleteQueryBatch(db, query, resolve) {
  const snapshot = await query.get();

  const batchSize = snapshot.size;
  if (batchSize === 0) {
    // When there are no documents left, we are done
    resolve();
    return;
  }

  // Delete documents in a batch
  const batch = db.batch();
  snapshot.docs.forEach((doc) => {
    batch.delete(doc.ref);
  });
  await batch.commit();

  // Recurse on the next process tick, to avoid
  // exploding the stack.
  process.nextTick(() => {
    deleteQueryBatch(db, query, resolve);
  });
}
