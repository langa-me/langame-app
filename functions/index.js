// Protobuf
const protobuf = require("protobufjs");

// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
admin.initializeApp();

// Check if a json user object match our proto type
const verifyUser = async jsonUser => {
  const root = await protobuf.load("../lib/protos/api.proto")
  const LangameUser = root.lookupType("api.LangameUser");
  let errMsg = LangameUser.verify(jsonUser);
  if (errMsg) return errMsg;
  return null;
}

exports.onAuthCreate = functions.auth.user().onCreate(async user => {
  const userDoc = {
    'uid': user.uid,
    'email': user.email,
    'displayName': user.displayName,
    'emailVerified': user.emailVerified,
    'phoneNumber': user.phoneNumber,
    'photoUrl': user.photoURL
  }
  const err = await verifyUser(userDoc);
  if (err) throw Error(err);
  console.log('set', userDoc);
  return admin.firestore().collection('users').doc(user.uid).set(userDoc);
});
exports.getUser = functions.https.onCall(async (data, context) => {
  if (context.auth === null) {
    return {result: null, statusCode: 401};
  }
  const readResult = await admin.firestore().collection('users').doc(context.auth.uid).get();
  console.log('get', readResult.data(),{
    'uid': readResult.get('uid'),
    'email': readResult.get('email'),
    'displayName': readResult.get('displayName'),
    'emailVerified': readResult.get('emailVerified'),
    'phoneNumber': readResult.get('phoneNumber'),
    'photoUrl': readResult.get('photoUrl')
  });
  return {
    result:
      {
        'uid': readResult.get('uid'),
        'email': readResult.get('email'),
        'displayName': readResult.get('displayName'),
        'emailVerified': readResult.get('emailVerified'),
        'phoneNumber': readResult.get('phoneNumber'),
        'photoUrl': readResult.get('photoUrl')
      },
    statusCode: 200
  };
});
