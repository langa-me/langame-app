import "mocha";
import {initFirebaseTest} from "../utils/firestore.spec";
import {reviveLangame} from "./reviveLangame";
import {setTagsLangame} from "./setTagsLangame";

describe("langames", () => {
  it("setTagsLangame", async () => {
    initFirebaseTest("dev");
    setTagsLangame({
      eventId: "eventId",
      eventType: "google.firestore.document.write",
      params: {},
      resource: {
        service: "string",
        name: "string",
      },
      timestamp: "2020-04-01T00:00:00.000Z",
    });
  });
  it("reviveLangame", async () => {
    initFirebaseTest("dev");
    reviveLangame({
      eventId: "eventId",
      eventType: "google.firestore.document.write",
      params: {},
      resource: {
        service: "string",
        name: "string",
      },
      timestamp: "2020-04-01T00:00:00.000Z",
    });
  });
});
