import {EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import * as admin from "firebase-admin";
import {reportError} from "../errors";
import {isDev} from "../helpers";
import {TwitterApi} from "twitter-api-v2";
import * as functions from "firebase-functions";

/**
 *
 * @param{QueryDocumentSnapshot} snap
 * @param{EventContext} _
 */
export const onCreateMeme = async (
    snap: QueryDocumentSnapshot,
    _: EventContext
) => {
  try {
    if (isDev) return;
    if (!snap.data()) return;
    // const api = new ImplAiApi();
    const topics = snap.data().topics;
    // TODO: sentence similarity, delete similar sentences
    // let label = await api.openAITopicClassify(snap.data().content, {});
    // if (label) {
    //   label = label.toLowerCase();
    //   topics.push(label);
    //   // Unique topics
    //   topics = Array.from(new Set(topics));
    //   if (topics === snap.data()!.topics) return;
    //   await snap.ref.update({
    //     topics: topics,
    //   });
    //   functions.logger.log("new label detected for", snap.id, label);
    // }
    // TODO: only update if it's new
    await Promise.all(topics.map((t: string) =>
      admin.firestore().collection("topics").doc(t).set({})));

    if (snap.data().tweet === true) {
      const twitterClient = new TwitterApi({
        accessToken: functions.config().twitter.access_token,
        appKey: functions.config().twitter.app_key,
        appSecret: functions.config().twitter.app_secret,
        accessSecret: functions.config().twitter.access_secret,
      });
      // eslint-disable-next-line max-len
      const tweet = `${snap.data().content} ${snap.data()!.topics.map((e: string) => "#"+e.replace(/\s/g, "")).join(" ")}`;
      await twitterClient.v1.tweet(tweet);
      functions.logger.log("tweeted", tweet);
    }

    // TODO: sentence similarity -> delete
  } catch (e: any) {
    await reportError(e, {});
  }
};
