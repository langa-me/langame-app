import {https} from "firebase-functions";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {langame} from "./langame/protobuf/langame";
import {getPerUserlimiter} from "./utils/firestore";
const satisfies = require("semver/functions/satisfies");


export const versionCheck = async (
    data: any, context: https.CallableContext) => {
  if (!context.rawRequest.ip) {
    throw new https.HttpsError(
        "internal",
        "unknown error",
    );
  }
  const uidQualifier = "u_" + context.rawRequest.ip;
  const isQuotaExceeded =
        await getPerUserlimiter().isQuotaAlreadyExceeded(uidQualifier);
  if (isQuotaExceeded) {
    const m = "too many requests";
    throw new https.HttpsError(
        "resource-exhausted",
        m,
    );
  }

  if (!data || !data.version || data.version.split("+").length < 2) {
    const m = "you must provide a version";
    throw new https.HttpsError(
        "invalid-argument",
        m,
    );
  }


  functions.logger.info("checking user version", data.version);
  const t = await admin.remoteConfig().getTemplate();
  // @ts-ignore
  const langameVersion = t.parameters.langame_version.defaultValue.value;
  if (!satisfies(data.version, langameVersion)) {
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
