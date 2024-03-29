import * as admin from "firebase-admin";
import {langame} from "../langame/protobuf/langame";
import {welcomeMessages} from "../users/welcomeMessages";
import {sample} from "../utils/array";
import {converter} from "../utils/firestore";
import {initFirebaseTest} from "../utils/firestore.spec";
import {
  getAppleHtmlButtonWithBase64Image, googleHtmlButton, html,
  webHtmlButton,
} from "../utils/html";
// import {initFirebaseTest} from "../utils/firestore.spec";
interface ReleaseOptions {
  sendMail?: boolean;
  resetOnboarding?: boolean;
  resetSawWhatsNew?: boolean;
}
/* eslint-disable max-len */
// Show a list of the buttons to get the new version (Google, Apple, Web)
// In a vertical center aligned list
const body = (appleButton: string) => `Download the new version of Langame now 😛<br>
<table>
  <tr>
    <td>
      ${googleHtmlButton}
    </td>
  </tr>
  <tr>
    <td>
      ${appleButton}
    </td>
  </tr>
  <tr>
    <td>
      ${webHtmlButton}
    </td>
  </tr>
</table>
<br>
Please do not hesitate to give us feedback <a href="https://help.langa.me/feedback">here.</a>
<br>
<em>${sample(welcomeMessages)}</em>
`;
/* eslint-disable max-len */

export const release = async ({
  sendMail = false,
  resetOnboarding = false,
  resetSawWhatsNew = false,
}: ReleaseOptions) => {
  const db = admin.firestore();
  const preferencesDocs = await db.collection("preferences")
      .withConverter(converter<langame.protobuf.IUserPreference>())
      .get();
  const usersDocs = await db.collection("users")
      .withConverter(converter<langame.protobuf.IUser>())
      .get();
  // List of {user, preference}
  const users = preferencesDocs.docs
  // It's inefficient but ok for now
      .filter((doc) => {
        const user = usersDocs.docs.find((u) => u.id === doc.id);
        return (user &&
          user.data() &&
          doc.data() &&
          !user.data().email?.includes("langa.me")
        );
      })
      .map((doc) => {
        const user = usersDocs.docs.find((u) => u.id === doc.id);
        return {
          userDoc: user!,
          preferenceDoc: doc,
        };
      });
  console.log(`${users.length} users`);
  if (sendMail) {
    console.log("Will notify by mail",
        // Count users with email preference
        users.filter((u) =>
          u.preferenceDoc.data()!.notification?.newVersion?.email === true)
            .length,
        "users",
    );
  }

  if (resetOnboarding) console.log("Will reset onboarding");
  if (resetSawWhatsNew) console.log("Will reset sawWhatsNew");
  await Promise.all(users.map(async (user) => {
    const promises = [];
    const propertyToUpdate: any = {};
    if (resetOnboarding) propertyToUpdate.hasDoneOnBoarding = false;
    if (resetSawWhatsNew) propertyToUpdate.sawWhatsNew = false;
    // check has the property hasDoneOnboarding
    if (
      // If propertyToUpdate has any key
      Object.keys(propertyToUpdate).length > 0 &&
      user.preferenceDoc.data().hasDoneOnBoarding !== undefined) {
      // set to false
      promises.push(user.preferenceDoc.ref.update(propertyToUpdate));
    }
    // TODO: PUSH
    if (sendMail && user.preferenceDoc.data()!.notification?.newVersion?.email === true) {
      const appleButton = await getAppleHtmlButtonWithBase64Image();
      const title = "A new version of Langame is available!";
      promises.push(db.collection("mails").add({
        to: user.userDoc.data()!.email,
        message: {
          subject: title,
          html: `<code>
        ${html(title, body(appleButton), "Have a great day 😇.")}
      </code>`,
        },
      }));
    }
    return Promise.all(promises);
  }));
  console.log(`Done, new version released, ${users.length} users notified`);
};


if (process.argv[2] === "execute") {
  initFirebaseTest("prod", ".");
  release({
    sendMail: false,
  });
}
