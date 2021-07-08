import * as admin from "firebase-admin";
import {ImplAiApi} from "../aiApi/implAiApi";
import {reportError} from "../errors";
import {kTagsCollection} from "../helpers";
import {langame} from "../langame/protobuf/langame";
import {converter} from "../utils/firestore";

export const classifyTag =
    // eslint-disable-next-line max-len
    async (m: admin.firestore.DocumentSnapshot<langame.protobuf.Meme>): Promise<admin.firestore.DocumentReference<any>[]> => {
      const db = admin.firestore();
      // TODO: doesn't scale
      const tagDocs = await db
          .collectionGroup(kTagsCollection)
          .where("topic.content", "!=", "")
          .withConverter(converter<langame.protobuf.Tag>())
          .get();
      const alreadyPresentTopics =
          (await m.ref.collection("tags")
              .where("topic.content", "!=", "").get())
              .docs.filter((e) => e.data().topic && e.data().topic.content)
              .map((e) => e.data().topic.content);

      const distinctClasses = [...new Set(tagDocs.docs
          .map((e) =>
                e.data().topic!.content
          ))].filter((e) => !alreadyPresentTopics.includes(e));

      if (!distinctClasses) {
        return reportError(new Error("failed to get distinct topics"));
      }
      const api = new ImplAiApi();
      // TODO: multi label = lower quality?
      const classifications =
            await api.classify(
                m.data()!.content, distinctClasses as string[],
                true,
                0.7);
      const classesWithEmojis = distinctClasses.map((c) => {
        const t = tagDocs.docs.find((e) => e.data().topic?.content === c);
        return {
          topic: c,
          emojis: t && t.data().topic ? t!.data().topic!.emojis : [],
        };
      });
      const basePrompt =
      classesWithEmojis.map((e) =>
        `${e.topic}:${e.emojis!.join("")}`).join("\n");

      return Promise.all(classifications
          // Infer emojis and insert
          .map(async (c) => {
            const prompt = `${basePrompt}\n${c}:`;
            const inferredEmojis =
                await api.completion(prompt,
                    true,
                    {
                      model: "davinci",
                      temperature: 0.8,
                      maxTokens: 100,
                      topP: 1,
                      frequencyPenalty: 0,
                      presencePenalty: 0,
                      stop: ["\n"],
                    });
            // eslint-disable-next-line max-len
            const regexExp = /(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])/gi;

            const emojisAsList = inferredEmojis ? Array.from(inferredEmojis)
                // Filter non-emojis
                .filter((e) => regexExp.test(e))
                .map((e) => e.toString()) : [];
            return m.ref.collection("tags")
                .add({
                  createdAt: admin.firestore.FieldValue.serverTimestamp(),
                  topic: {
                    content: c.trim(),
                    emojis: emojisAsList,
                  },
                });
          }
          ));
    };

export const onlyUnique = <T>(value: any, index: number, self: Array<T>) => {
  return self.indexOf(value) === index;
};
