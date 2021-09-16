import {Change, EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {reportError} from "../errors";
import {ImplAiApi} from "../aiApi/implAiApi";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import TwitterApi from "twitter-api-v2";
import {isDev} from "../helpers";

/**
 *
 * @param{QueryDocumentSnapshot} change
 * @param{EventContext} e
 */
export const onUpdateMeme = async (
    change: Change<QueryDocumentSnapshot>,
    e: EventContext
) => {
  // TODO: should translate etc only when meme is enabled
  try {
    if (isDev) return;
    if (!change.after.data() ||
      e.eventType === "google.firestore.document.delete") return;

    const api = new ImplAiApi();

    await api.getIndex("prod_memes").saveObject({
      objectID: change.after.id,
      disabled: change.after.data().disabled,
      content: change.after.data().content,
      createdAt: change.after.data().createdAt,
      _tags: change.after.data()!.topics,
    });
    // TODO: only update if it's new
    await Promise.all(change.after.data()!.topics.map((t: string) =>
      admin.firestore().collection("topics").doc(t).set({})));

    functions.logger.log(`Updated meme ${change.after.id}`,
        change.after.data());

    // When enabling a meme, tweet randomly
    if (change.before.data()!.disabled === true &&
        change.after.data()!.disabled === false) {
      const twitterClient = new TwitterApi({
        accessToken: functions.config().twitter.access_token,
        appKey: functions.config().twitter.app_key,
        appSecret: functions.config().twitter.app_secret,
        accessSecret: functions.config().twitter.access_secret,
      });
      // eslint-disable-next-line max-len
      const tweet = `${change.after.data().content} ${change.after.data()!.topics.map((e: string) => "#"+e.replace(/\s/g, "")).join(" ")}`;
      await twitterClient.v1.tweet(tweet);
      functions.logger.log("tweeted", tweet);
    }

    // TODO: sentence similarity -> delete
  } catch (e: any) {
    await reportError(e, {});
  }
};
