import {
  filterOutSendLangameCalls,
  getUserData, handleSendToDevice,
  hashFnv32a,
  kLangamesCollection,
  kNotificationsCollection,
  kUserDoesNotExist,
} from "./helpers";
import {
  FirebaseFunctionsResponse,
  FirebaseFunctionsResponseStatusCode,
} from "./models";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {offlineQuestionSearch} from "./questions";
import {https} from "firebase-functions";

export const sendLangame = async (
    data: any, context: https.CallableContext) => {
  // Check request body is ok
  const initialChecks = filterOutSendLangameCalls(data, context);
  if (initialChecks !== 0) return initialChecks;
  // Get recipients data from firestore
  const recipientsData: Array<FirebaseFunctionsResponse | any> = [];
  for (const r of data.recipients) {
    const user = await getUserData(r);
    if ("statusCode" in user) return user;
    if (!user.tokens) {
      functions.logger
          .error(kUserDoesNotExist(r.langameUid), "has no devices");
      return new FirebaseFunctionsResponse(
          FirebaseFunctionsResponseStatusCode.INTERNAL,
          undefined,
          `user ${r.langameUid} has no devices (tokens)`,
      );
    }
    recipientsData.push(user);
  }

  // Get sender data from firestore
  const senderData: FirebaseFunctionsResponse | any =
        await getUserData(context.auth!.uid);
    // Failed ? Return error
  if ("statusCode" in senderData) return senderData;

  // TODO: is it really 100% atomic?
  const channelName: string | number =
        hashFnv32a(senderData.uid!, true, Date.now());
    // Somehow, shouldn't happen
  if (typeof channelName === "number") {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "failed to generate channel name");
  }

  const t = await admin.remoteConfig().getTemplate();
  if (!t.parameters.question_engine.defaultValue ||
        !("value" in t.parameters.question_engine.defaultValue) ||
        !t.parameters.offline_use_generated.defaultValue ||
        !("value" in t.parameters.offline_use_generated.defaultValue)) {
    functions.logger.error("invalid remote config");
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "question_invalid_config");
  }
  let questions: any[] | undefined;
  if (t.parameters.question_engine.defaultValue.value === "offline") {
    questions = await offlineQuestionSearch(data.topics,
        1,
        0.1,
        t.parameters.offline_use_generated.defaultValue.value === "true");
  } else if (t.parameters.question_engine.defaultValue.value === "online") {
    throw Error("unimplemented");
    // questions =
    //         await onlineOpenAiCompletion(data.topics, t.parameters);
  }

  if (!questions || questions.length === 0) {
    functions.logger.error("failed to find question for topics", data.topics);
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "question_find_error");
  }

  functions
      .logger
      .info("found questions for topics", data.topics, questions);
  const recipientsUid = recipientsData.map((r) => r.uid);
  const playersLangameUid = recipientsUid.concat([senderData.uid!]);
  await admin
      .firestore()
      .collection(kLangamesCollection)
      .add(JSON.parse(JSON.stringify({
        channelName: channelName,
        players: playersLangameUid.map((e, i) => {
          // i.e. mapping channel user id -> Langame user id
          return {
            channelUid: i+1, // Agora need not start 0
            langameUid: e!,
          };
        }),
        topics: data.topics,
        questions: questions,
      },
      ),
      ),
      ); // TODO: might check error?

  const results = await recipientsData
  // @ts-ignore
      .map(async (e: any) => {
        const notificationPayload = {
          senderUid: context.auth!.uid,
          // @ts-ignore
          recipientsUid: recipientsUid,
          // Topics of the Langame
          topics: data.topics,
          channelName: channelName,
        };

        const notification = await admin
            .firestore()
            .collection(kNotificationsCollection)
            .add(JSON.parse(JSON.stringify(notificationPayload)));

        return await handleSendToDevice(e,
            notification.id,
            admin.messaging().sendToDevice(
                    e.tokens!,
                    {
                      data: {id: notification.id},
                      notification: {
                        tag: channelName,
                        // eslint-disable-next-line max-len
                        body: `${senderData.displayName} invited you to play ${data.topics.join(",")}`,
                        // eslint-disable-next-line max-len
                        title: `Play ${data.topics.join(",")} with ${senderData.displayName}?`,
                      },
                    },
                    {
                      // Required for background data-only messages on iOS
                      contentAvailable: true,
                      // Required for background data-only messages on Android
                      priority: "high",
                    }
            ),
        );
      });
  const successfulResults = results.filter((r) =>
    !("statusCode" in r));
    // If all failed
  if (successfulResults.length === 0) {
    return new FirebaseFunctionsResponse(
        FirebaseFunctionsResponseStatusCode.INTERNAL,
        undefined,
        "could not send Langame");
  }
  // TODO: might send a notification to the sender to offer joining now?
  // Succeed
  return new FirebaseFunctionsResponse(
      FirebaseFunctionsResponseStatusCode.OK,
      {channelName: channelName},
      undefined);
};
