
/**
 * Usage
 * ```typescript
 * import {object} from './utils/object'
 * type OutputType =
 *  {[K in keyof InputType as SnakeToCamelCase<K>]: InputType[K]}
 * ```
 */
export type SnakeToCamelCase<S extends string> =
  S extends `${infer T}_${infer U}` ?
  `${T}${Capitalize<SnakeToCamelCase<U>>}` :
  S

/**
 * Convert Javascript object properties from camel case to snake case
 * @param{any} obj
 * @return{any}
 */
export const converCamelCaseToSnake = (
    obj: any
): any => {
  const newObj = {};
  for (const key in obj) {
    // eslint-disable-next-line no-prototype-builtins
    if (obj.hasOwnProperty(key)) {
      const newKey = key.replace(/([A-Z])/g, "_$1").toLowerCase();
      // @ts-ignore
      newObj[newKey] = obj[key];
    }
  }
  return newObj;
};
