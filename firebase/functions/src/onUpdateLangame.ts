import {Change, EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import {handleError} from "./utils/firestore";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

/**
 *
 * @param{Change<QueryDocumentSnapshot>} change
 * @param{EventContext} _
 */
export const onUpdateLangame =
  async (change: Change<QueryDocumentSnapshot>,
      _: EventContext) => {
    try {
      functions.logger.log("onUpdateLangame before", change.before);
      functions.logger.log("onUpdateLangame after", change.after);

      return await admin.firestore().runTransaction(async (t) => {
        // Someone increased the current meme
        if (change.before.data().currentMeme <
            change.after.data().currentMeme) {
          // If already on last meme, set null
          if (change.after.data().currentMeme ==
          change.after.data().memes.length - 1) {
            functions.logger.log("last meme, setting nextMeme to null");
            return t.update(change.after.ref, {
              nextMeme: null,
            });
          }
          const d = new Date();
          const rc = await admin.remoteConfig().getTemplate();
          d.setMinutes(d.getMinutes() +
          // @ts-ignore
          rc.parameters.langame_delay_for_next.defaultValue.value*1);
          functions.logger.log("Incrementing nextMeme date", d);

          // Increase the next meme update
          return t.update(change.after.ref, {
            nextMeme: d,
          });
        }
        return Promise.resolve();
      });
    } catch (e) {
      await Promise.all(handleError(change.after, e, "null"));
    }
  };
