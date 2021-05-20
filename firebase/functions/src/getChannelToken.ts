import {https} from "firebase-functions";
import {kNotAuthenticated,
  kInvalidRequest,
  getLangame,
  generateAgoraRtcToken} from "./helpers";
import {FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode} from "./models";

export const getChannelToken = async (data: any,
    context: https.CallableContext) => {
  if (!context.auth) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.UNAUTHORIZED,
        undefined,
        kNotAuthenticated,
    );
  }
  if (!data) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        kInvalidRequest,
    );
  }
  if (!data.channelName) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "you must provide a valid channel name",
    );
  }

  const langame = await getLangame(data.channelName);
  if ("statusCode" in langame) return langame;
  const player = langame.players
      .find((p: any) => p.langameUid === context.auth!.uid);

  if (!player) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.BAD_REQUEST,
        undefined,
        "could not find user in this channel",
    );
  }
  const agoraRtcToken =
          generateAgoraRtcToken(data.channelName, player.channelUid);
  return new FirebaseFunctionsResponse(
      FirebaseFunctionsResponseStatusCode.OK,
      {channelToken: agoraRtcToken},
      undefined,
  );
};
