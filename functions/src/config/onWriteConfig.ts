import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {Change, EventContext} from "firebase-functions";
import {handleError, reportError} from "../errors";
import {shouldDrop} from "../utils/contexts";
import fetch from "node-fetch";
import {Client} from "@notionhq/client";

export const onWriteConfig = async (
    change: Change<admin.firestore.DocumentSnapshot<any>>,
    ctx: EventContext) => {
  functions.logger.log(ctx);

  if (shouldDrop(ctx) || change.after.data().errors) return;

  try {
    if (!change.after.data()) {
      return reportError(new Error(`${change.after.id} has no data`), ctx);
    }

    const data = change.after.data();
    functions.logger.log("data", change.before.data(), data);
    if (
      data.notion &&
      // didn't already get the access token
      !data.notion.access_token &&
      data.notion.code &&
      data.notion.redirect_uri
    ) {
      const clientId = functions.config().notion.client_id;
      const clientSecret = functions.config().notion.client_secret;

      const response = await fetch("https://api.notion.com/v1/oauth/token", {
        method: "POST",
        headers: {
          "Authorization": "Basic " +
            Buffer.from(clientId + ":" + clientSecret).toString("base64"),
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          "grant_type": "authorization_code",
          "code": data.notion.code,
          "redirect_uri": data.notion.redirect_uri,
        }),
      });
      const json = await response.json();

      await change.after.ref.set({
        notion: {
          ...data.notion,
          ...json,
        },
      }, {merge: true});
      const notion = new Client({
        auth: json.access_token,
      });
      const hasLangamesDatabaseAlready = await notion.search({
        query: "Langames",
      });
      if (hasLangamesDatabaseAlready.results.length > 0) {
        functions.logger.log("already has langames database");
        return;
      }
      return createLangamesDatabase(notion, json.workspace_icon);
    }
    return Promise.resolve();
  } catch (e: any) {
    await Promise.all(handleError(
        change.after.ref, {developerMessage: e}));
    return Promise.reject(e);
  }
};

export const createLangamesDatabase = async (
    notion: Client, langameIcon: string) => {
  const responseSearch = await notion.search({});
  if (responseSearch.results.length === 0) {
    throw new Error("Notion workspace has no pages");
  }
  const responseDatabaseCreate = await notion.databases.create({
    parent: {page_id: responseSearch.results.find((e) =>
      e.object === "page")!.id},
    title: [{
      "text": {
        "content": "Langames",
      },
    }],
    icon: {
      external: {
        url: langameIcon,
      },
    },
    properties: {
      "Langame": {
        "type": "rich_text",
        // @ts-ignore
        "rich_text": [],
      },
      "Author": {
        "type": "rich_text",
        // @ts-ignore
        "rich_text": [],
      },
      "Answer": {
        // @ts-ignore
        "title": [],
      },
      "Channel": {
        "type": "rich_text",
        // @ts-ignore
        "rich_text": [],
      },
      "Date": {
        "type": "date",
        "date": {},
      },
    },
  });
  functions.logger.log("created langames database", responseDatabaseCreate);
  return responseDatabaseCreate.id;
};
