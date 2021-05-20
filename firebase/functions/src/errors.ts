import {Logging} from "@google-cloud/logging";
import * as functions from "firebase-functions";
const logging = process.env.GCLOUD_PROJECT ? new Logging({
  projectId: process.env.GCLOUD_PROJECT,
}) : null;

// [START reportError]

export const reportError = (err: Error, context = {}) => {
  // Skip StackDriver in non-production / tests
  if (!logging) {
    functions.logger.error(err, context);
    return;
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

  // Write the error log entry
  return new Promise<void>((resolve, reject) => {
    // @ts-ignore
    log.write(log.entry(metadata, errorEvent), (error) => {
      if (error) {
        return reject(error);
      }
      return resolve();
    });
  });
};

// [END reportError]

/**
 * Sanitize the error message for the user.
 * @param{Error} error
 * @return{String}
 */
export const userFacingMessage = (error: Error) => {
  // @ts-ignore
  return error.type ?
        error.message :
        "An error occurred, developers have been alerted";
};
