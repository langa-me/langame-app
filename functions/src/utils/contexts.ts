import * as functions from "firebase-functions";


interface ShouldDropOptions {
  eventMaxAgeMs?: number;
}

/**
 * Set an end condition to avoid infinite retry loops
 * It is best practice to protect your function against
 * continuous looping when using retries.
 * You can do this by including a well-defined end condition,
 * before the function begins processing. Note that this technique only works
 * if your function starts successfully
 * and is able to evaluate the end condition.
 * A simple yet effective approach is to discard events
 * with timestamps older than a certain time.
 * This helps to avoid excessive executions when failures
 * are either persistent or longer-lived than expected.
 * For example, this code snippet discards all events older than 10 seconds:
 * @param{functions.EventContext} ctx
 * @param{ShouldDropOptions} options
 * @return{boolean}
 */
export const shouldDrop = (ctx: functions.EventContext,
    options?: ShouldDropOptions): boolean => {
  const eventAgeMs = Date.now() - Date.parse(ctx.timestamp);
  const eventMaxAgeMs = options?.eventMaxAgeMs || 10_000;
  if (eventAgeMs > eventMaxAgeMs) {
    // eslint-disable-next-line max-len
    functions.logger.log(`Dropping event ${ctx.eventId} with age[ms]: ${eventAgeMs}`);
    return true;
  }
  return false;
};
