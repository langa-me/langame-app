import "mocha";
import * as firebase from "@firebase/rules-unit-testing";
import * as fs from "fs";

const admin = firebase.initializeAdminApp({
  projectId: "langame-dev",
});
const alice = firebase.initializeTestApp({
  projectId: "langame-dev",
  auth: {uid: "alice", email: "alice@langa.me"},
});
const bob = firebase.initializeTestApp({
  projectId: "langame-dev",
  auth: {uid: "bob", email: "bob@langa.me"},
});
const anonymous = firebase.initializeTestApp({
  projectId: "langame-dev",
});

describe("Firestore rules", async () => {
  before(async () => {
    await firebase.loadFirestoreRules({
      projectId: "langame-dev",
      rules: fs.readFileSync("../firestore.rules", "utf8"),
    });
  });
  after(async () => {
    await firebase.clearFirestoreData({
      projectId: "langame-dev",
    });
  });

  it("users", async () => {
    firebase.assertSucceeds(alice.firestore().collection("users")
        .doc("alice")
        .set({
          uid: "alice",
          displayName: "alice",
        }));
    firebase.assertSucceeds(alice.firestore().collection("users")
        .doc("alice")
        .get());

    firebase.assertSucceeds(alice.firestore().collection("users")
        .doc("alice")
        .update({
          displayName: "bar",
        }));
    firebase.assertSucceeds(alice.firestore().collection("users")
        .doc("alice")
        .delete());

    // Bob create an account
    firebase.assertSucceeds(bob.firestore().collection("users")
        .doc("bob")
        .set({
          uid: "bob",
          displayName: "bob",
        }));

    // Can read others profiles
    firebase.assertSucceeds(alice.firestore().collection("users")
        .doc("bob")
        .get());

    // Alice read-only access to others data
    firebase.assertFails(alice.firestore().collection("users")
        .doc("bob")
        .set({
          uid: "bob",
          displayName: "bob",
        }));

    firebase.assertFails(alice.firestore().collection("users")
        .doc("bob")
        .update({
          displayName: "bob",
        }));

    firebase.assertFails(alice.firestore().collection("users")
        .doc("bob")
        .delete());

    // Anonymous can do nothing
    firebase.assertFails(anonymous.firestore().collection("users")
        .doc("bob")
        .get());

    firebase.assertFails(anonymous.firestore().collection("users")
        .doc("bob")
        .set({
          uid: "bob",
          displayName: "bob",
        }));

    firebase.assertFails(anonymous.firestore().collection("users")
        .doc("bob")
        .update({
          displayName: "bob",
        }));

    firebase.assertFails(anonymous.firestore().collection("users")
        .doc("bob")
        .delete());
  });
  it("memes", async () => {
    firebase.assertSucceeds(alice.firestore().collection("memes")
        .get());
    firebase.assertSucceeds(alice.firestore().collectionGroup("tags")
        .get());
    const memeRef = await admin.firestore().collection("memes").add({
      "topics": ["foo", "bar"],
    });
    firebase.assertSucceeds(alice.firestore().collection("memes")
        .doc(memeRef.id).collection("tags").get());
    firebase.assertSucceeds(alice.firestore().collection("memes")
        .doc(memeRef.id)
        .collection("tags")
        .add({
          feedback: {
            userId: "alice",
          },
        }));
    firebase.assertFails(alice.firestore().collection("memes")
        .add({}));
    firebase.assertFails(alice.firestore().collection("memes")
        .doc(memeRef.id)
        .collection("tags")
        .add({
          something_else: {
            userId: "alice",
          },
        }));
  });

  it("langames", async () => {

  });
});

