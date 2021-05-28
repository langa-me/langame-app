import {Change, EventContext} from "firebase-functions";
import {QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";

/**
 *
 * @param{Change<QueryDocumentSnapshot>} change
 * @param{EventContext} context
 */
export const onUpdateLangame =
 async (change: Change<QueryDocumentSnapshot>,
     context: EventContext) => {
 };
