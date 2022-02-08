/*eslint-disable block-scoped-var, id-length, no-control-regex, no-magic-numbers, no-prototype-builtins, no-redeclare, no-shadow, no-var, sort-vars*/
"use strict";

var $protobuf = require("protobufjs/minimal");

// Common aliases
var $Reader = $protobuf.Reader, $Writer = $protobuf.Writer, $util = $protobuf.util;

// Exported root namespace
var $root = $protobuf.roots["default"] || ($protobuf.roots["default"] = {});

$root.langame = (function() {

    /**
     * Namespace langame.
     * @exports langame
     * @namespace
     */
    var langame = {};

    langame.protobuf = (function() {

        /**
         * Namespace protobuf.
         * @memberof langame
         * @namespace
         */
        var protobuf = {};

        protobuf.Error = (function() {

            /**
             * Properties of an Error.
             * @memberof langame.protobuf
             * @interface IError
             * @property {string|null} [developerMessage] Error developerMessage
             * @property {google.protobuf.ITimestamp|null} [createdAt] Error createdAt
             * @property {string|null} [code] Error code
             * @property {string|null} [userMessage] Error userMessage
             */

            /**
             * Constructs a new Error.
             * @memberof langame.protobuf
             * @classdesc Represents an Error.
             * @implements IError
             * @constructor
             * @param {langame.protobuf.IError=} [properties] Properties to set
             */
            function Error(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }

            /**
             * Error developerMessage.
             * @member {string} developerMessage
             * @memberof langame.protobuf.Error
             * @instance
             */
            Error.prototype.developerMessage = "";

            /**
             * Error createdAt.
             * @member {google.protobuf.ITimestamp|null|undefined} createdAt
             * @memberof langame.protobuf.Error
             * @instance
             */
            Error.prototype.createdAt = null;

            /**
             * Error code.
             * @member {string} code
             * @memberof langame.protobuf.Error
             * @instance
             */
            Error.prototype.code = "";

            /**
             * Error userMessage.
             * @member {string} userMessage
             * @memberof langame.protobuf.Error
             * @instance
             */
            Error.prototype.userMessage = "";

            /**
             * Creates a new Error instance using the specified properties.
             * @function create
             * @memberof langame.protobuf.Error
             * @static
             * @param {langame.protobuf.IError=} [properties] Properties to set
             * @returns {langame.protobuf.Error} Error instance
             */
            Error.create = function create(properties) {
                return new Error(properties);
            };

            /**
             * Encodes the specified Error message. Does not implicitly {@link langame.protobuf.Error.verify|verify} messages.
             * @function encode
             * @memberof langame.protobuf.Error
             * @static
             * @param {langame.protobuf.IError} message Error message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            Error.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.developerMessage != null && Object.hasOwnProperty.call(message, "developerMessage"))
                    writer.uint32(/* id 1, wireType 2 =*/10).string(message.developerMessage);
                if (message.createdAt != null && Object.hasOwnProperty.call(message, "createdAt"))
                    $root.google.protobuf.Timestamp.encode(message.createdAt, writer.uint32(/* id 2, wireType 2 =*/18).fork()).ldelim();
                if (message.code != null && Object.hasOwnProperty.call(message, "code"))
                    writer.uint32(/* id 3, wireType 2 =*/26).string(message.code);
                if (message.userMessage != null && Object.hasOwnProperty.call(message, "userMessage"))
                    writer.uint32(/* id 4, wireType 2 =*/34).string(message.userMessage);
                return writer;
            };

            /**
             * Encodes the specified Error message, length delimited. Does not implicitly {@link langame.protobuf.Error.verify|verify} messages.
             * @function encodeDelimited
             * @memberof langame.protobuf.Error
             * @static
             * @param {langame.protobuf.IError} message Error message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            Error.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };

            /**
             * Decodes an Error message from the specified reader or buffer.
             * @function decode
             * @memberof langame.protobuf.Error
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {langame.protobuf.Error} Error
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            Error.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Error();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1:
                        message.developerMessage = reader.string();
                        break;
                    case 2:
                        message.createdAt = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                        break;
                    case 3:
                        message.code = reader.string();
                        break;
                    case 4:
                        message.userMessage = reader.string();
                        break;
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };

            /**
             * Decodes an Error message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof langame.protobuf.Error
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {langame.protobuf.Error} Error
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            Error.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };

            /**
             * Verifies an Error message.
             * @function verify
             * @memberof langame.protobuf.Error
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            Error.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.developerMessage != null && message.hasOwnProperty("developerMessage"))
                    if (!$util.isString(message.developerMessage))
                        return "developerMessage: string expected";
                if (message.createdAt != null && message.hasOwnProperty("createdAt")) {
                    var error = $root.google.protobuf.Timestamp.verify(message.createdAt);
                    if (error)
                        return "createdAt." + error;
                }
                if (message.code != null && message.hasOwnProperty("code"))
                    if (!$util.isString(message.code))
                        return "code: string expected";
                if (message.userMessage != null && message.hasOwnProperty("userMessage"))
                    if (!$util.isString(message.userMessage))
                        return "userMessage: string expected";
                return null;
            };

            /**
             * Creates an Error message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof langame.protobuf.Error
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {langame.protobuf.Error} Error
             */
            Error.fromObject = function fromObject(object) {
                if (object instanceof $root.langame.protobuf.Error)
                    return object;
                var message = new $root.langame.protobuf.Error();
                if (object.developerMessage != null)
                    message.developerMessage = String(object.developerMessage);
                if (object.createdAt != null) {
                    if (typeof object.createdAt !== "object")
                        throw TypeError(".langame.protobuf.Error.createdAt: object expected");
                    message.createdAt = $root.google.protobuf.Timestamp.fromObject(object.createdAt);
                }
                if (object.code != null)
                    message.code = String(object.code);
                if (object.userMessage != null)
                    message.userMessage = String(object.userMessage);
                return message;
            };

            /**
             * Creates a plain object from an Error message. Also converts values to other types if specified.
             * @function toObject
             * @memberof langame.protobuf.Error
             * @static
             * @param {langame.protobuf.Error} message Error
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            Error.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.defaults) {
                    object.developerMessage = "";
                    object.createdAt = null;
                    object.code = "";
                    object.userMessage = "";
                }
                if (message.developerMessage != null && message.hasOwnProperty("developerMessage"))
                    object.developerMessage = message.developerMessage;
                if (message.createdAt != null && message.hasOwnProperty("createdAt"))
                    object.createdAt = $root.google.protobuf.Timestamp.toObject(message.createdAt, options);
                if (message.code != null && message.hasOwnProperty("code"))
                    object.code = message.code;
                if (message.userMessage != null && message.hasOwnProperty("userMessage"))
                    object.userMessage = message.userMessage;
                return object;
            };

            /**
             * Converts this Error to JSON.
             * @function toJSON
             * @memberof langame.protobuf.Error
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            Error.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };

            return Error;
        })();

        protobuf.SeenMemes = (function() {

            /**
             * Properties of a SeenMemes.
             * @memberof langame.protobuf
             * @interface ISeenMemes
             * @property {langame.protobuf.SeenMemes.ISeen|null} [seen] SeenMemes seen
             */

            /**
             * Constructs a new SeenMemes.
             * @memberof langame.protobuf
             * @classdesc Represents a SeenMemes.
             * @implements ISeenMemes
             * @constructor
             * @param {langame.protobuf.ISeenMemes=} [properties] Properties to set
             */
            function SeenMemes(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }

            /**
             * SeenMemes seen.
             * @member {langame.protobuf.SeenMemes.ISeen|null|undefined} seen
             * @memberof langame.protobuf.SeenMemes
             * @instance
             */
            SeenMemes.prototype.seen = null;

            /**
             * Creates a new SeenMemes instance using the specified properties.
             * @function create
             * @memberof langame.protobuf.SeenMemes
             * @static
             * @param {langame.protobuf.ISeenMemes=} [properties] Properties to set
             * @returns {langame.protobuf.SeenMemes} SeenMemes instance
             */
            SeenMemes.create = function create(properties) {
                return new SeenMemes(properties);
            };

            /**
             * Encodes the specified SeenMemes message. Does not implicitly {@link langame.protobuf.SeenMemes.verify|verify} messages.
             * @function encode
             * @memberof langame.protobuf.SeenMemes
             * @static
             * @param {langame.protobuf.ISeenMemes} message SeenMemes message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            SeenMemes.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.seen != null && Object.hasOwnProperty.call(message, "seen"))
                    $root.langame.protobuf.SeenMemes.Seen.encode(message.seen, writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
                return writer;
            };

            /**
             * Encodes the specified SeenMemes message, length delimited. Does not implicitly {@link langame.protobuf.SeenMemes.verify|verify} messages.
             * @function encodeDelimited
             * @memberof langame.protobuf.SeenMemes
             * @static
             * @param {langame.protobuf.ISeenMemes} message SeenMemes message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            SeenMemes.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };

            /**
             * Decodes a SeenMemes message from the specified reader or buffer.
             * @function decode
             * @memberof langame.protobuf.SeenMemes
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {langame.protobuf.SeenMemes} SeenMemes
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            SeenMemes.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.SeenMemes();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1:
                        message.seen = $root.langame.protobuf.SeenMemes.Seen.decode(reader, reader.uint32());
                        break;
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };

            /**
             * Decodes a SeenMemes message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof langame.protobuf.SeenMemes
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {langame.protobuf.SeenMemes} SeenMemes
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            SeenMemes.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };

            /**
             * Verifies a SeenMemes message.
             * @function verify
             * @memberof langame.protobuf.SeenMemes
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            SeenMemes.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.seen != null && message.hasOwnProperty("seen")) {
                    var error = $root.langame.protobuf.SeenMemes.Seen.verify(message.seen);
                    if (error)
                        return "seen." + error;
                }
                return null;
            };

            /**
             * Creates a SeenMemes message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof langame.protobuf.SeenMemes
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {langame.protobuf.SeenMemes} SeenMemes
             */
            SeenMemes.fromObject = function fromObject(object) {
                if (object instanceof $root.langame.protobuf.SeenMemes)
                    return object;
                var message = new $root.langame.protobuf.SeenMemes();
                if (object.seen != null) {
                    if (typeof object.seen !== "object")
                        throw TypeError(".langame.protobuf.SeenMemes.seen: object expected");
                    message.seen = $root.langame.protobuf.SeenMemes.Seen.fromObject(object.seen);
                }
                return message;
            };

            /**
             * Creates a plain object from a SeenMemes message. Also converts values to other types if specified.
             * @function toObject
             * @memberof langame.protobuf.SeenMemes
             * @static
             * @param {langame.protobuf.SeenMemes} message SeenMemes
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            SeenMemes.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.defaults)
                    object.seen = null;
                if (message.seen != null && message.hasOwnProperty("seen"))
                    object.seen = $root.langame.protobuf.SeenMemes.Seen.toObject(message.seen, options);
                return object;
            };

            /**
             * Converts this SeenMemes to JSON.
             * @function toJSON
             * @memberof langame.protobuf.SeenMemes
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            SeenMemes.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };

            SeenMemes.Seen = (function() {

                /**
                 * Properties of a Seen.
                 * @memberof langame.protobuf.SeenMemes
                 * @interface ISeen
                 * @property {Array.<langame.protobuf.SeenMemes.Seen.ISingle>|null} [s] Seen s
                 */

                /**
                 * Constructs a new Seen.
                 * @memberof langame.protobuf.SeenMemes
                 * @classdesc Represents a Seen.
                 * @implements ISeen
                 * @constructor
                 * @param {langame.protobuf.SeenMemes.ISeen=} [properties] Properties to set
                 */
                function Seen(properties) {
                    this.s = [];
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * Seen s.
                 * @member {Array.<langame.protobuf.SeenMemes.Seen.ISingle>} s
                 * @memberof langame.protobuf.SeenMemes.Seen
                 * @instance
                 */
                Seen.prototype.s = $util.emptyArray;

                /**
                 * Creates a new Seen instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.SeenMemes.Seen
                 * @static
                 * @param {langame.protobuf.SeenMemes.ISeen=} [properties] Properties to set
                 * @returns {langame.protobuf.SeenMemes.Seen} Seen instance
                 */
                Seen.create = function create(properties) {
                    return new Seen(properties);
                };

                /**
                 * Encodes the specified Seen message. Does not implicitly {@link langame.protobuf.SeenMemes.Seen.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.SeenMemes.Seen
                 * @static
                 * @param {langame.protobuf.SeenMemes.ISeen} message Seen message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Seen.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.s != null && message.s.length)
                        for (var i = 0; i < message.s.length; ++i)
                            $root.langame.protobuf.SeenMemes.Seen.Single.encode(message.s[i], writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
                    return writer;
                };

                /**
                 * Encodes the specified Seen message, length delimited. Does not implicitly {@link langame.protobuf.SeenMemes.Seen.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.SeenMemes.Seen
                 * @static
                 * @param {langame.protobuf.SeenMemes.ISeen} message Seen message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Seen.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes a Seen message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.SeenMemes.Seen
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.SeenMemes.Seen} Seen
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Seen.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.SeenMemes.Seen();
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            if (!(message.s && message.s.length))
                                message.s = [];
                            message.s.push($root.langame.protobuf.SeenMemes.Seen.Single.decode(reader, reader.uint32()));
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes a Seen message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.SeenMemes.Seen
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.SeenMemes.Seen} Seen
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Seen.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies a Seen message.
                 * @function verify
                 * @memberof langame.protobuf.SeenMemes.Seen
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                Seen.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.s != null && message.hasOwnProperty("s")) {
                        if (!Array.isArray(message.s))
                            return "s: array expected";
                        for (var i = 0; i < message.s.length; ++i) {
                            var error = $root.langame.protobuf.SeenMemes.Seen.Single.verify(message.s[i]);
                            if (error)
                                return "s." + error;
                        }
                    }
                    return null;
                };

                /**
                 * Creates a Seen message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.SeenMemes.Seen
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.SeenMemes.Seen} Seen
                 */
                Seen.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.SeenMemes.Seen)
                        return object;
                    var message = new $root.langame.protobuf.SeenMemes.Seen();
                    if (object.s) {
                        if (!Array.isArray(object.s))
                            throw TypeError(".langame.protobuf.SeenMemes.Seen.s: array expected");
                        message.s = [];
                        for (var i = 0; i < object.s.length; ++i) {
                            if (typeof object.s[i] !== "object")
                                throw TypeError(".langame.protobuf.SeenMemes.Seen.s: object expected");
                            message.s[i] = $root.langame.protobuf.SeenMemes.Seen.Single.fromObject(object.s[i]);
                        }
                    }
                    return message;
                };

                /**
                 * Creates a plain object from a Seen message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.SeenMemes.Seen
                 * @static
                 * @param {langame.protobuf.SeenMemes.Seen} message Seen
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                Seen.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.arrays || options.defaults)
                        object.s = [];
                    if (message.s && message.s.length) {
                        object.s = [];
                        for (var j = 0; j < message.s.length; ++j)
                            object.s[j] = $root.langame.protobuf.SeenMemes.Seen.Single.toObject(message.s[j], options);
                    }
                    return object;
                };

                /**
                 * Converts this Seen to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.SeenMemes.Seen
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                Seen.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                Seen.Single = (function() {

                    /**
                     * Properties of a Single.
                     * @memberof langame.protobuf.SeenMemes.Seen
                     * @interface ISingle
                     * @property {google.protobuf.ITimestamp|null} [date] Single date
                     * @property {string|null} [meme] Single meme
                     */

                    /**
                     * Constructs a new Single.
                     * @memberof langame.protobuf.SeenMemes.Seen
                     * @classdesc Represents a Single.
                     * @implements ISingle
                     * @constructor
                     * @param {langame.protobuf.SeenMemes.Seen.ISingle=} [properties] Properties to set
                     */
                    function Single(properties) {
                        if (properties)
                            for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                                if (properties[keys[i]] != null)
                                    this[keys[i]] = properties[keys[i]];
                    }

                    /**
                     * Single date.
                     * @member {google.protobuf.ITimestamp|null|undefined} date
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @instance
                     */
                    Single.prototype.date = null;

                    /**
                     * Single meme.
                     * @member {string} meme
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @instance
                     */
                    Single.prototype.meme = "";

                    /**
                     * Creates a new Single instance using the specified properties.
                     * @function create
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @static
                     * @param {langame.protobuf.SeenMemes.Seen.ISingle=} [properties] Properties to set
                     * @returns {langame.protobuf.SeenMemes.Seen.Single} Single instance
                     */
                    Single.create = function create(properties) {
                        return new Single(properties);
                    };

                    /**
                     * Encodes the specified Single message. Does not implicitly {@link langame.protobuf.SeenMemes.Seen.Single.verify|verify} messages.
                     * @function encode
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @static
                     * @param {langame.protobuf.SeenMemes.Seen.ISingle} message Single message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Single.encode = function encode(message, writer) {
                        if (!writer)
                            writer = $Writer.create();
                        if (message.date != null && Object.hasOwnProperty.call(message, "date"))
                            $root.google.protobuf.Timestamp.encode(message.date, writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
                        if (message.meme != null && Object.hasOwnProperty.call(message, "meme"))
                            writer.uint32(/* id 2, wireType 2 =*/18).string(message.meme);
                        return writer;
                    };

                    /**
                     * Encodes the specified Single message, length delimited. Does not implicitly {@link langame.protobuf.SeenMemes.Seen.Single.verify|verify} messages.
                     * @function encodeDelimited
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @static
                     * @param {langame.protobuf.SeenMemes.Seen.ISingle} message Single message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Single.encodeDelimited = function encodeDelimited(message, writer) {
                        return this.encode(message, writer).ldelim();
                    };

                    /**
                     * Decodes a Single message from the specified reader or buffer.
                     * @function decode
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @param {number} [length] Message length if known beforehand
                     * @returns {langame.protobuf.SeenMemes.Seen.Single} Single
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Single.decode = function decode(reader, length) {
                        if (!(reader instanceof $Reader))
                            reader = $Reader.create(reader);
                        var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.SeenMemes.Seen.Single();
                        while (reader.pos < end) {
                            var tag = reader.uint32();
                            switch (tag >>> 3) {
                            case 1:
                                message.date = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                                break;
                            case 2:
                                message.meme = reader.string();
                                break;
                            default:
                                reader.skipType(tag & 7);
                                break;
                            }
                        }
                        return message;
                    };

                    /**
                     * Decodes a Single message from the specified reader or buffer, length delimited.
                     * @function decodeDelimited
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @returns {langame.protobuf.SeenMemes.Seen.Single} Single
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Single.decodeDelimited = function decodeDelimited(reader) {
                        if (!(reader instanceof $Reader))
                            reader = new $Reader(reader);
                        return this.decode(reader, reader.uint32());
                    };

                    /**
                     * Verifies a Single message.
                     * @function verify
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @static
                     * @param {Object.<string,*>} message Plain object to verify
                     * @returns {string|null} `null` if valid, otherwise the reason why it is not
                     */
                    Single.verify = function verify(message) {
                        if (typeof message !== "object" || message === null)
                            return "object expected";
                        if (message.date != null && message.hasOwnProperty("date")) {
                            var error = $root.google.protobuf.Timestamp.verify(message.date);
                            if (error)
                                return "date." + error;
                        }
                        if (message.meme != null && message.hasOwnProperty("meme"))
                            if (!$util.isString(message.meme))
                                return "meme: string expected";
                        return null;
                    };

                    /**
                     * Creates a Single message from a plain object. Also converts values to their respective internal types.
                     * @function fromObject
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @static
                     * @param {Object.<string,*>} object Plain object
                     * @returns {langame.protobuf.SeenMemes.Seen.Single} Single
                     */
                    Single.fromObject = function fromObject(object) {
                        if (object instanceof $root.langame.protobuf.SeenMemes.Seen.Single)
                            return object;
                        var message = new $root.langame.protobuf.SeenMemes.Seen.Single();
                        if (object.date != null) {
                            if (typeof object.date !== "object")
                                throw TypeError(".langame.protobuf.SeenMemes.Seen.Single.date: object expected");
                            message.date = $root.google.protobuf.Timestamp.fromObject(object.date);
                        }
                        if (object.meme != null)
                            message.meme = String(object.meme);
                        return message;
                    };

                    /**
                     * Creates a plain object from a Single message. Also converts values to other types if specified.
                     * @function toObject
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @static
                     * @param {langame.protobuf.SeenMemes.Seen.Single} message Single
                     * @param {$protobuf.IConversionOptions} [options] Conversion options
                     * @returns {Object.<string,*>} Plain object
                     */
                    Single.toObject = function toObject(message, options) {
                        if (!options)
                            options = {};
                        var object = {};
                        if (options.defaults) {
                            object.date = null;
                            object.meme = "";
                        }
                        if (message.date != null && message.hasOwnProperty("date"))
                            object.date = $root.google.protobuf.Timestamp.toObject(message.date, options);
                        if (message.meme != null && message.hasOwnProperty("meme"))
                            object.meme = message.meme;
                        return object;
                    };

                    /**
                     * Converts this Single to JSON.
                     * @function toJSON
                     * @memberof langame.protobuf.SeenMemes.Seen.Single
                     * @instance
                     * @returns {Object.<string,*>} JSON object
                     */
                    Single.prototype.toJSON = function toJSON() {
                        return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                    };

                    return Single;
                })();

                return Seen;
            })();

            return SeenMemes;
        })();

        protobuf.Meme = (function() {

            /**
             * Properties of a Meme.
             * @memberof langame.protobuf
             * @interface IMeme
             * @property {google.protobuf.ITimestamp|null} [createdAt] Meme createdAt
             * @property {string|null} [content] Meme content
             * @property {Array.<string>|null} [topics] Meme topics
             * @property {string|null} [promptId] Meme promptId
             * @property {Object.<string,string>|null} [translated] Meme translated
             * @property {string|null} [id] Meme id
             * @property {boolean|null} [disabled] Meme disabled
             * @property {boolean|null} [tweet] Meme tweet
             * @property {string|null} [state] Meme state
             * @property {string|null} [error] Meme error
             */

            /**
             * Constructs a new Meme.
             * @memberof langame.protobuf
             * @classdesc Represents a Meme.
             * @implements IMeme
             * @constructor
             * @param {langame.protobuf.IMeme=} [properties] Properties to set
             */
            function Meme(properties) {
                this.topics = [];
                this.translated = {};
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }

            /**
             * Meme createdAt.
             * @member {google.protobuf.ITimestamp|null|undefined} createdAt
             * @memberof langame.protobuf.Meme
             * @instance
             */
            Meme.prototype.createdAt = null;

            /**
             * Meme content.
             * @member {string} content
             * @memberof langame.protobuf.Meme
             * @instance
             */
            Meme.prototype.content = "";

            /**
             * Meme topics.
             * @member {Array.<string>} topics
             * @memberof langame.protobuf.Meme
             * @instance
             */
            Meme.prototype.topics = $util.emptyArray;

            /**
             * Meme promptId.
             * @member {string} promptId
             * @memberof langame.protobuf.Meme
             * @instance
             */
            Meme.prototype.promptId = "";

            /**
             * Meme translated.
             * @member {Object.<string,string>} translated
             * @memberof langame.protobuf.Meme
             * @instance
             */
            Meme.prototype.translated = $util.emptyObject;

            /**
             * Meme id.
             * @member {string} id
             * @memberof langame.protobuf.Meme
             * @instance
             */
            Meme.prototype.id = "";

            /**
             * Meme disabled.
             * @member {boolean} disabled
             * @memberof langame.protobuf.Meme
             * @instance
             */
            Meme.prototype.disabled = false;

            /**
             * Meme tweet.
             * @member {boolean} tweet
             * @memberof langame.protobuf.Meme
             * @instance
             */
            Meme.prototype.tweet = false;

            /**
             * Meme state.
             * @member {string} state
             * @memberof langame.protobuf.Meme
             * @instance
             */
            Meme.prototype.state = "";

            /**
             * Meme error.
             * @member {string} error
             * @memberof langame.protobuf.Meme
             * @instance
             */
            Meme.prototype.error = "";

            /**
             * Creates a new Meme instance using the specified properties.
             * @function create
             * @memberof langame.protobuf.Meme
             * @static
             * @param {langame.protobuf.IMeme=} [properties] Properties to set
             * @returns {langame.protobuf.Meme} Meme instance
             */
            Meme.create = function create(properties) {
                return new Meme(properties);
            };

            /**
             * Encodes the specified Meme message. Does not implicitly {@link langame.protobuf.Meme.verify|verify} messages.
             * @function encode
             * @memberof langame.protobuf.Meme
             * @static
             * @param {langame.protobuf.IMeme} message Meme message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            Meme.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.createdAt != null && Object.hasOwnProperty.call(message, "createdAt"))
                    $root.google.protobuf.Timestamp.encode(message.createdAt, writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
                if (message.content != null && Object.hasOwnProperty.call(message, "content"))
                    writer.uint32(/* id 2, wireType 2 =*/18).string(message.content);
                if (message.topics != null && message.topics.length)
                    for (var i = 0; i < message.topics.length; ++i)
                        writer.uint32(/* id 4, wireType 2 =*/34).string(message.topics[i]);
                if (message.promptId != null && Object.hasOwnProperty.call(message, "promptId"))
                    writer.uint32(/* id 5, wireType 2 =*/42).string(message.promptId);
                if (message.translated != null && Object.hasOwnProperty.call(message, "translated"))
                    for (var keys = Object.keys(message.translated), i = 0; i < keys.length; ++i)
                        writer.uint32(/* id 6, wireType 2 =*/50).fork().uint32(/* id 1, wireType 2 =*/10).string(keys[i]).uint32(/* id 2, wireType 2 =*/18).string(message.translated[keys[i]]).ldelim();
                if (message.id != null && Object.hasOwnProperty.call(message, "id"))
                    writer.uint32(/* id 7, wireType 2 =*/58).string(message.id);
                if (message.disabled != null && Object.hasOwnProperty.call(message, "disabled"))
                    writer.uint32(/* id 8, wireType 0 =*/64).bool(message.disabled);
                if (message.tweet != null && Object.hasOwnProperty.call(message, "tweet"))
                    writer.uint32(/* id 9, wireType 0 =*/72).bool(message.tweet);
                if (message.state != null && Object.hasOwnProperty.call(message, "state"))
                    writer.uint32(/* id 10, wireType 2 =*/82).string(message.state);
                if (message.error != null && Object.hasOwnProperty.call(message, "error"))
                    writer.uint32(/* id 11, wireType 2 =*/90).string(message.error);
                return writer;
            };

            /**
             * Encodes the specified Meme message, length delimited. Does not implicitly {@link langame.protobuf.Meme.verify|verify} messages.
             * @function encodeDelimited
             * @memberof langame.protobuf.Meme
             * @static
             * @param {langame.protobuf.IMeme} message Meme message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            Meme.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };

            /**
             * Decodes a Meme message from the specified reader or buffer.
             * @function decode
             * @memberof langame.protobuf.Meme
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {langame.protobuf.Meme} Meme
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            Meme.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Meme(), key, value;
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1:
                        message.createdAt = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                        break;
                    case 2:
                        message.content = reader.string();
                        break;
                    case 4:
                        if (!(message.topics && message.topics.length))
                            message.topics = [];
                        message.topics.push(reader.string());
                        break;
                    case 5:
                        message.promptId = reader.string();
                        break;
                    case 6:
                        if (message.translated === $util.emptyObject)
                            message.translated = {};
                        var end2 = reader.uint32() + reader.pos;
                        key = "";
                        value = "";
                        while (reader.pos < end2) {
                            var tag2 = reader.uint32();
                            switch (tag2 >>> 3) {
                            case 1:
                                key = reader.string();
                                break;
                            case 2:
                                value = reader.string();
                                break;
                            default:
                                reader.skipType(tag2 & 7);
                                break;
                            }
                        }
                        message.translated[key] = value;
                        break;
                    case 7:
                        message.id = reader.string();
                        break;
                    case 8:
                        message.disabled = reader.bool();
                        break;
                    case 9:
                        message.tweet = reader.bool();
                        break;
                    case 10:
                        message.state = reader.string();
                        break;
                    case 11:
                        message.error = reader.string();
                        break;
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };

            /**
             * Decodes a Meme message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof langame.protobuf.Meme
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {langame.protobuf.Meme} Meme
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            Meme.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };

            /**
             * Verifies a Meme message.
             * @function verify
             * @memberof langame.protobuf.Meme
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            Meme.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.createdAt != null && message.hasOwnProperty("createdAt")) {
                    var error = $root.google.protobuf.Timestamp.verify(message.createdAt);
                    if (error)
                        return "createdAt." + error;
                }
                if (message.content != null && message.hasOwnProperty("content"))
                    if (!$util.isString(message.content))
                        return "content: string expected";
                if (message.topics != null && message.hasOwnProperty("topics")) {
                    if (!Array.isArray(message.topics))
                        return "topics: array expected";
                    for (var i = 0; i < message.topics.length; ++i)
                        if (!$util.isString(message.topics[i]))
                            return "topics: string[] expected";
                }
                if (message.promptId != null && message.hasOwnProperty("promptId"))
                    if (!$util.isString(message.promptId))
                        return "promptId: string expected";
                if (message.translated != null && message.hasOwnProperty("translated")) {
                    if (!$util.isObject(message.translated))
                        return "translated: object expected";
                    var key = Object.keys(message.translated);
                    for (var i = 0; i < key.length; ++i)
                        if (!$util.isString(message.translated[key[i]]))
                            return "translated: string{k:string} expected";
                }
                if (message.id != null && message.hasOwnProperty("id"))
                    if (!$util.isString(message.id))
                        return "id: string expected";
                if (message.disabled != null && message.hasOwnProperty("disabled"))
                    if (typeof message.disabled !== "boolean")
                        return "disabled: boolean expected";
                if (message.tweet != null && message.hasOwnProperty("tweet"))
                    if (typeof message.tweet !== "boolean")
                        return "tweet: boolean expected";
                if (message.state != null && message.hasOwnProperty("state"))
                    if (!$util.isString(message.state))
                        return "state: string expected";
                if (message.error != null && message.hasOwnProperty("error"))
                    if (!$util.isString(message.error))
                        return "error: string expected";
                return null;
            };

            /**
             * Creates a Meme message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof langame.protobuf.Meme
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {langame.protobuf.Meme} Meme
             */
            Meme.fromObject = function fromObject(object) {
                if (object instanceof $root.langame.protobuf.Meme)
                    return object;
                var message = new $root.langame.protobuf.Meme();
                if (object.createdAt != null) {
                    if (typeof object.createdAt !== "object")
                        throw TypeError(".langame.protobuf.Meme.createdAt: object expected");
                    message.createdAt = $root.google.protobuf.Timestamp.fromObject(object.createdAt);
                }
                if (object.content != null)
                    message.content = String(object.content);
                if (object.topics) {
                    if (!Array.isArray(object.topics))
                        throw TypeError(".langame.protobuf.Meme.topics: array expected");
                    message.topics = [];
                    for (var i = 0; i < object.topics.length; ++i)
                        message.topics[i] = String(object.topics[i]);
                }
                if (object.promptId != null)
                    message.promptId = String(object.promptId);
                if (object.translated) {
                    if (typeof object.translated !== "object")
                        throw TypeError(".langame.protobuf.Meme.translated: object expected");
                    message.translated = {};
                    for (var keys = Object.keys(object.translated), i = 0; i < keys.length; ++i)
                        message.translated[keys[i]] = String(object.translated[keys[i]]);
                }
                if (object.id != null)
                    message.id = String(object.id);
                if (object.disabled != null)
                    message.disabled = Boolean(object.disabled);
                if (object.tweet != null)
                    message.tweet = Boolean(object.tweet);
                if (object.state != null)
                    message.state = String(object.state);
                if (object.error != null)
                    message.error = String(object.error);
                return message;
            };

            /**
             * Creates a plain object from a Meme message. Also converts values to other types if specified.
             * @function toObject
             * @memberof langame.protobuf.Meme
             * @static
             * @param {langame.protobuf.Meme} message Meme
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            Meme.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.arrays || options.defaults)
                    object.topics = [];
                if (options.objects || options.defaults)
                    object.translated = {};
                if (options.defaults) {
                    object.createdAt = null;
                    object.content = "";
                    object.promptId = "";
                    object.id = "";
                    object.disabled = false;
                    object.tweet = false;
                    object.state = "";
                    object.error = "";
                }
                if (message.createdAt != null && message.hasOwnProperty("createdAt"))
                    object.createdAt = $root.google.protobuf.Timestamp.toObject(message.createdAt, options);
                if (message.content != null && message.hasOwnProperty("content"))
                    object.content = message.content;
                if (message.topics && message.topics.length) {
                    object.topics = [];
                    for (var j = 0; j < message.topics.length; ++j)
                        object.topics[j] = message.topics[j];
                }
                if (message.promptId != null && message.hasOwnProperty("promptId"))
                    object.promptId = message.promptId;
                var keys2;
                if (message.translated && (keys2 = Object.keys(message.translated)).length) {
                    object.translated = {};
                    for (var j = 0; j < keys2.length; ++j)
                        object.translated[keys2[j]] = message.translated[keys2[j]];
                }
                if (message.id != null && message.hasOwnProperty("id"))
                    object.id = message.id;
                if (message.disabled != null && message.hasOwnProperty("disabled"))
                    object.disabled = message.disabled;
                if (message.tweet != null && message.hasOwnProperty("tweet"))
                    object.tweet = message.tweet;
                if (message.state != null && message.hasOwnProperty("state"))
                    object.state = message.state;
                if (message.error != null && message.hasOwnProperty("error"))
                    object.error = message.error;
                return object;
            };

            /**
             * Converts this Meme to JSON.
             * @function toJSON
             * @memberof langame.protobuf.Meme
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            Meme.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };

            return Meme;
        })();

        protobuf.User = (function() {

            /**
             * Properties of a User.
             * @memberof langame.protobuf
             * @interface IUser
             * @property {string|null} [uid] [uid] is set by Firebase authentication
             * @property {string|null} [email] User email
             * @property {string|null} [displayName] User displayName
             * @property {string|null} [phoneNumber] User phoneNumber
             * @property {string|null} [photoUrl] User photoUrl
             * @property {boolean|null} [online] Is the user [online]?
             * @property {boolean|null} [google] Google account linked?
             * @property {boolean|null} [apple] Apple account linked?
             * @property {string|null} [tag] Twitter-like [tag] i.e. @steveTheApple
             * @property {Array.<string>|null} [tokens] Device [tokens] used for Cloud Messaging
             * @property {Array.<string>|null} [latestInteractions] User latestInteractions
             * @property {Array.<langame.protobuf.IError>|null} [errors] User errors
             * @property {google.protobuf.ITimestamp|null} [lastLogin] User lastLogin
             * @property {google.protobuf.ITimestamp|null} [lastLogout] User lastLogout
             * @property {google.protobuf.ITimestamp|null} [creationTime] User creationTime
             * @property {boolean|null} [disabled] User disabled
             * @property {Array.<langame.protobuf.User.IDevice>|null} [devices] User devices
             * @property {number|null} [credits] User credits
             * @property {string|null} [role] User role
             * @property {boolean|null} [bot] User bot
             */

            /**
             * Constructs a new User.
             * @memberof langame.protobuf
             * @classdesc Represents a User.
             * @implements IUser
             * @constructor
             * @param {langame.protobuf.IUser=} [properties] Properties to set
             */
            function User(properties) {
                this.tokens = [];
                this.latestInteractions = [];
                this.errors = [];
                this.devices = [];
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }

            /**
             * [uid] is set by Firebase authentication
             * @member {string} uid
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.uid = "";

            /**
             * User email.
             * @member {string} email
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.email = "";

            /**
             * User displayName.
             * @member {string} displayName
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.displayName = "";

            /**
             * User phoneNumber.
             * @member {string} phoneNumber
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.phoneNumber = "";

            /**
             * User photoUrl.
             * @member {string} photoUrl
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.photoUrl = "";

            /**
             * Is the user [online]?
             * @member {boolean} online
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.online = false;

            /**
             * Google account linked?
             * @member {boolean} google
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.google = false;

            /**
             * Apple account linked?
             * @member {boolean} apple
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.apple = false;

            /**
             * Twitter-like [tag] i.e. @steveTheApple
             * @member {string} tag
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.tag = "";

            /**
             * Device [tokens] used for Cloud Messaging
             * @member {Array.<string>} tokens
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.tokens = $util.emptyArray;

            /**
             * User latestInteractions.
             * @member {Array.<string>} latestInteractions
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.latestInteractions = $util.emptyArray;

            /**
             * User errors.
             * @member {Array.<langame.protobuf.IError>} errors
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.errors = $util.emptyArray;

            /**
             * User lastLogin.
             * @member {google.protobuf.ITimestamp|null|undefined} lastLogin
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.lastLogin = null;

            /**
             * User lastLogout.
             * @member {google.protobuf.ITimestamp|null|undefined} lastLogout
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.lastLogout = null;

            /**
             * User creationTime.
             * @member {google.protobuf.ITimestamp|null|undefined} creationTime
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.creationTime = null;

            /**
             * User disabled.
             * @member {boolean} disabled
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.disabled = false;

            /**
             * User devices.
             * @member {Array.<langame.protobuf.User.IDevice>} devices
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.devices = $util.emptyArray;

            /**
             * User credits.
             * @member {number} credits
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.credits = 0;

            /**
             * User role.
             * @member {string} role
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.role = "";

            /**
             * User bot.
             * @member {boolean} bot
             * @memberof langame.protobuf.User
             * @instance
             */
            User.prototype.bot = false;

            /**
             * Creates a new User instance using the specified properties.
             * @function create
             * @memberof langame.protobuf.User
             * @static
             * @param {langame.protobuf.IUser=} [properties] Properties to set
             * @returns {langame.protobuf.User} User instance
             */
            User.create = function create(properties) {
                return new User(properties);
            };

            /**
             * Encodes the specified User message. Does not implicitly {@link langame.protobuf.User.verify|verify} messages.
             * @function encode
             * @memberof langame.protobuf.User
             * @static
             * @param {langame.protobuf.IUser} message User message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            User.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.uid != null && Object.hasOwnProperty.call(message, "uid"))
                    writer.uint32(/* id 1, wireType 2 =*/10).string(message.uid);
                if (message.email != null && Object.hasOwnProperty.call(message, "email"))
                    writer.uint32(/* id 2, wireType 2 =*/18).string(message.email);
                if (message.displayName != null && Object.hasOwnProperty.call(message, "displayName"))
                    writer.uint32(/* id 3, wireType 2 =*/26).string(message.displayName);
                if (message.phoneNumber != null && Object.hasOwnProperty.call(message, "phoneNumber"))
                    writer.uint32(/* id 4, wireType 2 =*/34).string(message.phoneNumber);
                if (message.photoUrl != null && Object.hasOwnProperty.call(message, "photoUrl"))
                    writer.uint32(/* id 5, wireType 2 =*/42).string(message.photoUrl);
                if (message.online != null && Object.hasOwnProperty.call(message, "online"))
                    writer.uint32(/* id 6, wireType 0 =*/48).bool(message.online);
                if (message.google != null && Object.hasOwnProperty.call(message, "google"))
                    writer.uint32(/* id 7, wireType 0 =*/56).bool(message.google);
                if (message.apple != null && Object.hasOwnProperty.call(message, "apple"))
                    writer.uint32(/* id 9, wireType 0 =*/72).bool(message.apple);
                if (message.tag != null && Object.hasOwnProperty.call(message, "tag"))
                    writer.uint32(/* id 11, wireType 2 =*/90).string(message.tag);
                if (message.tokens != null && message.tokens.length)
                    for (var i = 0; i < message.tokens.length; ++i)
                        writer.uint32(/* id 12, wireType 2 =*/98).string(message.tokens[i]);
                if (message.latestInteractions != null && message.latestInteractions.length)
                    for (var i = 0; i < message.latestInteractions.length; ++i)
                        writer.uint32(/* id 13, wireType 2 =*/106).string(message.latestInteractions[i]);
                if (message.errors != null && message.errors.length)
                    for (var i = 0; i < message.errors.length; ++i)
                        $root.langame.protobuf.Error.encode(message.errors[i], writer.uint32(/* id 14, wireType 2 =*/114).fork()).ldelim();
                if (message.lastLogin != null && Object.hasOwnProperty.call(message, "lastLogin"))
                    $root.google.protobuf.Timestamp.encode(message.lastLogin, writer.uint32(/* id 15, wireType 2 =*/122).fork()).ldelim();
                if (message.lastLogout != null && Object.hasOwnProperty.call(message, "lastLogout"))
                    $root.google.protobuf.Timestamp.encode(message.lastLogout, writer.uint32(/* id 16, wireType 2 =*/130).fork()).ldelim();
                if (message.creationTime != null && Object.hasOwnProperty.call(message, "creationTime"))
                    $root.google.protobuf.Timestamp.encode(message.creationTime, writer.uint32(/* id 17, wireType 2 =*/138).fork()).ldelim();
                if (message.disabled != null && Object.hasOwnProperty.call(message, "disabled"))
                    writer.uint32(/* id 18, wireType 0 =*/144).bool(message.disabled);
                if (message.devices != null && message.devices.length)
                    for (var i = 0; i < message.devices.length; ++i)
                        $root.langame.protobuf.User.Device.encode(message.devices[i], writer.uint32(/* id 19, wireType 2 =*/154).fork()).ldelim();
                if (message.credits != null && Object.hasOwnProperty.call(message, "credits"))
                    writer.uint32(/* id 20, wireType 0 =*/160).int32(message.credits);
                if (message.role != null && Object.hasOwnProperty.call(message, "role"))
                    writer.uint32(/* id 21, wireType 2 =*/170).string(message.role);
                if (message.bot != null && Object.hasOwnProperty.call(message, "bot"))
                    writer.uint32(/* id 22, wireType 0 =*/176).bool(message.bot);
                return writer;
            };

            /**
             * Encodes the specified User message, length delimited. Does not implicitly {@link langame.protobuf.User.verify|verify} messages.
             * @function encodeDelimited
             * @memberof langame.protobuf.User
             * @static
             * @param {langame.protobuf.IUser} message User message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            User.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };

            /**
             * Decodes a User message from the specified reader or buffer.
             * @function decode
             * @memberof langame.protobuf.User
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {langame.protobuf.User} User
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            User.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.User();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1:
                        message.uid = reader.string();
                        break;
                    case 2:
                        message.email = reader.string();
                        break;
                    case 3:
                        message.displayName = reader.string();
                        break;
                    case 4:
                        message.phoneNumber = reader.string();
                        break;
                    case 5:
                        message.photoUrl = reader.string();
                        break;
                    case 6:
                        message.online = reader.bool();
                        break;
                    case 7:
                        message.google = reader.bool();
                        break;
                    case 9:
                        message.apple = reader.bool();
                        break;
                    case 11:
                        message.tag = reader.string();
                        break;
                    case 12:
                        if (!(message.tokens && message.tokens.length))
                            message.tokens = [];
                        message.tokens.push(reader.string());
                        break;
                    case 13:
                        if (!(message.latestInteractions && message.latestInteractions.length))
                            message.latestInteractions = [];
                        message.latestInteractions.push(reader.string());
                        break;
                    case 14:
                        if (!(message.errors && message.errors.length))
                            message.errors = [];
                        message.errors.push($root.langame.protobuf.Error.decode(reader, reader.uint32()));
                        break;
                    case 15:
                        message.lastLogin = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                        break;
                    case 16:
                        message.lastLogout = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                        break;
                    case 17:
                        message.creationTime = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                        break;
                    case 18:
                        message.disabled = reader.bool();
                        break;
                    case 19:
                        if (!(message.devices && message.devices.length))
                            message.devices = [];
                        message.devices.push($root.langame.protobuf.User.Device.decode(reader, reader.uint32()));
                        break;
                    case 20:
                        message.credits = reader.int32();
                        break;
                    case 21:
                        message.role = reader.string();
                        break;
                    case 22:
                        message.bot = reader.bool();
                        break;
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };

            /**
             * Decodes a User message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof langame.protobuf.User
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {langame.protobuf.User} User
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            User.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };

            /**
             * Verifies a User message.
             * @function verify
             * @memberof langame.protobuf.User
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            User.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.uid != null && message.hasOwnProperty("uid"))
                    if (!$util.isString(message.uid))
                        return "uid: string expected";
                if (message.email != null && message.hasOwnProperty("email"))
                    if (!$util.isString(message.email))
                        return "email: string expected";
                if (message.displayName != null && message.hasOwnProperty("displayName"))
                    if (!$util.isString(message.displayName))
                        return "displayName: string expected";
                if (message.phoneNumber != null && message.hasOwnProperty("phoneNumber"))
                    if (!$util.isString(message.phoneNumber))
                        return "phoneNumber: string expected";
                if (message.photoUrl != null && message.hasOwnProperty("photoUrl"))
                    if (!$util.isString(message.photoUrl))
                        return "photoUrl: string expected";
                if (message.online != null && message.hasOwnProperty("online"))
                    if (typeof message.online !== "boolean")
                        return "online: boolean expected";
                if (message.google != null && message.hasOwnProperty("google"))
                    if (typeof message.google !== "boolean")
                        return "google: boolean expected";
                if (message.apple != null && message.hasOwnProperty("apple"))
                    if (typeof message.apple !== "boolean")
                        return "apple: boolean expected";
                if (message.tag != null && message.hasOwnProperty("tag"))
                    if (!$util.isString(message.tag))
                        return "tag: string expected";
                if (message.tokens != null && message.hasOwnProperty("tokens")) {
                    if (!Array.isArray(message.tokens))
                        return "tokens: array expected";
                    for (var i = 0; i < message.tokens.length; ++i)
                        if (!$util.isString(message.tokens[i]))
                            return "tokens: string[] expected";
                }
                if (message.latestInteractions != null && message.hasOwnProperty("latestInteractions")) {
                    if (!Array.isArray(message.latestInteractions))
                        return "latestInteractions: array expected";
                    for (var i = 0; i < message.latestInteractions.length; ++i)
                        if (!$util.isString(message.latestInteractions[i]))
                            return "latestInteractions: string[] expected";
                }
                if (message.errors != null && message.hasOwnProperty("errors")) {
                    if (!Array.isArray(message.errors))
                        return "errors: array expected";
                    for (var i = 0; i < message.errors.length; ++i) {
                        var error = $root.langame.protobuf.Error.verify(message.errors[i]);
                        if (error)
                            return "errors." + error;
                    }
                }
                if (message.lastLogin != null && message.hasOwnProperty("lastLogin")) {
                    var error = $root.google.protobuf.Timestamp.verify(message.lastLogin);
                    if (error)
                        return "lastLogin." + error;
                }
                if (message.lastLogout != null && message.hasOwnProperty("lastLogout")) {
                    var error = $root.google.protobuf.Timestamp.verify(message.lastLogout);
                    if (error)
                        return "lastLogout." + error;
                }
                if (message.creationTime != null && message.hasOwnProperty("creationTime")) {
                    var error = $root.google.protobuf.Timestamp.verify(message.creationTime);
                    if (error)
                        return "creationTime." + error;
                }
                if (message.disabled != null && message.hasOwnProperty("disabled"))
                    if (typeof message.disabled !== "boolean")
                        return "disabled: boolean expected";
                if (message.devices != null && message.hasOwnProperty("devices")) {
                    if (!Array.isArray(message.devices))
                        return "devices: array expected";
                    for (var i = 0; i < message.devices.length; ++i) {
                        var error = $root.langame.protobuf.User.Device.verify(message.devices[i]);
                        if (error)
                            return "devices." + error;
                    }
                }
                if (message.credits != null && message.hasOwnProperty("credits"))
                    if (!$util.isInteger(message.credits))
                        return "credits: integer expected";
                if (message.role != null && message.hasOwnProperty("role"))
                    if (!$util.isString(message.role))
                        return "role: string expected";
                if (message.bot != null && message.hasOwnProperty("bot"))
                    if (typeof message.bot !== "boolean")
                        return "bot: boolean expected";
                return null;
            };

            /**
             * Creates a User message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof langame.protobuf.User
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {langame.protobuf.User} User
             */
            User.fromObject = function fromObject(object) {
                if (object instanceof $root.langame.protobuf.User)
                    return object;
                var message = new $root.langame.protobuf.User();
                if (object.uid != null)
                    message.uid = String(object.uid);
                if (object.email != null)
                    message.email = String(object.email);
                if (object.displayName != null)
                    message.displayName = String(object.displayName);
                if (object.phoneNumber != null)
                    message.phoneNumber = String(object.phoneNumber);
                if (object.photoUrl != null)
                    message.photoUrl = String(object.photoUrl);
                if (object.online != null)
                    message.online = Boolean(object.online);
                if (object.google != null)
                    message.google = Boolean(object.google);
                if (object.apple != null)
                    message.apple = Boolean(object.apple);
                if (object.tag != null)
                    message.tag = String(object.tag);
                if (object.tokens) {
                    if (!Array.isArray(object.tokens))
                        throw TypeError(".langame.protobuf.User.tokens: array expected");
                    message.tokens = [];
                    for (var i = 0; i < object.tokens.length; ++i)
                        message.tokens[i] = String(object.tokens[i]);
                }
                if (object.latestInteractions) {
                    if (!Array.isArray(object.latestInteractions))
                        throw TypeError(".langame.protobuf.User.latestInteractions: array expected");
                    message.latestInteractions = [];
                    for (var i = 0; i < object.latestInteractions.length; ++i)
                        message.latestInteractions[i] = String(object.latestInteractions[i]);
                }
                if (object.errors) {
                    if (!Array.isArray(object.errors))
                        throw TypeError(".langame.protobuf.User.errors: array expected");
                    message.errors = [];
                    for (var i = 0; i < object.errors.length; ++i) {
                        if (typeof object.errors[i] !== "object")
                            throw TypeError(".langame.protobuf.User.errors: object expected");
                        message.errors[i] = $root.langame.protobuf.Error.fromObject(object.errors[i]);
                    }
                }
                if (object.lastLogin != null) {
                    if (typeof object.lastLogin !== "object")
                        throw TypeError(".langame.protobuf.User.lastLogin: object expected");
                    message.lastLogin = $root.google.protobuf.Timestamp.fromObject(object.lastLogin);
                }
                if (object.lastLogout != null) {
                    if (typeof object.lastLogout !== "object")
                        throw TypeError(".langame.protobuf.User.lastLogout: object expected");
                    message.lastLogout = $root.google.protobuf.Timestamp.fromObject(object.lastLogout);
                }
                if (object.creationTime != null) {
                    if (typeof object.creationTime !== "object")
                        throw TypeError(".langame.protobuf.User.creationTime: object expected");
                    message.creationTime = $root.google.protobuf.Timestamp.fromObject(object.creationTime);
                }
                if (object.disabled != null)
                    message.disabled = Boolean(object.disabled);
                if (object.devices) {
                    if (!Array.isArray(object.devices))
                        throw TypeError(".langame.protobuf.User.devices: array expected");
                    message.devices = [];
                    for (var i = 0; i < object.devices.length; ++i) {
                        if (typeof object.devices[i] !== "object")
                            throw TypeError(".langame.protobuf.User.devices: object expected");
                        message.devices[i] = $root.langame.protobuf.User.Device.fromObject(object.devices[i]);
                    }
                }
                if (object.credits != null)
                    message.credits = object.credits | 0;
                if (object.role != null)
                    message.role = String(object.role);
                if (object.bot != null)
                    message.bot = Boolean(object.bot);
                return message;
            };

            /**
             * Creates a plain object from a User message. Also converts values to other types if specified.
             * @function toObject
             * @memberof langame.protobuf.User
             * @static
             * @param {langame.protobuf.User} message User
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            User.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.arrays || options.defaults) {
                    object.tokens = [];
                    object.latestInteractions = [];
                    object.errors = [];
                    object.devices = [];
                }
                if (options.defaults) {
                    object.uid = "";
                    object.email = "";
                    object.displayName = "";
                    object.phoneNumber = "";
                    object.photoUrl = "";
                    object.online = false;
                    object.google = false;
                    object.apple = false;
                    object.tag = "";
                    object.lastLogin = null;
                    object.lastLogout = null;
                    object.creationTime = null;
                    object.disabled = false;
                    object.credits = 0;
                    object.role = "";
                    object.bot = false;
                }
                if (message.uid != null && message.hasOwnProperty("uid"))
                    object.uid = message.uid;
                if (message.email != null && message.hasOwnProperty("email"))
                    object.email = message.email;
                if (message.displayName != null && message.hasOwnProperty("displayName"))
                    object.displayName = message.displayName;
                if (message.phoneNumber != null && message.hasOwnProperty("phoneNumber"))
                    object.phoneNumber = message.phoneNumber;
                if (message.photoUrl != null && message.hasOwnProperty("photoUrl"))
                    object.photoUrl = message.photoUrl;
                if (message.online != null && message.hasOwnProperty("online"))
                    object.online = message.online;
                if (message.google != null && message.hasOwnProperty("google"))
                    object.google = message.google;
                if (message.apple != null && message.hasOwnProperty("apple"))
                    object.apple = message.apple;
                if (message.tag != null && message.hasOwnProperty("tag"))
                    object.tag = message.tag;
                if (message.tokens && message.tokens.length) {
                    object.tokens = [];
                    for (var j = 0; j < message.tokens.length; ++j)
                        object.tokens[j] = message.tokens[j];
                }
                if (message.latestInteractions && message.latestInteractions.length) {
                    object.latestInteractions = [];
                    for (var j = 0; j < message.latestInteractions.length; ++j)
                        object.latestInteractions[j] = message.latestInteractions[j];
                }
                if (message.errors && message.errors.length) {
                    object.errors = [];
                    for (var j = 0; j < message.errors.length; ++j)
                        object.errors[j] = $root.langame.protobuf.Error.toObject(message.errors[j], options);
                }
                if (message.lastLogin != null && message.hasOwnProperty("lastLogin"))
                    object.lastLogin = $root.google.protobuf.Timestamp.toObject(message.lastLogin, options);
                if (message.lastLogout != null && message.hasOwnProperty("lastLogout"))
                    object.lastLogout = $root.google.protobuf.Timestamp.toObject(message.lastLogout, options);
                if (message.creationTime != null && message.hasOwnProperty("creationTime"))
                    object.creationTime = $root.google.protobuf.Timestamp.toObject(message.creationTime, options);
                if (message.disabled != null && message.hasOwnProperty("disabled"))
                    object.disabled = message.disabled;
                if (message.devices && message.devices.length) {
                    object.devices = [];
                    for (var j = 0; j < message.devices.length; ++j)
                        object.devices[j] = $root.langame.protobuf.User.Device.toObject(message.devices[j], options);
                }
                if (message.credits != null && message.hasOwnProperty("credits"))
                    object.credits = message.credits;
                if (message.role != null && message.hasOwnProperty("role"))
                    object.role = message.role;
                if (message.bot != null && message.hasOwnProperty("bot"))
                    object.bot = message.bot;
                return object;
            };

            /**
             * Converts this User to JSON.
             * @function toJSON
             * @memberof langame.protobuf.User
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            User.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };

            User.Device = (function() {

                /**
                 * Properties of a Device.
                 * @memberof langame.protobuf.User
                 * @interface IDevice
                 * @property {string|null} [langameVersion] Device langameVersion
                 * @property {string|null} [deviceInfo] Device deviceInfo
                 */

                /**
                 * Constructs a new Device.
                 * @memberof langame.protobuf.User
                 * @classdesc Represents a Device.
                 * @implements IDevice
                 * @constructor
                 * @param {langame.protobuf.User.IDevice=} [properties] Properties to set
                 */
                function Device(properties) {
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * Device langameVersion.
                 * @member {string} langameVersion
                 * @memberof langame.protobuf.User.Device
                 * @instance
                 */
                Device.prototype.langameVersion = "";

                /**
                 * Device deviceInfo.
                 * @member {string} deviceInfo
                 * @memberof langame.protobuf.User.Device
                 * @instance
                 */
                Device.prototype.deviceInfo = "";

                /**
                 * Creates a new Device instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.User.Device
                 * @static
                 * @param {langame.protobuf.User.IDevice=} [properties] Properties to set
                 * @returns {langame.protobuf.User.Device} Device instance
                 */
                Device.create = function create(properties) {
                    return new Device(properties);
                };

                /**
                 * Encodes the specified Device message. Does not implicitly {@link langame.protobuf.User.Device.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.User.Device
                 * @static
                 * @param {langame.protobuf.User.IDevice} message Device message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Device.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.langameVersion != null && Object.hasOwnProperty.call(message, "langameVersion"))
                        writer.uint32(/* id 1, wireType 2 =*/10).string(message.langameVersion);
                    if (message.deviceInfo != null && Object.hasOwnProperty.call(message, "deviceInfo"))
                        writer.uint32(/* id 2, wireType 2 =*/18).string(message.deviceInfo);
                    return writer;
                };

                /**
                 * Encodes the specified Device message, length delimited. Does not implicitly {@link langame.protobuf.User.Device.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.User.Device
                 * @static
                 * @param {langame.protobuf.User.IDevice} message Device message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Device.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes a Device message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.User.Device
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.User.Device} Device
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Device.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.User.Device();
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            message.langameVersion = reader.string();
                            break;
                        case 2:
                            message.deviceInfo = reader.string();
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes a Device message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.User.Device
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.User.Device} Device
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Device.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies a Device message.
                 * @function verify
                 * @memberof langame.protobuf.User.Device
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                Device.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.langameVersion != null && message.hasOwnProperty("langameVersion"))
                        if (!$util.isString(message.langameVersion))
                            return "langameVersion: string expected";
                    if (message.deviceInfo != null && message.hasOwnProperty("deviceInfo"))
                        if (!$util.isString(message.deviceInfo))
                            return "deviceInfo: string expected";
                    return null;
                };

                /**
                 * Creates a Device message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.User.Device
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.User.Device} Device
                 */
                Device.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.User.Device)
                        return object;
                    var message = new $root.langame.protobuf.User.Device();
                    if (object.langameVersion != null)
                        message.langameVersion = String(object.langameVersion);
                    if (object.deviceInfo != null)
                        message.deviceInfo = String(object.deviceInfo);
                    return message;
                };

                /**
                 * Creates a plain object from a Device message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.User.Device
                 * @static
                 * @param {langame.protobuf.User.Device} message Device
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                Device.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.defaults) {
                        object.langameVersion = "";
                        object.deviceInfo = "";
                    }
                    if (message.langameVersion != null && message.hasOwnProperty("langameVersion"))
                        object.langameVersion = message.langameVersion;
                    if (message.deviceInfo != null && message.hasOwnProperty("deviceInfo"))
                        object.deviceInfo = message.deviceInfo;
                    return object;
                };

                /**
                 * Converts this Device to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.User.Device
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                Device.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                return Device;
            })();

            return User;
        })();

        protobuf.UserPreference = (function() {

            /**
             * Properties of a UserPreference.
             * @memberof langame.protobuf
             * @interface IUserPreference
             * @property {string|null} [userId] UserPreference userId
             * @property {boolean|null} [userRecommendations] UserPreference userRecommendations
             * @property {number|null} [themeIndex] UserPreference themeIndex
             * @property {boolean|null} [hasDoneOnBoarding] UserPreference hasDoneOnBoarding
             * @property {Array.<string>|null} [userSearchHistory] UserPreference userSearchHistory
             * @property {Array.<string>|null} [favoriteTopics] UserPreference favoriteTopics
             * @property {Array.<string>|null} [topicSearchHistory] UserPreference topicSearchHistory
             * @property {Array.<langame.protobuf.IError>|null} [errors] UserPreference errors
             * @property {boolean|null} [sawWhatsNew] UserPreference sawWhatsNew
             * @property {langame.protobuf.UserPreference.INotification|null} [notification] UserPreference notification
             * @property {boolean|null} [previewMode] UserPreference previewMode
             * @property {langame.protobuf.UserPreference.IGoals|null} [goals] UserPreference goals
             * @property {string|null} [langamesSubscriptionFrequency] UserPreference langamesSubscriptionFrequency
             */

            /**
             * Constructs a new UserPreference.
             * @memberof langame.protobuf
             * @classdesc Represents a UserPreference.
             * @implements IUserPreference
             * @constructor
             * @param {langame.protobuf.IUserPreference=} [properties] Properties to set
             */
            function UserPreference(properties) {
                this.userSearchHistory = [];
                this.favoriteTopics = [];
                this.topicSearchHistory = [];
                this.errors = [];
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }

            /**
             * UserPreference userId.
             * @member {string} userId
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.userId = "";

            /**
             * UserPreference userRecommendations.
             * @member {boolean} userRecommendations
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.userRecommendations = false;

            /**
             * UserPreference themeIndex.
             * @member {number} themeIndex
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.themeIndex = 0;

            /**
             * UserPreference hasDoneOnBoarding.
             * @member {boolean} hasDoneOnBoarding
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.hasDoneOnBoarding = false;

            /**
             * UserPreference userSearchHistory.
             * @member {Array.<string>} userSearchHistory
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.userSearchHistory = $util.emptyArray;

            /**
             * UserPreference favoriteTopics.
             * @member {Array.<string>} favoriteTopics
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.favoriteTopics = $util.emptyArray;

            /**
             * UserPreference topicSearchHistory.
             * @member {Array.<string>} topicSearchHistory
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.topicSearchHistory = $util.emptyArray;

            /**
             * UserPreference errors.
             * @member {Array.<langame.protobuf.IError>} errors
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.errors = $util.emptyArray;

            /**
             * UserPreference sawWhatsNew.
             * @member {boolean} sawWhatsNew
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.sawWhatsNew = false;

            /**
             * UserPreference notification.
             * @member {langame.protobuf.UserPreference.INotification|null|undefined} notification
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.notification = null;

            /**
             * UserPreference previewMode.
             * @member {boolean} previewMode
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.previewMode = false;

            /**
             * UserPreference goals.
             * @member {langame.protobuf.UserPreference.IGoals|null|undefined} goals
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.goals = null;

            /**
             * UserPreference langamesSubscriptionFrequency.
             * @member {string} langamesSubscriptionFrequency
             * @memberof langame.protobuf.UserPreference
             * @instance
             */
            UserPreference.prototype.langamesSubscriptionFrequency = "";

            /**
             * Creates a new UserPreference instance using the specified properties.
             * @function create
             * @memberof langame.protobuf.UserPreference
             * @static
             * @param {langame.protobuf.IUserPreference=} [properties] Properties to set
             * @returns {langame.protobuf.UserPreference} UserPreference instance
             */
            UserPreference.create = function create(properties) {
                return new UserPreference(properties);
            };

            /**
             * Encodes the specified UserPreference message. Does not implicitly {@link langame.protobuf.UserPreference.verify|verify} messages.
             * @function encode
             * @memberof langame.protobuf.UserPreference
             * @static
             * @param {langame.protobuf.IUserPreference} message UserPreference message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            UserPreference.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.userId != null && Object.hasOwnProperty.call(message, "userId"))
                    writer.uint32(/* id 2, wireType 2 =*/18).string(message.userId);
                if (message.userRecommendations != null && Object.hasOwnProperty.call(message, "userRecommendations"))
                    writer.uint32(/* id 3, wireType 0 =*/24).bool(message.userRecommendations);
                if (message.themeIndex != null && Object.hasOwnProperty.call(message, "themeIndex"))
                    writer.uint32(/* id 4, wireType 0 =*/32).int32(message.themeIndex);
                if (message.hasDoneOnBoarding != null && Object.hasOwnProperty.call(message, "hasDoneOnBoarding"))
                    writer.uint32(/* id 5, wireType 0 =*/40).bool(message.hasDoneOnBoarding);
                if (message.userSearchHistory != null && message.userSearchHistory.length)
                    for (var i = 0; i < message.userSearchHistory.length; ++i)
                        writer.uint32(/* id 6, wireType 2 =*/50).string(message.userSearchHistory[i]);
                if (message.favoriteTopics != null && message.favoriteTopics.length)
                    for (var i = 0; i < message.favoriteTopics.length; ++i)
                        writer.uint32(/* id 8, wireType 2 =*/66).string(message.favoriteTopics[i]);
                if (message.topicSearchHistory != null && message.topicSearchHistory.length)
                    for (var i = 0; i < message.topicSearchHistory.length; ++i)
                        writer.uint32(/* id 9, wireType 2 =*/74).string(message.topicSearchHistory[i]);
                if (message.errors != null && message.errors.length)
                    for (var i = 0; i < message.errors.length; ++i)
                        $root.langame.protobuf.Error.encode(message.errors[i], writer.uint32(/* id 10, wireType 2 =*/82).fork()).ldelim();
                if (message.sawWhatsNew != null && Object.hasOwnProperty.call(message, "sawWhatsNew"))
                    writer.uint32(/* id 13, wireType 0 =*/104).bool(message.sawWhatsNew);
                if (message.notification != null && Object.hasOwnProperty.call(message, "notification"))
                    $root.langame.protobuf.UserPreference.Notification.encode(message.notification, writer.uint32(/* id 14, wireType 2 =*/114).fork()).ldelim();
                if (message.previewMode != null && Object.hasOwnProperty.call(message, "previewMode"))
                    writer.uint32(/* id 15, wireType 0 =*/120).bool(message.previewMode);
                if (message.goals != null && Object.hasOwnProperty.call(message, "goals"))
                    $root.langame.protobuf.UserPreference.Goals.encode(message.goals, writer.uint32(/* id 16, wireType 2 =*/130).fork()).ldelim();
                if (message.langamesSubscriptionFrequency != null && Object.hasOwnProperty.call(message, "langamesSubscriptionFrequency"))
                    writer.uint32(/* id 17, wireType 2 =*/138).string(message.langamesSubscriptionFrequency);
                return writer;
            };

            /**
             * Encodes the specified UserPreference message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.verify|verify} messages.
             * @function encodeDelimited
             * @memberof langame.protobuf.UserPreference
             * @static
             * @param {langame.protobuf.IUserPreference} message UserPreference message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            UserPreference.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };

            /**
             * Decodes a UserPreference message from the specified reader or buffer.
             * @function decode
             * @memberof langame.protobuf.UserPreference
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {langame.protobuf.UserPreference} UserPreference
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            UserPreference.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.UserPreference();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 2:
                        message.userId = reader.string();
                        break;
                    case 3:
                        message.userRecommendations = reader.bool();
                        break;
                    case 4:
                        message.themeIndex = reader.int32();
                        break;
                    case 5:
                        message.hasDoneOnBoarding = reader.bool();
                        break;
                    case 6:
                        if (!(message.userSearchHistory && message.userSearchHistory.length))
                            message.userSearchHistory = [];
                        message.userSearchHistory.push(reader.string());
                        break;
                    case 8:
                        if (!(message.favoriteTopics && message.favoriteTopics.length))
                            message.favoriteTopics = [];
                        message.favoriteTopics.push(reader.string());
                        break;
                    case 9:
                        if (!(message.topicSearchHistory && message.topicSearchHistory.length))
                            message.topicSearchHistory = [];
                        message.topicSearchHistory.push(reader.string());
                        break;
                    case 10:
                        if (!(message.errors && message.errors.length))
                            message.errors = [];
                        message.errors.push($root.langame.protobuf.Error.decode(reader, reader.uint32()));
                        break;
                    case 13:
                        message.sawWhatsNew = reader.bool();
                        break;
                    case 14:
                        message.notification = $root.langame.protobuf.UserPreference.Notification.decode(reader, reader.uint32());
                        break;
                    case 15:
                        message.previewMode = reader.bool();
                        break;
                    case 16:
                        message.goals = $root.langame.protobuf.UserPreference.Goals.decode(reader, reader.uint32());
                        break;
                    case 17:
                        message.langamesSubscriptionFrequency = reader.string();
                        break;
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };

            /**
             * Decodes a UserPreference message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof langame.protobuf.UserPreference
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {langame.protobuf.UserPreference} UserPreference
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            UserPreference.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };

            /**
             * Verifies a UserPreference message.
             * @function verify
             * @memberof langame.protobuf.UserPreference
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            UserPreference.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.userId != null && message.hasOwnProperty("userId"))
                    if (!$util.isString(message.userId))
                        return "userId: string expected";
                if (message.userRecommendations != null && message.hasOwnProperty("userRecommendations"))
                    if (typeof message.userRecommendations !== "boolean")
                        return "userRecommendations: boolean expected";
                if (message.themeIndex != null && message.hasOwnProperty("themeIndex"))
                    if (!$util.isInteger(message.themeIndex))
                        return "themeIndex: integer expected";
                if (message.hasDoneOnBoarding != null && message.hasOwnProperty("hasDoneOnBoarding"))
                    if (typeof message.hasDoneOnBoarding !== "boolean")
                        return "hasDoneOnBoarding: boolean expected";
                if (message.userSearchHistory != null && message.hasOwnProperty("userSearchHistory")) {
                    if (!Array.isArray(message.userSearchHistory))
                        return "userSearchHistory: array expected";
                    for (var i = 0; i < message.userSearchHistory.length; ++i)
                        if (!$util.isString(message.userSearchHistory[i]))
                            return "userSearchHistory: string[] expected";
                }
                if (message.favoriteTopics != null && message.hasOwnProperty("favoriteTopics")) {
                    if (!Array.isArray(message.favoriteTopics))
                        return "favoriteTopics: array expected";
                    for (var i = 0; i < message.favoriteTopics.length; ++i)
                        if (!$util.isString(message.favoriteTopics[i]))
                            return "favoriteTopics: string[] expected";
                }
                if (message.topicSearchHistory != null && message.hasOwnProperty("topicSearchHistory")) {
                    if (!Array.isArray(message.topicSearchHistory))
                        return "topicSearchHistory: array expected";
                    for (var i = 0; i < message.topicSearchHistory.length; ++i)
                        if (!$util.isString(message.topicSearchHistory[i]))
                            return "topicSearchHistory: string[] expected";
                }
                if (message.errors != null && message.hasOwnProperty("errors")) {
                    if (!Array.isArray(message.errors))
                        return "errors: array expected";
                    for (var i = 0; i < message.errors.length; ++i) {
                        var error = $root.langame.protobuf.Error.verify(message.errors[i]);
                        if (error)
                            return "errors." + error;
                    }
                }
                if (message.sawWhatsNew != null && message.hasOwnProperty("sawWhatsNew"))
                    if (typeof message.sawWhatsNew !== "boolean")
                        return "sawWhatsNew: boolean expected";
                if (message.notification != null && message.hasOwnProperty("notification")) {
                    var error = $root.langame.protobuf.UserPreference.Notification.verify(message.notification);
                    if (error)
                        return "notification." + error;
                }
                if (message.previewMode != null && message.hasOwnProperty("previewMode"))
                    if (typeof message.previewMode !== "boolean")
                        return "previewMode: boolean expected";
                if (message.goals != null && message.hasOwnProperty("goals")) {
                    var error = $root.langame.protobuf.UserPreference.Goals.verify(message.goals);
                    if (error)
                        return "goals." + error;
                }
                if (message.langamesSubscriptionFrequency != null && message.hasOwnProperty("langamesSubscriptionFrequency"))
                    if (!$util.isString(message.langamesSubscriptionFrequency))
                        return "langamesSubscriptionFrequency: string expected";
                return null;
            };

            /**
             * Creates a UserPreference message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof langame.protobuf.UserPreference
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {langame.protobuf.UserPreference} UserPreference
             */
            UserPreference.fromObject = function fromObject(object) {
                if (object instanceof $root.langame.protobuf.UserPreference)
                    return object;
                var message = new $root.langame.protobuf.UserPreference();
                if (object.userId != null)
                    message.userId = String(object.userId);
                if (object.userRecommendations != null)
                    message.userRecommendations = Boolean(object.userRecommendations);
                if (object.themeIndex != null)
                    message.themeIndex = object.themeIndex | 0;
                if (object.hasDoneOnBoarding != null)
                    message.hasDoneOnBoarding = Boolean(object.hasDoneOnBoarding);
                if (object.userSearchHistory) {
                    if (!Array.isArray(object.userSearchHistory))
                        throw TypeError(".langame.protobuf.UserPreference.userSearchHistory: array expected");
                    message.userSearchHistory = [];
                    for (var i = 0; i < object.userSearchHistory.length; ++i)
                        message.userSearchHistory[i] = String(object.userSearchHistory[i]);
                }
                if (object.favoriteTopics) {
                    if (!Array.isArray(object.favoriteTopics))
                        throw TypeError(".langame.protobuf.UserPreference.favoriteTopics: array expected");
                    message.favoriteTopics = [];
                    for (var i = 0; i < object.favoriteTopics.length; ++i)
                        message.favoriteTopics[i] = String(object.favoriteTopics[i]);
                }
                if (object.topicSearchHistory) {
                    if (!Array.isArray(object.topicSearchHistory))
                        throw TypeError(".langame.protobuf.UserPreference.topicSearchHistory: array expected");
                    message.topicSearchHistory = [];
                    for (var i = 0; i < object.topicSearchHistory.length; ++i)
                        message.topicSearchHistory[i] = String(object.topicSearchHistory[i]);
                }
                if (object.errors) {
                    if (!Array.isArray(object.errors))
                        throw TypeError(".langame.protobuf.UserPreference.errors: array expected");
                    message.errors = [];
                    for (var i = 0; i < object.errors.length; ++i) {
                        if (typeof object.errors[i] !== "object")
                            throw TypeError(".langame.protobuf.UserPreference.errors: object expected");
                        message.errors[i] = $root.langame.protobuf.Error.fromObject(object.errors[i]);
                    }
                }
                if (object.sawWhatsNew != null)
                    message.sawWhatsNew = Boolean(object.sawWhatsNew);
                if (object.notification != null) {
                    if (typeof object.notification !== "object")
                        throw TypeError(".langame.protobuf.UserPreference.notification: object expected");
                    message.notification = $root.langame.protobuf.UserPreference.Notification.fromObject(object.notification);
                }
                if (object.previewMode != null)
                    message.previewMode = Boolean(object.previewMode);
                if (object.goals != null) {
                    if (typeof object.goals !== "object")
                        throw TypeError(".langame.protobuf.UserPreference.goals: object expected");
                    message.goals = $root.langame.protobuf.UserPreference.Goals.fromObject(object.goals);
                }
                if (object.langamesSubscriptionFrequency != null)
                    message.langamesSubscriptionFrequency = String(object.langamesSubscriptionFrequency);
                return message;
            };

            /**
             * Creates a plain object from a UserPreference message. Also converts values to other types if specified.
             * @function toObject
             * @memberof langame.protobuf.UserPreference
             * @static
             * @param {langame.protobuf.UserPreference} message UserPreference
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            UserPreference.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.arrays || options.defaults) {
                    object.userSearchHistory = [];
                    object.favoriteTopics = [];
                    object.topicSearchHistory = [];
                    object.errors = [];
                }
                if (options.defaults) {
                    object.userId = "";
                    object.userRecommendations = false;
                    object.themeIndex = 0;
                    object.hasDoneOnBoarding = false;
                    object.sawWhatsNew = false;
                    object.notification = null;
                    object.previewMode = false;
                    object.goals = null;
                    object.langamesSubscriptionFrequency = "";
                }
                if (message.userId != null && message.hasOwnProperty("userId"))
                    object.userId = message.userId;
                if (message.userRecommendations != null && message.hasOwnProperty("userRecommendations"))
                    object.userRecommendations = message.userRecommendations;
                if (message.themeIndex != null && message.hasOwnProperty("themeIndex"))
                    object.themeIndex = message.themeIndex;
                if (message.hasDoneOnBoarding != null && message.hasOwnProperty("hasDoneOnBoarding"))
                    object.hasDoneOnBoarding = message.hasDoneOnBoarding;
                if (message.userSearchHistory && message.userSearchHistory.length) {
                    object.userSearchHistory = [];
                    for (var j = 0; j < message.userSearchHistory.length; ++j)
                        object.userSearchHistory[j] = message.userSearchHistory[j];
                }
                if (message.favoriteTopics && message.favoriteTopics.length) {
                    object.favoriteTopics = [];
                    for (var j = 0; j < message.favoriteTopics.length; ++j)
                        object.favoriteTopics[j] = message.favoriteTopics[j];
                }
                if (message.topicSearchHistory && message.topicSearchHistory.length) {
                    object.topicSearchHistory = [];
                    for (var j = 0; j < message.topicSearchHistory.length; ++j)
                        object.topicSearchHistory[j] = message.topicSearchHistory[j];
                }
                if (message.errors && message.errors.length) {
                    object.errors = [];
                    for (var j = 0; j < message.errors.length; ++j)
                        object.errors[j] = $root.langame.protobuf.Error.toObject(message.errors[j], options);
                }
                if (message.sawWhatsNew != null && message.hasOwnProperty("sawWhatsNew"))
                    object.sawWhatsNew = message.sawWhatsNew;
                if (message.notification != null && message.hasOwnProperty("notification"))
                    object.notification = $root.langame.protobuf.UserPreference.Notification.toObject(message.notification, options);
                if (message.previewMode != null && message.hasOwnProperty("previewMode"))
                    object.previewMode = message.previewMode;
                if (message.goals != null && message.hasOwnProperty("goals"))
                    object.goals = $root.langame.protobuf.UserPreference.Goals.toObject(message.goals, options);
                if (message.langamesSubscriptionFrequency != null && message.hasOwnProperty("langamesSubscriptionFrequency"))
                    object.langamesSubscriptionFrequency = message.langamesSubscriptionFrequency;
                return object;
            };

            /**
             * Converts this UserPreference to JSON.
             * @function toJSON
             * @memberof langame.protobuf.UserPreference
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            UserPreference.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };

            UserPreference.Notification = (function() {

                /**
                 * Properties of a Notification.
                 * @memberof langame.protobuf.UserPreference
                 * @interface INotification
                 * @property {langame.protobuf.UserPreference.Notification.IInvite|null} [invite] Notification invite
                 * @property {langame.protobuf.UserPreference.Notification.IMessage|null} [message] Notification message
                 * @property {langame.protobuf.UserPreference.Notification.INewVersion|null} [newVersion] Notification newVersion
                 */

                /**
                 * Constructs a new Notification.
                 * @memberof langame.protobuf.UserPreference
                 * @classdesc Represents a Notification.
                 * @implements INotification
                 * @constructor
                 * @param {langame.protobuf.UserPreference.INotification=} [properties] Properties to set
                 */
                function Notification(properties) {
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * Notification invite.
                 * @member {langame.protobuf.UserPreference.Notification.IInvite|null|undefined} invite
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @instance
                 */
                Notification.prototype.invite = null;

                /**
                 * Notification message.
                 * @member {langame.protobuf.UserPreference.Notification.IMessage|null|undefined} message
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @instance
                 */
                Notification.prototype.message = null;

                /**
                 * Notification newVersion.
                 * @member {langame.protobuf.UserPreference.Notification.INewVersion|null|undefined} newVersion
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @instance
                 */
                Notification.prototype.newVersion = null;

                /**
                 * Creates a new Notification instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @static
                 * @param {langame.protobuf.UserPreference.INotification=} [properties] Properties to set
                 * @returns {langame.protobuf.UserPreference.Notification} Notification instance
                 */
                Notification.create = function create(properties) {
                    return new Notification(properties);
                };

                /**
                 * Encodes the specified Notification message. Does not implicitly {@link langame.protobuf.UserPreference.Notification.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @static
                 * @param {langame.protobuf.UserPreference.INotification} message Notification message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Notification.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.invite != null && Object.hasOwnProperty.call(message, "invite"))
                        $root.langame.protobuf.UserPreference.Notification.Invite.encode(message.invite, writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
                    if (message.message != null && Object.hasOwnProperty.call(message, "message"))
                        $root.langame.protobuf.UserPreference.Notification.Message.encode(message.message, writer.uint32(/* id 2, wireType 2 =*/18).fork()).ldelim();
                    if (message.newVersion != null && Object.hasOwnProperty.call(message, "newVersion"))
                        $root.langame.protobuf.UserPreference.Notification.NewVersion.encode(message.newVersion, writer.uint32(/* id 3, wireType 2 =*/26).fork()).ldelim();
                    return writer;
                };

                /**
                 * Encodes the specified Notification message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.Notification.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @static
                 * @param {langame.protobuf.UserPreference.INotification} message Notification message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Notification.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes a Notification message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.UserPreference.Notification} Notification
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Notification.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.UserPreference.Notification();
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            message.invite = $root.langame.protobuf.UserPreference.Notification.Invite.decode(reader, reader.uint32());
                            break;
                        case 2:
                            message.message = $root.langame.protobuf.UserPreference.Notification.Message.decode(reader, reader.uint32());
                            break;
                        case 3:
                            message.newVersion = $root.langame.protobuf.UserPreference.Notification.NewVersion.decode(reader, reader.uint32());
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes a Notification message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.UserPreference.Notification} Notification
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Notification.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies a Notification message.
                 * @function verify
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                Notification.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.invite != null && message.hasOwnProperty("invite")) {
                        var error = $root.langame.protobuf.UserPreference.Notification.Invite.verify(message.invite);
                        if (error)
                            return "invite." + error;
                    }
                    if (message.message != null && message.hasOwnProperty("message")) {
                        var error = $root.langame.protobuf.UserPreference.Notification.Message.verify(message.message);
                        if (error)
                            return "message." + error;
                    }
                    if (message.newVersion != null && message.hasOwnProperty("newVersion")) {
                        var error = $root.langame.protobuf.UserPreference.Notification.NewVersion.verify(message.newVersion);
                        if (error)
                            return "newVersion." + error;
                    }
                    return null;
                };

                /**
                 * Creates a Notification message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.UserPreference.Notification} Notification
                 */
                Notification.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.UserPreference.Notification)
                        return object;
                    var message = new $root.langame.protobuf.UserPreference.Notification();
                    if (object.invite != null) {
                        if (typeof object.invite !== "object")
                            throw TypeError(".langame.protobuf.UserPreference.Notification.invite: object expected");
                        message.invite = $root.langame.protobuf.UserPreference.Notification.Invite.fromObject(object.invite);
                    }
                    if (object.message != null) {
                        if (typeof object.message !== "object")
                            throw TypeError(".langame.protobuf.UserPreference.Notification.message: object expected");
                        message.message = $root.langame.protobuf.UserPreference.Notification.Message.fromObject(object.message);
                    }
                    if (object.newVersion != null) {
                        if (typeof object.newVersion !== "object")
                            throw TypeError(".langame.protobuf.UserPreference.Notification.newVersion: object expected");
                        message.newVersion = $root.langame.protobuf.UserPreference.Notification.NewVersion.fromObject(object.newVersion);
                    }
                    return message;
                };

                /**
                 * Creates a plain object from a Notification message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @static
                 * @param {langame.protobuf.UserPreference.Notification} message Notification
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                Notification.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.defaults) {
                        object.invite = null;
                        object.message = null;
                        object.newVersion = null;
                    }
                    if (message.invite != null && message.hasOwnProperty("invite"))
                        object.invite = $root.langame.protobuf.UserPreference.Notification.Invite.toObject(message.invite, options);
                    if (message.message != null && message.hasOwnProperty("message"))
                        object.message = $root.langame.protobuf.UserPreference.Notification.Message.toObject(message.message, options);
                    if (message.newVersion != null && message.hasOwnProperty("newVersion"))
                        object.newVersion = $root.langame.protobuf.UserPreference.Notification.NewVersion.toObject(message.newVersion, options);
                    return object;
                };

                /**
                 * Converts this Notification to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.UserPreference.Notification
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                Notification.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                Notification.Invite = (function() {

                    /**
                     * Properties of an Invite.
                     * @memberof langame.protobuf.UserPreference.Notification
                     * @interface IInvite
                     * @property {boolean|null} [email] Invite email
                     * @property {boolean|null} [push] Invite push
                     */

                    /**
                     * Constructs a new Invite.
                     * @memberof langame.protobuf.UserPreference.Notification
                     * @classdesc Represents an Invite.
                     * @implements IInvite
                     * @constructor
                     * @param {langame.protobuf.UserPreference.Notification.IInvite=} [properties] Properties to set
                     */
                    function Invite(properties) {
                        if (properties)
                            for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                                if (properties[keys[i]] != null)
                                    this[keys[i]] = properties[keys[i]];
                    }

                    /**
                     * Invite email.
                     * @member {boolean} email
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @instance
                     */
                    Invite.prototype.email = false;

                    /**
                     * Invite push.
                     * @member {boolean} push
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @instance
                     */
                    Invite.prototype.push = false;

                    /**
                     * Creates a new Invite instance using the specified properties.
                     * @function create
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.IInvite=} [properties] Properties to set
                     * @returns {langame.protobuf.UserPreference.Notification.Invite} Invite instance
                     */
                    Invite.create = function create(properties) {
                        return new Invite(properties);
                    };

                    /**
                     * Encodes the specified Invite message. Does not implicitly {@link langame.protobuf.UserPreference.Notification.Invite.verify|verify} messages.
                     * @function encode
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.IInvite} message Invite message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Invite.encode = function encode(message, writer) {
                        if (!writer)
                            writer = $Writer.create();
                        if (message.email != null && Object.hasOwnProperty.call(message, "email"))
                            writer.uint32(/* id 1, wireType 0 =*/8).bool(message.email);
                        if (message.push != null && Object.hasOwnProperty.call(message, "push"))
                            writer.uint32(/* id 2, wireType 0 =*/16).bool(message.push);
                        return writer;
                    };

                    /**
                     * Encodes the specified Invite message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.Notification.Invite.verify|verify} messages.
                     * @function encodeDelimited
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.IInvite} message Invite message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Invite.encodeDelimited = function encodeDelimited(message, writer) {
                        return this.encode(message, writer).ldelim();
                    };

                    /**
                     * Decodes an Invite message from the specified reader or buffer.
                     * @function decode
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @param {number} [length] Message length if known beforehand
                     * @returns {langame.protobuf.UserPreference.Notification.Invite} Invite
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Invite.decode = function decode(reader, length) {
                        if (!(reader instanceof $Reader))
                            reader = $Reader.create(reader);
                        var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.UserPreference.Notification.Invite();
                        while (reader.pos < end) {
                            var tag = reader.uint32();
                            switch (tag >>> 3) {
                            case 1:
                                message.email = reader.bool();
                                break;
                            case 2:
                                message.push = reader.bool();
                                break;
                            default:
                                reader.skipType(tag & 7);
                                break;
                            }
                        }
                        return message;
                    };

                    /**
                     * Decodes an Invite message from the specified reader or buffer, length delimited.
                     * @function decodeDelimited
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @returns {langame.protobuf.UserPreference.Notification.Invite} Invite
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Invite.decodeDelimited = function decodeDelimited(reader) {
                        if (!(reader instanceof $Reader))
                            reader = new $Reader(reader);
                        return this.decode(reader, reader.uint32());
                    };

                    /**
                     * Verifies an Invite message.
                     * @function verify
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @static
                     * @param {Object.<string,*>} message Plain object to verify
                     * @returns {string|null} `null` if valid, otherwise the reason why it is not
                     */
                    Invite.verify = function verify(message) {
                        if (typeof message !== "object" || message === null)
                            return "object expected";
                        if (message.email != null && message.hasOwnProperty("email"))
                            if (typeof message.email !== "boolean")
                                return "email: boolean expected";
                        if (message.push != null && message.hasOwnProperty("push"))
                            if (typeof message.push !== "boolean")
                                return "push: boolean expected";
                        return null;
                    };

                    /**
                     * Creates an Invite message from a plain object. Also converts values to their respective internal types.
                     * @function fromObject
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @static
                     * @param {Object.<string,*>} object Plain object
                     * @returns {langame.protobuf.UserPreference.Notification.Invite} Invite
                     */
                    Invite.fromObject = function fromObject(object) {
                        if (object instanceof $root.langame.protobuf.UserPreference.Notification.Invite)
                            return object;
                        var message = new $root.langame.protobuf.UserPreference.Notification.Invite();
                        if (object.email != null)
                            message.email = Boolean(object.email);
                        if (object.push != null)
                            message.push = Boolean(object.push);
                        return message;
                    };

                    /**
                     * Creates a plain object from an Invite message. Also converts values to other types if specified.
                     * @function toObject
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.Invite} message Invite
                     * @param {$protobuf.IConversionOptions} [options] Conversion options
                     * @returns {Object.<string,*>} Plain object
                     */
                    Invite.toObject = function toObject(message, options) {
                        if (!options)
                            options = {};
                        var object = {};
                        if (options.defaults) {
                            object.email = false;
                            object.push = false;
                        }
                        if (message.email != null && message.hasOwnProperty("email"))
                            object.email = message.email;
                        if (message.push != null && message.hasOwnProperty("push"))
                            object.push = message.push;
                        return object;
                    };

                    /**
                     * Converts this Invite to JSON.
                     * @function toJSON
                     * @memberof langame.protobuf.UserPreference.Notification.Invite
                     * @instance
                     * @returns {Object.<string,*>} JSON object
                     */
                    Invite.prototype.toJSON = function toJSON() {
                        return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                    };

                    return Invite;
                })();

                Notification.Message = (function() {

                    /**
                     * Properties of a Message.
                     * @memberof langame.protobuf.UserPreference.Notification
                     * @interface IMessage
                     * @property {boolean|null} [email] Message email
                     * @property {boolean|null} [push] Message push
                     */

                    /**
                     * Constructs a new Message.
                     * @memberof langame.protobuf.UserPreference.Notification
                     * @classdesc Represents a Message.
                     * @implements IMessage
                     * @constructor
                     * @param {langame.protobuf.UserPreference.Notification.IMessage=} [properties] Properties to set
                     */
                    function Message(properties) {
                        if (properties)
                            for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                                if (properties[keys[i]] != null)
                                    this[keys[i]] = properties[keys[i]];
                    }

                    /**
                     * Message email.
                     * @member {boolean} email
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @instance
                     */
                    Message.prototype.email = false;

                    /**
                     * Message push.
                     * @member {boolean} push
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @instance
                     */
                    Message.prototype.push = false;

                    /**
                     * Creates a new Message instance using the specified properties.
                     * @function create
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.IMessage=} [properties] Properties to set
                     * @returns {langame.protobuf.UserPreference.Notification.Message} Message instance
                     */
                    Message.create = function create(properties) {
                        return new Message(properties);
                    };

                    /**
                     * Encodes the specified Message message. Does not implicitly {@link langame.protobuf.UserPreference.Notification.Message.verify|verify} messages.
                     * @function encode
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.IMessage} message Message message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Message.encode = function encode(message, writer) {
                        if (!writer)
                            writer = $Writer.create();
                        if (message.email != null && Object.hasOwnProperty.call(message, "email"))
                            writer.uint32(/* id 1, wireType 0 =*/8).bool(message.email);
                        if (message.push != null && Object.hasOwnProperty.call(message, "push"))
                            writer.uint32(/* id 2, wireType 0 =*/16).bool(message.push);
                        return writer;
                    };

                    /**
                     * Encodes the specified Message message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.Notification.Message.verify|verify} messages.
                     * @function encodeDelimited
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.IMessage} message Message message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Message.encodeDelimited = function encodeDelimited(message, writer) {
                        return this.encode(message, writer).ldelim();
                    };

                    /**
                     * Decodes a Message message from the specified reader or buffer.
                     * @function decode
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @param {number} [length] Message length if known beforehand
                     * @returns {langame.protobuf.UserPreference.Notification.Message} Message
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Message.decode = function decode(reader, length) {
                        if (!(reader instanceof $Reader))
                            reader = $Reader.create(reader);
                        var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.UserPreference.Notification.Message();
                        while (reader.pos < end) {
                            var tag = reader.uint32();
                            switch (tag >>> 3) {
                            case 1:
                                message.email = reader.bool();
                                break;
                            case 2:
                                message.push = reader.bool();
                                break;
                            default:
                                reader.skipType(tag & 7);
                                break;
                            }
                        }
                        return message;
                    };

                    /**
                     * Decodes a Message message from the specified reader or buffer, length delimited.
                     * @function decodeDelimited
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @returns {langame.protobuf.UserPreference.Notification.Message} Message
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Message.decodeDelimited = function decodeDelimited(reader) {
                        if (!(reader instanceof $Reader))
                            reader = new $Reader(reader);
                        return this.decode(reader, reader.uint32());
                    };

                    /**
                     * Verifies a Message message.
                     * @function verify
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @static
                     * @param {Object.<string,*>} message Plain object to verify
                     * @returns {string|null} `null` if valid, otherwise the reason why it is not
                     */
                    Message.verify = function verify(message) {
                        if (typeof message !== "object" || message === null)
                            return "object expected";
                        if (message.email != null && message.hasOwnProperty("email"))
                            if (typeof message.email !== "boolean")
                                return "email: boolean expected";
                        if (message.push != null && message.hasOwnProperty("push"))
                            if (typeof message.push !== "boolean")
                                return "push: boolean expected";
                        return null;
                    };

                    /**
                     * Creates a Message message from a plain object. Also converts values to their respective internal types.
                     * @function fromObject
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @static
                     * @param {Object.<string,*>} object Plain object
                     * @returns {langame.protobuf.UserPreference.Notification.Message} Message
                     */
                    Message.fromObject = function fromObject(object) {
                        if (object instanceof $root.langame.protobuf.UserPreference.Notification.Message)
                            return object;
                        var message = new $root.langame.protobuf.UserPreference.Notification.Message();
                        if (object.email != null)
                            message.email = Boolean(object.email);
                        if (object.push != null)
                            message.push = Boolean(object.push);
                        return message;
                    };

                    /**
                     * Creates a plain object from a Message message. Also converts values to other types if specified.
                     * @function toObject
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.Message} message Message
                     * @param {$protobuf.IConversionOptions} [options] Conversion options
                     * @returns {Object.<string,*>} Plain object
                     */
                    Message.toObject = function toObject(message, options) {
                        if (!options)
                            options = {};
                        var object = {};
                        if (options.defaults) {
                            object.email = false;
                            object.push = false;
                        }
                        if (message.email != null && message.hasOwnProperty("email"))
                            object.email = message.email;
                        if (message.push != null && message.hasOwnProperty("push"))
                            object.push = message.push;
                        return object;
                    };

                    /**
                     * Converts this Message to JSON.
                     * @function toJSON
                     * @memberof langame.protobuf.UserPreference.Notification.Message
                     * @instance
                     * @returns {Object.<string,*>} JSON object
                     */
                    Message.prototype.toJSON = function toJSON() {
                        return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                    };

                    return Message;
                })();

                Notification.NewVersion = (function() {

                    /**
                     * Properties of a NewVersion.
                     * @memberof langame.protobuf.UserPreference.Notification
                     * @interface INewVersion
                     * @property {boolean|null} [email] NewVersion email
                     * @property {boolean|null} [push] NewVersion push
                     */

                    /**
                     * Constructs a new NewVersion.
                     * @memberof langame.protobuf.UserPreference.Notification
                     * @classdesc Represents a NewVersion.
                     * @implements INewVersion
                     * @constructor
                     * @param {langame.protobuf.UserPreference.Notification.INewVersion=} [properties] Properties to set
                     */
                    function NewVersion(properties) {
                        if (properties)
                            for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                                if (properties[keys[i]] != null)
                                    this[keys[i]] = properties[keys[i]];
                    }

                    /**
                     * NewVersion email.
                     * @member {boolean} email
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @instance
                     */
                    NewVersion.prototype.email = false;

                    /**
                     * NewVersion push.
                     * @member {boolean} push
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @instance
                     */
                    NewVersion.prototype.push = false;

                    /**
                     * Creates a new NewVersion instance using the specified properties.
                     * @function create
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.INewVersion=} [properties] Properties to set
                     * @returns {langame.protobuf.UserPreference.Notification.NewVersion} NewVersion instance
                     */
                    NewVersion.create = function create(properties) {
                        return new NewVersion(properties);
                    };

                    /**
                     * Encodes the specified NewVersion message. Does not implicitly {@link langame.protobuf.UserPreference.Notification.NewVersion.verify|verify} messages.
                     * @function encode
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.INewVersion} message NewVersion message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    NewVersion.encode = function encode(message, writer) {
                        if (!writer)
                            writer = $Writer.create();
                        if (message.email != null && Object.hasOwnProperty.call(message, "email"))
                            writer.uint32(/* id 1, wireType 0 =*/8).bool(message.email);
                        if (message.push != null && Object.hasOwnProperty.call(message, "push"))
                            writer.uint32(/* id 2, wireType 0 =*/16).bool(message.push);
                        return writer;
                    };

                    /**
                     * Encodes the specified NewVersion message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.Notification.NewVersion.verify|verify} messages.
                     * @function encodeDelimited
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.INewVersion} message NewVersion message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    NewVersion.encodeDelimited = function encodeDelimited(message, writer) {
                        return this.encode(message, writer).ldelim();
                    };

                    /**
                     * Decodes a NewVersion message from the specified reader or buffer.
                     * @function decode
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @param {number} [length] Message length if known beforehand
                     * @returns {langame.protobuf.UserPreference.Notification.NewVersion} NewVersion
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    NewVersion.decode = function decode(reader, length) {
                        if (!(reader instanceof $Reader))
                            reader = $Reader.create(reader);
                        var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.UserPreference.Notification.NewVersion();
                        while (reader.pos < end) {
                            var tag = reader.uint32();
                            switch (tag >>> 3) {
                            case 1:
                                message.email = reader.bool();
                                break;
                            case 2:
                                message.push = reader.bool();
                                break;
                            default:
                                reader.skipType(tag & 7);
                                break;
                            }
                        }
                        return message;
                    };

                    /**
                     * Decodes a NewVersion message from the specified reader or buffer, length delimited.
                     * @function decodeDelimited
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @returns {langame.protobuf.UserPreference.Notification.NewVersion} NewVersion
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    NewVersion.decodeDelimited = function decodeDelimited(reader) {
                        if (!(reader instanceof $Reader))
                            reader = new $Reader(reader);
                        return this.decode(reader, reader.uint32());
                    };

                    /**
                     * Verifies a NewVersion message.
                     * @function verify
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @static
                     * @param {Object.<string,*>} message Plain object to verify
                     * @returns {string|null} `null` if valid, otherwise the reason why it is not
                     */
                    NewVersion.verify = function verify(message) {
                        if (typeof message !== "object" || message === null)
                            return "object expected";
                        if (message.email != null && message.hasOwnProperty("email"))
                            if (typeof message.email !== "boolean")
                                return "email: boolean expected";
                        if (message.push != null && message.hasOwnProperty("push"))
                            if (typeof message.push !== "boolean")
                                return "push: boolean expected";
                        return null;
                    };

                    /**
                     * Creates a NewVersion message from a plain object. Also converts values to their respective internal types.
                     * @function fromObject
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @static
                     * @param {Object.<string,*>} object Plain object
                     * @returns {langame.protobuf.UserPreference.Notification.NewVersion} NewVersion
                     */
                    NewVersion.fromObject = function fromObject(object) {
                        if (object instanceof $root.langame.protobuf.UserPreference.Notification.NewVersion)
                            return object;
                        var message = new $root.langame.protobuf.UserPreference.Notification.NewVersion();
                        if (object.email != null)
                            message.email = Boolean(object.email);
                        if (object.push != null)
                            message.push = Boolean(object.push);
                        return message;
                    };

                    /**
                     * Creates a plain object from a NewVersion message. Also converts values to other types if specified.
                     * @function toObject
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @static
                     * @param {langame.protobuf.UserPreference.Notification.NewVersion} message NewVersion
                     * @param {$protobuf.IConversionOptions} [options] Conversion options
                     * @returns {Object.<string,*>} Plain object
                     */
                    NewVersion.toObject = function toObject(message, options) {
                        if (!options)
                            options = {};
                        var object = {};
                        if (options.defaults) {
                            object.email = false;
                            object.push = false;
                        }
                        if (message.email != null && message.hasOwnProperty("email"))
                            object.email = message.email;
                        if (message.push != null && message.hasOwnProperty("push"))
                            object.push = message.push;
                        return object;
                    };

                    /**
                     * Converts this NewVersion to JSON.
                     * @function toJSON
                     * @memberof langame.protobuf.UserPreference.Notification.NewVersion
                     * @instance
                     * @returns {Object.<string,*>} JSON object
                     */
                    NewVersion.prototype.toJSON = function toJSON() {
                        return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                    };

                    return NewVersion;
                })();

                return Notification;
            })();

            UserPreference.Goals = (function() {

                /**
                 * Properties of a Goals.
                 * @memberof langame.protobuf.UserPreference
                 * @interface IGoals
                 * @property {boolean|null} [growRelationships] Goals growRelationships
                 * @property {boolean|null} [compoundRelationships] Goals compoundRelationships
                 * @property {boolean|null} [learn] Goals learn
                 */

                /**
                 * Constructs a new Goals.
                 * @memberof langame.protobuf.UserPreference
                 * @classdesc Represents a Goals.
                 * @implements IGoals
                 * @constructor
                 * @param {langame.protobuf.UserPreference.IGoals=} [properties] Properties to set
                 */
                function Goals(properties) {
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * Goals growRelationships.
                 * @member {boolean} growRelationships
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @instance
                 */
                Goals.prototype.growRelationships = false;

                /**
                 * Goals compoundRelationships.
                 * @member {boolean} compoundRelationships
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @instance
                 */
                Goals.prototype.compoundRelationships = false;

                /**
                 * Goals learn.
                 * @member {boolean} learn
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @instance
                 */
                Goals.prototype.learn = false;

                /**
                 * Creates a new Goals instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @static
                 * @param {langame.protobuf.UserPreference.IGoals=} [properties] Properties to set
                 * @returns {langame.protobuf.UserPreference.Goals} Goals instance
                 */
                Goals.create = function create(properties) {
                    return new Goals(properties);
                };

                /**
                 * Encodes the specified Goals message. Does not implicitly {@link langame.protobuf.UserPreference.Goals.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @static
                 * @param {langame.protobuf.UserPreference.IGoals} message Goals message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Goals.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.growRelationships != null && Object.hasOwnProperty.call(message, "growRelationships"))
                        writer.uint32(/* id 1, wireType 0 =*/8).bool(message.growRelationships);
                    if (message.compoundRelationships != null && Object.hasOwnProperty.call(message, "compoundRelationships"))
                        writer.uint32(/* id 2, wireType 0 =*/16).bool(message.compoundRelationships);
                    if (message.learn != null && Object.hasOwnProperty.call(message, "learn"))
                        writer.uint32(/* id 3, wireType 0 =*/24).bool(message.learn);
                    return writer;
                };

                /**
                 * Encodes the specified Goals message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.Goals.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @static
                 * @param {langame.protobuf.UserPreference.IGoals} message Goals message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Goals.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes a Goals message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.UserPreference.Goals} Goals
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Goals.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.UserPreference.Goals();
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            message.growRelationships = reader.bool();
                            break;
                        case 2:
                            message.compoundRelationships = reader.bool();
                            break;
                        case 3:
                            message.learn = reader.bool();
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes a Goals message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.UserPreference.Goals} Goals
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Goals.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies a Goals message.
                 * @function verify
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                Goals.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.growRelationships != null && message.hasOwnProperty("growRelationships"))
                        if (typeof message.growRelationships !== "boolean")
                            return "growRelationships: boolean expected";
                    if (message.compoundRelationships != null && message.hasOwnProperty("compoundRelationships"))
                        if (typeof message.compoundRelationships !== "boolean")
                            return "compoundRelationships: boolean expected";
                    if (message.learn != null && message.hasOwnProperty("learn"))
                        if (typeof message.learn !== "boolean")
                            return "learn: boolean expected";
                    return null;
                };

                /**
                 * Creates a Goals message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.UserPreference.Goals} Goals
                 */
                Goals.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.UserPreference.Goals)
                        return object;
                    var message = new $root.langame.protobuf.UserPreference.Goals();
                    if (object.growRelationships != null)
                        message.growRelationships = Boolean(object.growRelationships);
                    if (object.compoundRelationships != null)
                        message.compoundRelationships = Boolean(object.compoundRelationships);
                    if (object.learn != null)
                        message.learn = Boolean(object.learn);
                    return message;
                };

                /**
                 * Creates a plain object from a Goals message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @static
                 * @param {langame.protobuf.UserPreference.Goals} message Goals
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                Goals.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.defaults) {
                        object.growRelationships = false;
                        object.compoundRelationships = false;
                        object.learn = false;
                    }
                    if (message.growRelationships != null && message.hasOwnProperty("growRelationships"))
                        object.growRelationships = message.growRelationships;
                    if (message.compoundRelationships != null && message.hasOwnProperty("compoundRelationships"))
                        object.compoundRelationships = message.compoundRelationships;
                    if (message.learn != null && message.hasOwnProperty("learn"))
                        object.learn = message.learn;
                    return object;
                };

                /**
                 * Converts this Goals to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.UserPreference.Goals
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                Goals.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                return Goals;
            })();

            return UserPreference;
        })();

        protobuf.Langame = (function() {

            /**
             * Properties of a Langame.
             * @memberof langame.protobuf
             * @interface ILangame
             * @property {string|null} [id] Langame id
             * @property {Array.<langame.protobuf.Langame.IPlayer>|null} [players] Langame players
             * @property {Array.<string>|null} [topics] Langame topics
             * @property {string|null} [initiator] Langame initiator
             * @property {google.protobuf.ITimestamp|null} [done] Langame done
             * @property {google.protobuf.ITimestamp|null} [createdAt] Langame createdAt
             * @property {Array.<langame.protobuf.IError>|null} [errors] Langame errors
             * @property {Array.<langame.protobuf.Langame.IReflection>|null} [reflections] Langame reflections
             * @property {Array.<string>|null} [tags] Langame tags
             */

            /**
             * Constructs a new Langame.
             * @memberof langame.protobuf
             * @classdesc Represents a Langame.
             * @implements ILangame
             * @constructor
             * @param {langame.protobuf.ILangame=} [properties] Properties to set
             */
            function Langame(properties) {
                this.players = [];
                this.topics = [];
                this.errors = [];
                this.reflections = [];
                this.tags = [];
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }

            /**
             * Langame id.
             * @member {string} id
             * @memberof langame.protobuf.Langame
             * @instance
             */
            Langame.prototype.id = "";

            /**
             * Langame players.
             * @member {Array.<langame.protobuf.Langame.IPlayer>} players
             * @memberof langame.protobuf.Langame
             * @instance
             */
            Langame.prototype.players = $util.emptyArray;

            /**
             * Langame topics.
             * @member {Array.<string>} topics
             * @memberof langame.protobuf.Langame
             * @instance
             */
            Langame.prototype.topics = $util.emptyArray;

            /**
             * Langame initiator.
             * @member {string} initiator
             * @memberof langame.protobuf.Langame
             * @instance
             */
            Langame.prototype.initiator = "";

            /**
             * Langame done.
             * @member {google.protobuf.ITimestamp|null|undefined} done
             * @memberof langame.protobuf.Langame
             * @instance
             */
            Langame.prototype.done = null;

            /**
             * Langame createdAt.
             * @member {google.protobuf.ITimestamp|null|undefined} createdAt
             * @memberof langame.protobuf.Langame
             * @instance
             */
            Langame.prototype.createdAt = null;

            /**
             * Langame errors.
             * @member {Array.<langame.protobuf.IError>} errors
             * @memberof langame.protobuf.Langame
             * @instance
             */
            Langame.prototype.errors = $util.emptyArray;

            /**
             * Langame reflections.
             * @member {Array.<langame.protobuf.Langame.IReflection>} reflections
             * @memberof langame.protobuf.Langame
             * @instance
             */
            Langame.prototype.reflections = $util.emptyArray;

            /**
             * Langame tags.
             * @member {Array.<string>} tags
             * @memberof langame.protobuf.Langame
             * @instance
             */
            Langame.prototype.tags = $util.emptyArray;

            /**
             * Creates a new Langame instance using the specified properties.
             * @function create
             * @memberof langame.protobuf.Langame
             * @static
             * @param {langame.protobuf.ILangame=} [properties] Properties to set
             * @returns {langame.protobuf.Langame} Langame instance
             */
            Langame.create = function create(properties) {
                return new Langame(properties);
            };

            /**
             * Encodes the specified Langame message. Does not implicitly {@link langame.protobuf.Langame.verify|verify} messages.
             * @function encode
             * @memberof langame.protobuf.Langame
             * @static
             * @param {langame.protobuf.ILangame} message Langame message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            Langame.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.id != null && Object.hasOwnProperty.call(message, "id"))
                    writer.uint32(/* id 1, wireType 2 =*/10).string(message.id);
                if (message.players != null && message.players.length)
                    for (var i = 0; i < message.players.length; ++i)
                        $root.langame.protobuf.Langame.Player.encode(message.players[i], writer.uint32(/* id 2, wireType 2 =*/18).fork()).ldelim();
                if (message.topics != null && message.topics.length)
                    for (var i = 0; i < message.topics.length; ++i)
                        writer.uint32(/* id 3, wireType 2 =*/26).string(message.topics[i]);
                if (message.initiator != null && Object.hasOwnProperty.call(message, "initiator"))
                    writer.uint32(/* id 5, wireType 2 =*/42).string(message.initiator);
                if (message.done != null && Object.hasOwnProperty.call(message, "done"))
                    $root.google.protobuf.Timestamp.encode(message.done, writer.uint32(/* id 7, wireType 2 =*/58).fork()).ldelim();
                if (message.createdAt != null && Object.hasOwnProperty.call(message, "createdAt"))
                    $root.google.protobuf.Timestamp.encode(message.createdAt, writer.uint32(/* id 9, wireType 2 =*/74).fork()).ldelim();
                if (message.errors != null && message.errors.length)
                    for (var i = 0; i < message.errors.length; ++i)
                        $root.langame.protobuf.Error.encode(message.errors[i], writer.uint32(/* id 10, wireType 2 =*/82).fork()).ldelim();
                if (message.reflections != null && message.reflections.length)
                    for (var i = 0; i < message.reflections.length; ++i)
                        $root.langame.protobuf.Langame.Reflection.encode(message.reflections[i], writer.uint32(/* id 21, wireType 2 =*/170).fork()).ldelim();
                if (message.tags != null && message.tags.length)
                    for (var i = 0; i < message.tags.length; ++i)
                        writer.uint32(/* id 23, wireType 2 =*/186).string(message.tags[i]);
                return writer;
            };

            /**
             * Encodes the specified Langame message, length delimited. Does not implicitly {@link langame.protobuf.Langame.verify|verify} messages.
             * @function encodeDelimited
             * @memberof langame.protobuf.Langame
             * @static
             * @param {langame.protobuf.ILangame} message Langame message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            Langame.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };

            /**
             * Decodes a Langame message from the specified reader or buffer.
             * @function decode
             * @memberof langame.protobuf.Langame
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {langame.protobuf.Langame} Langame
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            Langame.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Langame();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1:
                        message.id = reader.string();
                        break;
                    case 2:
                        if (!(message.players && message.players.length))
                            message.players = [];
                        message.players.push($root.langame.protobuf.Langame.Player.decode(reader, reader.uint32()));
                        break;
                    case 3:
                        if (!(message.topics && message.topics.length))
                            message.topics = [];
                        message.topics.push(reader.string());
                        break;
                    case 5:
                        message.initiator = reader.string();
                        break;
                    case 7:
                        message.done = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                        break;
                    case 9:
                        message.createdAt = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                        break;
                    case 10:
                        if (!(message.errors && message.errors.length))
                            message.errors = [];
                        message.errors.push($root.langame.protobuf.Error.decode(reader, reader.uint32()));
                        break;
                    case 21:
                        if (!(message.reflections && message.reflections.length))
                            message.reflections = [];
                        message.reflections.push($root.langame.protobuf.Langame.Reflection.decode(reader, reader.uint32()));
                        break;
                    case 23:
                        if (!(message.tags && message.tags.length))
                            message.tags = [];
                        message.tags.push(reader.string());
                        break;
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };

            /**
             * Decodes a Langame message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof langame.protobuf.Langame
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {langame.protobuf.Langame} Langame
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            Langame.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };

            /**
             * Verifies a Langame message.
             * @function verify
             * @memberof langame.protobuf.Langame
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            Langame.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.id != null && message.hasOwnProperty("id"))
                    if (!$util.isString(message.id))
                        return "id: string expected";
                if (message.players != null && message.hasOwnProperty("players")) {
                    if (!Array.isArray(message.players))
                        return "players: array expected";
                    for (var i = 0; i < message.players.length; ++i) {
                        var error = $root.langame.protobuf.Langame.Player.verify(message.players[i]);
                        if (error)
                            return "players." + error;
                    }
                }
                if (message.topics != null && message.hasOwnProperty("topics")) {
                    if (!Array.isArray(message.topics))
                        return "topics: array expected";
                    for (var i = 0; i < message.topics.length; ++i)
                        if (!$util.isString(message.topics[i]))
                            return "topics: string[] expected";
                }
                if (message.initiator != null && message.hasOwnProperty("initiator"))
                    if (!$util.isString(message.initiator))
                        return "initiator: string expected";
                if (message.done != null && message.hasOwnProperty("done")) {
                    var error = $root.google.protobuf.Timestamp.verify(message.done);
                    if (error)
                        return "done." + error;
                }
                if (message.createdAt != null && message.hasOwnProperty("createdAt")) {
                    var error = $root.google.protobuf.Timestamp.verify(message.createdAt);
                    if (error)
                        return "createdAt." + error;
                }
                if (message.errors != null && message.hasOwnProperty("errors")) {
                    if (!Array.isArray(message.errors))
                        return "errors: array expected";
                    for (var i = 0; i < message.errors.length; ++i) {
                        var error = $root.langame.protobuf.Error.verify(message.errors[i]);
                        if (error)
                            return "errors." + error;
                    }
                }
                if (message.reflections != null && message.hasOwnProperty("reflections")) {
                    if (!Array.isArray(message.reflections))
                        return "reflections: array expected";
                    for (var i = 0; i < message.reflections.length; ++i) {
                        var error = $root.langame.protobuf.Langame.Reflection.verify(message.reflections[i]);
                        if (error)
                            return "reflections." + error;
                    }
                }
                if (message.tags != null && message.hasOwnProperty("tags")) {
                    if (!Array.isArray(message.tags))
                        return "tags: array expected";
                    for (var i = 0; i < message.tags.length; ++i)
                        if (!$util.isString(message.tags[i]))
                            return "tags: string[] expected";
                }
                return null;
            };

            /**
             * Creates a Langame message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof langame.protobuf.Langame
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {langame.protobuf.Langame} Langame
             */
            Langame.fromObject = function fromObject(object) {
                if (object instanceof $root.langame.protobuf.Langame)
                    return object;
                var message = new $root.langame.protobuf.Langame();
                if (object.id != null)
                    message.id = String(object.id);
                if (object.players) {
                    if (!Array.isArray(object.players))
                        throw TypeError(".langame.protobuf.Langame.players: array expected");
                    message.players = [];
                    for (var i = 0; i < object.players.length; ++i) {
                        if (typeof object.players[i] !== "object")
                            throw TypeError(".langame.protobuf.Langame.players: object expected");
                        message.players[i] = $root.langame.protobuf.Langame.Player.fromObject(object.players[i]);
                    }
                }
                if (object.topics) {
                    if (!Array.isArray(object.topics))
                        throw TypeError(".langame.protobuf.Langame.topics: array expected");
                    message.topics = [];
                    for (var i = 0; i < object.topics.length; ++i)
                        message.topics[i] = String(object.topics[i]);
                }
                if (object.initiator != null)
                    message.initiator = String(object.initiator);
                if (object.done != null) {
                    if (typeof object.done !== "object")
                        throw TypeError(".langame.protobuf.Langame.done: object expected");
                    message.done = $root.google.protobuf.Timestamp.fromObject(object.done);
                }
                if (object.createdAt != null) {
                    if (typeof object.createdAt !== "object")
                        throw TypeError(".langame.protobuf.Langame.createdAt: object expected");
                    message.createdAt = $root.google.protobuf.Timestamp.fromObject(object.createdAt);
                }
                if (object.errors) {
                    if (!Array.isArray(object.errors))
                        throw TypeError(".langame.protobuf.Langame.errors: array expected");
                    message.errors = [];
                    for (var i = 0; i < object.errors.length; ++i) {
                        if (typeof object.errors[i] !== "object")
                            throw TypeError(".langame.protobuf.Langame.errors: object expected");
                        message.errors[i] = $root.langame.protobuf.Error.fromObject(object.errors[i]);
                    }
                }
                if (object.reflections) {
                    if (!Array.isArray(object.reflections))
                        throw TypeError(".langame.protobuf.Langame.reflections: array expected");
                    message.reflections = [];
                    for (var i = 0; i < object.reflections.length; ++i) {
                        if (typeof object.reflections[i] !== "object")
                            throw TypeError(".langame.protobuf.Langame.reflections: object expected");
                        message.reflections[i] = $root.langame.protobuf.Langame.Reflection.fromObject(object.reflections[i]);
                    }
                }
                if (object.tags) {
                    if (!Array.isArray(object.tags))
                        throw TypeError(".langame.protobuf.Langame.tags: array expected");
                    message.tags = [];
                    for (var i = 0; i < object.tags.length; ++i)
                        message.tags[i] = String(object.tags[i]);
                }
                return message;
            };

            /**
             * Creates a plain object from a Langame message. Also converts values to other types if specified.
             * @function toObject
             * @memberof langame.protobuf.Langame
             * @static
             * @param {langame.protobuf.Langame} message Langame
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            Langame.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.arrays || options.defaults) {
                    object.players = [];
                    object.topics = [];
                    object.errors = [];
                    object.reflections = [];
                    object.tags = [];
                }
                if (options.defaults) {
                    object.id = "";
                    object.initiator = "";
                    object.done = null;
                    object.createdAt = null;
                }
                if (message.id != null && message.hasOwnProperty("id"))
                    object.id = message.id;
                if (message.players && message.players.length) {
                    object.players = [];
                    for (var j = 0; j < message.players.length; ++j)
                        object.players[j] = $root.langame.protobuf.Langame.Player.toObject(message.players[j], options);
                }
                if (message.topics && message.topics.length) {
                    object.topics = [];
                    for (var j = 0; j < message.topics.length; ++j)
                        object.topics[j] = message.topics[j];
                }
                if (message.initiator != null && message.hasOwnProperty("initiator"))
                    object.initiator = message.initiator;
                if (message.done != null && message.hasOwnProperty("done"))
                    object.done = $root.google.protobuf.Timestamp.toObject(message.done, options);
                if (message.createdAt != null && message.hasOwnProperty("createdAt"))
                    object.createdAt = $root.google.protobuf.Timestamp.toObject(message.createdAt, options);
                if (message.errors && message.errors.length) {
                    object.errors = [];
                    for (var j = 0; j < message.errors.length; ++j)
                        object.errors[j] = $root.langame.protobuf.Error.toObject(message.errors[j], options);
                }
                if (message.reflections && message.reflections.length) {
                    object.reflections = [];
                    for (var j = 0; j < message.reflections.length; ++j)
                        object.reflections[j] = $root.langame.protobuf.Langame.Reflection.toObject(message.reflections[j], options);
                }
                if (message.tags && message.tags.length) {
                    object.tags = [];
                    for (var j = 0; j < message.tags.length; ++j)
                        object.tags[j] = message.tags[j];
                }
                return object;
            };

            /**
             * Converts this Langame to JSON.
             * @function toJSON
             * @memberof langame.protobuf.Langame
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            Langame.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };

            Langame.Player = (function() {

                /**
                 * Properties of a Player.
                 * @memberof langame.protobuf.Langame
                 * @interface IPlayer
                 * @property {string|null} [id] Player id
                 * @property {string|null} [tag] Player tag
                 * @property {string|null} [photoUrl] Player photoUrl
                 * @property {boolean|null} [bot] Player bot
                 * @property {string|null} [locale] Player locale
                 * @property {string|null} [email] Player email
                 */

                /**
                 * Constructs a new Player.
                 * @memberof langame.protobuf.Langame
                 * @classdesc Represents a Player.
                 * @implements IPlayer
                 * @constructor
                 * @param {langame.protobuf.Langame.IPlayer=} [properties] Properties to set
                 */
                function Player(properties) {
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * Player id.
                 * @member {string} id
                 * @memberof langame.protobuf.Langame.Player
                 * @instance
                 */
                Player.prototype.id = "";

                /**
                 * Player tag.
                 * @member {string} tag
                 * @memberof langame.protobuf.Langame.Player
                 * @instance
                 */
                Player.prototype.tag = "";

                /**
                 * Player photoUrl.
                 * @member {string} photoUrl
                 * @memberof langame.protobuf.Langame.Player
                 * @instance
                 */
                Player.prototype.photoUrl = "";

                /**
                 * Player bot.
                 * @member {boolean} bot
                 * @memberof langame.protobuf.Langame.Player
                 * @instance
                 */
                Player.prototype.bot = false;

                /**
                 * Player locale.
                 * @member {string} locale
                 * @memberof langame.protobuf.Langame.Player
                 * @instance
                 */
                Player.prototype.locale = "";

                /**
                 * Player email.
                 * @member {string} email
                 * @memberof langame.protobuf.Langame.Player
                 * @instance
                 */
                Player.prototype.email = "";

                /**
                 * Creates a new Player instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.Langame.Player
                 * @static
                 * @param {langame.protobuf.Langame.IPlayer=} [properties] Properties to set
                 * @returns {langame.protobuf.Langame.Player} Player instance
                 */
                Player.create = function create(properties) {
                    return new Player(properties);
                };

                /**
                 * Encodes the specified Player message. Does not implicitly {@link langame.protobuf.Langame.Player.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.Langame.Player
                 * @static
                 * @param {langame.protobuf.Langame.IPlayer} message Player message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Player.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.id != null && Object.hasOwnProperty.call(message, "id"))
                        writer.uint32(/* id 1, wireType 2 =*/10).string(message.id);
                    if (message.tag != null && Object.hasOwnProperty.call(message, "tag"))
                        writer.uint32(/* id 2, wireType 2 =*/18).string(message.tag);
                    if (message.photoUrl != null && Object.hasOwnProperty.call(message, "photoUrl"))
                        writer.uint32(/* id 4, wireType 2 =*/34).string(message.photoUrl);
                    if (message.bot != null && Object.hasOwnProperty.call(message, "bot"))
                        writer.uint32(/* id 5, wireType 0 =*/40).bool(message.bot);
                    if (message.locale != null && Object.hasOwnProperty.call(message, "locale"))
                        writer.uint32(/* id 10, wireType 2 =*/82).string(message.locale);
                    if (message.email != null && Object.hasOwnProperty.call(message, "email"))
                        writer.uint32(/* id 12, wireType 2 =*/98).string(message.email);
                    return writer;
                };

                /**
                 * Encodes the specified Player message, length delimited. Does not implicitly {@link langame.protobuf.Langame.Player.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.Langame.Player
                 * @static
                 * @param {langame.protobuf.Langame.IPlayer} message Player message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Player.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes a Player message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.Langame.Player
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.Langame.Player} Player
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Player.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Langame.Player();
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            message.id = reader.string();
                            break;
                        case 2:
                            message.tag = reader.string();
                            break;
                        case 4:
                            message.photoUrl = reader.string();
                            break;
                        case 5:
                            message.bot = reader.bool();
                            break;
                        case 10:
                            message.locale = reader.string();
                            break;
                        case 12:
                            message.email = reader.string();
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes a Player message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.Langame.Player
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.Langame.Player} Player
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Player.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies a Player message.
                 * @function verify
                 * @memberof langame.protobuf.Langame.Player
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                Player.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.id != null && message.hasOwnProperty("id"))
                        if (!$util.isString(message.id))
                            return "id: string expected";
                    if (message.tag != null && message.hasOwnProperty("tag"))
                        if (!$util.isString(message.tag))
                            return "tag: string expected";
                    if (message.photoUrl != null && message.hasOwnProperty("photoUrl"))
                        if (!$util.isString(message.photoUrl))
                            return "photoUrl: string expected";
                    if (message.bot != null && message.hasOwnProperty("bot"))
                        if (typeof message.bot !== "boolean")
                            return "bot: boolean expected";
                    if (message.locale != null && message.hasOwnProperty("locale"))
                        if (!$util.isString(message.locale))
                            return "locale: string expected";
                    if (message.email != null && message.hasOwnProperty("email"))
                        if (!$util.isString(message.email))
                            return "email: string expected";
                    return null;
                };

                /**
                 * Creates a Player message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.Langame.Player
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.Langame.Player} Player
                 */
                Player.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.Langame.Player)
                        return object;
                    var message = new $root.langame.protobuf.Langame.Player();
                    if (object.id != null)
                        message.id = String(object.id);
                    if (object.tag != null)
                        message.tag = String(object.tag);
                    if (object.photoUrl != null)
                        message.photoUrl = String(object.photoUrl);
                    if (object.bot != null)
                        message.bot = Boolean(object.bot);
                    if (object.locale != null)
                        message.locale = String(object.locale);
                    if (object.email != null)
                        message.email = String(object.email);
                    return message;
                };

                /**
                 * Creates a plain object from a Player message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.Langame.Player
                 * @static
                 * @param {langame.protobuf.Langame.Player} message Player
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                Player.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.defaults) {
                        object.id = "";
                        object.tag = "";
                        object.photoUrl = "";
                        object.bot = false;
                        object.locale = "";
                        object.email = "";
                    }
                    if (message.id != null && message.hasOwnProperty("id"))
                        object.id = message.id;
                    if (message.tag != null && message.hasOwnProperty("tag"))
                        object.tag = message.tag;
                    if (message.photoUrl != null && message.hasOwnProperty("photoUrl"))
                        object.photoUrl = message.photoUrl;
                    if (message.bot != null && message.hasOwnProperty("bot"))
                        object.bot = message.bot;
                    if (message.locale != null && message.hasOwnProperty("locale"))
                        object.locale = message.locale;
                    if (message.email != null && message.hasOwnProperty("email"))
                        object.email = message.email;
                    return object;
                };

                /**
                 * Converts this Player to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.Langame.Player
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                Player.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                return Player;
            })();

            Langame.Reflection = (function() {

                /**
                 * Properties of a Reflection.
                 * @memberof langame.protobuf.Langame
                 * @interface IReflection
                 * @property {string|null} [userId] Reflection userId
                 * @property {string|null} [lastMessageId] Reflection lastMessageId
                 * @property {Array.<string>|null} [alternatives] Reflection alternatives
                 * @property {google.protobuf.ITimestamp|null} [createdAt] Reflection createdAt
                 * @property {langame.protobuf.ContentFilter|null} [contentFilter] Reflection contentFilter
                 * @property {Object.<string,number>|null} [userFeedbacks] Reflection userFeedbacks
                 */

                /**
                 * Constructs a new Reflection.
                 * @memberof langame.protobuf.Langame
                 * @classdesc Represents a Reflection.
                 * @implements IReflection
                 * @constructor
                 * @param {langame.protobuf.Langame.IReflection=} [properties] Properties to set
                 */
                function Reflection(properties) {
                    this.alternatives = [];
                    this.userFeedbacks = {};
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * Reflection userId.
                 * @member {string} userId
                 * @memberof langame.protobuf.Langame.Reflection
                 * @instance
                 */
                Reflection.prototype.userId = "";

                /**
                 * Reflection lastMessageId.
                 * @member {string} lastMessageId
                 * @memberof langame.protobuf.Langame.Reflection
                 * @instance
                 */
                Reflection.prototype.lastMessageId = "";

                /**
                 * Reflection alternatives.
                 * @member {Array.<string>} alternatives
                 * @memberof langame.protobuf.Langame.Reflection
                 * @instance
                 */
                Reflection.prototype.alternatives = $util.emptyArray;

                /**
                 * Reflection createdAt.
                 * @member {google.protobuf.ITimestamp|null|undefined} createdAt
                 * @memberof langame.protobuf.Langame.Reflection
                 * @instance
                 */
                Reflection.prototype.createdAt = null;

                /**
                 * Reflection contentFilter.
                 * @member {langame.protobuf.ContentFilter} contentFilter
                 * @memberof langame.protobuf.Langame.Reflection
                 * @instance
                 */
                Reflection.prototype.contentFilter = 0;

                /**
                 * Reflection userFeedbacks.
                 * @member {Object.<string,number>} userFeedbacks
                 * @memberof langame.protobuf.Langame.Reflection
                 * @instance
                 */
                Reflection.prototype.userFeedbacks = $util.emptyObject;

                /**
                 * Creates a new Reflection instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.Langame.Reflection
                 * @static
                 * @param {langame.protobuf.Langame.IReflection=} [properties] Properties to set
                 * @returns {langame.protobuf.Langame.Reflection} Reflection instance
                 */
                Reflection.create = function create(properties) {
                    return new Reflection(properties);
                };

                /**
                 * Encodes the specified Reflection message. Does not implicitly {@link langame.protobuf.Langame.Reflection.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.Langame.Reflection
                 * @static
                 * @param {langame.protobuf.Langame.IReflection} message Reflection message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Reflection.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.userId != null && Object.hasOwnProperty.call(message, "userId"))
                        writer.uint32(/* id 1, wireType 2 =*/10).string(message.userId);
                    if (message.lastMessageId != null && Object.hasOwnProperty.call(message, "lastMessageId"))
                        writer.uint32(/* id 2, wireType 2 =*/18).string(message.lastMessageId);
                    if (message.alternatives != null && message.alternatives.length)
                        for (var i = 0; i < message.alternatives.length; ++i)
                            writer.uint32(/* id 3, wireType 2 =*/26).string(message.alternatives[i]);
                    if (message.createdAt != null && Object.hasOwnProperty.call(message, "createdAt"))
                        $root.google.protobuf.Timestamp.encode(message.createdAt, writer.uint32(/* id 4, wireType 2 =*/34).fork()).ldelim();
                    if (message.contentFilter != null && Object.hasOwnProperty.call(message, "contentFilter"))
                        writer.uint32(/* id 5, wireType 0 =*/40).int32(message.contentFilter);
                    if (message.userFeedbacks != null && Object.hasOwnProperty.call(message, "userFeedbacks"))
                        for (var keys = Object.keys(message.userFeedbacks), i = 0; i < keys.length; ++i)
                            writer.uint32(/* id 6, wireType 2 =*/50).fork().uint32(/* id 1, wireType 2 =*/10).string(keys[i]).uint32(/* id 2, wireType 0 =*/16).uint32(message.userFeedbacks[keys[i]]).ldelim();
                    return writer;
                };

                /**
                 * Encodes the specified Reflection message, length delimited. Does not implicitly {@link langame.protobuf.Langame.Reflection.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.Langame.Reflection
                 * @static
                 * @param {langame.protobuf.Langame.IReflection} message Reflection message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Reflection.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes a Reflection message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.Langame.Reflection
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.Langame.Reflection} Reflection
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Reflection.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Langame.Reflection(), key, value;
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            message.userId = reader.string();
                            break;
                        case 2:
                            message.lastMessageId = reader.string();
                            break;
                        case 3:
                            if (!(message.alternatives && message.alternatives.length))
                                message.alternatives = [];
                            message.alternatives.push(reader.string());
                            break;
                        case 4:
                            message.createdAt = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                            break;
                        case 5:
                            message.contentFilter = reader.int32();
                            break;
                        case 6:
                            if (message.userFeedbacks === $util.emptyObject)
                                message.userFeedbacks = {};
                            var end2 = reader.uint32() + reader.pos;
                            key = "";
                            value = 0;
                            while (reader.pos < end2) {
                                var tag2 = reader.uint32();
                                switch (tag2 >>> 3) {
                                case 1:
                                    key = reader.string();
                                    break;
                                case 2:
                                    value = reader.uint32();
                                    break;
                                default:
                                    reader.skipType(tag2 & 7);
                                    break;
                                }
                            }
                            message.userFeedbacks[key] = value;
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes a Reflection message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.Langame.Reflection
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.Langame.Reflection} Reflection
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Reflection.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies a Reflection message.
                 * @function verify
                 * @memberof langame.protobuf.Langame.Reflection
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                Reflection.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.userId != null && message.hasOwnProperty("userId"))
                        if (!$util.isString(message.userId))
                            return "userId: string expected";
                    if (message.lastMessageId != null && message.hasOwnProperty("lastMessageId"))
                        if (!$util.isString(message.lastMessageId))
                            return "lastMessageId: string expected";
                    if (message.alternatives != null && message.hasOwnProperty("alternatives")) {
                        if (!Array.isArray(message.alternatives))
                            return "alternatives: array expected";
                        for (var i = 0; i < message.alternatives.length; ++i)
                            if (!$util.isString(message.alternatives[i]))
                                return "alternatives: string[] expected";
                    }
                    if (message.createdAt != null && message.hasOwnProperty("createdAt")) {
                        var error = $root.google.protobuf.Timestamp.verify(message.createdAt);
                        if (error)
                            return "createdAt." + error;
                    }
                    if (message.contentFilter != null && message.hasOwnProperty("contentFilter"))
                        switch (message.contentFilter) {
                        default:
                            return "contentFilter: enum value expected";
                        case 0:
                        case 1:
                        case 2:
                            break;
                        }
                    if (message.userFeedbacks != null && message.hasOwnProperty("userFeedbacks")) {
                        if (!$util.isObject(message.userFeedbacks))
                            return "userFeedbacks: object expected";
                        var key = Object.keys(message.userFeedbacks);
                        for (var i = 0; i < key.length; ++i)
                            if (!$util.isInteger(message.userFeedbacks[key[i]]))
                                return "userFeedbacks: integer{k:string} expected";
                    }
                    return null;
                };

                /**
                 * Creates a Reflection message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.Langame.Reflection
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.Langame.Reflection} Reflection
                 */
                Reflection.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.Langame.Reflection)
                        return object;
                    var message = new $root.langame.protobuf.Langame.Reflection();
                    if (object.userId != null)
                        message.userId = String(object.userId);
                    if (object.lastMessageId != null)
                        message.lastMessageId = String(object.lastMessageId);
                    if (object.alternatives) {
                        if (!Array.isArray(object.alternatives))
                            throw TypeError(".langame.protobuf.Langame.Reflection.alternatives: array expected");
                        message.alternatives = [];
                        for (var i = 0; i < object.alternatives.length; ++i)
                            message.alternatives[i] = String(object.alternatives[i]);
                    }
                    if (object.createdAt != null) {
                        if (typeof object.createdAt !== "object")
                            throw TypeError(".langame.protobuf.Langame.Reflection.createdAt: object expected");
                        message.createdAt = $root.google.protobuf.Timestamp.fromObject(object.createdAt);
                    }
                    switch (object.contentFilter) {
                    case "Safe":
                    case 0:
                        message.contentFilter = 0;
                        break;
                    case "Sensitive":
                    case 1:
                        message.contentFilter = 1;
                        break;
                    case "Unsafe":
                    case 2:
                        message.contentFilter = 2;
                        break;
                    }
                    if (object.userFeedbacks) {
                        if (typeof object.userFeedbacks !== "object")
                            throw TypeError(".langame.protobuf.Langame.Reflection.userFeedbacks: object expected");
                        message.userFeedbacks = {};
                        for (var keys = Object.keys(object.userFeedbacks), i = 0; i < keys.length; ++i)
                            message.userFeedbacks[keys[i]] = object.userFeedbacks[keys[i]] >>> 0;
                    }
                    return message;
                };

                /**
                 * Creates a plain object from a Reflection message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.Langame.Reflection
                 * @static
                 * @param {langame.protobuf.Langame.Reflection} message Reflection
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                Reflection.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.arrays || options.defaults)
                        object.alternatives = [];
                    if (options.objects || options.defaults)
                        object.userFeedbacks = {};
                    if (options.defaults) {
                        object.userId = "";
                        object.lastMessageId = "";
                        object.createdAt = null;
                        object.contentFilter = options.enums === String ? "Safe" : 0;
                    }
                    if (message.userId != null && message.hasOwnProperty("userId"))
                        object.userId = message.userId;
                    if (message.lastMessageId != null && message.hasOwnProperty("lastMessageId"))
                        object.lastMessageId = message.lastMessageId;
                    if (message.alternatives && message.alternatives.length) {
                        object.alternatives = [];
                        for (var j = 0; j < message.alternatives.length; ++j)
                            object.alternatives[j] = message.alternatives[j];
                    }
                    if (message.createdAt != null && message.hasOwnProperty("createdAt"))
                        object.createdAt = $root.google.protobuf.Timestamp.toObject(message.createdAt, options);
                    if (message.contentFilter != null && message.hasOwnProperty("contentFilter"))
                        object.contentFilter = options.enums === String ? $root.langame.protobuf.ContentFilter[message.contentFilter] : message.contentFilter;
                    var keys2;
                    if (message.userFeedbacks && (keys2 = Object.keys(message.userFeedbacks)).length) {
                        object.userFeedbacks = {};
                        for (var j = 0; j < keys2.length; ++j)
                            object.userFeedbacks[keys2[j]] = message.userFeedbacks[keys2[j]];
                    }
                    return object;
                };

                /**
                 * Converts this Reflection to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.Langame.Reflection
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                Reflection.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                return Reflection;
            })();

            return Langame;
        })();

        protobuf.FunctionResponse = (function() {

            /**
             * Properties of a FunctionResponse.
             * @memberof langame.protobuf
             * @interface IFunctionResponse
             * @property {langame.protobuf.FunctionResponse.IVersionCheck|null} [versionCheck] FunctionResponse versionCheck
             */

            /**
             * Constructs a new FunctionResponse.
             * @memberof langame.protobuf
             * @classdesc Represents a FunctionResponse.
             * @implements IFunctionResponse
             * @constructor
             * @param {langame.protobuf.IFunctionResponse=} [properties] Properties to set
             */
            function FunctionResponse(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }

            /**
             * FunctionResponse versionCheck.
             * @member {langame.protobuf.FunctionResponse.IVersionCheck|null|undefined} versionCheck
             * @memberof langame.protobuf.FunctionResponse
             * @instance
             */
            FunctionResponse.prototype.versionCheck = null;

            // OneOf field names bound to virtual getters and setters
            var $oneOfFields;

            /**
             * FunctionResponse type.
             * @member {"versionCheck"|undefined} type
             * @memberof langame.protobuf.FunctionResponse
             * @instance
             */
            Object.defineProperty(FunctionResponse.prototype, "type", {
                get: $util.oneOfGetter($oneOfFields = ["versionCheck"]),
                set: $util.oneOfSetter($oneOfFields)
            });

            /**
             * Creates a new FunctionResponse instance using the specified properties.
             * @function create
             * @memberof langame.protobuf.FunctionResponse
             * @static
             * @param {langame.protobuf.IFunctionResponse=} [properties] Properties to set
             * @returns {langame.protobuf.FunctionResponse} FunctionResponse instance
             */
            FunctionResponse.create = function create(properties) {
                return new FunctionResponse(properties);
            };

            /**
             * Encodes the specified FunctionResponse message. Does not implicitly {@link langame.protobuf.FunctionResponse.verify|verify} messages.
             * @function encode
             * @memberof langame.protobuf.FunctionResponse
             * @static
             * @param {langame.protobuf.IFunctionResponse} message FunctionResponse message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            FunctionResponse.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.versionCheck != null && Object.hasOwnProperty.call(message, "versionCheck"))
                    $root.langame.protobuf.FunctionResponse.VersionCheck.encode(message.versionCheck, writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
                return writer;
            };

            /**
             * Encodes the specified FunctionResponse message, length delimited. Does not implicitly {@link langame.protobuf.FunctionResponse.verify|verify} messages.
             * @function encodeDelimited
             * @memberof langame.protobuf.FunctionResponse
             * @static
             * @param {langame.protobuf.IFunctionResponse} message FunctionResponse message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            FunctionResponse.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };

            /**
             * Decodes a FunctionResponse message from the specified reader or buffer.
             * @function decode
             * @memberof langame.protobuf.FunctionResponse
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {langame.protobuf.FunctionResponse} FunctionResponse
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            FunctionResponse.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.FunctionResponse();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1:
                        message.versionCheck = $root.langame.protobuf.FunctionResponse.VersionCheck.decode(reader, reader.uint32());
                        break;
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };

            /**
             * Decodes a FunctionResponse message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof langame.protobuf.FunctionResponse
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {langame.protobuf.FunctionResponse} FunctionResponse
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            FunctionResponse.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };

            /**
             * Verifies a FunctionResponse message.
             * @function verify
             * @memberof langame.protobuf.FunctionResponse
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            FunctionResponse.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                var properties = {};
                if (message.versionCheck != null && message.hasOwnProperty("versionCheck")) {
                    properties.type = 1;
                    {
                        var error = $root.langame.protobuf.FunctionResponse.VersionCheck.verify(message.versionCheck);
                        if (error)
                            return "versionCheck." + error;
                    }
                }
                return null;
            };

            /**
             * Creates a FunctionResponse message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof langame.protobuf.FunctionResponse
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {langame.protobuf.FunctionResponse} FunctionResponse
             */
            FunctionResponse.fromObject = function fromObject(object) {
                if (object instanceof $root.langame.protobuf.FunctionResponse)
                    return object;
                var message = new $root.langame.protobuf.FunctionResponse();
                if (object.versionCheck != null) {
                    if (typeof object.versionCheck !== "object")
                        throw TypeError(".langame.protobuf.FunctionResponse.versionCheck: object expected");
                    message.versionCheck = $root.langame.protobuf.FunctionResponse.VersionCheck.fromObject(object.versionCheck);
                }
                return message;
            };

            /**
             * Creates a plain object from a FunctionResponse message. Also converts values to other types if specified.
             * @function toObject
             * @memberof langame.protobuf.FunctionResponse
             * @static
             * @param {langame.protobuf.FunctionResponse} message FunctionResponse
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            FunctionResponse.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (message.versionCheck != null && message.hasOwnProperty("versionCheck")) {
                    object.versionCheck = $root.langame.protobuf.FunctionResponse.VersionCheck.toObject(message.versionCheck, options);
                    if (options.oneofs)
                        object.type = "versionCheck";
                }
                return object;
            };

            /**
             * Converts this FunctionResponse to JSON.
             * @function toJSON
             * @memberof langame.protobuf.FunctionResponse
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            FunctionResponse.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };

            FunctionResponse.VersionCheck = (function() {

                /**
                 * Properties of a VersionCheck.
                 * @memberof langame.protobuf.FunctionResponse
                 * @interface IVersionCheck
                 * @property {langame.protobuf.FunctionResponse.VersionCheck.UpdateRequired|null} [update] VersionCheck update
                 */

                /**
                 * Constructs a new VersionCheck.
                 * @memberof langame.protobuf.FunctionResponse
                 * @classdesc Represents a VersionCheck.
                 * @implements IVersionCheck
                 * @constructor
                 * @param {langame.protobuf.FunctionResponse.IVersionCheck=} [properties] Properties to set
                 */
                function VersionCheck(properties) {
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * VersionCheck update.
                 * @member {langame.protobuf.FunctionResponse.VersionCheck.UpdateRequired} update
                 * @memberof langame.protobuf.FunctionResponse.VersionCheck
                 * @instance
                 */
                VersionCheck.prototype.update = 0;

                /**
                 * Creates a new VersionCheck instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.FunctionResponse.VersionCheck
                 * @static
                 * @param {langame.protobuf.FunctionResponse.IVersionCheck=} [properties] Properties to set
                 * @returns {langame.protobuf.FunctionResponse.VersionCheck} VersionCheck instance
                 */
                VersionCheck.create = function create(properties) {
                    return new VersionCheck(properties);
                };

                /**
                 * Encodes the specified VersionCheck message. Does not implicitly {@link langame.protobuf.FunctionResponse.VersionCheck.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.FunctionResponse.VersionCheck
                 * @static
                 * @param {langame.protobuf.FunctionResponse.IVersionCheck} message VersionCheck message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                VersionCheck.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.update != null && Object.hasOwnProperty.call(message, "update"))
                        writer.uint32(/* id 1, wireType 0 =*/8).int32(message.update);
                    return writer;
                };

                /**
                 * Encodes the specified VersionCheck message, length delimited. Does not implicitly {@link langame.protobuf.FunctionResponse.VersionCheck.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.FunctionResponse.VersionCheck
                 * @static
                 * @param {langame.protobuf.FunctionResponse.IVersionCheck} message VersionCheck message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                VersionCheck.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes a VersionCheck message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.FunctionResponse.VersionCheck
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.FunctionResponse.VersionCheck} VersionCheck
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                VersionCheck.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.FunctionResponse.VersionCheck();
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            message.update = reader.int32();
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes a VersionCheck message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.FunctionResponse.VersionCheck
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.FunctionResponse.VersionCheck} VersionCheck
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                VersionCheck.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies a VersionCheck message.
                 * @function verify
                 * @memberof langame.protobuf.FunctionResponse.VersionCheck
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                VersionCheck.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.update != null && message.hasOwnProperty("update"))
                        switch (message.update) {
                        default:
                            return "update: enum value expected";
                        case 0:
                        case 1:
                        case 2:
                            break;
                        }
                    return null;
                };

                /**
                 * Creates a VersionCheck message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.FunctionResponse.VersionCheck
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.FunctionResponse.VersionCheck} VersionCheck
                 */
                VersionCheck.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.FunctionResponse.VersionCheck)
                        return object;
                    var message = new $root.langame.protobuf.FunctionResponse.VersionCheck();
                    switch (object.update) {
                    case "OK":
                    case 0:
                        message.update = 0;
                        break;
                    case "REQUIRED":
                    case 1:
                        message.update = 1;
                        break;
                    case "RETRO_COMPATIBLE":
                    case 2:
                        message.update = 2;
                        break;
                    }
                    return message;
                };

                /**
                 * Creates a plain object from a VersionCheck message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.FunctionResponse.VersionCheck
                 * @static
                 * @param {langame.protobuf.FunctionResponse.VersionCheck} message VersionCheck
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                VersionCheck.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.defaults)
                        object.update = options.enums === String ? "OK" : 0;
                    if (message.update != null && message.hasOwnProperty("update"))
                        object.update = options.enums === String ? $root.langame.protobuf.FunctionResponse.VersionCheck.UpdateRequired[message.update] : message.update;
                    return object;
                };

                /**
                 * Converts this VersionCheck to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.FunctionResponse.VersionCheck
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                VersionCheck.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                /**
                 * UpdateRequired enum.
                 * @name langame.protobuf.FunctionResponse.VersionCheck.UpdateRequired
                 * @enum {number}
                 * @property {number} OK=0 OK value
                 * @property {number} REQUIRED=1 REQUIRED value
                 * @property {number} RETRO_COMPATIBLE=2 RETRO_COMPATIBLE value
                 */
                VersionCheck.UpdateRequired = (function() {
                    var valuesById = {}, values = Object.create(valuesById);
                    values[valuesById[0] = "OK"] = 0;
                    values[valuesById[1] = "REQUIRED"] = 1;
                    values[valuesById[2] = "RETRO_COMPATIBLE"] = 2;
                    return values;
                })();

                return VersionCheck;
            })();

            return FunctionResponse;
        })();

        protobuf.Message = (function() {

            /**
             * Properties of a Message.
             * @memberof langame.protobuf
             * @interface IMessage
             * @property {google.protobuf.ITimestamp|null} [createdAt] Message createdAt
             * @property {langame.protobuf.Message.IAuthor|null} [author] Message author
             * @property {string|null} [langameId] Message langameId
             * @property {langame.protobuf.Message.Type|null} [type] Message type
             * @property {string|null} [body] Message body
             * @property {string|null} [title] Message title
             * @property {string|null} [id] Message id
             * @property {langame.protobuf.Message.IAnalysis|null} [analysis] Message analysis
             * @property {langame.protobuf.Message.IDelivery|null} [delivery] Message delivery
             * @property {Array.<langame.protobuf.Message.IComponent>|null} [components] Message components
             */

            /**
             * Constructs a new Message.
             * @memberof langame.protobuf
             * @classdesc Represents a Message.
             * @implements IMessage
             * @constructor
             * @param {langame.protobuf.IMessage=} [properties] Properties to set
             */
            function Message(properties) {
                this.components = [];
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }

            /**
             * Message createdAt.
             * @member {google.protobuf.ITimestamp|null|undefined} createdAt
             * @memberof langame.protobuf.Message
             * @instance
             */
            Message.prototype.createdAt = null;

            /**
             * Message author.
             * @member {langame.protobuf.Message.IAuthor|null|undefined} author
             * @memberof langame.protobuf.Message
             * @instance
             */
            Message.prototype.author = null;

            /**
             * Message langameId.
             * @member {string} langameId
             * @memberof langame.protobuf.Message
             * @instance
             */
            Message.prototype.langameId = "";

            /**
             * Message type.
             * @member {langame.protobuf.Message.Type} type
             * @memberof langame.protobuf.Message
             * @instance
             */
            Message.prototype.type = 0;

            /**
             * Message body.
             * @member {string} body
             * @memberof langame.protobuf.Message
             * @instance
             */
            Message.prototype.body = "";

            /**
             * Message title.
             * @member {string} title
             * @memberof langame.protobuf.Message
             * @instance
             */
            Message.prototype.title = "";

            /**
             * Message id.
             * @member {string} id
             * @memberof langame.protobuf.Message
             * @instance
             */
            Message.prototype.id = "";

            /**
             * Message analysis.
             * @member {langame.protobuf.Message.IAnalysis|null|undefined} analysis
             * @memberof langame.protobuf.Message
             * @instance
             */
            Message.prototype.analysis = null;

            /**
             * Message delivery.
             * @member {langame.protobuf.Message.IDelivery|null|undefined} delivery
             * @memberof langame.protobuf.Message
             * @instance
             */
            Message.prototype.delivery = null;

            /**
             * Message components.
             * @member {Array.<langame.protobuf.Message.IComponent>} components
             * @memberof langame.protobuf.Message
             * @instance
             */
            Message.prototype.components = $util.emptyArray;

            /**
             * Creates a new Message instance using the specified properties.
             * @function create
             * @memberof langame.protobuf.Message
             * @static
             * @param {langame.protobuf.IMessage=} [properties] Properties to set
             * @returns {langame.protobuf.Message} Message instance
             */
            Message.create = function create(properties) {
                return new Message(properties);
            };

            /**
             * Encodes the specified Message message. Does not implicitly {@link langame.protobuf.Message.verify|verify} messages.
             * @function encode
             * @memberof langame.protobuf.Message
             * @static
             * @param {langame.protobuf.IMessage} message Message message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            Message.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.createdAt != null && Object.hasOwnProperty.call(message, "createdAt"))
                    $root.google.protobuf.Timestamp.encode(message.createdAt, writer.uint32(/* id 3, wireType 2 =*/26).fork()).ldelim();
                if (message.author != null && Object.hasOwnProperty.call(message, "author"))
                    $root.langame.protobuf.Message.Author.encode(message.author, writer.uint32(/* id 4, wireType 2 =*/34).fork()).ldelim();
                if (message.langameId != null && Object.hasOwnProperty.call(message, "langameId"))
                    writer.uint32(/* id 7, wireType 2 =*/58).string(message.langameId);
                if (message.type != null && Object.hasOwnProperty.call(message, "type"))
                    writer.uint32(/* id 8, wireType 0 =*/64).int32(message.type);
                if (message.body != null && Object.hasOwnProperty.call(message, "body"))
                    writer.uint32(/* id 9, wireType 2 =*/74).string(message.body);
                if (message.title != null && Object.hasOwnProperty.call(message, "title"))
                    writer.uint32(/* id 10, wireType 2 =*/82).string(message.title);
                if (message.id != null && Object.hasOwnProperty.call(message, "id"))
                    writer.uint32(/* id 11, wireType 2 =*/90).string(message.id);
                if (message.analysis != null && Object.hasOwnProperty.call(message, "analysis"))
                    $root.langame.protobuf.Message.Analysis.encode(message.analysis, writer.uint32(/* id 12, wireType 2 =*/98).fork()).ldelim();
                if (message.delivery != null && Object.hasOwnProperty.call(message, "delivery"))
                    $root.langame.protobuf.Message.Delivery.encode(message.delivery, writer.uint32(/* id 13, wireType 2 =*/106).fork()).ldelim();
                if (message.components != null && message.components.length)
                    for (var i = 0; i < message.components.length; ++i)
                        $root.langame.protobuf.Message.Component.encode(message.components[i], writer.uint32(/* id 14, wireType 2 =*/114).fork()).ldelim();
                return writer;
            };

            /**
             * Encodes the specified Message message, length delimited. Does not implicitly {@link langame.protobuf.Message.verify|verify} messages.
             * @function encodeDelimited
             * @memberof langame.protobuf.Message
             * @static
             * @param {langame.protobuf.IMessage} message Message message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            Message.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };

            /**
             * Decodes a Message message from the specified reader or buffer.
             * @function decode
             * @memberof langame.protobuf.Message
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {langame.protobuf.Message} Message
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            Message.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Message();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 3:
                        message.createdAt = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                        break;
                    case 4:
                        message.author = $root.langame.protobuf.Message.Author.decode(reader, reader.uint32());
                        break;
                    case 7:
                        message.langameId = reader.string();
                        break;
                    case 8:
                        message.type = reader.int32();
                        break;
                    case 9:
                        message.body = reader.string();
                        break;
                    case 10:
                        message.title = reader.string();
                        break;
                    case 11:
                        message.id = reader.string();
                        break;
                    case 12:
                        message.analysis = $root.langame.protobuf.Message.Analysis.decode(reader, reader.uint32());
                        break;
                    case 13:
                        message.delivery = $root.langame.protobuf.Message.Delivery.decode(reader, reader.uint32());
                        break;
                    case 14:
                        if (!(message.components && message.components.length))
                            message.components = [];
                        message.components.push($root.langame.protobuf.Message.Component.decode(reader, reader.uint32()));
                        break;
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };

            /**
             * Decodes a Message message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof langame.protobuf.Message
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {langame.protobuf.Message} Message
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            Message.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };

            /**
             * Verifies a Message message.
             * @function verify
             * @memberof langame.protobuf.Message
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            Message.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.createdAt != null && message.hasOwnProperty("createdAt")) {
                    var error = $root.google.protobuf.Timestamp.verify(message.createdAt);
                    if (error)
                        return "createdAt." + error;
                }
                if (message.author != null && message.hasOwnProperty("author")) {
                    var error = $root.langame.protobuf.Message.Author.verify(message.author);
                    if (error)
                        return "author." + error;
                }
                if (message.langameId != null && message.hasOwnProperty("langameId"))
                    if (!$util.isString(message.langameId))
                        return "langameId: string expected";
                if (message.type != null && message.hasOwnProperty("type"))
                    switch (message.type) {
                    default:
                        return "type: enum value expected";
                    case 0:
                    case 1:
                        break;
                    }
                if (message.body != null && message.hasOwnProperty("body"))
                    if (!$util.isString(message.body))
                        return "body: string expected";
                if (message.title != null && message.hasOwnProperty("title"))
                    if (!$util.isString(message.title))
                        return "title: string expected";
                if (message.id != null && message.hasOwnProperty("id"))
                    if (!$util.isString(message.id))
                        return "id: string expected";
                if (message.analysis != null && message.hasOwnProperty("analysis")) {
                    var error = $root.langame.protobuf.Message.Analysis.verify(message.analysis);
                    if (error)
                        return "analysis." + error;
                }
                if (message.delivery != null && message.hasOwnProperty("delivery")) {
                    var error = $root.langame.protobuf.Message.Delivery.verify(message.delivery);
                    if (error)
                        return "delivery." + error;
                }
                if (message.components != null && message.hasOwnProperty("components")) {
                    if (!Array.isArray(message.components))
                        return "components: array expected";
                    for (var i = 0; i < message.components.length; ++i) {
                        var error = $root.langame.protobuf.Message.Component.verify(message.components[i]);
                        if (error)
                            return "components." + error;
                    }
                }
                return null;
            };

            /**
             * Creates a Message message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof langame.protobuf.Message
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {langame.protobuf.Message} Message
             */
            Message.fromObject = function fromObject(object) {
                if (object instanceof $root.langame.protobuf.Message)
                    return object;
                var message = new $root.langame.protobuf.Message();
                if (object.createdAt != null) {
                    if (typeof object.createdAt !== "object")
                        throw TypeError(".langame.protobuf.Message.createdAt: object expected");
                    message.createdAt = $root.google.protobuf.Timestamp.fromObject(object.createdAt);
                }
                if (object.author != null) {
                    if (typeof object.author !== "object")
                        throw TypeError(".langame.protobuf.Message.author: object expected");
                    message.author = $root.langame.protobuf.Message.Author.fromObject(object.author);
                }
                if (object.langameId != null)
                    message.langameId = String(object.langameId);
                switch (object.type) {
                case "INVITE":
                case 0:
                    message.type = 0;
                    break;
                case "MESSAGE":
                case 1:
                    message.type = 1;
                    break;
                }
                if (object.body != null)
                    message.body = String(object.body);
                if (object.title != null)
                    message.title = String(object.title);
                if (object.id != null)
                    message.id = String(object.id);
                if (object.analysis != null) {
                    if (typeof object.analysis !== "object")
                        throw TypeError(".langame.protobuf.Message.analysis: object expected");
                    message.analysis = $root.langame.protobuf.Message.Analysis.fromObject(object.analysis);
                }
                if (object.delivery != null) {
                    if (typeof object.delivery !== "object")
                        throw TypeError(".langame.protobuf.Message.delivery: object expected");
                    message.delivery = $root.langame.protobuf.Message.Delivery.fromObject(object.delivery);
                }
                if (object.components) {
                    if (!Array.isArray(object.components))
                        throw TypeError(".langame.protobuf.Message.components: array expected");
                    message.components = [];
                    for (var i = 0; i < object.components.length; ++i) {
                        if (typeof object.components[i] !== "object")
                            throw TypeError(".langame.protobuf.Message.components: object expected");
                        message.components[i] = $root.langame.protobuf.Message.Component.fromObject(object.components[i]);
                    }
                }
                return message;
            };

            /**
             * Creates a plain object from a Message message. Also converts values to other types if specified.
             * @function toObject
             * @memberof langame.protobuf.Message
             * @static
             * @param {langame.protobuf.Message} message Message
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            Message.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.arrays || options.defaults)
                    object.components = [];
                if (options.defaults) {
                    object.createdAt = null;
                    object.author = null;
                    object.langameId = "";
                    object.type = options.enums === String ? "INVITE" : 0;
                    object.body = "";
                    object.title = "";
                    object.id = "";
                    object.analysis = null;
                    object.delivery = null;
                }
                if (message.createdAt != null && message.hasOwnProperty("createdAt"))
                    object.createdAt = $root.google.protobuf.Timestamp.toObject(message.createdAt, options);
                if (message.author != null && message.hasOwnProperty("author"))
                    object.author = $root.langame.protobuf.Message.Author.toObject(message.author, options);
                if (message.langameId != null && message.hasOwnProperty("langameId"))
                    object.langameId = message.langameId;
                if (message.type != null && message.hasOwnProperty("type"))
                    object.type = options.enums === String ? $root.langame.protobuf.Message.Type[message.type] : message.type;
                if (message.body != null && message.hasOwnProperty("body"))
                    object.body = message.body;
                if (message.title != null && message.hasOwnProperty("title"))
                    object.title = message.title;
                if (message.id != null && message.hasOwnProperty("id"))
                    object.id = message.id;
                if (message.analysis != null && message.hasOwnProperty("analysis"))
                    object.analysis = $root.langame.protobuf.Message.Analysis.toObject(message.analysis, options);
                if (message.delivery != null && message.hasOwnProperty("delivery"))
                    object.delivery = $root.langame.protobuf.Message.Delivery.toObject(message.delivery, options);
                if (message.components && message.components.length) {
                    object.components = [];
                    for (var j = 0; j < message.components.length; ++j)
                        object.components[j] = $root.langame.protobuf.Message.Component.toObject(message.components[j], options);
                }
                return object;
            };

            /**
             * Converts this Message to JSON.
             * @function toJSON
             * @memberof langame.protobuf.Message
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            Message.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };

            Message.Author = (function() {

                /**
                 * Properties of an Author.
                 * @memberof langame.protobuf.Message
                 * @interface IAuthor
                 * @property {string|null} [id] Author id
                 * @property {string|null} [tag] Author tag
                 * @property {string|null} [photoUrl] Author photoUrl
                 * @property {boolean|null} [bot] Author bot
                 * @property {string|null} [locale] Author locale
                 * @property {string|null} [email] Author email
                 */

                /**
                 * Constructs a new Author.
                 * @memberof langame.protobuf.Message
                 * @classdesc Represents an Author.
                 * @implements IAuthor
                 * @constructor
                 * @param {langame.protobuf.Message.IAuthor=} [properties] Properties to set
                 */
                function Author(properties) {
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * Author id.
                 * @member {string} id
                 * @memberof langame.protobuf.Message.Author
                 * @instance
                 */
                Author.prototype.id = "";

                /**
                 * Author tag.
                 * @member {string} tag
                 * @memberof langame.protobuf.Message.Author
                 * @instance
                 */
                Author.prototype.tag = "";

                /**
                 * Author photoUrl.
                 * @member {string} photoUrl
                 * @memberof langame.protobuf.Message.Author
                 * @instance
                 */
                Author.prototype.photoUrl = "";

                /**
                 * Author bot.
                 * @member {boolean} bot
                 * @memberof langame.protobuf.Message.Author
                 * @instance
                 */
                Author.prototype.bot = false;

                /**
                 * Author locale.
                 * @member {string} locale
                 * @memberof langame.protobuf.Message.Author
                 * @instance
                 */
                Author.prototype.locale = "";

                /**
                 * Author email.
                 * @member {string} email
                 * @memberof langame.protobuf.Message.Author
                 * @instance
                 */
                Author.prototype.email = "";

                /**
                 * Creates a new Author instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.Message.Author
                 * @static
                 * @param {langame.protobuf.Message.IAuthor=} [properties] Properties to set
                 * @returns {langame.protobuf.Message.Author} Author instance
                 */
                Author.create = function create(properties) {
                    return new Author(properties);
                };

                /**
                 * Encodes the specified Author message. Does not implicitly {@link langame.protobuf.Message.Author.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.Message.Author
                 * @static
                 * @param {langame.protobuf.Message.IAuthor} message Author message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Author.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.id != null && Object.hasOwnProperty.call(message, "id"))
                        writer.uint32(/* id 1, wireType 2 =*/10).string(message.id);
                    if (message.tag != null && Object.hasOwnProperty.call(message, "tag"))
                        writer.uint32(/* id 2, wireType 2 =*/18).string(message.tag);
                    if (message.photoUrl != null && Object.hasOwnProperty.call(message, "photoUrl"))
                        writer.uint32(/* id 4, wireType 2 =*/34).string(message.photoUrl);
                    if (message.bot != null && Object.hasOwnProperty.call(message, "bot"))
                        writer.uint32(/* id 5, wireType 0 =*/40).bool(message.bot);
                    if (message.locale != null && Object.hasOwnProperty.call(message, "locale"))
                        writer.uint32(/* id 10, wireType 2 =*/82).string(message.locale);
                    if (message.email != null && Object.hasOwnProperty.call(message, "email"))
                        writer.uint32(/* id 12, wireType 2 =*/98).string(message.email);
                    return writer;
                };

                /**
                 * Encodes the specified Author message, length delimited. Does not implicitly {@link langame.protobuf.Message.Author.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.Message.Author
                 * @static
                 * @param {langame.protobuf.Message.IAuthor} message Author message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Author.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes an Author message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.Message.Author
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.Message.Author} Author
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Author.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Message.Author();
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            message.id = reader.string();
                            break;
                        case 2:
                            message.tag = reader.string();
                            break;
                        case 4:
                            message.photoUrl = reader.string();
                            break;
                        case 5:
                            message.bot = reader.bool();
                            break;
                        case 10:
                            message.locale = reader.string();
                            break;
                        case 12:
                            message.email = reader.string();
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes an Author message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.Message.Author
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.Message.Author} Author
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Author.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies an Author message.
                 * @function verify
                 * @memberof langame.protobuf.Message.Author
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                Author.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.id != null && message.hasOwnProperty("id"))
                        if (!$util.isString(message.id))
                            return "id: string expected";
                    if (message.tag != null && message.hasOwnProperty("tag"))
                        if (!$util.isString(message.tag))
                            return "tag: string expected";
                    if (message.photoUrl != null && message.hasOwnProperty("photoUrl"))
                        if (!$util.isString(message.photoUrl))
                            return "photoUrl: string expected";
                    if (message.bot != null && message.hasOwnProperty("bot"))
                        if (typeof message.bot !== "boolean")
                            return "bot: boolean expected";
                    if (message.locale != null && message.hasOwnProperty("locale"))
                        if (!$util.isString(message.locale))
                            return "locale: string expected";
                    if (message.email != null && message.hasOwnProperty("email"))
                        if (!$util.isString(message.email))
                            return "email: string expected";
                    return null;
                };

                /**
                 * Creates an Author message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.Message.Author
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.Message.Author} Author
                 */
                Author.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.Message.Author)
                        return object;
                    var message = new $root.langame.protobuf.Message.Author();
                    if (object.id != null)
                        message.id = String(object.id);
                    if (object.tag != null)
                        message.tag = String(object.tag);
                    if (object.photoUrl != null)
                        message.photoUrl = String(object.photoUrl);
                    if (object.bot != null)
                        message.bot = Boolean(object.bot);
                    if (object.locale != null)
                        message.locale = String(object.locale);
                    if (object.email != null)
                        message.email = String(object.email);
                    return message;
                };

                /**
                 * Creates a plain object from an Author message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.Message.Author
                 * @static
                 * @param {langame.protobuf.Message.Author} message Author
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                Author.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.defaults) {
                        object.id = "";
                        object.tag = "";
                        object.photoUrl = "";
                        object.bot = false;
                        object.locale = "";
                        object.email = "";
                    }
                    if (message.id != null && message.hasOwnProperty("id"))
                        object.id = message.id;
                    if (message.tag != null && message.hasOwnProperty("tag"))
                        object.tag = message.tag;
                    if (message.photoUrl != null && message.hasOwnProperty("photoUrl"))
                        object.photoUrl = message.photoUrl;
                    if (message.bot != null && message.hasOwnProperty("bot"))
                        object.bot = message.bot;
                    if (message.locale != null && message.hasOwnProperty("locale"))
                        object.locale = message.locale;
                    if (message.email != null && message.hasOwnProperty("email"))
                        object.email = message.email;
                    return object;
                };

                /**
                 * Converts this Author to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.Message.Author
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                Author.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                return Author;
            })();

            Message.Component = (function() {

                /**
                 * Properties of a Component.
                 * @memberof langame.protobuf.Message
                 * @interface IComponent
                 * @property {number|null} [type] Component type
                 * @property {string|null} [customId] Component customId
                 * @property {boolean|null} [disabled] Component disabled
                 * @property {number|null} [style] Component style
                 * @property {string|null} [label] Component label
                 * @property {string|null} [emoji] Component emoji
                 * @property {string|null} [url] Component url
                 * @property {Array.<langame.protobuf.Message.Component.IOption>|null} [options] Component options
                 * @property {string|null} [placeholder] Component placeholder
                 * @property {number|null} [minValues] Component minValues
                 * @property {number|null} [maxValues] Component maxValues
                 * @property {Array.<langame.protobuf.Message.IComponent>|null} [components] Component components
                 */

                /**
                 * Constructs a new Component.
                 * @memberof langame.protobuf.Message
                 * @classdesc Represents a Component.
                 * @implements IComponent
                 * @constructor
                 * @param {langame.protobuf.Message.IComponent=} [properties] Properties to set
                 */
                function Component(properties) {
                    this.options = [];
                    this.components = [];
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * Component type.
                 * @member {number} type
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.type = 0;

                /**
                 * Component customId.
                 * @member {string} customId
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.customId = "";

                /**
                 * Component disabled.
                 * @member {boolean} disabled
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.disabled = false;

                /**
                 * Component style.
                 * @member {number} style
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.style = 0;

                /**
                 * Component label.
                 * @member {string} label
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.label = "";

                /**
                 * Component emoji.
                 * @member {string} emoji
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.emoji = "";

                /**
                 * Component url.
                 * @member {string} url
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.url = "";

                /**
                 * Component options.
                 * @member {Array.<langame.protobuf.Message.Component.IOption>} options
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.options = $util.emptyArray;

                /**
                 * Component placeholder.
                 * @member {string} placeholder
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.placeholder = "";

                /**
                 * Component minValues.
                 * @member {number} minValues
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.minValues = 0;

                /**
                 * Component maxValues.
                 * @member {number} maxValues
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.maxValues = 0;

                /**
                 * Component components.
                 * @member {Array.<langame.protobuf.Message.IComponent>} components
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 */
                Component.prototype.components = $util.emptyArray;

                /**
                 * Creates a new Component instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.Message.Component
                 * @static
                 * @param {langame.protobuf.Message.IComponent=} [properties] Properties to set
                 * @returns {langame.protobuf.Message.Component} Component instance
                 */
                Component.create = function create(properties) {
                    return new Component(properties);
                };

                /**
                 * Encodes the specified Component message. Does not implicitly {@link langame.protobuf.Message.Component.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.Message.Component
                 * @static
                 * @param {langame.protobuf.Message.IComponent} message Component message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Component.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.type != null && Object.hasOwnProperty.call(message, "type"))
                        writer.uint32(/* id 1, wireType 0 =*/8).uint32(message.type);
                    if (message.customId != null && Object.hasOwnProperty.call(message, "customId"))
                        writer.uint32(/* id 2, wireType 2 =*/18).string(message.customId);
                    if (message.disabled != null && Object.hasOwnProperty.call(message, "disabled"))
                        writer.uint32(/* id 3, wireType 0 =*/24).bool(message.disabled);
                    if (message.style != null && Object.hasOwnProperty.call(message, "style"))
                        writer.uint32(/* id 4, wireType 0 =*/32).uint32(message.style);
                    if (message.label != null && Object.hasOwnProperty.call(message, "label"))
                        writer.uint32(/* id 5, wireType 2 =*/42).string(message.label);
                    if (message.emoji != null && Object.hasOwnProperty.call(message, "emoji"))
                        writer.uint32(/* id 6, wireType 2 =*/50).string(message.emoji);
                    if (message.url != null && Object.hasOwnProperty.call(message, "url"))
                        writer.uint32(/* id 7, wireType 2 =*/58).string(message.url);
                    if (message.options != null && message.options.length)
                        for (var i = 0; i < message.options.length; ++i)
                            $root.langame.protobuf.Message.Component.Option.encode(message.options[i], writer.uint32(/* id 8, wireType 2 =*/66).fork()).ldelim();
                    if (message.placeholder != null && Object.hasOwnProperty.call(message, "placeholder"))
                        writer.uint32(/* id 9, wireType 2 =*/74).string(message.placeholder);
                    if (message.minValues != null && Object.hasOwnProperty.call(message, "minValues"))
                        writer.uint32(/* id 10, wireType 0 =*/80).int32(message.minValues);
                    if (message.maxValues != null && Object.hasOwnProperty.call(message, "maxValues"))
                        writer.uint32(/* id 11, wireType 0 =*/88).int32(message.maxValues);
                    if (message.components != null && message.components.length)
                        for (var i = 0; i < message.components.length; ++i)
                            $root.langame.protobuf.Message.Component.encode(message.components[i], writer.uint32(/* id 12, wireType 2 =*/98).fork()).ldelim();
                    return writer;
                };

                /**
                 * Encodes the specified Component message, length delimited. Does not implicitly {@link langame.protobuf.Message.Component.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.Message.Component
                 * @static
                 * @param {langame.protobuf.Message.IComponent} message Component message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Component.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes a Component message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.Message.Component
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.Message.Component} Component
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Component.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Message.Component();
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            message.type = reader.uint32();
                            break;
                        case 2:
                            message.customId = reader.string();
                            break;
                        case 3:
                            message.disabled = reader.bool();
                            break;
                        case 4:
                            message.style = reader.uint32();
                            break;
                        case 5:
                            message.label = reader.string();
                            break;
                        case 6:
                            message.emoji = reader.string();
                            break;
                        case 7:
                            message.url = reader.string();
                            break;
                        case 8:
                            if (!(message.options && message.options.length))
                                message.options = [];
                            message.options.push($root.langame.protobuf.Message.Component.Option.decode(reader, reader.uint32()));
                            break;
                        case 9:
                            message.placeholder = reader.string();
                            break;
                        case 10:
                            message.minValues = reader.int32();
                            break;
                        case 11:
                            message.maxValues = reader.int32();
                            break;
                        case 12:
                            if (!(message.components && message.components.length))
                                message.components = [];
                            message.components.push($root.langame.protobuf.Message.Component.decode(reader, reader.uint32()));
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes a Component message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.Message.Component
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.Message.Component} Component
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Component.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies a Component message.
                 * @function verify
                 * @memberof langame.protobuf.Message.Component
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                Component.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.type != null && message.hasOwnProperty("type"))
                        if (!$util.isInteger(message.type))
                            return "type: integer expected";
                    if (message.customId != null && message.hasOwnProperty("customId"))
                        if (!$util.isString(message.customId))
                            return "customId: string expected";
                    if (message.disabled != null && message.hasOwnProperty("disabled"))
                        if (typeof message.disabled !== "boolean")
                            return "disabled: boolean expected";
                    if (message.style != null && message.hasOwnProperty("style"))
                        if (!$util.isInteger(message.style))
                            return "style: integer expected";
                    if (message.label != null && message.hasOwnProperty("label"))
                        if (!$util.isString(message.label))
                            return "label: string expected";
                    if (message.emoji != null && message.hasOwnProperty("emoji"))
                        if (!$util.isString(message.emoji))
                            return "emoji: string expected";
                    if (message.url != null && message.hasOwnProperty("url"))
                        if (!$util.isString(message.url))
                            return "url: string expected";
                    if (message.options != null && message.hasOwnProperty("options")) {
                        if (!Array.isArray(message.options))
                            return "options: array expected";
                        for (var i = 0; i < message.options.length; ++i) {
                            var error = $root.langame.protobuf.Message.Component.Option.verify(message.options[i]);
                            if (error)
                                return "options." + error;
                        }
                    }
                    if (message.placeholder != null && message.hasOwnProperty("placeholder"))
                        if (!$util.isString(message.placeholder))
                            return "placeholder: string expected";
                    if (message.minValues != null && message.hasOwnProperty("minValues"))
                        if (!$util.isInteger(message.minValues))
                            return "minValues: integer expected";
                    if (message.maxValues != null && message.hasOwnProperty("maxValues"))
                        if (!$util.isInteger(message.maxValues))
                            return "maxValues: integer expected";
                    if (message.components != null && message.hasOwnProperty("components")) {
                        if (!Array.isArray(message.components))
                            return "components: array expected";
                        for (var i = 0; i < message.components.length; ++i) {
                            var error = $root.langame.protobuf.Message.Component.verify(message.components[i]);
                            if (error)
                                return "components." + error;
                        }
                    }
                    return null;
                };

                /**
                 * Creates a Component message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.Message.Component
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.Message.Component} Component
                 */
                Component.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.Message.Component)
                        return object;
                    var message = new $root.langame.protobuf.Message.Component();
                    if (object.type != null)
                        message.type = object.type >>> 0;
                    if (object.customId != null)
                        message.customId = String(object.customId);
                    if (object.disabled != null)
                        message.disabled = Boolean(object.disabled);
                    if (object.style != null)
                        message.style = object.style >>> 0;
                    if (object.label != null)
                        message.label = String(object.label);
                    if (object.emoji != null)
                        message.emoji = String(object.emoji);
                    if (object.url != null)
                        message.url = String(object.url);
                    if (object.options) {
                        if (!Array.isArray(object.options))
                            throw TypeError(".langame.protobuf.Message.Component.options: array expected");
                        message.options = [];
                        for (var i = 0; i < object.options.length; ++i) {
                            if (typeof object.options[i] !== "object")
                                throw TypeError(".langame.protobuf.Message.Component.options: object expected");
                            message.options[i] = $root.langame.protobuf.Message.Component.Option.fromObject(object.options[i]);
                        }
                    }
                    if (object.placeholder != null)
                        message.placeholder = String(object.placeholder);
                    if (object.minValues != null)
                        message.minValues = object.minValues | 0;
                    if (object.maxValues != null)
                        message.maxValues = object.maxValues | 0;
                    if (object.components) {
                        if (!Array.isArray(object.components))
                            throw TypeError(".langame.protobuf.Message.Component.components: array expected");
                        message.components = [];
                        for (var i = 0; i < object.components.length; ++i) {
                            if (typeof object.components[i] !== "object")
                                throw TypeError(".langame.protobuf.Message.Component.components: object expected");
                            message.components[i] = $root.langame.protobuf.Message.Component.fromObject(object.components[i]);
                        }
                    }
                    return message;
                };

                /**
                 * Creates a plain object from a Component message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.Message.Component
                 * @static
                 * @param {langame.protobuf.Message.Component} message Component
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                Component.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.arrays || options.defaults) {
                        object.options = [];
                        object.components = [];
                    }
                    if (options.defaults) {
                        object.type = 0;
                        object.customId = "";
                        object.disabled = false;
                        object.style = 0;
                        object.label = "";
                        object.emoji = "";
                        object.url = "";
                        object.placeholder = "";
                        object.minValues = 0;
                        object.maxValues = 0;
                    }
                    if (message.type != null && message.hasOwnProperty("type"))
                        object.type = message.type;
                    if (message.customId != null && message.hasOwnProperty("customId"))
                        object.customId = message.customId;
                    if (message.disabled != null && message.hasOwnProperty("disabled"))
                        object.disabled = message.disabled;
                    if (message.style != null && message.hasOwnProperty("style"))
                        object.style = message.style;
                    if (message.label != null && message.hasOwnProperty("label"))
                        object.label = message.label;
                    if (message.emoji != null && message.hasOwnProperty("emoji"))
                        object.emoji = message.emoji;
                    if (message.url != null && message.hasOwnProperty("url"))
                        object.url = message.url;
                    if (message.options && message.options.length) {
                        object.options = [];
                        for (var j = 0; j < message.options.length; ++j)
                            object.options[j] = $root.langame.protobuf.Message.Component.Option.toObject(message.options[j], options);
                    }
                    if (message.placeholder != null && message.hasOwnProperty("placeholder"))
                        object.placeholder = message.placeholder;
                    if (message.minValues != null && message.hasOwnProperty("minValues"))
                        object.minValues = message.minValues;
                    if (message.maxValues != null && message.hasOwnProperty("maxValues"))
                        object.maxValues = message.maxValues;
                    if (message.components && message.components.length) {
                        object.components = [];
                        for (var j = 0; j < message.components.length; ++j)
                            object.components[j] = $root.langame.protobuf.Message.Component.toObject(message.components[j], options);
                    }
                    return object;
                };

                /**
                 * Converts this Component to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.Message.Component
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                Component.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                Component.Option = (function() {

                    /**
                     * Properties of an Option.
                     * @memberof langame.protobuf.Message.Component
                     * @interface IOption
                     * @property {string|null} [label] Option label
                     * @property {string|null} [value] Option value
                     * @property {string|null} [description] Option description
                     * @property {string|null} [emoji] Option emoji
                     * @property {boolean|null} ["default"] Option default
                     */

                    /**
                     * Constructs a new Option.
                     * @memberof langame.protobuf.Message.Component
                     * @classdesc Represents an Option.
                     * @implements IOption
                     * @constructor
                     * @param {langame.protobuf.Message.Component.IOption=} [properties] Properties to set
                     */
                    function Option(properties) {
                        if (properties)
                            for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                                if (properties[keys[i]] != null)
                                    this[keys[i]] = properties[keys[i]];
                    }

                    /**
                     * Option label.
                     * @member {string} label
                     * @memberof langame.protobuf.Message.Component.Option
                     * @instance
                     */
                    Option.prototype.label = "";

                    /**
                     * Option value.
                     * @member {string} value
                     * @memberof langame.protobuf.Message.Component.Option
                     * @instance
                     */
                    Option.prototype.value = "";

                    /**
                     * Option description.
                     * @member {string} description
                     * @memberof langame.protobuf.Message.Component.Option
                     * @instance
                     */
                    Option.prototype.description = "";

                    /**
                     * Option emoji.
                     * @member {string} emoji
                     * @memberof langame.protobuf.Message.Component.Option
                     * @instance
                     */
                    Option.prototype.emoji = "";

                    /**
                     * Option default.
                     * @member {boolean} default
                     * @memberof langame.protobuf.Message.Component.Option
                     * @instance
                     */
                    Option.prototype["default"] = false;

                    /**
                     * Creates a new Option instance using the specified properties.
                     * @function create
                     * @memberof langame.protobuf.Message.Component.Option
                     * @static
                     * @param {langame.protobuf.Message.Component.IOption=} [properties] Properties to set
                     * @returns {langame.protobuf.Message.Component.Option} Option instance
                     */
                    Option.create = function create(properties) {
                        return new Option(properties);
                    };

                    /**
                     * Encodes the specified Option message. Does not implicitly {@link langame.protobuf.Message.Component.Option.verify|verify} messages.
                     * @function encode
                     * @memberof langame.protobuf.Message.Component.Option
                     * @static
                     * @param {langame.protobuf.Message.Component.IOption} message Option message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Option.encode = function encode(message, writer) {
                        if (!writer)
                            writer = $Writer.create();
                        if (message.label != null && Object.hasOwnProperty.call(message, "label"))
                            writer.uint32(/* id 1, wireType 2 =*/10).string(message.label);
                        if (message.value != null && Object.hasOwnProperty.call(message, "value"))
                            writer.uint32(/* id 2, wireType 2 =*/18).string(message.value);
                        if (message.description != null && Object.hasOwnProperty.call(message, "description"))
                            writer.uint32(/* id 3, wireType 2 =*/26).string(message.description);
                        if (message.emoji != null && Object.hasOwnProperty.call(message, "emoji"))
                            writer.uint32(/* id 4, wireType 2 =*/34).string(message.emoji);
                        if (message["default"] != null && Object.hasOwnProperty.call(message, "default"))
                            writer.uint32(/* id 5, wireType 0 =*/40).bool(message["default"]);
                        return writer;
                    };

                    /**
                     * Encodes the specified Option message, length delimited. Does not implicitly {@link langame.protobuf.Message.Component.Option.verify|verify} messages.
                     * @function encodeDelimited
                     * @memberof langame.protobuf.Message.Component.Option
                     * @static
                     * @param {langame.protobuf.Message.Component.IOption} message Option message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Option.encodeDelimited = function encodeDelimited(message, writer) {
                        return this.encode(message, writer).ldelim();
                    };

                    /**
                     * Decodes an Option message from the specified reader or buffer.
                     * @function decode
                     * @memberof langame.protobuf.Message.Component.Option
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @param {number} [length] Message length if known beforehand
                     * @returns {langame.protobuf.Message.Component.Option} Option
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Option.decode = function decode(reader, length) {
                        if (!(reader instanceof $Reader))
                            reader = $Reader.create(reader);
                        var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Message.Component.Option();
                        while (reader.pos < end) {
                            var tag = reader.uint32();
                            switch (tag >>> 3) {
                            case 1:
                                message.label = reader.string();
                                break;
                            case 2:
                                message.value = reader.string();
                                break;
                            case 3:
                                message.description = reader.string();
                                break;
                            case 4:
                                message.emoji = reader.string();
                                break;
                            case 5:
                                message["default"] = reader.bool();
                                break;
                            default:
                                reader.skipType(tag & 7);
                                break;
                            }
                        }
                        return message;
                    };

                    /**
                     * Decodes an Option message from the specified reader or buffer, length delimited.
                     * @function decodeDelimited
                     * @memberof langame.protobuf.Message.Component.Option
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @returns {langame.protobuf.Message.Component.Option} Option
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Option.decodeDelimited = function decodeDelimited(reader) {
                        if (!(reader instanceof $Reader))
                            reader = new $Reader(reader);
                        return this.decode(reader, reader.uint32());
                    };

                    /**
                     * Verifies an Option message.
                     * @function verify
                     * @memberof langame.protobuf.Message.Component.Option
                     * @static
                     * @param {Object.<string,*>} message Plain object to verify
                     * @returns {string|null} `null` if valid, otherwise the reason why it is not
                     */
                    Option.verify = function verify(message) {
                        if (typeof message !== "object" || message === null)
                            return "object expected";
                        if (message.label != null && message.hasOwnProperty("label"))
                            if (!$util.isString(message.label))
                                return "label: string expected";
                        if (message.value != null && message.hasOwnProperty("value"))
                            if (!$util.isString(message.value))
                                return "value: string expected";
                        if (message.description != null && message.hasOwnProperty("description"))
                            if (!$util.isString(message.description))
                                return "description: string expected";
                        if (message.emoji != null && message.hasOwnProperty("emoji"))
                            if (!$util.isString(message.emoji))
                                return "emoji: string expected";
                        if (message["default"] != null && message.hasOwnProperty("default"))
                            if (typeof message["default"] !== "boolean")
                                return "default: boolean expected";
                        return null;
                    };

                    /**
                     * Creates an Option message from a plain object. Also converts values to their respective internal types.
                     * @function fromObject
                     * @memberof langame.protobuf.Message.Component.Option
                     * @static
                     * @param {Object.<string,*>} object Plain object
                     * @returns {langame.protobuf.Message.Component.Option} Option
                     */
                    Option.fromObject = function fromObject(object) {
                        if (object instanceof $root.langame.protobuf.Message.Component.Option)
                            return object;
                        var message = new $root.langame.protobuf.Message.Component.Option();
                        if (object.label != null)
                            message.label = String(object.label);
                        if (object.value != null)
                            message.value = String(object.value);
                        if (object.description != null)
                            message.description = String(object.description);
                        if (object.emoji != null)
                            message.emoji = String(object.emoji);
                        if (object["default"] != null)
                            message["default"] = Boolean(object["default"]);
                        return message;
                    };

                    /**
                     * Creates a plain object from an Option message. Also converts values to other types if specified.
                     * @function toObject
                     * @memberof langame.protobuf.Message.Component.Option
                     * @static
                     * @param {langame.protobuf.Message.Component.Option} message Option
                     * @param {$protobuf.IConversionOptions} [options] Conversion options
                     * @returns {Object.<string,*>} Plain object
                     */
                    Option.toObject = function toObject(message, options) {
                        if (!options)
                            options = {};
                        var object = {};
                        if (options.defaults) {
                            object.label = "";
                            object.value = "";
                            object.description = "";
                            object.emoji = "";
                            object["default"] = false;
                        }
                        if (message.label != null && message.hasOwnProperty("label"))
                            object.label = message.label;
                        if (message.value != null && message.hasOwnProperty("value"))
                            object.value = message.value;
                        if (message.description != null && message.hasOwnProperty("description"))
                            object.description = message.description;
                        if (message.emoji != null && message.hasOwnProperty("emoji"))
                            object.emoji = message.emoji;
                        if (message["default"] != null && message.hasOwnProperty("default"))
                            object["default"] = message["default"];
                        return object;
                    };

                    /**
                     * Converts this Option to JSON.
                     * @function toJSON
                     * @memberof langame.protobuf.Message.Component.Option
                     * @instance
                     * @returns {Object.<string,*>} JSON object
                     */
                    Option.prototype.toJSON = function toJSON() {
                        return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                    };

                    return Option;
                })();

                return Component;
            })();

            Message.Delivery = (function() {

                /**
                 * Properties of a Delivery.
                 * @memberof langame.protobuf.Message
                 * @interface IDelivery
                 * @property {number|null} [attempts] Delivery attempts
                 * @property {google.protobuf.ITimestamp|null} [endTime] Delivery endTime
                 * @property {string|null} [error] Delivery error
                 * @property {string|null} [status] Delivery status
                 */

                /**
                 * Constructs a new Delivery.
                 * @memberof langame.protobuf.Message
                 * @classdesc Represents a Delivery.
                 * @implements IDelivery
                 * @constructor
                 * @param {langame.protobuf.Message.IDelivery=} [properties] Properties to set
                 */
                function Delivery(properties) {
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * Delivery attempts.
                 * @member {number} attempts
                 * @memberof langame.protobuf.Message.Delivery
                 * @instance
                 */
                Delivery.prototype.attempts = 0;

                /**
                 * Delivery endTime.
                 * @member {google.protobuf.ITimestamp|null|undefined} endTime
                 * @memberof langame.protobuf.Message.Delivery
                 * @instance
                 */
                Delivery.prototype.endTime = null;

                /**
                 * Delivery error.
                 * @member {string} error
                 * @memberof langame.protobuf.Message.Delivery
                 * @instance
                 */
                Delivery.prototype.error = "";

                /**
                 * Delivery status.
                 * @member {string} status
                 * @memberof langame.protobuf.Message.Delivery
                 * @instance
                 */
                Delivery.prototype.status = "";

                /**
                 * Creates a new Delivery instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.Message.Delivery
                 * @static
                 * @param {langame.protobuf.Message.IDelivery=} [properties] Properties to set
                 * @returns {langame.protobuf.Message.Delivery} Delivery instance
                 */
                Delivery.create = function create(properties) {
                    return new Delivery(properties);
                };

                /**
                 * Encodes the specified Delivery message. Does not implicitly {@link langame.protobuf.Message.Delivery.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.Message.Delivery
                 * @static
                 * @param {langame.protobuf.Message.IDelivery} message Delivery message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Delivery.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.attempts != null && Object.hasOwnProperty.call(message, "attempts"))
                        writer.uint32(/* id 1, wireType 0 =*/8).uint32(message.attempts);
                    if (message.endTime != null && Object.hasOwnProperty.call(message, "endTime"))
                        $root.google.protobuf.Timestamp.encode(message.endTime, writer.uint32(/* id 2, wireType 2 =*/18).fork()).ldelim();
                    if (message.error != null && Object.hasOwnProperty.call(message, "error"))
                        writer.uint32(/* id 3, wireType 2 =*/26).string(message.error);
                    if (message.status != null && Object.hasOwnProperty.call(message, "status"))
                        writer.uint32(/* id 4, wireType 2 =*/34).string(message.status);
                    return writer;
                };

                /**
                 * Encodes the specified Delivery message, length delimited. Does not implicitly {@link langame.protobuf.Message.Delivery.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.Message.Delivery
                 * @static
                 * @param {langame.protobuf.Message.IDelivery} message Delivery message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Delivery.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes a Delivery message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.Message.Delivery
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.Message.Delivery} Delivery
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Delivery.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Message.Delivery();
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            message.attempts = reader.uint32();
                            break;
                        case 2:
                            message.endTime = $root.google.protobuf.Timestamp.decode(reader, reader.uint32());
                            break;
                        case 3:
                            message.error = reader.string();
                            break;
                        case 4:
                            message.status = reader.string();
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes a Delivery message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.Message.Delivery
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.Message.Delivery} Delivery
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Delivery.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies a Delivery message.
                 * @function verify
                 * @memberof langame.protobuf.Message.Delivery
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                Delivery.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.attempts != null && message.hasOwnProperty("attempts"))
                        if (!$util.isInteger(message.attempts))
                            return "attempts: integer expected";
                    if (message.endTime != null && message.hasOwnProperty("endTime")) {
                        var error = $root.google.protobuf.Timestamp.verify(message.endTime);
                        if (error)
                            return "endTime." + error;
                    }
                    if (message.error != null && message.hasOwnProperty("error"))
                        if (!$util.isString(message.error))
                            return "error: string expected";
                    if (message.status != null && message.hasOwnProperty("status"))
                        if (!$util.isString(message.status))
                            return "status: string expected";
                    return null;
                };

                /**
                 * Creates a Delivery message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.Message.Delivery
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.Message.Delivery} Delivery
                 */
                Delivery.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.Message.Delivery)
                        return object;
                    var message = new $root.langame.protobuf.Message.Delivery();
                    if (object.attempts != null)
                        message.attempts = object.attempts >>> 0;
                    if (object.endTime != null) {
                        if (typeof object.endTime !== "object")
                            throw TypeError(".langame.protobuf.Message.Delivery.endTime: object expected");
                        message.endTime = $root.google.protobuf.Timestamp.fromObject(object.endTime);
                    }
                    if (object.error != null)
                        message.error = String(object.error);
                    if (object.status != null)
                        message.status = String(object.status);
                    return message;
                };

                /**
                 * Creates a plain object from a Delivery message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.Message.Delivery
                 * @static
                 * @param {langame.protobuf.Message.Delivery} message Delivery
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                Delivery.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.defaults) {
                        object.attempts = 0;
                        object.endTime = null;
                        object.error = "";
                        object.status = "";
                    }
                    if (message.attempts != null && message.hasOwnProperty("attempts"))
                        object.attempts = message.attempts;
                    if (message.endTime != null && message.hasOwnProperty("endTime"))
                        object.endTime = $root.google.protobuf.Timestamp.toObject(message.endTime, options);
                    if (message.error != null && message.hasOwnProperty("error"))
                        object.error = message.error;
                    if (message.status != null && message.hasOwnProperty("status"))
                        object.status = message.status;
                    return object;
                };

                /**
                 * Converts this Delivery to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.Message.Delivery
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                Delivery.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                return Delivery;
            })();

            /**
             * Type enum.
             * @name langame.protobuf.Message.Type
             * @enum {number}
             * @property {number} INVITE=0 INVITE value
             * @property {number} MESSAGE=1 MESSAGE value
             */
            Message.Type = (function() {
                var valuesById = {}, values = Object.create(valuesById);
                values[valuesById[0] = "INVITE"] = 0;
                values[valuesById[1] = "MESSAGE"] = 1;
                return values;
            })();

            Message.Analysis = (function() {

                /**
                 * Properties of an Analysis.
                 * @memberof langame.protobuf.Message
                 * @interface IAnalysis
                 * @property {Array.<string>|null} [topics] Analysis topics
                 * @property {Array.<langame.protobuf.Message.Analysis.ISentiment>|null} [sentiments] Analysis sentiments
                 * @property {langame.protobuf.Message.Analysis.IError|null} [error] Analysis error
                 * @property {langame.protobuf.ContentFilter|null} [filter] Analysis filter
                 * @property {Array.<langame.protobuf.Message.Analysis.IToken>|null} [token] Analysis token
                 */

                /**
                 * Constructs a new Analysis.
                 * @memberof langame.protobuf.Message
                 * @classdesc Represents an Analysis.
                 * @implements IAnalysis
                 * @constructor
                 * @param {langame.protobuf.Message.IAnalysis=} [properties] Properties to set
                 */
                function Analysis(properties) {
                    this.topics = [];
                    this.sentiments = [];
                    this.token = [];
                    if (properties)
                        for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                            if (properties[keys[i]] != null)
                                this[keys[i]] = properties[keys[i]];
                }

                /**
                 * Analysis topics.
                 * @member {Array.<string>} topics
                 * @memberof langame.protobuf.Message.Analysis
                 * @instance
                 */
                Analysis.prototype.topics = $util.emptyArray;

                /**
                 * Analysis sentiments.
                 * @member {Array.<langame.protobuf.Message.Analysis.ISentiment>} sentiments
                 * @memberof langame.protobuf.Message.Analysis
                 * @instance
                 */
                Analysis.prototype.sentiments = $util.emptyArray;

                /**
                 * Analysis error.
                 * @member {langame.protobuf.Message.Analysis.IError|null|undefined} error
                 * @memberof langame.protobuf.Message.Analysis
                 * @instance
                 */
                Analysis.prototype.error = null;

                /**
                 * Analysis filter.
                 * @member {langame.protobuf.ContentFilter} filter
                 * @memberof langame.protobuf.Message.Analysis
                 * @instance
                 */
                Analysis.prototype.filter = 0;

                /**
                 * Analysis token.
                 * @member {Array.<langame.protobuf.Message.Analysis.IToken>} token
                 * @memberof langame.protobuf.Message.Analysis
                 * @instance
                 */
                Analysis.prototype.token = $util.emptyArray;

                /**
                 * Creates a new Analysis instance using the specified properties.
                 * @function create
                 * @memberof langame.protobuf.Message.Analysis
                 * @static
                 * @param {langame.protobuf.Message.IAnalysis=} [properties] Properties to set
                 * @returns {langame.protobuf.Message.Analysis} Analysis instance
                 */
                Analysis.create = function create(properties) {
                    return new Analysis(properties);
                };

                /**
                 * Encodes the specified Analysis message. Does not implicitly {@link langame.protobuf.Message.Analysis.verify|verify} messages.
                 * @function encode
                 * @memberof langame.protobuf.Message.Analysis
                 * @static
                 * @param {langame.protobuf.Message.IAnalysis} message Analysis message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Analysis.encode = function encode(message, writer) {
                    if (!writer)
                        writer = $Writer.create();
                    if (message.topics != null && message.topics.length)
                        for (var i = 0; i < message.topics.length; ++i)
                            writer.uint32(/* id 1, wireType 2 =*/10).string(message.topics[i]);
                    if (message.sentiments != null && message.sentiments.length)
                        for (var i = 0; i < message.sentiments.length; ++i)
                            $root.langame.protobuf.Message.Analysis.Sentiment.encode(message.sentiments[i], writer.uint32(/* id 2, wireType 2 =*/18).fork()).ldelim();
                    if (message.error != null && Object.hasOwnProperty.call(message, "error"))
                        $root.langame.protobuf.Message.Analysis.Error.encode(message.error, writer.uint32(/* id 3, wireType 2 =*/26).fork()).ldelim();
                    if (message.filter != null && Object.hasOwnProperty.call(message, "filter"))
                        writer.uint32(/* id 4, wireType 0 =*/32).int32(message.filter);
                    if (message.token != null && message.token.length)
                        for (var i = 0; i < message.token.length; ++i)
                            $root.langame.protobuf.Message.Analysis.Token.encode(message.token[i], writer.uint32(/* id 5, wireType 2 =*/42).fork()).ldelim();
                    return writer;
                };

                /**
                 * Encodes the specified Analysis message, length delimited. Does not implicitly {@link langame.protobuf.Message.Analysis.verify|verify} messages.
                 * @function encodeDelimited
                 * @memberof langame.protobuf.Message.Analysis
                 * @static
                 * @param {langame.protobuf.Message.IAnalysis} message Analysis message or plain object to encode
                 * @param {$protobuf.Writer} [writer] Writer to encode to
                 * @returns {$protobuf.Writer} Writer
                 */
                Analysis.encodeDelimited = function encodeDelimited(message, writer) {
                    return this.encode(message, writer).ldelim();
                };

                /**
                 * Decodes an Analysis message from the specified reader or buffer.
                 * @function decode
                 * @memberof langame.protobuf.Message.Analysis
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @param {number} [length] Message length if known beforehand
                 * @returns {langame.protobuf.Message.Analysis} Analysis
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Analysis.decode = function decode(reader, length) {
                    if (!(reader instanceof $Reader))
                        reader = $Reader.create(reader);
                    var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Message.Analysis();
                    while (reader.pos < end) {
                        var tag = reader.uint32();
                        switch (tag >>> 3) {
                        case 1:
                            if (!(message.topics && message.topics.length))
                                message.topics = [];
                            message.topics.push(reader.string());
                            break;
                        case 2:
                            if (!(message.sentiments && message.sentiments.length))
                                message.sentiments = [];
                            message.sentiments.push($root.langame.protobuf.Message.Analysis.Sentiment.decode(reader, reader.uint32()));
                            break;
                        case 3:
                            message.error = $root.langame.protobuf.Message.Analysis.Error.decode(reader, reader.uint32());
                            break;
                        case 4:
                            message.filter = reader.int32();
                            break;
                        case 5:
                            if (!(message.token && message.token.length))
                                message.token = [];
                            message.token.push($root.langame.protobuf.Message.Analysis.Token.decode(reader, reader.uint32()));
                            break;
                        default:
                            reader.skipType(tag & 7);
                            break;
                        }
                    }
                    return message;
                };

                /**
                 * Decodes an Analysis message from the specified reader or buffer, length delimited.
                 * @function decodeDelimited
                 * @memberof langame.protobuf.Message.Analysis
                 * @static
                 * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                 * @returns {langame.protobuf.Message.Analysis} Analysis
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                Analysis.decodeDelimited = function decodeDelimited(reader) {
                    if (!(reader instanceof $Reader))
                        reader = new $Reader(reader);
                    return this.decode(reader, reader.uint32());
                };

                /**
                 * Verifies an Analysis message.
                 * @function verify
                 * @memberof langame.protobuf.Message.Analysis
                 * @static
                 * @param {Object.<string,*>} message Plain object to verify
                 * @returns {string|null} `null` if valid, otherwise the reason why it is not
                 */
                Analysis.verify = function verify(message) {
                    if (typeof message !== "object" || message === null)
                        return "object expected";
                    if (message.topics != null && message.hasOwnProperty("topics")) {
                        if (!Array.isArray(message.topics))
                            return "topics: array expected";
                        for (var i = 0; i < message.topics.length; ++i)
                            if (!$util.isString(message.topics[i]))
                                return "topics: string[] expected";
                    }
                    if (message.sentiments != null && message.hasOwnProperty("sentiments")) {
                        if (!Array.isArray(message.sentiments))
                            return "sentiments: array expected";
                        for (var i = 0; i < message.sentiments.length; ++i) {
                            var error = $root.langame.protobuf.Message.Analysis.Sentiment.verify(message.sentiments[i]);
                            if (error)
                                return "sentiments." + error;
                        }
                    }
                    if (message.error != null && message.hasOwnProperty("error")) {
                        var error = $root.langame.protobuf.Message.Analysis.Error.verify(message.error);
                        if (error)
                            return "error." + error;
                    }
                    if (message.filter != null && message.hasOwnProperty("filter"))
                        switch (message.filter) {
                        default:
                            return "filter: enum value expected";
                        case 0:
                        case 1:
                        case 2:
                            break;
                        }
                    if (message.token != null && message.hasOwnProperty("token")) {
                        if (!Array.isArray(message.token))
                            return "token: array expected";
                        for (var i = 0; i < message.token.length; ++i) {
                            var error = $root.langame.protobuf.Message.Analysis.Token.verify(message.token[i]);
                            if (error)
                                return "token." + error;
                        }
                    }
                    return null;
                };

                /**
                 * Creates an Analysis message from a plain object. Also converts values to their respective internal types.
                 * @function fromObject
                 * @memberof langame.protobuf.Message.Analysis
                 * @static
                 * @param {Object.<string,*>} object Plain object
                 * @returns {langame.protobuf.Message.Analysis} Analysis
                 */
                Analysis.fromObject = function fromObject(object) {
                    if (object instanceof $root.langame.protobuf.Message.Analysis)
                        return object;
                    var message = new $root.langame.protobuf.Message.Analysis();
                    if (object.topics) {
                        if (!Array.isArray(object.topics))
                            throw TypeError(".langame.protobuf.Message.Analysis.topics: array expected");
                        message.topics = [];
                        for (var i = 0; i < object.topics.length; ++i)
                            message.topics[i] = String(object.topics[i]);
                    }
                    if (object.sentiments) {
                        if (!Array.isArray(object.sentiments))
                            throw TypeError(".langame.protobuf.Message.Analysis.sentiments: array expected");
                        message.sentiments = [];
                        for (var i = 0; i < object.sentiments.length; ++i) {
                            if (typeof object.sentiments[i] !== "object")
                                throw TypeError(".langame.protobuf.Message.Analysis.sentiments: object expected");
                            message.sentiments[i] = $root.langame.protobuf.Message.Analysis.Sentiment.fromObject(object.sentiments[i]);
                        }
                    }
                    if (object.error != null) {
                        if (typeof object.error !== "object")
                            throw TypeError(".langame.protobuf.Message.Analysis.error: object expected");
                        message.error = $root.langame.protobuf.Message.Analysis.Error.fromObject(object.error);
                    }
                    switch (object.filter) {
                    case "Safe":
                    case 0:
                        message.filter = 0;
                        break;
                    case "Sensitive":
                    case 1:
                        message.filter = 1;
                        break;
                    case "Unsafe":
                    case 2:
                        message.filter = 2;
                        break;
                    }
                    if (object.token) {
                        if (!Array.isArray(object.token))
                            throw TypeError(".langame.protobuf.Message.Analysis.token: array expected");
                        message.token = [];
                        for (var i = 0; i < object.token.length; ++i) {
                            if (typeof object.token[i] !== "object")
                                throw TypeError(".langame.protobuf.Message.Analysis.token: object expected");
                            message.token[i] = $root.langame.protobuf.Message.Analysis.Token.fromObject(object.token[i]);
                        }
                    }
                    return message;
                };

                /**
                 * Creates a plain object from an Analysis message. Also converts values to other types if specified.
                 * @function toObject
                 * @memberof langame.protobuf.Message.Analysis
                 * @static
                 * @param {langame.protobuf.Message.Analysis} message Analysis
                 * @param {$protobuf.IConversionOptions} [options] Conversion options
                 * @returns {Object.<string,*>} Plain object
                 */
                Analysis.toObject = function toObject(message, options) {
                    if (!options)
                        options = {};
                    var object = {};
                    if (options.arrays || options.defaults) {
                        object.topics = [];
                        object.sentiments = [];
                        object.token = [];
                    }
                    if (options.defaults) {
                        object.error = null;
                        object.filter = options.enums === String ? "Safe" : 0;
                    }
                    if (message.topics && message.topics.length) {
                        object.topics = [];
                        for (var j = 0; j < message.topics.length; ++j)
                            object.topics[j] = message.topics[j];
                    }
                    if (message.sentiments && message.sentiments.length) {
                        object.sentiments = [];
                        for (var j = 0; j < message.sentiments.length; ++j)
                            object.sentiments[j] = $root.langame.protobuf.Message.Analysis.Sentiment.toObject(message.sentiments[j], options);
                    }
                    if (message.error != null && message.hasOwnProperty("error"))
                        object.error = $root.langame.protobuf.Message.Analysis.Error.toObject(message.error, options);
                    if (message.filter != null && message.hasOwnProperty("filter"))
                        object.filter = options.enums === String ? $root.langame.protobuf.ContentFilter[message.filter] : message.filter;
                    if (message.token && message.token.length) {
                        object.token = [];
                        for (var j = 0; j < message.token.length; ++j)
                            object.token[j] = $root.langame.protobuf.Message.Analysis.Token.toObject(message.token[j], options);
                    }
                    return object;
                };

                /**
                 * Converts this Analysis to JSON.
                 * @function toJSON
                 * @memberof langame.protobuf.Message.Analysis
                 * @instance
                 * @returns {Object.<string,*>} JSON object
                 */
                Analysis.prototype.toJSON = function toJSON() {
                    return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                };

                Analysis.Error = (function() {

                    /**
                     * Properties of an Error.
                     * @memberof langame.protobuf.Message.Analysis
                     * @interface IError
                     * @property {string|null} [developerMessage] Error developerMessage
                     * @property {number|null} [tries] Error tries
                     */

                    /**
                     * Constructs a new Error.
                     * @memberof langame.protobuf.Message.Analysis
                     * @classdesc Represents an Error.
                     * @implements IError
                     * @constructor
                     * @param {langame.protobuf.Message.Analysis.IError=} [properties] Properties to set
                     */
                    function Error(properties) {
                        if (properties)
                            for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                                if (properties[keys[i]] != null)
                                    this[keys[i]] = properties[keys[i]];
                    }

                    /**
                     * Error developerMessage.
                     * @member {string} developerMessage
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @instance
                     */
                    Error.prototype.developerMessage = "";

                    /**
                     * Error tries.
                     * @member {number} tries
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @instance
                     */
                    Error.prototype.tries = 0;

                    /**
                     * Creates a new Error instance using the specified properties.
                     * @function create
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @static
                     * @param {langame.protobuf.Message.Analysis.IError=} [properties] Properties to set
                     * @returns {langame.protobuf.Message.Analysis.Error} Error instance
                     */
                    Error.create = function create(properties) {
                        return new Error(properties);
                    };

                    /**
                     * Encodes the specified Error message. Does not implicitly {@link langame.protobuf.Message.Analysis.Error.verify|verify} messages.
                     * @function encode
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @static
                     * @param {langame.protobuf.Message.Analysis.IError} message Error message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Error.encode = function encode(message, writer) {
                        if (!writer)
                            writer = $Writer.create();
                        if (message.developerMessage != null && Object.hasOwnProperty.call(message, "developerMessage"))
                            writer.uint32(/* id 1, wireType 2 =*/10).string(message.developerMessage);
                        if (message.tries != null && Object.hasOwnProperty.call(message, "tries"))
                            writer.uint32(/* id 2, wireType 0 =*/16).int32(message.tries);
                        return writer;
                    };

                    /**
                     * Encodes the specified Error message, length delimited. Does not implicitly {@link langame.protobuf.Message.Analysis.Error.verify|verify} messages.
                     * @function encodeDelimited
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @static
                     * @param {langame.protobuf.Message.Analysis.IError} message Error message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Error.encodeDelimited = function encodeDelimited(message, writer) {
                        return this.encode(message, writer).ldelim();
                    };

                    /**
                     * Decodes an Error message from the specified reader or buffer.
                     * @function decode
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @param {number} [length] Message length if known beforehand
                     * @returns {langame.protobuf.Message.Analysis.Error} Error
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Error.decode = function decode(reader, length) {
                        if (!(reader instanceof $Reader))
                            reader = $Reader.create(reader);
                        var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Message.Analysis.Error();
                        while (reader.pos < end) {
                            var tag = reader.uint32();
                            switch (tag >>> 3) {
                            case 1:
                                message.developerMessage = reader.string();
                                break;
                            case 2:
                                message.tries = reader.int32();
                                break;
                            default:
                                reader.skipType(tag & 7);
                                break;
                            }
                        }
                        return message;
                    };

                    /**
                     * Decodes an Error message from the specified reader or buffer, length delimited.
                     * @function decodeDelimited
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @returns {langame.protobuf.Message.Analysis.Error} Error
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Error.decodeDelimited = function decodeDelimited(reader) {
                        if (!(reader instanceof $Reader))
                            reader = new $Reader(reader);
                        return this.decode(reader, reader.uint32());
                    };

                    /**
                     * Verifies an Error message.
                     * @function verify
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @static
                     * @param {Object.<string,*>} message Plain object to verify
                     * @returns {string|null} `null` if valid, otherwise the reason why it is not
                     */
                    Error.verify = function verify(message) {
                        if (typeof message !== "object" || message === null)
                            return "object expected";
                        if (message.developerMessage != null && message.hasOwnProperty("developerMessage"))
                            if (!$util.isString(message.developerMessage))
                                return "developerMessage: string expected";
                        if (message.tries != null && message.hasOwnProperty("tries"))
                            if (!$util.isInteger(message.tries))
                                return "tries: integer expected";
                        return null;
                    };

                    /**
                     * Creates an Error message from a plain object. Also converts values to their respective internal types.
                     * @function fromObject
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @static
                     * @param {Object.<string,*>} object Plain object
                     * @returns {langame.protobuf.Message.Analysis.Error} Error
                     */
                    Error.fromObject = function fromObject(object) {
                        if (object instanceof $root.langame.protobuf.Message.Analysis.Error)
                            return object;
                        var message = new $root.langame.protobuf.Message.Analysis.Error();
                        if (object.developerMessage != null)
                            message.developerMessage = String(object.developerMessage);
                        if (object.tries != null)
                            message.tries = object.tries | 0;
                        return message;
                    };

                    /**
                     * Creates a plain object from an Error message. Also converts values to other types if specified.
                     * @function toObject
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @static
                     * @param {langame.protobuf.Message.Analysis.Error} message Error
                     * @param {$protobuf.IConversionOptions} [options] Conversion options
                     * @returns {Object.<string,*>} Plain object
                     */
                    Error.toObject = function toObject(message, options) {
                        if (!options)
                            options = {};
                        var object = {};
                        if (options.defaults) {
                            object.developerMessage = "";
                            object.tries = 0;
                        }
                        if (message.developerMessage != null && message.hasOwnProperty("developerMessage"))
                            object.developerMessage = message.developerMessage;
                        if (message.tries != null && message.hasOwnProperty("tries"))
                            object.tries = message.tries;
                        return object;
                    };

                    /**
                     * Converts this Error to JSON.
                     * @function toJSON
                     * @memberof langame.protobuf.Message.Analysis.Error
                     * @instance
                     * @returns {Object.<string,*>} JSON object
                     */
                    Error.prototype.toJSON = function toJSON() {
                        return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                    };

                    return Error;
                })();

                Analysis.Sentiment = (function() {

                    /**
                     * Properties of a Sentiment.
                     * @memberof langame.protobuf.Message.Analysis
                     * @interface ISentiment
                     * @property {number|null} [score] Sentiment score
                     * @property {string|null} [label] Sentiment label
                     */

                    /**
                     * Constructs a new Sentiment.
                     * @memberof langame.protobuf.Message.Analysis
                     * @classdesc Represents a Sentiment.
                     * @implements ISentiment
                     * @constructor
                     * @param {langame.protobuf.Message.Analysis.ISentiment=} [properties] Properties to set
                     */
                    function Sentiment(properties) {
                        if (properties)
                            for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                                if (properties[keys[i]] != null)
                                    this[keys[i]] = properties[keys[i]];
                    }

                    /**
                     * Sentiment score.
                     * @member {number} score
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @instance
                     */
                    Sentiment.prototype.score = 0;

                    /**
                     * Sentiment label.
                     * @member {string} label
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @instance
                     */
                    Sentiment.prototype.label = "";

                    /**
                     * Creates a new Sentiment instance using the specified properties.
                     * @function create
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @static
                     * @param {langame.protobuf.Message.Analysis.ISentiment=} [properties] Properties to set
                     * @returns {langame.protobuf.Message.Analysis.Sentiment} Sentiment instance
                     */
                    Sentiment.create = function create(properties) {
                        return new Sentiment(properties);
                    };

                    /**
                     * Encodes the specified Sentiment message. Does not implicitly {@link langame.protobuf.Message.Analysis.Sentiment.verify|verify} messages.
                     * @function encode
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @static
                     * @param {langame.protobuf.Message.Analysis.ISentiment} message Sentiment message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Sentiment.encode = function encode(message, writer) {
                        if (!writer)
                            writer = $Writer.create();
                        if (message.score != null && Object.hasOwnProperty.call(message, "score"))
                            writer.uint32(/* id 1, wireType 5 =*/13).float(message.score);
                        if (message.label != null && Object.hasOwnProperty.call(message, "label"))
                            writer.uint32(/* id 2, wireType 2 =*/18).string(message.label);
                        return writer;
                    };

                    /**
                     * Encodes the specified Sentiment message, length delimited. Does not implicitly {@link langame.protobuf.Message.Analysis.Sentiment.verify|verify} messages.
                     * @function encodeDelimited
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @static
                     * @param {langame.protobuf.Message.Analysis.ISentiment} message Sentiment message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Sentiment.encodeDelimited = function encodeDelimited(message, writer) {
                        return this.encode(message, writer).ldelim();
                    };

                    /**
                     * Decodes a Sentiment message from the specified reader or buffer.
                     * @function decode
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @param {number} [length] Message length if known beforehand
                     * @returns {langame.protobuf.Message.Analysis.Sentiment} Sentiment
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Sentiment.decode = function decode(reader, length) {
                        if (!(reader instanceof $Reader))
                            reader = $Reader.create(reader);
                        var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Message.Analysis.Sentiment();
                        while (reader.pos < end) {
                            var tag = reader.uint32();
                            switch (tag >>> 3) {
                            case 1:
                                message.score = reader.float();
                                break;
                            case 2:
                                message.label = reader.string();
                                break;
                            default:
                                reader.skipType(tag & 7);
                                break;
                            }
                        }
                        return message;
                    };

                    /**
                     * Decodes a Sentiment message from the specified reader or buffer, length delimited.
                     * @function decodeDelimited
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @returns {langame.protobuf.Message.Analysis.Sentiment} Sentiment
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Sentiment.decodeDelimited = function decodeDelimited(reader) {
                        if (!(reader instanceof $Reader))
                            reader = new $Reader(reader);
                        return this.decode(reader, reader.uint32());
                    };

                    /**
                     * Verifies a Sentiment message.
                     * @function verify
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @static
                     * @param {Object.<string,*>} message Plain object to verify
                     * @returns {string|null} `null` if valid, otherwise the reason why it is not
                     */
                    Sentiment.verify = function verify(message) {
                        if (typeof message !== "object" || message === null)
                            return "object expected";
                        if (message.score != null && message.hasOwnProperty("score"))
                            if (typeof message.score !== "number")
                                return "score: number expected";
                        if (message.label != null && message.hasOwnProperty("label"))
                            if (!$util.isString(message.label))
                                return "label: string expected";
                        return null;
                    };

                    /**
                     * Creates a Sentiment message from a plain object. Also converts values to their respective internal types.
                     * @function fromObject
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @static
                     * @param {Object.<string,*>} object Plain object
                     * @returns {langame.protobuf.Message.Analysis.Sentiment} Sentiment
                     */
                    Sentiment.fromObject = function fromObject(object) {
                        if (object instanceof $root.langame.protobuf.Message.Analysis.Sentiment)
                            return object;
                        var message = new $root.langame.protobuf.Message.Analysis.Sentiment();
                        if (object.score != null)
                            message.score = Number(object.score);
                        if (object.label != null)
                            message.label = String(object.label);
                        return message;
                    };

                    /**
                     * Creates a plain object from a Sentiment message. Also converts values to other types if specified.
                     * @function toObject
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @static
                     * @param {langame.protobuf.Message.Analysis.Sentiment} message Sentiment
                     * @param {$protobuf.IConversionOptions} [options] Conversion options
                     * @returns {Object.<string,*>} Plain object
                     */
                    Sentiment.toObject = function toObject(message, options) {
                        if (!options)
                            options = {};
                        var object = {};
                        if (options.defaults) {
                            object.score = 0;
                            object.label = "";
                        }
                        if (message.score != null && message.hasOwnProperty("score"))
                            object.score = options.json && !isFinite(message.score) ? String(message.score) : message.score;
                        if (message.label != null && message.hasOwnProperty("label"))
                            object.label = message.label;
                        return object;
                    };

                    /**
                     * Converts this Sentiment to JSON.
                     * @function toJSON
                     * @memberof langame.protobuf.Message.Analysis.Sentiment
                     * @instance
                     * @returns {Object.<string,*>} JSON object
                     */
                    Sentiment.prototype.toJSON = function toJSON() {
                        return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                    };

                    return Sentiment;
                })();

                Analysis.Token = (function() {

                    /**
                     * Properties of a Token.
                     * @memberof langame.protobuf.Message.Analysis
                     * @interface IToken
                     * @property {number|null} [start] Token start
                     * @property {number|null} [end] Token end
                     * @property {string|null} [word] Token word
                     * @property {string|null} [entityGroup] Token entityGroup
                     * @property {number|null} [score] Token score
                     */

                    /**
                     * Constructs a new Token.
                     * @memberof langame.protobuf.Message.Analysis
                     * @classdesc Represents a Token.
                     * @implements IToken
                     * @constructor
                     * @param {langame.protobuf.Message.Analysis.IToken=} [properties] Properties to set
                     */
                    function Token(properties) {
                        if (properties)
                            for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                                if (properties[keys[i]] != null)
                                    this[keys[i]] = properties[keys[i]];
                    }

                    /**
                     * Token start.
                     * @member {number} start
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @instance
                     */
                    Token.prototype.start = 0;

                    /**
                     * Token end.
                     * @member {number} end
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @instance
                     */
                    Token.prototype.end = 0;

                    /**
                     * Token word.
                     * @member {string} word
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @instance
                     */
                    Token.prototype.word = "";

                    /**
                     * Token entityGroup.
                     * @member {string} entityGroup
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @instance
                     */
                    Token.prototype.entityGroup = "";

                    /**
                     * Token score.
                     * @member {number} score
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @instance
                     */
                    Token.prototype.score = 0;

                    /**
                     * Creates a new Token instance using the specified properties.
                     * @function create
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @static
                     * @param {langame.protobuf.Message.Analysis.IToken=} [properties] Properties to set
                     * @returns {langame.protobuf.Message.Analysis.Token} Token instance
                     */
                    Token.create = function create(properties) {
                        return new Token(properties);
                    };

                    /**
                     * Encodes the specified Token message. Does not implicitly {@link langame.protobuf.Message.Analysis.Token.verify|verify} messages.
                     * @function encode
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @static
                     * @param {langame.protobuf.Message.Analysis.IToken} message Token message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Token.encode = function encode(message, writer) {
                        if (!writer)
                            writer = $Writer.create();
                        if (message.start != null && Object.hasOwnProperty.call(message, "start"))
                            writer.uint32(/* id 1, wireType 0 =*/8).uint32(message.start);
                        if (message.end != null && Object.hasOwnProperty.call(message, "end"))
                            writer.uint32(/* id 2, wireType 0 =*/16).uint32(message.end);
                        if (message.word != null && Object.hasOwnProperty.call(message, "word"))
                            writer.uint32(/* id 3, wireType 2 =*/26).string(message.word);
                        if (message.entityGroup != null && Object.hasOwnProperty.call(message, "entityGroup"))
                            writer.uint32(/* id 4, wireType 2 =*/34).string(message.entityGroup);
                        if (message.score != null && Object.hasOwnProperty.call(message, "score"))
                            writer.uint32(/* id 5, wireType 5 =*/45).float(message.score);
                        return writer;
                    };

                    /**
                     * Encodes the specified Token message, length delimited. Does not implicitly {@link langame.protobuf.Message.Analysis.Token.verify|verify} messages.
                     * @function encodeDelimited
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @static
                     * @param {langame.protobuf.Message.Analysis.IToken} message Token message or plain object to encode
                     * @param {$protobuf.Writer} [writer] Writer to encode to
                     * @returns {$protobuf.Writer} Writer
                     */
                    Token.encodeDelimited = function encodeDelimited(message, writer) {
                        return this.encode(message, writer).ldelim();
                    };

                    /**
                     * Decodes a Token message from the specified reader or buffer.
                     * @function decode
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @param {number} [length] Message length if known beforehand
                     * @returns {langame.protobuf.Message.Analysis.Token} Token
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Token.decode = function decode(reader, length) {
                        if (!(reader instanceof $Reader))
                            reader = $Reader.create(reader);
                        var end = length === undefined ? reader.len : reader.pos + length, message = new $root.langame.protobuf.Message.Analysis.Token();
                        while (reader.pos < end) {
                            var tag = reader.uint32();
                            switch (tag >>> 3) {
                            case 1:
                                message.start = reader.uint32();
                                break;
                            case 2:
                                message.end = reader.uint32();
                                break;
                            case 3:
                                message.word = reader.string();
                                break;
                            case 4:
                                message.entityGroup = reader.string();
                                break;
                            case 5:
                                message.score = reader.float();
                                break;
                            default:
                                reader.skipType(tag & 7);
                                break;
                            }
                        }
                        return message;
                    };

                    /**
                     * Decodes a Token message from the specified reader or buffer, length delimited.
                     * @function decodeDelimited
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @static
                     * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
                     * @returns {langame.protobuf.Message.Analysis.Token} Token
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    Token.decodeDelimited = function decodeDelimited(reader) {
                        if (!(reader instanceof $Reader))
                            reader = new $Reader(reader);
                        return this.decode(reader, reader.uint32());
                    };

                    /**
                     * Verifies a Token message.
                     * @function verify
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @static
                     * @param {Object.<string,*>} message Plain object to verify
                     * @returns {string|null} `null` if valid, otherwise the reason why it is not
                     */
                    Token.verify = function verify(message) {
                        if (typeof message !== "object" || message === null)
                            return "object expected";
                        if (message.start != null && message.hasOwnProperty("start"))
                            if (!$util.isInteger(message.start))
                                return "start: integer expected";
                        if (message.end != null && message.hasOwnProperty("end"))
                            if (!$util.isInteger(message.end))
                                return "end: integer expected";
                        if (message.word != null && message.hasOwnProperty("word"))
                            if (!$util.isString(message.word))
                                return "word: string expected";
                        if (message.entityGroup != null && message.hasOwnProperty("entityGroup"))
                            if (!$util.isString(message.entityGroup))
                                return "entityGroup: string expected";
                        if (message.score != null && message.hasOwnProperty("score"))
                            if (typeof message.score !== "number")
                                return "score: number expected";
                        return null;
                    };

                    /**
                     * Creates a Token message from a plain object. Also converts values to their respective internal types.
                     * @function fromObject
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @static
                     * @param {Object.<string,*>} object Plain object
                     * @returns {langame.protobuf.Message.Analysis.Token} Token
                     */
                    Token.fromObject = function fromObject(object) {
                        if (object instanceof $root.langame.protobuf.Message.Analysis.Token)
                            return object;
                        var message = new $root.langame.protobuf.Message.Analysis.Token();
                        if (object.start != null)
                            message.start = object.start >>> 0;
                        if (object.end != null)
                            message.end = object.end >>> 0;
                        if (object.word != null)
                            message.word = String(object.word);
                        if (object.entityGroup != null)
                            message.entityGroup = String(object.entityGroup);
                        if (object.score != null)
                            message.score = Number(object.score);
                        return message;
                    };

                    /**
                     * Creates a plain object from a Token message. Also converts values to other types if specified.
                     * @function toObject
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @static
                     * @param {langame.protobuf.Message.Analysis.Token} message Token
                     * @param {$protobuf.IConversionOptions} [options] Conversion options
                     * @returns {Object.<string,*>} Plain object
                     */
                    Token.toObject = function toObject(message, options) {
                        if (!options)
                            options = {};
                        var object = {};
                        if (options.defaults) {
                            object.start = 0;
                            object.end = 0;
                            object.word = "";
                            object.entityGroup = "";
                            object.score = 0;
                        }
                        if (message.start != null && message.hasOwnProperty("start"))
                            object.start = message.start;
                        if (message.end != null && message.hasOwnProperty("end"))
                            object.end = message.end;
                        if (message.word != null && message.hasOwnProperty("word"))
                            object.word = message.word;
                        if (message.entityGroup != null && message.hasOwnProperty("entityGroup"))
                            object.entityGroup = message.entityGroup;
                        if (message.score != null && message.hasOwnProperty("score"))
                            object.score = options.json && !isFinite(message.score) ? String(message.score) : message.score;
                        return object;
                    };

                    /**
                     * Converts this Token to JSON.
                     * @function toJSON
                     * @memberof langame.protobuf.Message.Analysis.Token
                     * @instance
                     * @returns {Object.<string,*>} JSON object
                     */
                    Token.prototype.toJSON = function toJSON() {
                        return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
                    };

                    return Token;
                })();

                return Analysis;
            })();

            return Message;
        })();

        /**
         * ContentFilter enum.
         * @name langame.protobuf.ContentFilter
         * @enum {number}
         * @property {number} Safe=0 Safe value
         * @property {number} Sensitive=1 Sensitive value
         * @property {number} Unsafe=2 Unsafe value
         */
        protobuf.ContentFilter = (function() {
            var valuesById = {}, values = Object.create(valuesById);
            values[valuesById[0] = "Safe"] = 0;
            values[valuesById[1] = "Sensitive"] = 1;
            values[valuesById[2] = "Unsafe"] = 2;
            return values;
        })();

        return protobuf;
    })();

    return langame;
})();

$root.google = (function() {

    /**
     * Namespace google.
     * @exports google
     * @namespace
     */
    var google = {};

    google.protobuf = (function() {

        /**
         * Namespace protobuf.
         * @memberof google
         * @namespace
         */
        var protobuf = {};

        protobuf.Timestamp = (function() {

            /**
             * Properties of a Timestamp.
             * @memberof google.protobuf
             * @interface ITimestamp
             * @property {number|Long|null} [seconds] Timestamp seconds
             * @property {number|null} [nanos] Timestamp nanos
             */

            /**
             * Constructs a new Timestamp.
             * @memberof google.protobuf
             * @classdesc Represents a Timestamp.
             * @implements ITimestamp
             * @constructor
             * @param {google.protobuf.ITimestamp=} [properties] Properties to set
             */
            function Timestamp(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }

            /**
             * Timestamp seconds.
             * @member {number|Long} seconds
             * @memberof google.protobuf.Timestamp
             * @instance
             */
            Timestamp.prototype.seconds = $util.Long ? $util.Long.fromBits(0,0,false) : 0;

            /**
             * Timestamp nanos.
             * @member {number} nanos
             * @memberof google.protobuf.Timestamp
             * @instance
             */
            Timestamp.prototype.nanos = 0;

            /**
             * Creates a new Timestamp instance using the specified properties.
             * @function create
             * @memberof google.protobuf.Timestamp
             * @static
             * @param {google.protobuf.ITimestamp=} [properties] Properties to set
             * @returns {google.protobuf.Timestamp} Timestamp instance
             */
            Timestamp.create = function create(properties) {
                return new Timestamp(properties);
            };

            /**
             * Encodes the specified Timestamp message. Does not implicitly {@link google.protobuf.Timestamp.verify|verify} messages.
             * @function encode
             * @memberof google.protobuf.Timestamp
             * @static
             * @param {google.protobuf.ITimestamp} message Timestamp message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            Timestamp.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.seconds != null && Object.hasOwnProperty.call(message, "seconds"))
                    writer.uint32(/* id 1, wireType 0 =*/8).int64(message.seconds);
                if (message.nanos != null && Object.hasOwnProperty.call(message, "nanos"))
                    writer.uint32(/* id 2, wireType 0 =*/16).int32(message.nanos);
                return writer;
            };

            /**
             * Encodes the specified Timestamp message, length delimited. Does not implicitly {@link google.protobuf.Timestamp.verify|verify} messages.
             * @function encodeDelimited
             * @memberof google.protobuf.Timestamp
             * @static
             * @param {google.protobuf.ITimestamp} message Timestamp message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            Timestamp.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };

            /**
             * Decodes a Timestamp message from the specified reader or buffer.
             * @function decode
             * @memberof google.protobuf.Timestamp
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {google.protobuf.Timestamp} Timestamp
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            Timestamp.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.google.protobuf.Timestamp();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1:
                        message.seconds = reader.int64();
                        break;
                    case 2:
                        message.nanos = reader.int32();
                        break;
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };

            /**
             * Decodes a Timestamp message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof google.protobuf.Timestamp
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {google.protobuf.Timestamp} Timestamp
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            Timestamp.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };

            /**
             * Verifies a Timestamp message.
             * @function verify
             * @memberof google.protobuf.Timestamp
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            Timestamp.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.seconds != null && message.hasOwnProperty("seconds"))
                    if (!$util.isInteger(message.seconds) && !(message.seconds && $util.isInteger(message.seconds.low) && $util.isInteger(message.seconds.high)))
                        return "seconds: integer|Long expected";
                if (message.nanos != null && message.hasOwnProperty("nanos"))
                    if (!$util.isInteger(message.nanos))
                        return "nanos: integer expected";
                return null;
            };

            /**
             * Creates a Timestamp message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof google.protobuf.Timestamp
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {google.protobuf.Timestamp} Timestamp
             */
            Timestamp.fromObject = function fromObject(object) {
                if (object instanceof $root.google.protobuf.Timestamp)
                    return object;
                var message = new $root.google.protobuf.Timestamp();
                if (object.seconds != null)
                    if ($util.Long)
                        (message.seconds = $util.Long.fromValue(object.seconds)).unsigned = false;
                    else if (typeof object.seconds === "string")
                        message.seconds = parseInt(object.seconds, 10);
                    else if (typeof object.seconds === "number")
                        message.seconds = object.seconds;
                    else if (typeof object.seconds === "object")
                        message.seconds = new $util.LongBits(object.seconds.low >>> 0, object.seconds.high >>> 0).toNumber();
                if (object.nanos != null)
                    message.nanos = object.nanos | 0;
                return message;
            };

            /**
             * Creates a plain object from a Timestamp message. Also converts values to other types if specified.
             * @function toObject
             * @memberof google.protobuf.Timestamp
             * @static
             * @param {google.protobuf.Timestamp} message Timestamp
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            Timestamp.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.defaults) {
                    if ($util.Long) {
                        var long = new $util.Long(0, 0, false);
                        object.seconds = options.longs === String ? long.toString() : options.longs === Number ? long.toNumber() : long;
                    } else
                        object.seconds = options.longs === String ? "0" : 0;
                    object.nanos = 0;
                }
                if (message.seconds != null && message.hasOwnProperty("seconds"))
                    if (typeof message.seconds === "number")
                        object.seconds = options.longs === String ? String(message.seconds) : message.seconds;
                    else
                        object.seconds = options.longs === String ? $util.Long.prototype.toString.call(message.seconds) : options.longs === Number ? new $util.LongBits(message.seconds.low >>> 0, message.seconds.high >>> 0).toNumber() : message.seconds;
                if (message.nanos != null && message.hasOwnProperty("nanos"))
                    object.nanos = message.nanos;
                return object;
            };

            /**
             * Converts this Timestamp to JSON.
             * @function toJSON
             * @memberof google.protobuf.Timestamp
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            Timestamp.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };

            return Timestamp;
        })();

        return protobuf;
    })();

    return google;
})();

module.exports = $root;
