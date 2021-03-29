// The Cloud Functions for Firebase SDK to create Cloud Functions
// and setup triggers.
const functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");

// Initialize admin firebase
admin.initializeApp();

/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.saveToken = functions.https.onCall(async (data, context) => {
  if (context.auth === null) {
    return {
      result: null,
      statusCode: 401,
      errorMessage: "not authenticated",
    };
  }

  if (!data.tokens) {
    return {
      result: null,
      statusCode: 400,
      errorMessage: "you must provide token(s)",
    };
  }

  // Save user device token(s) to Firestore, used to send notifications
  return await admin
      .firestore()
      .collection("users")
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

const kRecipientDoesNotExist = "recipient does not exist";

/**
 *
 * @type {HttpsFunction & Runnable<any>}
 */
exports.sendLangame = functions.https.onCall(async (data, context) => {
  // TODO: cloud messaging
  // TODO: firestore append notification
  //

  if (context.auth === null) {
    return {
      result: null,
      statusCode: 401,
      errorMessage: "not authenticated",
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

  const recipient = await admin
      .firestore()
      .collection("users")
      .doc(data.recipient)
      .get();
  if (!recipient.exists) {
    return {
      result: null,
      statusCode: 400,
      errorMessage: kRecipientDoesNotExist,
    };
  }

  const recipientData = recipient.data();

  if (!recipientData) {
    return {
      result: null,
      statusCode: 400,
      errorMessage: kRecipientDoesNotExist,
    };
  }

  if (!recipientData.tokens) {
    return {
      result: null,
      statusCode: 500,
      errorMessage: "recipient has no devices (tokens)",
    };
  }

  if (!recipientData.uid) {
    return {
      result: null,
      statusCode: 500,
      errorMessage: "recipient has no uid",
    };
  }

  const notificationData = {
    data: {
      senderUid: context.auth.uid,
      recipientUid: recipientData.uid,
      topic: data.topic,
    },
  };
  const notification = await admin
      .firestore()
      .collection("notifications")
      .add(notificationData);
  notificationData.id = notification.id;
  return admin.messaging().sendToDevice(
      recipientData.tokens,
      notificationData,
      {
      // Required for background/quit data-only messages on iOS
        contentAvailable: true,
        // Required for background/quit data-only messages on Android
        priority: "high",
      }
  ).then((res) => {
    const errors = res.results.filter((e) => e.error !== null);
    if (errors.length > 0) {
      return {result: null, statusCode: 200, errorMessage: errors[0]};
    }
    return {result: notificationData.id, statusCode: 200, errorMessage: null};
  });
});

if (process.env.FUNCTIONS_EMULATOR && process.env.FIRESTORE_EMULATOR_HOST) {
  const nbUsers = 10;
  deleteCollection(admin.firestore(), "users", 10_000).then(() => {
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
      admin.firestore().collection("users").doc(userDoc.uid).set(userDoc);
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
    const r = Math.random() * 16 | 0; const v = c == "x" ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

/**
 *
 * @param{any} db
 * @param{string} collectionPath
 * @param{number} batchSize
 * @return {Promise<void>}
 */
async function deleteCollection(db, collectionPath, batchSize) {
  const collectionRef = db.collection(collectionPath);
  const query = collectionRef.orderBy("__name__").limit(batchSize);

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
