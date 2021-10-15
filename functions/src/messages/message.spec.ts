import {createReflection, createSuggestion} from "./onWriteMessageAnalysis";
import "mocha";
import {initFirebaseTest} from "../utils/firestore.spec";
import {ImplAiApi} from "../aiApi/implAiApi";


it("suggest", async () => {
  initFirebaseTest({isDev: true});

  const completion = await createSuggestion(
      new ImplAiApi(),
      "775b19ed",
      "qpbGMze6PHb1PPDhnrCVoObosGj2",
  );
  console.log(completion);
});

it("reflect", async () => {
  initFirebaseTest({isDev: true});

  const completion = await createReflection(
      new ImplAiApi(),
      "775b19ed",
      "qpbGMze6PHb1PPDhnrCVoObosGj2",
  );
  console.log(completion);
});

