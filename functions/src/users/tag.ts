import * as admin from "firebase-admin";
import {names, uniqueNamesGenerator} from "unique-names-generator";

interface GenerateTagOptions {
    maxTries: number;
}
export const generateTag = async (options: GenerateTagOptions = {
  maxTries: 5,
}): Promise<string | undefined> => {
  let tag: string | undefined = undefined;
  let tries = 0;
  while (!tag && tries < options.maxTries) {
    tries++;
    tag = uniqueNamesGenerator({
      dictionaries: [names],
      length: 1,
      style: "lowerCase",
    });

    if (tag.length > 12) continue;

    // Check that this tag is not taken
    const userWithSameTag =
            await admin.firestore().collection("users")
                .where("tag", "==", tag).get();
    if (userWithSameTag.empty) {
      break;
    }
    tag = undefined;
  }
  return tag;
};
