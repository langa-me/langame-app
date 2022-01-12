import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {https} from "firebase-functions";
import {offlineMemeSearch, onlineMemeGenerator} from "./memes";
import {getPerUserlimiter} from "../utils/firestore";
const limiter = !process.env.IS_TESTING ?
  getPerUserlimiter() : undefined;
interface GetMemesRequest {
  topics: string[];
  appId?: string;
  quantity?: number;
  translated?: boolean;
}
export const getMemes = async (
    data: GetMemesRequest,
    context: functions.https.CallableContext
) => {
  if (!context.auth && !data.appId) {
    throw new https.HttpsError(
        "unauthenticated",
        "not authenticated",
    );
  }

  // The rate limit identifier is either bound to a client or
  // to a service.
  const callerId = context.auth ? context.auth.uid : data.appId!;
  const uidQualifier = callerId;
  const isQuotaExceeded =
    await limiter!.isQuotaExceededOrRecordUsage(uidQualifier);
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
  if (data.quantity && typeof data.quantity !== "number") {
    throw new https.HttpsError(
        "invalid-argument",
        "quantity must be a number",
    );
  }
  // If quantity > 5
  if (data.quantity && data.quantity > 5) {
    throw new https.HttpsError(
        "invalid-argument",
        "quantity must be less than or equal to 5",
    );
  }
  let callerDoc: admin.firestore.DocumentSnapshot;
  if (context.auth) {
    callerDoc = await admin.firestore()
        .collection("users")
        .doc(context.auth.uid)
        .get();
  } else {
    const apiKeyDoc = await admin.firestore()
        .collection("api_keys")
        .doc(data.appId!)
        .get();
    // If document does not exist, it means the key is invalid
    if (!apiKeyDoc.exists) {
      throw new https.HttpsError(
          "invalid-argument",
          "invalid appId",
      );
    }
    callerDoc = await admin.firestore()
        .collection("organizations")
        .doc(apiKeyDoc.data()!.owner)
        .get();
    // The owner does not exist
    if (!callerDoc.exists) {
      throw new https.HttpsError(
          "invalid-argument",
          "the owner of this key does not exist",
      );
    }
  }

  if (callerDoc.data()!.credits <= 0) {
    throw new https.HttpsError(
        "invalid-argument",
        "you do not have enough credits, " +
        "please buy more on https://langa.me or contact us at contact@langa.me",
    );
  }

  const seenMemesDoc = await admin.firestore()
      .collection("seenMemes")
      .doc(callerId)
      .get();
  let seenMemes = seenMemesDoc.data() && seenMemesDoc.data()!.seen ?
    seenMemesDoc.data()!.seen! :
    [];

  // If the user does not provide topics, leave empty string
  // will find all memes
  let memes = await offlineMemeSearch(
      data.topics || ["ice breaker"],
    seenMemes!.map((e: any) => e.meme),
    data.quantity || 1,
  );

  if (memes.length === 0) {
    functions.logger.log("could not find a conversation starter, generating");
    memes = await onlineMemeGenerator(data.topics || ["ice breaker"],
        data.quantity || 1,
        data.translated || false
    );
  }

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
      meme: e.id,
      date: new Date(),
    };
  });
  // Filter out memes already seen X time ago
  seenMemes = seenMemes!
      .filter((e: any) => e.date < oneWeekAgo).concat(newMemesSeen);
  await callerDoc.ref.update({
    credits: admin.firestore.FieldValue.increment(-1),
    lastSpent: admin.firestore.FieldValue.serverTimestamp(),
  });

  seenMemesDoc.ref.set({
    seen: seenMemes,
  }, {merge: true});

  // Return the conversation starters
  return {
    memes: memes
        .filter((e) => e.data())
        .map((e) => {
          return {...e.data()!, id: e.id};
        }),
  };
};
