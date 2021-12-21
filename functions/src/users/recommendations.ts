import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {converter} from "../utils/firestore";
import {langame} from "../langame/protobuf/langame";

export const setRecommendations = (
    db: admin.firestore.Firestore,
    user: admin.firestore.DocumentSnapshot<langame.protobuf.IUser>,
    userPreference:
        admin.firestore.DocumentSnapshot<langame.protobuf.IUserPreference>,
): Promise<void | admin.firestore.Transaction> => {
  return db.runTransaction(async (t) => {
    // TODO: enum to string is fucking verbose in TS, thats why
    if (
      !userPreference.data()?.userRecommendations
    ) {
      functions.logger.info(`User ${user.id} does not want recommendations`);
      return Promise.resolve();
    }
    const recommendations: { [id: string]: number } = {};
    const recommendationReasons: { [id: string]: string[] } = {};
    const langamesWhereImPresent = await db.collection("langame_presences")
        .doc(user.id)
        .get();
    await Promise.all(langamesWhereImPresent.data()!["presences"].map(
        async (langameId: string) => {
          const langame = await admin.firestore().collection("langames")
              .withConverter(converter<langame.protobuf.ILangame>())
              .doc(langameId).get();
          langame.data()?.players?.forEach((player) => {
            if (player.id !== user.id) {
              recommendations[player.id!] =
                            recommendations[player.id!] + 1 || 1;
              const reason = "langame-presence";
              recommendationReasons[player.id!] =
                            recommendationReasons[player.id!]?.concat(reason) ||
                            [reason];
            }
          });
        }));
    if (userPreference.data()?.favoriteTopics) {
      // Find recommendations according to similar interests
      const usersWithSimilarInterests = await db.collection("preferences")
          .withConverter(converter<langame.protobuf.IUserPreference>())
          .where("favoriteTopics",
              "array-contains-any",
                    userPreference.data()!.favoriteTopics)
          .get();
      usersWithSimilarInterests.docs.forEach((e) => {
        // add recommendation score every time has similar interests
        const topicsInCommon = e.data()!.favoriteTopics!.filter(
            (topic) => userPreference.data()!.favoriteTopics!.includes(topic));
        const score = topicsInCommon.length;
        if (e.id !== user.id) {
          recommendations[e.id!] = recommendations[e.id!] + score || score;
          const reason = "similar-interests";
          recommendationReasons[e.id!] =
                        recommendationReasons[e.id!]?.concat(reason) ||
                        [reason];
        }
      });
    }

    if (Object.values(recommendations).length === 0) {
      functions.logger.info("didn't find any recommendations");
      return Promise.resolve();
    }
    return t.set(db.collection("recommendations").doc(user.id), {
      recommendations: recommendations,
      recommendationReasons: recommendationReasons,
    });
  });
};
