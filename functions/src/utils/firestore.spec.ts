import * as admin from "firebase-admin";

export const initFirebaseTest = (env: "prod" | "dev", dir = "./functions") => {
  console.log("sat up", env === "dev" ?
    "development firebase" : "production firebase");
  const cred = env === "dev" ?
    admin.credential.cert(`${dir}/svc.dev.json`) :
    admin.credential.cert(`${dir}/svc.prod.json`);
  try {
    admin.initializeApp({
      credential: cred,
      projectId: env === "prod" ? "langame-86ac4" : "langame-dev",
    });
  } catch (e) {
    console.log("failed to initialize firebase", e, process.env.GCLOUD_PROJECT);
  }
};

