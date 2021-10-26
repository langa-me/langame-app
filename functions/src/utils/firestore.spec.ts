import * as admin from "firebase-admin";

export const initFirebaseTest = ({isDev = true}) => {
  console.log("sat up", isDev ? "development firebase" : "production firebase");
  const cred = isDev ?
    admin.credential.cert("./functions/svc.dev.json") :
    admin.credential.cert("./functions/svc.prod.json");
  // require("firebase-functions-test")({
  //   credential: cred,
  // });
  try {
    admin.initializeApp({
      credential: cred,
    });
  // eslint-disable-next-line no-empty
  } catch (e) {}
};
