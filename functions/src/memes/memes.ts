import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";
import {shuffle} from "../utils/array";
/**
 * offlineMemeSearch Find memes in topic ordered by score, filtering
 * low scores
 * @param{string[]} topics
 * @param{string[]} idsFilter ids to filter out
 * @param{number} limit number of questions
 */
export const offlineMemeSearch = async (
    topics: string[],
    idsFilter: string[] = [],
    limit: number = 1,
): Promise<admin.firestore.DocumentSnapshot<langame.protobuf.IMeme>[]> => {
  topics = topics.map((t) => t.toLowerCase());
  if (topics.length === 0) topics = [""];
  // eslint-disable-next-line max-len
  functions.logger.log(`searching meme ${topics.join(",")}, limit: ${limit}, filters:${idsFilter}`);
  const db = admin.firestore();
  const results = await db.collection("memes")
      .withConverter(converter<langame.protobuf.IMeme>())
      .where("topics", "array-contains-any", topics)
      .where("disabled", "==", false) // TODO: confirmed?
      .get();
  const memes = results.docs
      .filter((d) => !idsFilter.includes(d.id));

  return shuffle(memes).slice(0, limit);
};

export const onlineMemeGenerator = async (
    topics: string[],
    limit: number = 1,
    translated: boolean = false,
    grammar: boolean = false,
    parallelCompletions: number = 3,
    timeout: number = 40_000,
): Promise<admin.firestore.DocumentSnapshot<
  langame.protobuf.IMeme>[]> => {
  functions.logger.log(`generating memes ${topics.join(",")},` +
    ` limit: ${limit}, translated:${translated}, grammar:${grammar}` +
    ` parallelCompletions:${parallelCompletions}, timeout:${timeout}`);

  // In a distributed ava scenario, need to know how many workers there is
  const avaWorkers = (functions.config().ava?.workers || 0) * 1;

  // For number "limit" generate
  return Promise.all(Array.from({length: limit}, async () => {
    const startProcessingTime = Date.now();
    const starterRef = await admin.firestore().collection("memes")
        .withConverter(converter<langame.protobuf.IMeme>())
        .add({
          state: "to-process",
          topics: topics,
          // @ts-ignore
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          disabled: true,
          tweet: false,
          // If the config is set, assign to a random worker
          shard: Math.floor(Math.random() * avaWorkers),
          fixGrammar: grammar,
          parallelCompletions,
        });
    return new Promise<admin.firestore.DocumentSnapshot<
      langame.protobuf.IMeme>>((resolve, reject) => {
        setTimeout(() => reject(new Error("timeout")),
            timeout *
            (translated || grammar ? 2 : 1)); // Wait more
        starterRef.onSnapshot((snapshot) => {
          if (
            snapshot.data()!.state === "processed" &&
            snapshot.data()!.content
          ) {
            if (translated && !snapshot.data()!.translated) return;
            functions.logger.log(`generated meme ${snapshot.id}`+
            ` in ${Date.now() - startProcessingTime}ms`);
            resolve(snapshot);
          } else if (snapshot.data()!.state === "error") {
            reject(new Error(snapshot.data()!.error || "unknown"));
          }
        });
      });
  }));
};
