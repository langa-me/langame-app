import {Change, EventContext} from "firebase-functions";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError} from "../errors";
import {isDev} from "../helpers";
import {TwitterApi} from "twitter-api-v2";

export const onWriteMeme = async (
    change: Change<admin.firestore.DocumentSnapshot>,
    ctx: EventContext) => {
  const api = new ImplAiApi();
  try {
    functions.logger.log("onWriteMeme", change.after);

    const i = api.getIndex(isDev ? "dev_memes" : "prod_memes");
    if (!change.after.exists) {
      await i.deleteObject(change.after.id);
      functions.logger.log("deleted", change.after.id);
      return;
    }

    await i.saveObject({
      ...change.after.data(),
      objectID: change.after.id,
      _tags: change.after.data()!.topics,
    });

    functions.logger.log(`Updated meme ${change.after.id}`,
        change.after.data());
    const topics = change.after.data()!.topics;
    await Promise.all(topics.map((t: string) =>
      admin.firestore().collection("topics").doc(t).set({})));

    if (
      // Changed tweet from null or false to true
      (!change.before.exists ||
        !change.before.data()!.tweet ||
        change.before.data()!.tweet === false) &&
      change.after.data()!.tweet === true) {
      const twitterClient = new TwitterApi({
        accessToken: functions.config().twitter.access_token,
        appKey: functions.config().twitter.app_key,
        appSecret: functions.config().twitter.app_secret,
        accessSecret: functions.config().twitter.access_secret,
      });
      // eslint-disable-next-line max-len
      const tweet = `${change.after.data()!.content} ${change.after.data()!.topics.map((e: string) => "#"+e.replace(/\s/g, "")).join(" ")}`;
      await twitterClient.v1.tweet(tweet);
      functions.logger.log("tweeted", tweet);
    }
    return Promise.resolve();
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref.parent.parent, {developerMessage: e}));
    return Promise.reject(e);
  }
};
