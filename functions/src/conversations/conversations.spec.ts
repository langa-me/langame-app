import "mocha";
import { writeToNotion } from "./onWriteSavedConversation";
import * as admin from "firebase-admin";
import { initFirebaseTest } from "../utils/firestore.spec";
import * as functions from "firebase-functions";
import fetch from "node-fetch";
import { Client } from "@notionhq/client";

describe("Conversations", () => {
    it("Test notion", async () => {
        initFirebaseTest("prod");
        const data = (await admin.firestore().collection("saved_conversations")
            .limit(1).get()).docs[0].data();
        const langame = data.conversation.find((e: any) =>
            e.author.includes("Langame")).content.match(/\*\*(.*)\*\*/)[1];
        const humanAnswer = data.conversation.find((e: any) =>
            !e.author.includes("Langame"));
        await writeToNotion({
            accessToken: "secret_SE4pP23s4GrU67DfkjDLU2pe61N9rGZUjeP0syikYea",
            langame: langame,
            author: humanAnswer.author,
            answer: humanAnswer.content,
            channel: data.channelName,
            date: data.createdAt.toDate().toISOString(),
        });
    });
    it("Test Notion 2", async () => {
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
          "code": "e7196fb7-ebbe-4771-a5bd-06345d5268c0",
          "redirect_uri": "http://localhost:3000/account/settings",
        }),
      });
      const json = await response.json();
      console.log(json);
    });
    it("Test Notion 3", async () => {
        const notion = new Client({auth: "secret_SE4pP23s4GrU67DfkjDLU2pe61N9rGZUjeP0syikYea"});
        const response = await notion.search({});
        const zz = await notion.search({
            query: "Langame",
        });
        if (zz.results.length > 0) return;
        const r2 = await notion.databases.create({
            parent: {page_id: response.results.find((e) => e.object === "page")!.id},
            title: [{
                "text": {
                    "content": "Langames",
                },
            }],
            icon: {
                external: {
                    url: "https://s3-us-west-2.amazonaws.com/public.notion-static.com/1316fe18-2a7f-4408-8710-fa72d49d6c10/logo-colourless.png",
                },
            },
            properties: {
          "Langame": {
            "type": "rich_text",
            "rich_text": [],
          },
          "Author": {
            "type": "rich_text",
            "rich_text": [],
          },
          "Answer": {
            "title": [],
          },
          "Channel": {
            "type": "rich_text",
            "rich_text": [],
          },
          "Date": {
            "type": "date",
            "date": {},
          },
        },
    });
    console.log(r2);
    });
});
