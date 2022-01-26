import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const resetCredits =
    async (_: functions.EventContext) => {
      const db = admin.firestore();
      const users = await db
          .collection("users")
          .listDocuments();
      const organizations = await db
          .collection("organizations")
          .listDocuments();
      const serverConfig = await db
          .collection("configs")
          .doc("business")
          .get();

      if (!serverConfig.data() ||
          !serverConfig.data()!.base_user_credits ||
          !serverConfig.data()!.base_organization_credits
      ) {
        throw new Error("Server config is invalid, "+
          "please check collection configs/business");
      }

      functions.logger.log("resetting credits", {
        users: users.length,
        organizations: organizations.length,
        base_user_credits: serverConfig.data()!.base_user_credits,
        base_organization_credits:
          serverConfig.data()!.base_organization_credits,
      });

      // Get a new write batch
      const batch = db.batch();
      for (const user of users) {
        batch.update(db.collection("users").doc(user.id), {
          credits: serverConfig.data()!.base_user_credits,
        });
      }
      for (const organization of organizations) {
        batch.update(db.collection("organizations").doc(organization.id), {
          credits: serverConfig.data()!.base_organization_credits,
        });
      }
      await batch.commit();
    };
