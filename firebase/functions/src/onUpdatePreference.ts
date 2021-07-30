import {Change, EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {ImplAiApi} from "./aiApi/implAiApi";
import {reportError} from "./errors";

/**
 *
 * @param{Change<QueryDocumentSnapshot>} change
 * @param{EventContext} _
 */
export const onUpdatePreference =
    async (change: Change<QueryDocumentSnapshot>,
        _: EventContext) => {
      try {
        const api = new ImplAiApi();
        await api.save(process.env.GCLOUD_PROJECT?.includes("dev") ?
            "dev_users" :
            "prod_users", [{
          object: {
            favoriteTopics: change.after.data().favoriteTopics,
            // TODO: last langames...
          },
          id: change.after.id,
        }]);
      } catch (e) {
        await reportError(e, {user: change.after.id});
      }
    };
