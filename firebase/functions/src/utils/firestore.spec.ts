import * as admin from "firebase-admin";

export const initFirebaseTest = ({isDev = true}) => {
  const cred = isDev ?
    admin.credential.cert("./firebase/functions/svc.dev.json") :
    admin.credential.cert("./firebase/functions/svc.prod.json");
  // require("firebase-functions-test")({
  //   credential: cred,
  // });
  admin.initializeApp({
    credential: cred,
  });
};
