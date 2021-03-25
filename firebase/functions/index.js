// Protobuf
const protobuf = require("protobufjs");

// The Cloud Functions for Firebase SDK to create Cloud Functions
// and setup triggers.
const functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");

// Initialize admin firebase
admin.initializeApp();

// // Check if a json user object match our proto type
// const verifyUser = async (jsonUser) => {
//   const root = await protobuf.load("./api.proto");
//   const LangameUser = root.lookupType("api.LangameUser");
//   const errMsg = LangameUser.verify(jsonUser);
//   if (errMsg) return errMsg;
//   return null;
// };
//
// exports.onAuthCreate = functions.auth.user().onCreate(async (user) => { // TODO: send mail
//   const userDoc = {
//     "uid": user.uid,
//     "email": user.email,
//     "displayName": user.displayName,
//     "emailVerified": user.emailVerified,
//     "phoneNumber": user.phoneNumber,
//     "photoUrl": user.photoURL,
//     "friends": [],
//   };
//   // const err = await verifyUser(userDoc);
//   // if (err) throw Error(err);
//   console.log("set", userDoc);
//   return admin.firestore().collection("users").doc(user.uid).set(userDoc);
// });
// exports.getUser = functions.https.onCall(async (data, context) => {
//   if (data.uid === null) {
//     return {result: null, statusCode: 401}; // TODO: smthing else than 401
//   }
//   const readResult = await admin.firestore().collection("users")
//       .doc(data.uid).get();
//   console.log("get", data.uid, {
//     "uid": readResult.get("uid"),
//     "email": readResult.get("email"),
//     "displayName": readResult.get("displayName"),
//     "emailVerified": readResult.get("emailVerified"),
//     "phoneNumber": readResult.get("phoneNumber"),
//     "photoUrl": readResult.get("photoUrl"),
//   });
//   if (readResult.get("email") === null) {
//     return {result: null, statusCode: 500};
//   }
//   return {
//     result:
//       {
//         "uid": readResult.get("uid"),
//         "email": readResult.get("email"),
//         "displayName": readResult.get("displayName"),
//         "emailVerified": readResult.get("emailVerified"),
//         "phoneNumber": readResult.get("phoneNumber"),
//         "photoUrl": readResult.get("photoUrl"),
//       },
//     statusCode: 200,
//   };
// });
// exports.getUserFriends = functions.https.onCall(async (data, context) => {
//   if (context.auth === null) {
//     return {result: null, statusCode: 401};
//   }
//   // Retrieve the user
//   const readResult = await admin.firestore().collection("users")
//     .doc(context.auth.uid).get();
//   console.log("get", context.auth.uid, {
//     "uid": readResult.get("uid"),
//     "friends": readResult.get("friends"),
//   });
//   if (readResult.get("email") === null) {
//     return {result: null, statusCode: 500};
//   }
//   return {
//     result:
//       {
//         "friends": readResult.get("friends"),
//       },
//     statusCode: 200,
//   };
// });
//
// exports.sendLangame = functions.https.onCall(async (data, context) => {
//   // TODO: cloud messaging
//   // TODO: firestore append notification
//   //
// });

if (process.env.FUNCTIONS_EMULATOR && process.env.FIRESTORE_EMULATOR_HOST) {
  // TODO: prepopulate firestore emulator from 'yourproject/src/sample_data.json
}
