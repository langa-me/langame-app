import {https} from "firebase-functions";
import {
  LangameFunctionsError,
} from "./models";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import FirebaseFunctionsRateLimiter from "firebase-functions-rate-limiter";
import {langame} from "./langame/protobuf/langame";
const perUserlimiter = FirebaseFunctionsRateLimiter.withFirestoreBackend(
    {
      name: "per_user_limiter",
      maxCalls: 2,
      periodSeconds: 15,
    },
    admin.firestore(),
);


export const versionCheck = async (
    data: any, context: https.CallableContext) => {
  if (!context.app) {
    throw new LangameFunctionsError("internal", "");
  }
  const uidQualifier = "u_" + context.app;
  const isQuotaExceeded =
        await perUserlimiter.isQuotaAlreadyExceeded(uidQualifier);
  if (isQuotaExceeded) {
    const m = "too many requests";
    throw new LangameFunctionsError("resource-exhausted", m, m);
  }

  if (!data || !data.version) {
    const m = "you must provide a version";
    throw new LangameFunctionsError("invalid-argument", m, m);
  }


  functions.logger.info("checking user version", data.version);
  const t = await admin.remoteConfig().getTemplate();
  // @ts-ignore
  const langameVersion = t.parameters.langame_version.defaultValue.value;

  // TODO: might fail if client send garbage
  //   let [version, versionCode] = data.version.split("+");
  // Naive for now, hard check
  if (data.version !== langameVersion) {
    return new langame.protobuf.FunctionResponse({
      versionCheck: new langame.protobuf.FunctionResponse.VersionCheck({
        update:
        langame.protobuf.FunctionResponse.VersionCheck.UpdateRequired.REQUIRED,
      }),
    });
  }

  return new langame.protobuf.FunctionResponse({
    versionCheck: new langame.protobuf.FunctionResponse.VersionCheck({
      update: langame.protobuf.FunctionResponse.VersionCheck.UpdateRequired.OK,
    }),
  });
};
