/**
 * shuffle an array
 * @param{Array<T>} array
 * @return{T[]}
 */
export function shuffle<T>(array: T[]): T[] {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
  return array;
}

/**
 *
 * @param{T[]} items
 * @param{number} n
 * @return{any}
 */
export const chunkItems = <T>(items: T[], n: number): T[][] =>
  items.reduce((chunks: T[][], item: T, index) => {
    const chunk = Math.floor(index / n);
    chunks[chunk] = ([] as T[]).concat(chunks[chunk] || [], item);
    return chunks;
  }, []);

/**
 * Chunks generator an array into smaller arrays of a specified size.
 * @param {T[]} arr
 * @param {number} n
 */
export function* chunks<T>(arr: T[], n: number) {
  for (let i = 0; i < arr.length; i += n) {
    yield arr.slice(i, i + n);
  }
}


/**
 * sample from array
 * @param {Array<T>} array
 * @return {T}
 */
export function sample<T>(array: T[]): T {
  return array[Math.floor(Math.random()*array.length)];
}

/**
 * samples from array
 * @param {Array<T>} array
 * @param {number} n
 * @return {T[]}
 */
export function samples<T>(array: T[], n: number): T[] {
  return shuffle(array).slice(0, n);
}
