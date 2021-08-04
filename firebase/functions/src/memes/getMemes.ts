import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import FirebaseFunctionsRateLimiter from "firebase-functions-rate-limiter";
import {https} from "firebase-functions";
import {offlineMemeSearch} from "./memes";

const perUserlimiter = FirebaseFunctionsRateLimiter.withFirestoreBackend(
    {
      name: "per_user_limiter",
      maxCalls: 2,
      periodSeconds: 15,
    },
    admin.firestore(),
);

export const getMemes = async (data: any,
    context: functions.https.CallableContext) => {
  if (!context.auth) {
    throw new https.HttpsError(
        "unauthenticated",
        "not authenticated",
    );
  }

  const uidQualifier = "u_" + context.auth.uid;
  const isQuotaExceeded =
        await perUserlimiter.isQuotaAlreadyExceeded(uidQualifier);
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
  // If the user does provide topics but it's not string[]
  if (data.topics && !Array.isArray(data.topics) ||
        (data.topics.length > 0 && typeof data.topics[0] !== "string")) {
    throw new https.HttpsError(
        "invalid-argument",
        "topics must be an array of strings",
    );
  }
  const userDoc = await admin.firestore()
      .collection("users")
      .doc(context.auth.uid)
      .get();
  if (userDoc.data()!.credits <= 0) {
    throw new https.HttpsError(
        "invalid-argument",
        "you do not have enough credits",
    );
  }
  const t = await admin.remoteConfig().getTemplate();
  const seenMemesDoc = await admin.firestore()
      .collection("seenMemes")
      .doc(context.auth.uid)
      .get();
  let seenMemes = seenMemesDoc.data() && seenMemesDoc.data()!.seen ?
      seenMemesDoc.data()!.seen! :
      [];

  // If the user does not provide topics, leave empty string
  // will find all memes
  const memes = await offlineMemeSearch(
        (data.topics && data.topics.length === 0) ? [""] : data.topics,
        // @ts-ignore
        t.parameters.meme_count.defaultValue.value * 1, // Casting to number
      seenMemes!.map((e: any) => e.meme),
  );

  if (memes.length === 0) {
    throw new https.HttpsError(
        "internal",
        "could not find memes",
    );
  }
  const oneWeek = 7 * 24 * 1000 * 60 * 60;
  const oneWeekAgo = new Date(Date.now() - oneWeek);
  const newMemesSeen = memes.map((e) => {
    return {
      meme: e.objectID,
      // @ts-ignore
      date: new Date(),
    };
  });
    // Filter out memes already seen X time ago
  seenMemes =
            seenMemes!
                .filter((e: any) => e.date < oneWeekAgo).concat(newMemesSeen);
  await userDoc.ref.update({
    credits: admin.firestore.FieldValue.increment(-1),
    lastSpent: admin.firestore.FieldValue.serverTimestamp(),
  });

  seenMemesDoc.ref.set({
    seen: seenMemes,
  }, {merge: true});
  return {memes: memes};
};
