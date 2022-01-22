import parser from "cron-parser";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {reportError} from "../errors";
import {langame} from "../langame/protobuf/langame";
import {samples} from "../utils/array";
import {converter} from "../utils/firestore";

export const isScheduleOutdated = (
    lastLangame: admin.firestore.Timestamp,
    cron: string,
) => {
  try {
    const options = {
      currentDate: lastLangame.toDate(),
      endDate: new Date(),
    };
    parser.parseExpression(cron, options)
        .next().toDate();
  } catch (e) {
    return false;
  }
  return true;
};

/**
 * Find a user with similar interest that has not been scheduled yet.
 * If all users have been scheduled, schedule a random one.
 * @param {string} uid
 * @param {string[]} previouslyScheduledUsers
 */
export const getScheduleUser = async (uid: string,
    previouslyScheduledUsers: string[],
): Promise<string | undefined> => {
  const db = admin.firestore();
  const recommendedUsers = await db.collection("recommendations")
      .doc(uid)
      .get();

  if (!recommendedUsers.exists || !recommendedUsers.data()!.recommendations) {
    return undefined;
  }

  const reco = recommendedUsers.data()!.recommendations;

  // get recommended user with highest score
  // in the propery "recommandations" which is a
  // map with format {[uid]: score}
  const usersFiltered: any[] = // {[uid: string]: number}[] =
    Object.entries(reco)
        .filter((e: any) =>
          !previouslyScheduledUsers.includes(e[0]));
  // if all user has been scheduled, schedule a random one
  if (usersFiltered.length === 0) {
    const index = Math.floor(Math.random() *
      recommendedUsers.data()!.recommendations.length);
    return Object.keys(recommendedUsers.data()!.recommendations)[index];
  }
  // get max score user
  const maxScoreUser = usersFiltered.reduce((a: any, b: any) =>
      a[1] > b[1] ? a : b);

  return maxScoreUser[0];
};


/**
 * According to what the user set as preferred langame schedule,
 * create langames for the user at these times.
 * @param {functions.EventContext} ctx
 * @return {Promise<any>}
 */
export const scheduleLangames = async (ctx: functions.EventContext) => {
  functions.logger.log(ctx);
  try {
    const db = admin.firestore();
    // for every document in 'preferences'
    // which has a 'langamesSubscriptionFrequency'
    // different from '0 0 5 31 2'
    // check if the last time a langame has been scheduled for
    // this user is older than the 'langamesSubscriptionFrequency'
    // if it is, create a langame for this user
    const preferences = await db.collection("preferences")
        .withConverter(converter<langame.protobuf.IUserPreference>())
        .where("langamesSubscriptionFrequency", "!=", "0 0 5 31 2")
        .get();
    functions.logger.log("found preferences",
        preferences.docs.map((e) => e.data()));
    return Promise.all(preferences.docs.map(async (preference) => {
      if (!preference.exists) {
        functions.logger.warn("preference does not exist", preference.id);
        return Promise.resolve();
      }
      const pData = preference.data() as langame.protobuf.IUserPreference;
      if (!pData.langamesSubscriptionFrequency) {
        functions.logger.warn("langamesSubscriptionFrequency is undefined",
            preference.id);
        return Promise.resolve();
      }
      const scheduleDoc = await db.collection("schedules")
          .doc(preference.id)
          .get();
      functions.logger.log("found schedules", scheduleDoc.data());
      // if last langame is outdated, create a langame
      if (!scheduleDoc.exists ||
        !scheduleDoc.data() ||
        !scheduleDoc.data()!.lastLangame ||
        isScheduleOutdated(
          scheduleDoc.data()!.lastLangame,
          pData.langamesSubscriptionFrequency!
        )
      ) {
        functions.logger.log("schedule outdated", preference.id);
        const otherUserToMatch = await getScheduleUser(
            preference.id,
            scheduleDoc.data()?.scheduledUsers || []
        );
        if (!otherUserToMatch) {
          functions.logger.warn("No other user to match for", preference.id);
          return Promise.resolve();
        }
        functions.logger.log("otherUserToMatch", otherUserToMatch);
        const self = await db.collection("users")
            .withConverter(converter<langame.protobuf.IUser>())
            .doc(preference.id).get();
        const other = await db.collection("users")
            .withConverter(converter<langame.protobuf.IUser>())
            .doc(otherUserToMatch).get();
        // pick 3 random topics of the user or "ice breaker" if he has none
        const topics = preference.data()!.favoriteTopics ?
          samples(preference.data()!.favoriteTopics!, 3) :
          ["ice breaker"];
        const lg = await db
            .collection("langames")
            .withConverter(converter<langame.protobuf.ILangame>())
            .add({
              topics: topics,
              initiator: self.id,
              // @ts-ignore
              createdAt: admin.firestore.FieldValue.serverTimestamp(),
              tags: ["schedule"],
              players: [
                {
                  id: self.id,
                  tag: self.data()!.tag,
                  photoUrl: self.data()!.photoUrl,
                  bot: false,
                  email: self.data()!.email,
                }, {
                  id: other.id,
                  tag: other.data()!.tag,
                  photoUrl: other.data()!.photoUrl,
                  bot: false,
                  email: other.data()!.email,
                },
              ],
            });
        functions.logger.log("langame created", lg.id);
        await scheduleDoc.ref.set({
          lastLangame: admin.firestore.FieldValue.serverTimestamp(),
          scheduledUsers: admin.firestore.FieldValue.arrayUnion(
              otherUserToMatch),
        }, {merge: true});
      } else {
        functions.logger.log("schedule not outdated",
            pData.langamesSubscriptionFrequency,
            scheduleDoc.data()?.lastLangame.toDate(),
        );
      }
    }));
  } catch (e: any) {
    await reportError(e, {});
    return Promise.reject(e);
  }
};


