import "mocha";
import * as firebase from "@firebase/rules-unit-testing";
import * as fs from "fs";
import {RulesTestContext, RulesTestEnvironment}
  from "@firebase/rules-unit-testing";


describe("Firestore rules", async () => {
  let testEnv: RulesTestEnvironment;
  let alice: RulesTestContext;
  let bob: RulesTestContext;
  let anonymous: RulesTestContext;
  before(async () => {
    testEnv = await firebase.initializeTestEnvironment({
      projectId: "fooBar",
      firestore: {
        rules: fs.readFileSync("./firestore.rules", "utf8"),
      },
    });
    alice = testEnv.authenticatedContext(
        "alice",
    );
    bob = testEnv.authenticatedContext("bob");
    anonymous = testEnv.unauthenticatedContext();
  });
  after(async () => {
    await testEnv.clearFirestore();
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
});

