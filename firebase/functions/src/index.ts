import * as admin from "firebase-admin";
if (admin.apps.length === 0) {
  admin.initializeApp();
  admin.firestore().settings({ignoreUndefinedProperties: true});
}
import * as functions from "firebase-functions";
import {newFeedback} from "./feedback";
import {onDeleteAuthentication} from "./onDeleteAuthentication";
import {subscribe} from "./subscribe";
import {
  isDev,
  kLangamesCollection,
} from "./helpers";
import {onCreateLangame} from "./onCreateLangame";
import {onUpdateLangamePlayers} from "./onUpdateLangamePlayers";
import {onUpdateLangame} from "./onUpdateLangame";
import {onCreateAuthentication} from "./onCreateAuthentication";
import {versionCheck} from "./versionCheck";
import {setLangamesDone} from "./setLangamesDone";
import {setUserRecommendation} from "./setUserRecommendation";
import {resetCredits} from "./users/resetCredits";
import {getMemes} from "./memes/getMemes";
import * as Sentry from "@sentry/node";
import {createMemes} from "./memes/createMemes";
import {onUpdateMeme} from "./memes/onUpdateMeme";
import {onDeleteMeme} from "./memes/onDeleteMeme";
import {onWriteTopic} from "./memes/onWriteTopic";

// see https://firebase.google.com/docs/reference/functions/function_configuration_.runtimeoptions
const runtimeOpts = {
  maxInstances: 10, // TODO: remoteconfig
};
// TODO: somehow doesn't work then on client
const region = "us-central1";

Sentry.init({
  dsn: "https://d871af5f23904bea86cddd740deaec48@o404046.ingest.sentry.io/5891479",

  // Set tracesSampleRate to 1.0 to capture 100%
  // of transactions for performance monitoring.
  // We recommend adjusting this value in production
  tracesSampleRate: 1.0,
  environment: isDev ? "development" : "production",
});


exports.subscribe = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(subscribe);

exports.versionCheck = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(versionCheck);


// exports.interactionsDecrement = functions
//     .pubsub
//     .schedule("1 * * * *")
//     .onRun(interactionsDecrement);

exports.userRecommendations = functions
    .pubsub
    .schedule("1 * * * *")
    .onRun(setUserRecommendation);

exports.setLangamesDone = functions
    .pubsub
    .schedule("1 * * * *")
    .onRun(setLangamesDone);

exports.resetCredits = functions
    .pubsub
    .schedule("0 1 * * *") // 1 am every day
    .onRun(resetCredits);

// https://firebase.google.com/docs/functions/gcp-storage-events
exports.onFeedback = functions
    .region(region)
    .storage.object()
    .onFinalize(async (object) => {
      if (!object.name?.startsWith("feedbacks") ||
          !object.mediaLink ||
            !object.metadata) {
        return;
      }
      functions.logger.info("new feedback", JSON.stringify(object));
      await newFeedback(object.mediaLink, object.metadata);
    }
    );


// Langame //

exports.onCreateLangame = functions.firestore
    .document(`${kLangamesCollection}/{pushId}`)
    .onCreate(onCreateLangame);

exports.onUpdateLangame = functions.firestore
    .document(`${kLangamesCollection}/{langameId}`)
    .onUpdate(onUpdateLangame);

exports.onUpdateLangamePlayers = functions.firestore
    .document(`${kLangamesCollection}/{langameId}/players/{playerId}`)
    .onWrite(onUpdateLangamePlayers);

// Authentication //

exports.onDeleteAuthentication =
    functions.auth.user().onDelete(onDeleteAuthentication);

exports.onCreateAuthentication =
    functions.auth.user().onCreate(onCreateAuthentication);


// Meme //


exports.getMemes = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(getMemes);

exports.createMemes = functions
    .region(region)
    .runWith({
      timeoutSeconds: 300,
      ...runtimeOpts,
    })
    .https
    .onCall(createMemes);


// exports.onCreateMeme = functions
//     .firestore.document("memes/{memeId}")
//     .onCreate(onCreateMeme);

exports.onDeleteMeme = functions
    .firestore.document("memes/{memeId}")
    .onDelete(onDeleteMeme);

exports.onUpdateMeme = functions
    .firestore.document("memes/{memeId}")
    .onUpdate(onUpdateMeme);

exports.onWriteTopic = functions
    .firestore.document("topics/{topicId}")
    .onWrite(onWriteTopic);
