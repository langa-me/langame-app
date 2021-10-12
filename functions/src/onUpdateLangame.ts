import {Change, EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {handleError} from "./errors";

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
      // Someone increased the current meme
      if (change.before.data().currentMeme !=
          change.after.data().currentMeme) {
        if (change.after.data().memesSeen >
            change.after.data().currentMeme) {
          functions.logger.log("memes seen", change.after.data().currentMeme);
          return Promise.resolve();
        }
        return await admin.firestore().runTransaction(async (t) => {
          const d = new Date();

          // If already on last meme, set null
          if (change.after.data().currentMeme ==
            change.after.data().memes.length - 1) {
            functions.logger.log("last meme, setting nextMeme to null");
            return t.update(change.after.ref, {
              nextMeme: null,
              memesSeen: change.after.data().currentMeme,
              memeChanged: new Date(),
            });
          }

          const rc = await admin.remoteConfig().getTemplate();
          d.setMinutes(d.getMinutes() +
            // @ts-ignore
            rc.parameters.langame_delay_for_next.defaultValue.value * 1);
          functions.logger.log("Incrementing nextMeme date", d);

          // Increase the next meme update
          return t.update(change.after.ref, {
            nextMeme: d,
            memesSeen: admin.firestore.FieldValue.increment(1),
            memeChanged: new Date(),
          });
        });
      }
    } catch (e: any) {
      await Promise.all(handleError(change.after, {developerMessage: e}));
    }
  };
