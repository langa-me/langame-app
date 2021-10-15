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
