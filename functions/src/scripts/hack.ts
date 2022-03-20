import {initFirebaseTest} from "../utils/firestore.spec";
import * as admin from "firebase-admin";

const f = async () => {
  const db = admin.firestore();
  const u = await db.collection("messages").get();
  await Promise.all(u.docs.map(async (doc) => {
    const author = doc.data().author;
    if (author.email?.includes("@langa.me") &&
        !author.email?.includes("louis")) {
      console.log("updating", author.email, author.id);
      author.bot = true;
      return doc.ref.update({
        author: author,
      });
    }
    return Promise.resolve();
  }));
};


if (process.argv[2] === "execute") {
  initFirebaseTest("prod", ".");
  f();
}
