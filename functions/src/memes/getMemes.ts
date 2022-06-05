import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {https} from "firebase-functions";
import {onlineMemeGenerator} from "./memes";
import {getPerUserlimiter} from "../utils/firestore";
import {reportError} from "../errors";
const limiter = !process.env.IS_TESTING ?
  getPerUserlimiter() : undefined;
interface GetMemesRequest {
  topics: string[];
  appId?: string;
  quantity?: number;
  translated?: boolean;
  fixGrammar?: boolean;
  parallelCompletions?: number;
}
export const getMemes = async (
    data: GetMemesRequest,
    context: functions.https.CallableContext
) => {
  functions.logger.info(context);
  if (!context.auth && !data.appId) {
    const message = "not authenticated";
    functions.logger.warn(message, data);
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
    const message = "resource-exhausted";
    functions.logger.warn(message, data);
    throw new https.HttpsError(
        message,
        "You have been rate limited, " +
      "please reach out at contact@langa.me if you want an increase.",
    );
  }

  if (!data) {
    const message = "must provide a request body";
    functions.logger.warn(message, data);
    throw new https.HttpsError(
        "invalid-argument",
        message,
    );
  }
  // If the user does provide topics but it's not string[]
  if (data.topics && !Array.isArray(data.topics) ||
    (data.topics.length > 0 && typeof data.topics[0] !== "string")) {
    const message = "topics must be an array of strings";
    functions.logger.warn(message, data);
    throw new https.HttpsError(
        "invalid-argument",
        message,
    );
  }
  if (data.quantity && typeof data.quantity !== "number") {
    const message = "quantity must be a number";
    functions.logger.warn(message, data);
    throw new https.HttpsError(
        "invalid-argument",
        message,
    );
  }
  // If quantity > 5
  if (data.quantity && data.quantity > 5) {
    const message = "quantity must be less than or equal to 5";
    functions.logger.warn(message, data);
    throw new https.HttpsError(
        "invalid-argument",
        message,
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
      const message = "invalid appId";
      functions.logger.warn(message, data);
      throw new https.HttpsError(
          "invalid-argument",
          message,
      );
    }
    callerDoc = await admin.firestore()
        .collection("organizations")
        .doc(apiKeyDoc.data()!.owner)
        .get();
    // The owner does not exist
    if (!callerDoc.exists) {
      const message = "the owner of this key does not exist";
      functions.logger.warn(message, data);
      throw new https.HttpsError(
          "invalid-argument",
          message,
      );
    }
  }

  functions.logger.log("caller ID", callerDoc.id);

  if (callerDoc.data()!.credits <= 0) {
    const message = "you do not have enough credits, " +
      "please buy more on https://langa.me or contact us at contact@langa.me";
    functions.logger.warn(message, data);
    throw new https.HttpsError(
        "invalid-argument",
        message,
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
  let memes: any[] = [];
  // await offlineMemeSearch(
  //     data.topics || ["ice breaker"],
  //   seenMemes!.map((e: any) => e.meme),
  //   data.quantity || 1,
  // );

  if (memes.length === 0) {
    functions.logger.log("could not find a conversation starter, generating");
    try {
      memes = await onlineMemeGenerator(data.topics || ["ice breaker"],
          data.quantity || 1,
          data.translated || false,
          data.fixGrammar || false,
          data.parallelCompletions || 1,
          240_000,
      );
    } catch (e: any) {
      const message = e.toString().includes("timeout") ?
        "the server is overloaded, please try again later" :
        "an error occurred, please try again later," +
        " reach out to us at contact@langa.me for further assistance";
      functions.logger.warn(message, data);
      throw new https.HttpsError(
          "internal",
          message,
      );
    }
  }

  if (memes.length === 0) {
    const message = "could not find memes";
    const e = new https.HttpsError(
        "internal",
        message,
    );
    await reportError(e, context);
    throw e;
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
