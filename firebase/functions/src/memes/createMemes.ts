import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {https} from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {reportError} from "../errors";
import {getPerUserlimiter} from "../utils/firestore";


export const createMemes = async (data: any,
    context: functions.https.CallableContext) => {
  if (!context.auth) {
    throw new https.HttpsError(
        "unauthenticated",
        "not authenticated",
    );
  }

  const uidQualifier = "u_" + context.auth.uid;
  const isQuotaExceeded =
    await getPerUserlimiter().isQuotaAlreadyExceeded(uidQualifier);
  if (isQuotaExceeded) {
    throw new https.HttpsError(
        "resource-exhausted",
        "rate limited",
    );
  }

  if (!data) {
    throw new https.HttpsError(
        "invalid-argument",
        "must provide a request body",
    );
  }
  if (!data.topic) {
    throw new https.HttpsError(
        "invalid-argument",
        "topic must be given",
    );
  }
  if (!data.amount && data.amount > 10) {
    throw new https.HttpsError(
        "invalid-argument",
        "maximum 10 memes at a time",
    );
  }
  const user = await admin.firestore().collection("users")
      .doc(context.auth.uid).get();
  if (!user.exists || !user.data() || user.data()!.role !== "admin") {
    throw new https.HttpsError(
        "permission-denied",
        "you are not admin",
    );
  }

  const promptType = data.promptType;
  functions.logger.log("attempting to search prompts of type", promptType);
  const promptDocs = await admin.firestore()
      .collection("prompts")
      .where("type", "==", promptType).get();

  if (promptDocs.size === 0) {
    const e = new https.HttpsError(
        "invalid-argument",
        "could not get any prompt",
    );
    reportError(e);
    throw e;
  }
  const randomPrompt =
    promptDocs.docs[Math.floor(Math.random() * promptDocs.size)];
  const api = new ImplAiApi();
  const amount = data.amount || 1;
  functions.logger.log("going to generate", amount,
      "memes using prompt", randomPrompt.id);
  return {
    memesId: await Promise.all([...Array(amount)].map(async () => {
      functions.logger.log("calling openai with prompt", randomPrompt);
      let meme: string | undefined;
      try {
        meme =
        await api.completion(
            randomPrompt.data().template.replace("[TOPIC]", data.topic),
            randomPrompt.data().parameters
        );
      } catch (e: any) {
        reportError(e);
        throw e;
      }
      if (!meme) {
        const e = new https.HttpsError(
            "internal",
            "could not generate any meme",
        );
        reportError(e);
        throw e;
      }
      const memeDoc = await admin.firestore().collection("memes").add({
        content: meme,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        promptId: randomPrompt.id,
        topics: [data.topic],
        disabled: true,
      });
      functions.logger.log("generated meme", meme);
      return memeDoc.id;
    })),
  };
};
