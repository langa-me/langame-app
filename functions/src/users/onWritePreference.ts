
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {Change, EventContext} from "firebase-functions";
import {handleError} from "../errors";
import {langame} from "../langame/protobuf/langame";
import {shouldDrop} from "../utils/contexts";
import {onboardUserWithBot} from "./bot";

export const onWritePreference = async (
    change: Change<admin.firestore.DocumentSnapshot<
    langame.protobuf.IUserPreference>>,
    ctx: EventContext) => {
  try {
    functions.logger.log(ctx);

    if (!change.after.exists) {
      functions.logger.log("preferences have been deleted, aborting");
      return;
    }
    if (shouldDrop(ctx)) return;


    // If the user preference has changed to onboarding done,
    // create a bot that will talk to him
    if (
      (!change.before.data()?.hasDoneOnBoarding ||
      change.before.data()!.hasDoneOnBoarding == false) &&
        change.after.data()!.hasDoneOnBoarding == true
    ) {
      return onboardUserWithBot(change.after);
    }
    return Promise.resolve();
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref, {developerMessage: e}));
    return Promise.reject(e);
  }
};
