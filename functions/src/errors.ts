import {Logging} from "@google-cloud/logging";
import * as functions from "firebase-functions";
import * as Sentry from "@sentry/node";
import * as admin from "firebase-admin";
import {DocumentSnapshot, QueryDocumentSnapshot}
  from "firebase-functions/lib/providers/firestore";


const logging = process.env.GCLOUD_PROJECT ? new Logging({
  projectId: process.env.GCLOUD_PROJECT,
}) : null;

// [START reportError]

export const reportError = (err: Error, context = {}): Promise<Error> => {
  functions.logger.log(err, context);
  // Skip StackDriver in non-production / tests
  if (!logging) {
    return Promise.resolve(err);
  }
  // This is the name of the StackDriver log stream that will receive the log
  // entry. This name can be any valid log stream name, but must contain "err"
  // in order for the error to be picked up by StackDriver Error Reporting.
  const logName = "errors";
  const log = logging.log(logName);

  // https://cloud.google.com/logging/docs/api/ref_v2beta1/rest/v2beta1/MonitoredResource
  const metadata = {
    resource: {
      type: "cloud_function",
      labels: {function_name: process.env.FUNCTION_NAME},
    },
  };

  // https://cloud.google.com/error-reporting/reference/rest/v1beta1/ErrorEvent
  const errorEvent = {
    message: err.stack,
    serviceContext: {
      service: process.env.FUNCTION_NAME,
      resourceType: "cloud_function",
    },
    context: context,
  };

  Sentry.captureException(err, {
    extra: context,
    tags: metadata.resource.labels,
  });

  // Write the error log entry
  return new Promise<Error>((resolve, reject) => {
    // @ts-ignore
    log.write(log.entry(metadata, errorEvent), (error) => {
      if (error) {
        return reject(error);
      }
      return resolve(err);
    });
  });
};

// [END reportError]


interface ErrorOptions {
    developerMessage?: string,
    userMessage?: string,
    code?: functions.https.FunctionsErrorCode,
    uid?: string,
}

export const handleError = (
    snap: admin.firestore.DocumentReference |
    null |
    QueryDocumentSnapshot |
    DocumentSnapshot,
    options: ErrorOptions
): Promise<any>[] => {
  const e = Error(JSON.stringify(options.developerMessage));
  const p1 = snap ?
  (
    snap instanceof admin.firestore.DocumentReference ?
    snap :
    snap.ref
  ).set({
    errors: admin.firestore.FieldValue.arrayUnion({
      developerMessage: e.toString(),
      createdAt: Date.now(),
      code: options.code ?? "internal",
      userMessage: options.userMessage ??
        "An error occurred, developers have been alerted",
    }),
  }, {merge: true}) : Promise.resolve();
  const p2 = reportError(e, options.uid ? {user: options.uid} : undefined);
  return [p1, p2];
};
