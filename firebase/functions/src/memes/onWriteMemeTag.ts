import {Change, EventContext} from "firebase-functions";
import {isDev, kTagsCollection} from "../helpers";
import {docRefHandleError} from "../utils/firestore";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";

export const onWriteMemeTag = async (
    change: Change<admin.firestore.DocumentSnapshot>,
    ctx: EventContext) => {
  // On create new tag, add to algolia index
  if (ctx.eventType === "google.firestore.document.create" &&
      change.after.ref.parent.parent &&
      change.after.data() &&
      change.after.data()!.topic?.content) {
    const api = new ImplAiApi();
    await api.getIndex(isDev ? "dev_memes" : "prod_memes").partialUpdateObject({
      "objectID": change.after.ref.parent.parent!.id,
      "_tags": {
        "_operation": "AddUnique",
        "value": change.after.data()!.topic.content,
      },
    });
  }
  // TODO: should also compute and set the prompt fitness
  // Basically if the change is a creation of feedback tag
  // or a feedback tag has been updated
  if (change.before.data() == null &&
        change.after.data() != null &&
        change.after.data()!.feedback ||
        change.before.data() != null &&
        change.before.data()!.feedback &&
        change.after.data() != null &&
        change.after.data()!.feedback) {
    try {
      functions.logger.log("onWriteMemeTag", change.after);
      await admin.firestore().runTransaction(async (t) => {
        // Now we want to compute the new meme aggregated score accordingly
        const aggregatedFeedbackGeneral =
        await t.get(change.after.ref.parent.parent!
            .collection(kTagsCollection)
            .where("aggregatedFeedback.general.score", ">", 0));
        const generalScore = change.after.data()!.feedback?.general?.score;
        const aggregatedFeedbackRelevance =
        await t.get(change.after.ref.parent.parent!
            .collection(kTagsCollection)
            .where("aggregatedFeedback.relevance.score", ">", 0));
        const relevanceScore = change.after.data()!.feedback?.general?.score;

        const promises: Promise<any>[] = [];
        if (aggregatedFeedbackGeneral.empty) {
          promises.push(change.after.ref.parent.parent!
              .collection(kTagsCollection)
              .add({
                aggregatedFeedback: {
                  general: {
                    score: generalScore ?? 0,
                  },
                },
              }));
        } else {
          t.set(aggregatedFeedbackGeneral.docs[0].ref,
              {
                aggregatedFeedback: {
                  general: {
                    score: admin.firestore.FieldValue
                        .increment(generalScore ?? 0),
                  },
                },
              }, {merge: true});
        }


        if (aggregatedFeedbackRelevance.empty) {
          promises.push(change.after.ref.parent.parent!
              .collection(kTagsCollection)
              .add({
                aggregatedFeedback: {
                  relevance: {
                    score: relevanceScore ?? 0,
                  },
                },
              }));
        } else {
          t.set(aggregatedFeedbackRelevance.docs[0].ref,
              {
                aggregatedFeedback: {
                  relevance: {
                    score: admin.firestore.FieldValue
                        .increment(relevanceScore ?? 0),
                  },
                },
              }, {merge: true});
        }
        return Promise.all(promises);
      });
    } catch (e) {
      await Promise.all(docRefHandleError(
          change.after.ref.parent.parent, e, "null"));
    }
  }
};