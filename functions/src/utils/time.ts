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

/**
 * Parse hrtime to seconds
 * @param{[number, number]} hrtime
 * @return{number}
 */
export function parseHrtimeToSeconds(hrtime: [number, number]): number {
  return +(hrtime[0] + (hrtime[1] / 1e9)).toFixed(3);
}
