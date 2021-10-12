/**
 * Wait some time in milliseconds
 * @param{number} ms
 * @return{Promise<void>}
 */
export function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}
