import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {Change, EventContext} from "firebase-functions";
import {ImplAiApi} from "../aiApi/implAiApi";
import {handleError, reportError} from "../errors";
import {algoliaPrefix} from "../helpers";
import {shouldDrop} from "../utils/contexts";
import {Client} from "@notionhq/client";
import {createLangamesDatabase} from "../config/onWriteConfig";


export const onWriteSavedConversation = async (
    change: Change<admin.firestore.DocumentSnapshot<any>>,
    ctx: EventContext) => {
  functions.logger.log(ctx);

  const api = new ImplAiApi();
  if (shouldDrop(ctx) || change.after.data().errors) return;

  try {
    const i = api.getIndex(algoliaPrefix + "saved_conversations");
    if (!change.after.data()) {
      await i?.deleteObject(change.after.id);
      return reportError(new Error(`${change.after.id} has no data`), ctx);
    }

    const data = change.after.data();
    functions.logger.log("synchronizing conversations to algolia");
    functions.logger.log("data", data.guildId);

    // find the text within the "**" (i.e. bold tags)
    const langame = data.conversation.find((e: any) =>
      e.author.includes("Langame")).content.match(/\*\*(.*)\*\*/)[1];
    const humanAnswer = data.conversation.find((e: any) =>
      !e.author.includes("Langame"));
    await i?.saveObject({
      ...data,
      objectID: change.after.id,
    });

    const configQueryDocs = await admin.firestore().collection("configs")
        .where("guild_id", "==", data.guildId)
        .get();

    if (configQueryDocs.empty) {
      return reportError(new Error(`${change.after.id} has no config`), ctx);
    }

    const config = configQueryDocs.docs[0].data();

    if (!config.notion) {
      functions.logger.log("guild has no notion integration, skipping");
      return;
    }

    if (!config.notion.access_token) {
      return reportError(new Error(
          "guild has notion integration but no access token"));
    }

    return writeToNotion({
      accessToken: config.notion.access_token,
      langame: langame,
      author: humanAnswer.author,
      answer: humanAnswer.content,
      channel: data.channelName,
      date: data.createdAt.toDate().toISOString(),
      langameIcon: config.notion.workspace_icon,
    });
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref, {developerMessage: e}));
    return Promise.reject(e);
  }
};

interface WriteToNotionRequest {
  accessToken: string
  langame: string
  author: string
  answer: string
  channel: string
  date: string
  langameIcon: string
}
export const writeToNotion = async ({
  accessToken,
  langame,
  author,
  answer,
  channel,
  date,
  langameIcon,
}: WriteToNotionRequest): Promise<void> => {
  const notion = new Client({auth: accessToken});
  const langamesDatabaseResponse = await notion.search({
    query: "Langames",
  });
  let langamesDatabaseId = langamesDatabaseResponse.results.find((e) =>
    e.object === "database"
  )?.id;
  if (!langamesDatabaseId) {
    langamesDatabaseId = await createLangamesDatabase(notion, langameIcon);
  }
  const response = await notion.pages.create({
    parent: {database_id: langamesDatabaseId},
    properties: {
      "Langame": {
        "type": "rich_text",
        "rich_text": [
          {
            "type": "text",
            "text":
            {
              "content": langame,
            },
          },
        ],
      },
      "Author": {
        "type": "rich_text",
        "rich_text": [
          {
            "type": "text",
            "text":
            {
              "content": author,
            },
          },
        ],
      },
      "Answer": {
        "title": [
          {
            "text": {
              "content": answer,
            },
          },
        ],
      },
      "Channel": {
        "type": "rich_text",
        "rich_text": [
          {
            "type": "text",
            "text":
            {
              "content": channel,
            },
          },
        ],
      },
      "Date": {
        "type": "date",
        "date": {
          "start": date,
        },
      },
    },
  });
  functions.logger.log(response);
  functions.logger.log("Success! Entry added.");
};
