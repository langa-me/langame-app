import * as admin from "firebase-admin";
if (admin.apps.length === 0) {
  admin.initializeApp();
  admin.firestore().settings({ignoreUndefinedProperties: true});
}
import * as functions from "firebase-functions";
import {newFeedback} from "./feedback";
import {onDeleteAuthentication} from "./users/onDeleteAuthentication";
import {
  isDev,
  kLangamesCollection,
} from "./helpers";
import {onCreateLangame} from "./onCreateLangame";
import {onUpdateLangamePlayers} from "./onUpdateLangamePlayers";
import {onUpdateLangame} from "./onUpdateLangame";
import {onCreateAuthentication} from "./users/onCreateAuthentication";
import {versionCheck} from "./versionCheck";
import {setLangamesDone} from "./setLangamesDone";
import {resetCredits} from "./users/resetCredits";
import {getMemes} from "./memes/getMemes";
import * as Sentry from "@sentry/node";
import {createMemes} from "./memes/createMemes";
import {onWriteTopic} from "./memes/onWriteTopic";
import {onWriteUser} from "./users/onWriteUser";
import {onWriteMeme} from "./memes/onWriteMeme";
import {onCreateMessage} from "./messages/onCreateMessage";
import {onCreateMessageAnalysis} from "./messages/onCreateMessageAnalysis";
import {onWritePreference} from "./users/onWritePreference";

// see https://firebase.google.com/docs/reference/functions/function_configuration_.runtimeoptions
const runtimeOpts = {
  maxInstances: 40, // TODO: remoteconfig
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


exports.versionCheck = functions
    .region(region)
    .runWith(runtimeOpts)
    .https
    .onCall(versionCheck);

exports.setLangamesDone = functions
    .region(region)
    .runWith(runtimeOpts)
    .pubsub
    .schedule("1 * * * *")
    .onRun(setLangamesDone);

exports.resetCredits = functions
    .region(region)
    .runWith(runtimeOpts)
    .pubsub
    .schedule("0 1 * * *") // 1 am every day
    .onRun(resetCredits);

// https://firebase.google.com/docs/functions/gcp-storage-events
exports.onFeedback = functions
    .region(region)
    .runWith({maxInstances: 3})
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

exports.onCreateLangame = functions
    .region(region)
    .runWith(runtimeOpts)
    .firestore
    .document(`${kLangamesCollection}/{pushId}`)
    .onCreate(onCreateLangame);

exports.onUpdateLangame = functions
    .region(region)
    .runWith(runtimeOpts)
    .firestore
    .document(`${kLangamesCollection}/{langameId}`)
    .onUpdate(onUpdateLangame);

exports.onUpdateLangamePlayers = functions
    .region(region)
    .runWith(runtimeOpts)
    .firestore
    .document(`${kLangamesCollection}/{langameId}/players/{playerId}`)
    .onWrite(onUpdateLangamePlayers);

// User //

exports.onDeleteAuthentication = functions
    .region(region)
    .runWith(runtimeOpts)
    .auth
    .user()
    .onDelete(onDeleteAuthentication);

exports.onCreateAuthentication = functions
    .region(region)
    .runWith(runtimeOpts)
    .auth
    .user()
    .onCreate(onCreateAuthentication);

exports.onWriteUser = functions
    .region(region)
    .runWith(runtimeOpts)
    .firestore
    .document("users/{userId}")
    .onWrite(onWriteUser);

exports.onWritePreference = functions
    .region(region)
    .runWith(runtimeOpts)
    .firestore
    .document("preferences/{preferenceId}")
    .onWrite(onWritePreference);


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


exports.onWriteMeme = functions
    .region(region)
    .runWith(runtimeOpts)
    .firestore.document("memes/{memeId}")
    .onWrite(onWriteMeme);

exports.onWriteTopic = functions
    .region(region)
    .runWith(runtimeOpts)
    .firestore.document("topics/{topicId}")
    .onWrite(onWriteTopic);


exports.onCreateMessage = functions
    .region(region)
    .runWith({
      ...runtimeOpts,
      failurePolicy: true,
    })
    .firestore.document("messages/{messageId}")
    .onCreate(onCreateMessage);


exports.onCreateMessageAnalysis = functions
    .region(region)
    .runWith({
      ...runtimeOpts,
      failurePolicy: true,
    })
    .firestore.document("messages/{messageId}")
    .onCreate(onCreateMessageAnalysis);
