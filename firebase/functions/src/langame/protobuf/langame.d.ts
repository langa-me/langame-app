import * as $protobuf from "protobufjs";
/** Namespace langame. */
export namespace langame {

    /** Namespace protobuf. */
    namespace protobuf {

        /** Properties of an Error. */
        interface IError {

            /** Error developerMessage */
            developerMessage?: (string|null);

            /** Error createdAt */
            createdAt?: (google.protobuf.ITimestamp|null);

            /** Error code */
            code?: (string|null);

            /** Error userMessage */
            userMessage?: (string|null);
        }

        /** Represents an Error. */
        class Error implements IError {

            /**
             * Constructs a new Error.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.IError);

            /** Error developerMessage. */
            public developerMessage: string;

            /** Error createdAt. */
            public createdAt?: (google.protobuf.ITimestamp|null);

            /** Error code. */
            public code: string;

            /** Error userMessage. */
            public userMessage: string;

            /**
             * Creates a new Error instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Error instance
             */
            public static create(properties?: langame.protobuf.IError): langame.protobuf.Error;

            /**
             * Encodes the specified Error message. Does not implicitly {@link langame.protobuf.Error.verify|verify} messages.
             * @param message Error message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.IError, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Error message, length delimited. Does not implicitly {@link langame.protobuf.Error.verify|verify} messages.
             * @param message Error message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.IError, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes an Error message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Error
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Error;

            /**
             * Decodes an Error message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Error
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Error;

            /**
             * Verifies an Error message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates an Error message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Error
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Error;

            /**
             * Creates a plain object from an Error message. Also converts values to other types if specified.
             * @param message Error
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Error, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Error to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        /** Properties of a SeenMemes. */
        interface ISeenMemes {

            /** SeenMemes seen */
            seen?: (langame.protobuf.SeenMemes.ISeen|null);
        }

        /** Represents a SeenMemes. */
        class SeenMemes implements ISeenMemes {

            /**
             * Constructs a new SeenMemes.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.ISeenMemes);

            /** SeenMemes seen. */
            public seen?: (langame.protobuf.SeenMemes.ISeen|null);

            /**
             * Creates a new SeenMemes instance using the specified properties.
             * @param [properties] Properties to set
             * @returns SeenMemes instance
             */
            public static create(properties?: langame.protobuf.ISeenMemes): langame.protobuf.SeenMemes;

            /**
             * Encodes the specified SeenMemes message. Does not implicitly {@link langame.protobuf.SeenMemes.verify|verify} messages.
             * @param message SeenMemes message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.ISeenMemes, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified SeenMemes message, length delimited. Does not implicitly {@link langame.protobuf.SeenMemes.verify|verify} messages.
             * @param message SeenMemes message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.ISeenMemes, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a SeenMemes message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns SeenMemes
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.SeenMemes;

            /**
             * Decodes a SeenMemes message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns SeenMemes
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.SeenMemes;

            /**
             * Verifies a SeenMemes message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a SeenMemes message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns SeenMemes
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.SeenMemes;

            /**
             * Creates a plain object from a SeenMemes message. Also converts values to other types if specified.
             * @param message SeenMemes
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.SeenMemes, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this SeenMemes to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        namespace SeenMemes {

            /** Properties of a Seen. */
            interface ISeen {

                /** Seen s */
                s?: (langame.protobuf.SeenMemes.Seen.ISingle[]|null);
            }

            /** Represents a Seen. */
            class Seen implements ISeen {

                /**
                 * Constructs a new Seen.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.SeenMemes.ISeen);

                /** Seen s. */
                public s: langame.protobuf.SeenMemes.Seen.ISingle[];

                /**
                 * Creates a new Seen instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Seen instance
                 */
                public static create(properties?: langame.protobuf.SeenMemes.ISeen): langame.protobuf.SeenMemes.Seen;

                /**
                 * Encodes the specified Seen message. Does not implicitly {@link langame.protobuf.SeenMemes.Seen.verify|verify} messages.
                 * @param message Seen message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.SeenMemes.ISeen, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Seen message, length delimited. Does not implicitly {@link langame.protobuf.SeenMemes.Seen.verify|verify} messages.
                 * @param message Seen message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.SeenMemes.ISeen, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Seen message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Seen
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.SeenMemes.Seen;

                /**
                 * Decodes a Seen message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Seen
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.SeenMemes.Seen;

                /**
                 * Verifies a Seen message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Seen message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Seen
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.SeenMemes.Seen;

                /**
                 * Creates a plain object from a Seen message. Also converts values to other types if specified.
                 * @param message Seen
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.SeenMemes.Seen, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Seen to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            namespace Seen {

                /** Properties of a Single. */
                interface ISingle {

                    /** Single date */
                    date?: (google.protobuf.ITimestamp|null);

                    /** Single meme */
                    meme?: (string|null);
                }

                /** Represents a Single. */
                class Single implements ISingle {

                    /**
                     * Constructs a new Single.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.SeenMemes.Seen.ISingle);

                    /** Single date. */
                    public date?: (google.protobuf.ITimestamp|null);

                    /** Single meme. */
                    public meme: string;

                    /**
                     * Creates a new Single instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns Single instance
                     */
                    public static create(properties?: langame.protobuf.SeenMemes.Seen.ISingle): langame.protobuf.SeenMemes.Seen.Single;

                    /**
                     * Encodes the specified Single message. Does not implicitly {@link langame.protobuf.SeenMemes.Seen.Single.verify|verify} messages.
                     * @param message Single message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.SeenMemes.Seen.ISingle, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified Single message, length delimited. Does not implicitly {@link langame.protobuf.SeenMemes.Seen.Single.verify|verify} messages.
                     * @param message Single message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.SeenMemes.Seen.ISingle, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes a Single message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns Single
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.SeenMemes.Seen.Single;

                    /**
                     * Decodes a Single message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns Single
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.SeenMemes.Seen.Single;

                    /**
                     * Verifies a Single message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates a Single message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns Single
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.SeenMemes.Seen.Single;

                    /**
                     * Creates a plain object from a Single message. Also converts values to other types if specified.
                     * @param message Single
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.SeenMemes.Seen.Single, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this Single to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }
            }
        }

        /** Properties of a Meme. */
        interface IMeme {

            /** Meme createdAt */
            createdAt?: (google.protobuf.ITimestamp|null);

            /** Meme content */
            content?: (string|null);

            /** Meme topics */
            topics?: (string[]|null);

            /** Meme promptId */
            promptId?: (string|null);

            /** Meme translated */
            translated?: ({ [k: string]: string }|null);

            /** Meme id */
            id?: (string|null);

            /** Meme disabled */
            disabled?: (boolean|null);
        }

        /** Represents a Meme. */
        class Meme implements IMeme {

            /**
             * Constructs a new Meme.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.IMeme);

            /** Meme createdAt. */
            public createdAt?: (google.protobuf.ITimestamp|null);

            /** Meme content. */
            public content: string;

            /** Meme topics. */
            public topics: string[];

            /** Meme promptId. */
            public promptId: string;

            /** Meme translated. */
            public translated: { [k: string]: string };

            /** Meme id. */
            public id: string;

            /** Meme disabled. */
            public disabled: boolean;

            /**
             * Creates a new Meme instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Meme instance
             */
            public static create(properties?: langame.protobuf.IMeme): langame.protobuf.Meme;

            /**
             * Encodes the specified Meme message. Does not implicitly {@link langame.protobuf.Meme.verify|verify} messages.
             * @param message Meme message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.IMeme, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Meme message, length delimited. Does not implicitly {@link langame.protobuf.Meme.verify|verify} messages.
             * @param message Meme message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.IMeme, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Meme message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Meme
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Meme;

            /**
             * Decodes a Meme message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Meme
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Meme;

            /**
             * Verifies a Meme message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Meme message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Meme
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Meme;

            /**
             * Creates a plain object from a Meme message. Also converts values to other types if specified.
             * @param message Meme
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Meme, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Meme to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        /** Properties of a Tag. */
        interface ITag {

            /** Tag createdAt */
            createdAt?: (google.protobuf.ITimestamp|null);

            /** Tag topic */
            topic?: (langame.protobuf.Tag.ITopic|null);

            /** Tag classification */
            classification?: (langame.protobuf.Tag.IClassification|null);

            /** Tag engine */
            engine?: (langame.protobuf.Tag.IEngine|null);

            /** Tag feedback */
            feedback?: (langame.protobuf.Tag.IFeedback|null);

            /** Tag context */
            context?: (langame.protobuf.Tag.IContext|null);

            /** Tag aggregatedFeedback */
            aggregatedFeedback?: (langame.protobuf.Tag.IFeedback|null);
        }

        /** Represents a Tag. */
        class Tag implements ITag {

            /**
             * Constructs a new Tag.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.ITag);

            /** Tag createdAt. */
            public createdAt?: (google.protobuf.ITimestamp|null);

            /** Tag topic. */
            public topic?: (langame.protobuf.Tag.ITopic|null);

            /** Tag classification. */
            public classification?: (langame.protobuf.Tag.IClassification|null);

            /** Tag engine. */
            public engine?: (langame.protobuf.Tag.IEngine|null);

            /** Tag feedback. */
            public feedback?: (langame.protobuf.Tag.IFeedback|null);

            /** Tag context. */
            public context?: (langame.protobuf.Tag.IContext|null);

            /** Tag aggregatedFeedback. */
            public aggregatedFeedback?: (langame.protobuf.Tag.IFeedback|null);

            /** Tag type. */
            public type?: ("topic"|"classification"|"engine"|"feedback"|"context"|"aggregatedFeedback");

            /**
             * Creates a new Tag instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Tag instance
             */
            public static create(properties?: langame.protobuf.ITag): langame.protobuf.Tag;

            /**
             * Encodes the specified Tag message. Does not implicitly {@link langame.protobuf.Tag.verify|verify} messages.
             * @param message Tag message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.ITag, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Tag message, length delimited. Does not implicitly {@link langame.protobuf.Tag.verify|verify} messages.
             * @param message Tag message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.ITag, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Tag message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Tag
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag;

            /**
             * Decodes a Tag message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Tag
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag;

            /**
             * Verifies a Tag message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Tag message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Tag
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag;

            /**
             * Creates a plain object from a Tag message. Also converts values to other types if specified.
             * @param message Tag
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Tag, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Tag to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        namespace Tag {

            /** Properties of a Topic. */
            interface ITopic {

                /** Topic content */
                content?: (string|null);

                /** Topic emojis */
                emojis?: (string[]|null);
            }

            /** Represents a Topic. */
            class Topic implements ITopic {

                /**
                 * Constructs a new Topic.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Tag.ITopic);

                /** Topic content. */
                public content: string;

                /** Topic emojis. */
                public emojis: string[];

                /**
                 * Creates a new Topic instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Topic instance
                 */
                public static create(properties?: langame.protobuf.Tag.ITopic): langame.protobuf.Tag.Topic;

                /**
                 * Encodes the specified Topic message. Does not implicitly {@link langame.protobuf.Tag.Topic.verify|verify} messages.
                 * @param message Topic message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Tag.ITopic, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Topic message, length delimited. Does not implicitly {@link langame.protobuf.Tag.Topic.verify|verify} messages.
                 * @param message Topic message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Tag.ITopic, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Topic message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Topic
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag.Topic;

                /**
                 * Decodes a Topic message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Topic
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag.Topic;

                /**
                 * Verifies a Topic message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Topic message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Topic
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag.Topic;

                /**
                 * Creates a plain object from a Topic message. Also converts values to other types if specified.
                 * @param message Topic
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Tag.Topic, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Topic to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            /** Properties of a Classification. */
            interface IClassification {

                /** Classification content */
                content?: (string|null);

                /** Classification score */
                score?: (number|null);

                /** Classification human */
                human?: (boolean|null);
            }

            /** Represents a Classification. */
            class Classification implements IClassification {

                /**
                 * Constructs a new Classification.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Tag.IClassification);

                /** Classification content. */
                public content: string;

                /** Classification score. */
                public score: number;

                /** Classification human. */
                public human: boolean;

                /**
                 * Creates a new Classification instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Classification instance
                 */
                public static create(properties?: langame.protobuf.Tag.IClassification): langame.protobuf.Tag.Classification;

                /**
                 * Encodes the specified Classification message. Does not implicitly {@link langame.protobuf.Tag.Classification.verify|verify} messages.
                 * @param message Classification message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Tag.IClassification, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Classification message, length delimited. Does not implicitly {@link langame.protobuf.Tag.Classification.verify|verify} messages.
                 * @param message Classification message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Tag.IClassification, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Classification message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Classification
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag.Classification;

                /**
                 * Decodes a Classification message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Classification
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag.Classification;

                /**
                 * Verifies a Classification message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Classification message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Classification
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag.Classification;

                /**
                 * Creates a plain object from a Classification message. Also converts values to other types if specified.
                 * @param message Classification
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Tag.Classification, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Classification to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            /** Properties of an Engine. */
            interface IEngine {

                /** Engine parameters */
                parameters?: (langame.protobuf.Tag.Engine.IParameters|null);
            }

            /** Represents an Engine. */
            class Engine implements IEngine {

                /**
                 * Constructs a new Engine.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Tag.IEngine);

                /** Engine parameters. */
                public parameters?: (langame.protobuf.Tag.Engine.IParameters|null);

                /**
                 * Creates a new Engine instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Engine instance
                 */
                public static create(properties?: langame.protobuf.Tag.IEngine): langame.protobuf.Tag.Engine;

                /**
                 * Encodes the specified Engine message. Does not implicitly {@link langame.protobuf.Tag.Engine.verify|verify} messages.
                 * @param message Engine message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Tag.IEngine, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Engine message, length delimited. Does not implicitly {@link langame.protobuf.Tag.Engine.verify|verify} messages.
                 * @param message Engine message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Tag.IEngine, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes an Engine message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Engine
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag.Engine;

                /**
                 * Decodes an Engine message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Engine
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag.Engine;

                /**
                 * Verifies an Engine message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates an Engine message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Engine
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag.Engine;

                /**
                 * Creates a plain object from an Engine message. Also converts values to other types if specified.
                 * @param message Engine
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Tag.Engine, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Engine to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            namespace Engine {

                /** Properties of a Parameters. */
                interface IParameters {

                    /** Parameters temperature */
                    temperature?: (number|null);

                    /** Parameters maxTokens */
                    maxTokens?: (number|null);

                    /** Parameters topP */
                    topP?: (number|null);

                    /** Parameters frequencyPenalty */
                    frequencyPenalty?: (number|null);

                    /** Parameters presencePenalty */
                    presencePenalty?: (number|null);

                    /** Parameters stop */
                    stop?: (string[]|null);

                    /** Parameters model */
                    model?: (string|null);
                }

                /** Represents a Parameters. */
                class Parameters implements IParameters {

                    /**
                     * Constructs a new Parameters.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.Tag.Engine.IParameters);

                    /** Parameters temperature. */
                    public temperature: number;

                    /** Parameters maxTokens. */
                    public maxTokens: number;

                    /** Parameters topP. */
                    public topP: number;

                    /** Parameters frequencyPenalty. */
                    public frequencyPenalty: number;

                    /** Parameters presencePenalty. */
                    public presencePenalty: number;

                    /** Parameters stop. */
                    public stop: string[];

                    /** Parameters model. */
                    public model: string;

                    /**
                     * Creates a new Parameters instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns Parameters instance
                     */
                    public static create(properties?: langame.protobuf.Tag.Engine.IParameters): langame.protobuf.Tag.Engine.Parameters;

                    /**
                     * Encodes the specified Parameters message. Does not implicitly {@link langame.protobuf.Tag.Engine.Parameters.verify|verify} messages.
                     * @param message Parameters message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.Tag.Engine.IParameters, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified Parameters message, length delimited. Does not implicitly {@link langame.protobuf.Tag.Engine.Parameters.verify|verify} messages.
                     * @param message Parameters message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.Tag.Engine.IParameters, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes a Parameters message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns Parameters
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag.Engine.Parameters;

                    /**
                     * Decodes a Parameters message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns Parameters
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag.Engine.Parameters;

                    /**
                     * Verifies a Parameters message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates a Parameters message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns Parameters
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag.Engine.Parameters;

                    /**
                     * Creates a plain object from a Parameters message. Also converts values to other types if specified.
                     * @param message Parameters
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.Tag.Engine.Parameters, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this Parameters to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }
            }

            /** Properties of a Feedback. */
            interface IFeedback {

                /** Feedback userId */
                userId?: (string|null);

                /** Feedback general */
                general?: (langame.protobuf.Tag.Feedback.IGeneral|null);

                /** Feedback relevance */
                relevance?: (langame.protobuf.Tag.Feedback.IRelevance|null);
            }

            /** Represents a Feedback. */
            class Feedback implements IFeedback {

                /**
                 * Constructs a new Feedback.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Tag.IFeedback);

                /** Feedback userId. */
                public userId: string;

                /** Feedback general. */
                public general?: (langame.protobuf.Tag.Feedback.IGeneral|null);

                /** Feedback relevance. */
                public relevance?: (langame.protobuf.Tag.Feedback.IRelevance|null);

                /** Feedback type. */
                public type?: ("general"|"relevance");

                /**
                 * Creates a new Feedback instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Feedback instance
                 */
                public static create(properties?: langame.protobuf.Tag.IFeedback): langame.protobuf.Tag.Feedback;

                /**
                 * Encodes the specified Feedback message. Does not implicitly {@link langame.protobuf.Tag.Feedback.verify|verify} messages.
                 * @param message Feedback message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Tag.IFeedback, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Feedback message, length delimited. Does not implicitly {@link langame.protobuf.Tag.Feedback.verify|verify} messages.
                 * @param message Feedback message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Tag.IFeedback, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Feedback message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Feedback
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag.Feedback;

                /**
                 * Decodes a Feedback message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Feedback
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag.Feedback;

                /**
                 * Verifies a Feedback message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Feedback message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Feedback
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag.Feedback;

                /**
                 * Creates a plain object from a Feedback message. Also converts values to other types if specified.
                 * @param message Feedback
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Tag.Feedback, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Feedback to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            namespace Feedback {

                /** Properties of a General. */
                interface IGeneral {

                    /** General score */
                    score?: (number|null);
                }

                /** Represents a General. */
                class General implements IGeneral {

                    /**
                     * Constructs a new General.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.Tag.Feedback.IGeneral);

                    /** General score. */
                    public score: number;

                    /**
                     * Creates a new General instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns General instance
                     */
                    public static create(properties?: langame.protobuf.Tag.Feedback.IGeneral): langame.protobuf.Tag.Feedback.General;

                    /**
                     * Encodes the specified General message. Does not implicitly {@link langame.protobuf.Tag.Feedback.General.verify|verify} messages.
                     * @param message General message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.Tag.Feedback.IGeneral, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified General message, length delimited. Does not implicitly {@link langame.protobuf.Tag.Feedback.General.verify|verify} messages.
                     * @param message General message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.Tag.Feedback.IGeneral, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes a General message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns General
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag.Feedback.General;

                    /**
                     * Decodes a General message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns General
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag.Feedback.General;

                    /**
                     * Verifies a General message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates a General message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns General
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag.Feedback.General;

                    /**
                     * Creates a plain object from a General message. Also converts values to other types if specified.
                     * @param message General
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.Tag.Feedback.General, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this General to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }

                /** Properties of a Relevance. */
                interface IRelevance {

                    /** Relevance score */
                    score?: (number|null);
                }

                /** Represents a Relevance. */
                class Relevance implements IRelevance {

                    /**
                     * Constructs a new Relevance.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.Tag.Feedback.IRelevance);

                    /** Relevance score. */
                    public score: number;

                    /**
                     * Creates a new Relevance instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns Relevance instance
                     */
                    public static create(properties?: langame.protobuf.Tag.Feedback.IRelevance): langame.protobuf.Tag.Feedback.Relevance;

                    /**
                     * Encodes the specified Relevance message. Does not implicitly {@link langame.protobuf.Tag.Feedback.Relevance.verify|verify} messages.
                     * @param message Relevance message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.Tag.Feedback.IRelevance, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified Relevance message, length delimited. Does not implicitly {@link langame.protobuf.Tag.Feedback.Relevance.verify|verify} messages.
                     * @param message Relevance message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.Tag.Feedback.IRelevance, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes a Relevance message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns Relevance
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag.Feedback.Relevance;

                    /**
                     * Decodes a Relevance message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns Relevance
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag.Feedback.Relevance;

                    /**
                     * Verifies a Relevance message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates a Relevance message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns Relevance
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag.Feedback.Relevance;

                    /**
                     * Creates a plain object from a Relevance message. Also converts values to other types if specified.
                     * @param message Relevance
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.Tag.Feedback.Relevance, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this Relevance to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }
            }

            /** Properties of a Context. */
            interface IContext {

                /** Context content */
                content?: (string|null);

                /** Context type */
                type?: (langame.protobuf.Tag.Context.Type|null);
            }

            /** Represents a Context. */
            class Context implements IContext {

                /**
                 * Constructs a new Context.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Tag.IContext);

                /** Context content. */
                public content: string;

                /** Context type. */
                public type: langame.protobuf.Tag.Context.Type;

                /**
                 * Creates a new Context instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Context instance
                 */
                public static create(properties?: langame.protobuf.Tag.IContext): langame.protobuf.Tag.Context;

                /**
                 * Encodes the specified Context message. Does not implicitly {@link langame.protobuf.Tag.Context.verify|verify} messages.
                 * @param message Context message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Tag.IContext, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Context message, length delimited. Does not implicitly {@link langame.protobuf.Tag.Context.verify|verify} messages.
                 * @param message Context message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Tag.IContext, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Context message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Context
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag.Context;

                /**
                 * Decodes a Context message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Context
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag.Context;

                /**
                 * Verifies a Context message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Context message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Context
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag.Context;

                /**
                 * Creates a plain object from a Context message. Also converts values to other types if specified.
                 * @param message Context
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Tag.Context, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Context to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            namespace Context {

                /** Type enum. */
                enum Type {
                    WIKIPEDIA = 0,
                    OPENAI = 1
                }
            }
        }

        /** Properties of a User. */
        interface IUser {

            /** [uid] is set by Firebase authentication */
            uid?: (string|null);

            /** User email */
            email?: (string|null);

            /** User displayName */
            displayName?: (string|null);

            /** User phoneNumber */
            phoneNumber?: (string|null);

            /** User photoUrl */
            photoUrl?: (string|null);

            /** Is the user [online]? */
            online?: (boolean|null);

            /** Google account linked? */
            google?: (boolean|null);

            /** Apple account linked? */
            apple?: (boolean|null);

            /** Twitter-like [tag] i.e. @steveTheApple */
            tag?: (string|null);

            /** Device [tokens] used for Cloud Messaging */
            tokens?: (string[]|null);

            /** User latestInteractions */
            latestInteractions?: (string[]|null);

            /** User errors */
            errors?: (langame.protobuf.IError[]|null);

            /** User lastLogin */
            lastLogin?: (google.protobuf.ITimestamp|null);

            /** User lastLogout */
            lastLogout?: (google.protobuf.ITimestamp|null);

            /** User creationTime */
            creationTime?: (google.protobuf.ITimestamp|null);

            /** User disabled */
            disabled?: (boolean|null);

            /** User devices */
            devices?: (langame.protobuf.User.IDevice[]|null);

            /** User credits */
            credits?: (number|null);

            /** User role */
            role?: (string|null);
        }

        /** Represents a User. */
        class User implements IUser {

            /**
             * Constructs a new User.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.IUser);

            /** [uid] is set by Firebase authentication */
            public uid: string;

            /** User email. */
            public email: string;

            /** User displayName. */
            public displayName: string;

            /** User phoneNumber. */
            public phoneNumber: string;

            /** User photoUrl. */
            public photoUrl: string;

            /** Is the user [online]? */
            public online: boolean;

            /** Google account linked? */
            public google: boolean;

            /** Apple account linked? */
            public apple: boolean;

            /** Twitter-like [tag] i.e. @steveTheApple */
            public tag: string;

            /** Device [tokens] used for Cloud Messaging */
            public tokens: string[];

            /** User latestInteractions. */
            public latestInteractions: string[];

            /** User errors. */
            public errors: langame.protobuf.IError[];

            /** User lastLogin. */
            public lastLogin?: (google.protobuf.ITimestamp|null);

            /** User lastLogout. */
            public lastLogout?: (google.protobuf.ITimestamp|null);

            /** User creationTime. */
            public creationTime?: (google.protobuf.ITimestamp|null);

            /** User disabled. */
            public disabled: boolean;

            /** User devices. */
            public devices: langame.protobuf.User.IDevice[];

            /** User credits. */
            public credits: number;

            /** User role. */
            public role: string;

            /**
             * Creates a new User instance using the specified properties.
             * @param [properties] Properties to set
             * @returns User instance
             */
            public static create(properties?: langame.protobuf.IUser): langame.protobuf.User;

            /**
             * Encodes the specified User message. Does not implicitly {@link langame.protobuf.User.verify|verify} messages.
             * @param message User message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.IUser, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified User message, length delimited. Does not implicitly {@link langame.protobuf.User.verify|verify} messages.
             * @param message User message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.IUser, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a User message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns User
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.User;

            /**
             * Decodes a User message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns User
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.User;

            /**
             * Verifies a User message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a User message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns User
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.User;

            /**
             * Creates a plain object from a User message. Also converts values to other types if specified.
             * @param message User
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.User, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this User to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        namespace User {

            /** Properties of a Device. */
            interface IDevice {

                /** Device langameVersion */
                langameVersion?: (string|null);

                /** Device deviceInfo */
                deviceInfo?: (string|null);
            }

            /** Represents a Device. */
            class Device implements IDevice {

                /**
                 * Constructs a new Device.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.User.IDevice);

                /** Device langameVersion. */
                public langameVersion: string;

                /** Device deviceInfo. */
                public deviceInfo: string;

                /**
                 * Creates a new Device instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Device instance
                 */
                public static create(properties?: langame.protobuf.User.IDevice): langame.protobuf.User.Device;

                /**
                 * Encodes the specified Device message. Does not implicitly {@link langame.protobuf.User.Device.verify|verify} messages.
                 * @param message Device message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.User.IDevice, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Device message, length delimited. Does not implicitly {@link langame.protobuf.User.Device.verify|verify} messages.
                 * @param message Device message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.User.IDevice, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Device message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Device
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.User.Device;

                /**
                 * Decodes a Device message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Device
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.User.Device;

                /**
                 * Verifies a Device message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Device message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Device
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.User.Device;

                /**
                 * Creates a plain object from a Device message. Also converts values to other types if specified.
                 * @param message Device
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.User.Device, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Device to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }
        }

        /** InteractionLevel enum. */
        enum InteractionLevel {
            BAD = 0,
            AVERAGE = 1,
            GREAT = 2,
            LOVE = 3
        }

        /** Properties of a UserPreference. */
        interface IUserPreference {

            /** UserPreference userId */
            userId?: (string|null);

            /** UserPreference userRecommendations */
            userRecommendations?: (boolean|null);

            /** UserPreference themeIndex */
            themeIndex?: (number|null);

            /** UserPreference hasDoneOnBoarding */
            hasDoneOnBoarding?: (boolean|null);

            /** UserPreference userSearchHistory */
            userSearchHistory?: (string[]|null);

            /** UserPreference shakeToFeedback */
            shakeToFeedback?: (boolean|null);

            /** UserPreference favoriteTopics */
            favoriteTopics?: (string[]|null);

            /** UserPreference topicSearchHistory */
            topicSearchHistory?: (string[]|null);

            /** UserPreference errors */
            errors?: (langame.protobuf.IError[]|null);
        }

        /** Represents a UserPreference. */
        class UserPreference implements IUserPreference {

            /**
             * Constructs a new UserPreference.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.IUserPreference);

            /** UserPreference userId. */
            public userId: string;

            /** UserPreference userRecommendations. */
            public userRecommendations: boolean;

            /** UserPreference themeIndex. */
            public themeIndex: number;

            /** UserPreference hasDoneOnBoarding. */
            public hasDoneOnBoarding: boolean;

            /** UserPreference userSearchHistory. */
            public userSearchHistory: string[];

            /** UserPreference shakeToFeedback. */
            public shakeToFeedback: boolean;

            /** UserPreference favoriteTopics. */
            public favoriteTopics: string[];

            /** UserPreference topicSearchHistory. */
            public topicSearchHistory: string[];

            /** UserPreference errors. */
            public errors: langame.protobuf.IError[];

            /**
             * Creates a new UserPreference instance using the specified properties.
             * @param [properties] Properties to set
             * @returns UserPreference instance
             */
            public static create(properties?: langame.protobuf.IUserPreference): langame.protobuf.UserPreference;

            /**
             * Encodes the specified UserPreference message. Does not implicitly {@link langame.protobuf.UserPreference.verify|verify} messages.
             * @param message UserPreference message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.IUserPreference, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified UserPreference message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.verify|verify} messages.
             * @param message UserPreference message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.IUserPreference, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a UserPreference message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns UserPreference
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.UserPreference;

            /**
             * Decodes a UserPreference message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns UserPreference
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.UserPreference;

            /**
             * Verifies a UserPreference message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a UserPreference message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns UserPreference
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.UserPreference;

            /**
             * Creates a plain object from a UserPreference message. Also converts values to other types if specified.
             * @param message UserPreference
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.UserPreference, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this UserPreference to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        namespace UserPreference {

            /** Properties of a Notification. */
            interface INotification {

                /** Notification email */
                email?: (boolean|null);

                /** Notification push */
                push?: (boolean|null);
            }

            /** Represents a Notification. */
            class Notification implements INotification {

                /**
                 * Constructs a new Notification.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.UserPreference.INotification);

                /** Notification email. */
                public email: boolean;

                /** Notification push. */
                public push: boolean;

                /**
                 * Creates a new Notification instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Notification instance
                 */
                public static create(properties?: langame.protobuf.UserPreference.INotification): langame.protobuf.UserPreference.Notification;

                /**
                 * Encodes the specified Notification message. Does not implicitly {@link langame.protobuf.UserPreference.Notification.verify|verify} messages.
                 * @param message Notification message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.UserPreference.INotification, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Notification message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.Notification.verify|verify} messages.
                 * @param message Notification message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.UserPreference.INotification, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Notification message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Notification
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.UserPreference.Notification;

                /**
                 * Decodes a Notification message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Notification
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.UserPreference.Notification;

                /**
                 * Verifies a Notification message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Notification message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Notification
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.UserPreference.Notification;

                /**
                 * Creates a plain object from a Notification message. Also converts values to other types if specified.
                 * @param message Notification
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.UserPreference.Notification, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Notification to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }
        }

        /** Properties of a Langame. */
        interface ILangame {

            /** Langame channelName */
            channelName?: (string|null);

            /** Langame players */
            players?: (string[]|null);

            /** Langame topics */
            topics?: (string[]|null);

            /** Langame memes */
            memes?: (langame.protobuf.IMeme[]|null);

            /** Langame initiator */
            initiator?: (string|null);

            /** Langame done */
            done?: (google.protobuf.ITimestamp|null);

            /** Langame currentMeme */
            currentMeme?: (number|null);

            /** Langame date */
            date?: (google.protobuf.ITimestamp|null);

            /** Langame errors */
            errors?: (langame.protobuf.IError[]|null);

            /** Langame started */
            started?: (google.protobuf.ITimestamp|null);

            /** Langame nextMeme */
            nextMeme?: (google.protobuf.ITimestamp|null);

            /** Langame memesSeen */
            memesSeen?: (number|null);

            /** Langame memeChanged */
            memeChanged?: (google.protobuf.ITimestamp|null);

            /** Langame link */
            link?: (string|null);

            /** Langame reservedSpots */
            reservedSpots?: (string[]|null);

            /** Langame isLocked */
            isLocked?: (boolean|null);
        }

        /** Represents a Langame. */
        class Langame implements ILangame {

            /**
             * Constructs a new Langame.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.ILangame);

            /** Langame channelName. */
            public channelName: string;

            /** Langame players. */
            public players: string[];

            /** Langame topics. */
            public topics: string[];

            /** Langame memes. */
            public memes: langame.protobuf.IMeme[];

            /** Langame initiator. */
            public initiator: string;

            /** Langame done. */
            public done?: (google.protobuf.ITimestamp|null);

            /** Langame currentMeme. */
            public currentMeme: number;

            /** Langame date. */
            public date?: (google.protobuf.ITimestamp|null);

            /** Langame errors. */
            public errors: langame.protobuf.IError[];

            /** Langame started. */
            public started?: (google.protobuf.ITimestamp|null);

            /** Langame nextMeme. */
            public nextMeme?: (google.protobuf.ITimestamp|null);

            /** Langame memesSeen. */
            public memesSeen: number;

            /** Langame memeChanged. */
            public memeChanged?: (google.protobuf.ITimestamp|null);

            /** Langame link. */
            public link: string;

            /** Langame reservedSpots. */
            public reservedSpots: string[];

            /** Langame isLocked. */
            public isLocked: boolean;

            /**
             * Creates a new Langame instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Langame instance
             */
            public static create(properties?: langame.protobuf.ILangame): langame.protobuf.Langame;

            /**
             * Encodes the specified Langame message. Does not implicitly {@link langame.protobuf.Langame.verify|verify} messages.
             * @param message Langame message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.ILangame, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Langame message, length delimited. Does not implicitly {@link langame.protobuf.Langame.verify|verify} messages.
             * @param message Langame message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.ILangame, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Langame message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Langame
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Langame;

            /**
             * Decodes a Langame message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Langame
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Langame;

            /**
             * Verifies a Langame message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Langame message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Langame
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Langame;

            /**
             * Creates a plain object from a Langame message. Also converts values to other types if specified.
             * @param message Langame
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Langame, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Langame to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        /** Properties of a Player. */
        interface IPlayer {

            /** Player userId */
            userId?: (string|null);

            /** Player timeIn */
            timeIn?: (google.protobuf.ITimestamp|null);

            /** Player timeOut */
            timeOut?: (google.protobuf.ITimestamp|null);

            /** Player notes */
            notes?: (langame.protobuf.INote[]|null);

            /** Player audioId */
            audioId?: (number|null);

            /** Player audioToken */
            audioToken?: (string|null);

            /** Player errors */
            errors?: (langame.protobuf.IError[]|null);
        }

        /** Represents a Player. */
        class Player implements IPlayer {

            /**
             * Constructs a new Player.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.IPlayer);

            /** Player userId. */
            public userId: string;

            /** Player timeIn. */
            public timeIn?: (google.protobuf.ITimestamp|null);

            /** Player timeOut. */
            public timeOut?: (google.protobuf.ITimestamp|null);

            /** Player notes. */
            public notes: langame.protobuf.INote[];

            /** Player audioId. */
            public audioId: number;

            /** Player audioToken. */
            public audioToken: string;

            /** Player errors. */
            public errors: langame.protobuf.IError[];

            /**
             * Creates a new Player instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Player instance
             */
            public static create(properties?: langame.protobuf.IPlayer): langame.protobuf.Player;

            /**
             * Encodes the specified Player message. Does not implicitly {@link langame.protobuf.Player.verify|verify} messages.
             * @param message Player message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.IPlayer, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Player message, length delimited. Does not implicitly {@link langame.protobuf.Player.verify|verify} messages.
             * @param message Player message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.IPlayer, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Player message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Player
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Player;

            /**
             * Decodes a Player message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Player
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Player;

            /**
             * Verifies a Player message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Player message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Player
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Player;

            /**
             * Creates a plain object from a Player message. Also converts values to other types if specified.
             * @param message Player
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Player, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Player to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        /** Properties of a Note. */
        interface INote {

            /** Note createdAt */
            createdAt?: (google.protobuf.ITimestamp|null);

            /** Note generic */
            generic?: (langame.protobuf.Note.IGeneric|null);

            /** Note goal */
            goal?: (langame.protobuf.Note.IGoal|null);

            /** Note definition */
            definition?: (langame.protobuf.Note.IDefinition|null);
        }

        /** Represents a Note. */
        class Note implements INote {

            /**
             * Constructs a new Note.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.INote);

            /** Note createdAt. */
            public createdAt?: (google.protobuf.ITimestamp|null);

            /** Note generic. */
            public generic?: (langame.protobuf.Note.IGeneric|null);

            /** Note goal. */
            public goal?: (langame.protobuf.Note.IGoal|null);

            /** Note definition. */
            public definition?: (langame.protobuf.Note.IDefinition|null);

            /** Note type. */
            public type?: ("generic"|"goal"|"definition");

            /**
             * Creates a new Note instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Note instance
             */
            public static create(properties?: langame.protobuf.INote): langame.protobuf.Note;

            /**
             * Encodes the specified Note message. Does not implicitly {@link langame.protobuf.Note.verify|verify} messages.
             * @param message Note message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.INote, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Note message, length delimited. Does not implicitly {@link langame.protobuf.Note.verify|verify} messages.
             * @param message Note message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.INote, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Note message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Note
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Note;

            /**
             * Decodes a Note message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Note
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Note;

            /**
             * Verifies a Note message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Note message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Note
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Note;

            /**
             * Creates a plain object from a Note message. Also converts values to other types if specified.
             * @param message Note
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Note, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Note to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        namespace Note {

            /** Properties of a Generic. */
            interface IGeneric {

                /** Generic content */
                content?: (string|null);
            }

            /** Represents a Generic. */
            class Generic implements IGeneric {

                /**
                 * Constructs a new Generic.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Note.IGeneric);

                /** Generic content. */
                public content: string;

                /**
                 * Creates a new Generic instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Generic instance
                 */
                public static create(properties?: langame.protobuf.Note.IGeneric): langame.protobuf.Note.Generic;

                /**
                 * Encodes the specified Generic message. Does not implicitly {@link langame.protobuf.Note.Generic.verify|verify} messages.
                 * @param message Generic message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Note.IGeneric, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Generic message, length delimited. Does not implicitly {@link langame.protobuf.Note.Generic.verify|verify} messages.
                 * @param message Generic message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Note.IGeneric, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Generic message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Generic
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Note.Generic;

                /**
                 * Decodes a Generic message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Generic
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Note.Generic;

                /**
                 * Verifies a Generic message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Generic message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Generic
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Note.Generic;

                /**
                 * Creates a plain object from a Generic message. Also converts values to other types if specified.
                 * @param message Generic
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Note.Generic, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Generic to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            /** Properties of a Goal. */
            interface IGoal {

                /** Goal content */
                content?: (string|null);
            }

            /** Represents a Goal. */
            class Goal implements IGoal {

                /**
                 * Constructs a new Goal.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Note.IGoal);

                /** Goal content. */
                public content: string;

                /**
                 * Creates a new Goal instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Goal instance
                 */
                public static create(properties?: langame.protobuf.Note.IGoal): langame.protobuf.Note.Goal;

                /**
                 * Encodes the specified Goal message. Does not implicitly {@link langame.protobuf.Note.Goal.verify|verify} messages.
                 * @param message Goal message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Note.IGoal, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Goal message, length delimited. Does not implicitly {@link langame.protobuf.Note.Goal.verify|verify} messages.
                 * @param message Goal message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Note.IGoal, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Goal message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Goal
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Note.Goal;

                /**
                 * Decodes a Goal message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Goal
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Note.Goal;

                /**
                 * Verifies a Goal message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Goal message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Goal
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Note.Goal;

                /**
                 * Creates a plain object from a Goal message. Also converts values to other types if specified.
                 * @param message Goal
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Note.Goal, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Goal to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            /** Properties of a Definition. */
            interface IDefinition {

                /** Definition content */
                content?: (string|null);
            }

            /** Represents a Definition. */
            class Definition implements IDefinition {

                /**
                 * Constructs a new Definition.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Note.IDefinition);

                /** Definition content. */
                public content: string;

                /**
                 * Creates a new Definition instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Definition instance
                 */
                public static create(properties?: langame.protobuf.Note.IDefinition): langame.protobuf.Note.Definition;

                /**
                 * Encodes the specified Definition message. Does not implicitly {@link langame.protobuf.Note.Definition.verify|verify} messages.
                 * @param message Definition message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Note.IDefinition, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Definition message, length delimited. Does not implicitly {@link langame.protobuf.Note.Definition.verify|verify} messages.
                 * @param message Definition message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Note.IDefinition, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Definition message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Definition
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Note.Definition;

                /**
                 * Decodes a Definition message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Definition
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Note.Definition;

                /**
                 * Verifies a Definition message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Definition message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Definition
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Note.Definition;

                /**
                 * Creates a plain object from a Definition message. Also converts values to other types if specified.
                 * @param message Definition
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Note.Definition, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Definition to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }
        }

        /** Properties of a Notification. */
        interface INotification {

            /** Notification id */
            id?: (string|null);

            /** Notification senderUid */
            senderUid?: (string|null);

            /** Notification recipientsUid */
            recipientsUid?: (string[]|null);

            /** Topics of the Langame */
            topics?: (string[]|null);

            /** Agora channel name */
            channelName?: (string|null);

            /** Notification ready */
            ready?: (boolean|null);
        }

        /** Represents a Notification. */
        class Notification implements INotification {

            /**
             * Constructs a new Notification.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.INotification);

            /** Notification id. */
            public id: string;

            /** Notification senderUid. */
            public senderUid: string;

            /** Notification recipientsUid. */
            public recipientsUid: string[];

            /** Topics of the Langame */
            public topics: string[];

            /** Agora channel name */
            public channelName: string;

            /** Notification ready. */
            public ready: boolean;

            /**
             * Creates a new Notification instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Notification instance
             */
            public static create(properties?: langame.protobuf.INotification): langame.protobuf.Notification;

            /**
             * Encodes the specified Notification message. Does not implicitly {@link langame.protobuf.Notification.verify|verify} messages.
             * @param message Notification message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.INotification, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Notification message, length delimited. Does not implicitly {@link langame.protobuf.Notification.verify|verify} messages.
             * @param message Notification message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.INotification, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Notification message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Notification
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Notification;

            /**
             * Decodes a Notification message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Notification
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Notification;

            /**
             * Verifies a Notification message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Notification message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Notification
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Notification;

            /**
             * Creates a plain object from a Notification message. Also converts values to other types if specified.
             * @param message Notification
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Notification, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Notification to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        /** Properties of a Subscription. */
        interface ISubscription {

            /** Subscription status */
            status?: (string|null);
        }

        /** Represents a Subscription. */
        class Subscription implements ISubscription {

            /**
             * Constructs a new Subscription.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.ISubscription);

            /** Subscription status. */
            public status: string;

            /**
             * Creates a new Subscription instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Subscription instance
             */
            public static create(properties?: langame.protobuf.ISubscription): langame.protobuf.Subscription;

            /**
             * Encodes the specified Subscription message. Does not implicitly {@link langame.protobuf.Subscription.verify|verify} messages.
             * @param message Subscription message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.ISubscription, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Subscription message, length delimited. Does not implicitly {@link langame.protobuf.Subscription.verify|verify} messages.
             * @param message Subscription message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.ISubscription, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Subscription message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Subscription
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Subscription;

            /**
             * Decodes a Subscription message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Subscription
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Subscription;

            /**
             * Verifies a Subscription message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Subscription message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Subscription
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Subscription;

            /**
             * Creates a plain object from a Subscription message. Also converts values to other types if specified.
             * @param message Subscription
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Subscription, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Subscription to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        /** Properties of a FunctionResponse. */
        interface IFunctionResponse {

            /** FunctionResponse versionCheck */
            versionCheck?: (langame.protobuf.FunctionResponse.IVersionCheck|null);
        }

        /** Represents a FunctionResponse. */
        class FunctionResponse implements IFunctionResponse {

            /**
             * Constructs a new FunctionResponse.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.IFunctionResponse);

            /** FunctionResponse versionCheck. */
            public versionCheck?: (langame.protobuf.FunctionResponse.IVersionCheck|null);

            /** FunctionResponse type. */
            public type?: "versionCheck";

            /**
             * Creates a new FunctionResponse instance using the specified properties.
             * @param [properties] Properties to set
             * @returns FunctionResponse instance
             */
            public static create(properties?: langame.protobuf.IFunctionResponse): langame.protobuf.FunctionResponse;

            /**
             * Encodes the specified FunctionResponse message. Does not implicitly {@link langame.protobuf.FunctionResponse.verify|verify} messages.
             * @param message FunctionResponse message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.IFunctionResponse, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified FunctionResponse message, length delimited. Does not implicitly {@link langame.protobuf.FunctionResponse.verify|verify} messages.
             * @param message FunctionResponse message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.IFunctionResponse, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a FunctionResponse message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns FunctionResponse
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.FunctionResponse;

            /**
             * Decodes a FunctionResponse message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns FunctionResponse
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.FunctionResponse;

            /**
             * Verifies a FunctionResponse message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a FunctionResponse message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns FunctionResponse
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.FunctionResponse;

            /**
             * Creates a plain object from a FunctionResponse message. Also converts values to other types if specified.
             * @param message FunctionResponse
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.FunctionResponse, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this FunctionResponse to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        namespace FunctionResponse {

            /** Properties of a VersionCheck. */
            interface IVersionCheck {

                /** VersionCheck update */
                update?: (langame.protobuf.FunctionResponse.VersionCheck.UpdateRequired|null);
            }

            /** Represents a VersionCheck. */
            class VersionCheck implements IVersionCheck {

                /**
                 * Constructs a new VersionCheck.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.FunctionResponse.IVersionCheck);

                /** VersionCheck update. */
                public update: langame.protobuf.FunctionResponse.VersionCheck.UpdateRequired;

                /**
                 * Creates a new VersionCheck instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns VersionCheck instance
                 */
                public static create(properties?: langame.protobuf.FunctionResponse.IVersionCheck): langame.protobuf.FunctionResponse.VersionCheck;

                /**
                 * Encodes the specified VersionCheck message. Does not implicitly {@link langame.protobuf.FunctionResponse.VersionCheck.verify|verify} messages.
                 * @param message VersionCheck message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.FunctionResponse.IVersionCheck, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified VersionCheck message, length delimited. Does not implicitly {@link langame.protobuf.FunctionResponse.VersionCheck.verify|verify} messages.
                 * @param message VersionCheck message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.FunctionResponse.IVersionCheck, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a VersionCheck message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns VersionCheck
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.FunctionResponse.VersionCheck;

                /**
                 * Decodes a VersionCheck message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns VersionCheck
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.FunctionResponse.VersionCheck;

                /**
                 * Verifies a VersionCheck message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a VersionCheck message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns VersionCheck
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.FunctionResponse.VersionCheck;

                /**
                 * Creates a plain object from a VersionCheck message. Also converts values to other types if specified.
                 * @param message VersionCheck
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.FunctionResponse.VersionCheck, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this VersionCheck to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            namespace VersionCheck {

                /** UpdateRequired enum. */
                enum UpdateRequired {
                    OK = 0,
                    REQUIRED = 1,
                    RETRO_COMPATIBLE = 2
                }
            }
        }

        /** Properties of a Prompt. */
        interface IPrompt {

            /** Prompt type */
            type?: (string|null);

            /** Prompt template */
            template?: (string|null);

            /** Prompt tags */
            tags?: (langame.protobuf.ITag[]|null);

            /** Prompt id */
            id?: (string|null);
        }

        /** Represents a Prompt. */
        class Prompt implements IPrompt {

            /**
             * Constructs a new Prompt.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.IPrompt);

            /** Prompt type. */
            public type: string;

            /** Prompt template. */
            public template: string;

            /** Prompt tags. */
            public tags: langame.protobuf.ITag[];

            /** Prompt id. */
            public id: string;

            /**
             * Creates a new Prompt instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Prompt instance
             */
            public static create(properties?: langame.protobuf.IPrompt): langame.protobuf.Prompt;

            /**
             * Encodes the specified Prompt message. Does not implicitly {@link langame.protobuf.Prompt.verify|verify} messages.
             * @param message Prompt message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.IPrompt, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Prompt message, length delimited. Does not implicitly {@link langame.protobuf.Prompt.verify|verify} messages.
             * @param message Prompt message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.IPrompt, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Prompt message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Prompt
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Prompt;

            /**
             * Decodes a Prompt message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Prompt
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Prompt;

            /**
             * Verifies a Prompt message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Prompt message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Prompt
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Prompt;

            /**
             * Creates a plain object from a Prompt message. Also converts values to other types if specified.
             * @param message Prompt
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Prompt, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Prompt to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        /** Properties of a Recording. */
        interface IRecording {

            /** Recording createdAt */
            createdAt?: (google.protobuf.ITimestamp|null);

            /** Recording text */
            text?: (string|null);

            /** Recording userId */
            userId?: (string|null);

            /** Recording metadata */
            metadata?: ({ [k: string]: string }|null);

            /** Recording note */
            note?: (string|null);
        }

        /** Represents a Recording. */
        class Recording implements IRecording {

            /**
             * Constructs a new Recording.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.IRecording);

            /** Recording createdAt. */
            public createdAt?: (google.protobuf.ITimestamp|null);

            /** Recording text. */
            public text: string;

            /** Recording userId. */
            public userId: string;

            /** Recording metadata. */
            public metadata: { [k: string]: string };

            /** Recording note. */
            public note: string;

            /**
             * Creates a new Recording instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Recording instance
             */
            public static create(properties?: langame.protobuf.IRecording): langame.protobuf.Recording;

            /**
             * Encodes the specified Recording message. Does not implicitly {@link langame.protobuf.Recording.verify|verify} messages.
             * @param message Recording message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.IRecording, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Recording message, length delimited. Does not implicitly {@link langame.protobuf.Recording.verify|verify} messages.
             * @param message Recording message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.IRecording, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Recording message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Recording
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Recording;

            /**
             * Decodes a Recording message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Recording
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Recording;

            /**
             * Verifies a Recording message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Recording message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Recording
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Recording;

            /**
             * Creates a plain object from a Recording message. Also converts values to other types if specified.
             * @param message Recording
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Recording, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Recording to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }
    }
}

/** Namespace google. */
export namespace google {

    /** Namespace protobuf. */
    namespace protobuf {

        /** Properties of a Timestamp. */
        interface ITimestamp {

            /** Timestamp seconds */
            seconds?: (number|Long|null);

            /** Timestamp nanos */
            nanos?: (number|null);
        }

        /** Represents a Timestamp. */
        class Timestamp implements ITimestamp {

            /**
             * Constructs a new Timestamp.
             * @param [properties] Properties to set
             */
            constructor(properties?: google.protobuf.ITimestamp);

            /** Timestamp seconds. */
            public seconds: (number|Long);

            /** Timestamp nanos. */
            public nanos: number;

            /**
             * Creates a new Timestamp instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Timestamp instance
             */
            public static create(properties?: google.protobuf.ITimestamp): google.protobuf.Timestamp;

            /**
             * Encodes the specified Timestamp message. Does not implicitly {@link google.protobuf.Timestamp.verify|verify} messages.
             * @param message Timestamp message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: google.protobuf.ITimestamp, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Timestamp message, length delimited. Does not implicitly {@link google.protobuf.Timestamp.verify|verify} messages.
             * @param message Timestamp message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: google.protobuf.ITimestamp, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Timestamp message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Timestamp
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): google.protobuf.Timestamp;

            /**
             * Decodes a Timestamp message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Timestamp
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): google.protobuf.Timestamp;

            /**
             * Verifies a Timestamp message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Timestamp message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Timestamp
             */
            public static fromObject(object: { [k: string]: any }): google.protobuf.Timestamp;

            /**
             * Creates a plain object from a Timestamp message. Also converts values to other types if specified.
             * @param message Timestamp
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: google.protobuf.Timestamp, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Timestamp to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        /** Properties of an Any. */
        interface IAny {

            /** Any type_url */
            type_url?: (string|null);

            /** Any value */
            value?: (Uint8Array|null);
        }

        /** Represents an Any. */
        class Any implements IAny {

            /**
             * Constructs a new Any.
             * @param [properties] Properties to set
             */
            constructor(properties?: google.protobuf.IAny);

            /** Any type_url. */
            public type_url: string;

            /** Any value. */
            public value: Uint8Array;

            /**
             * Creates a new Any instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Any instance
             */
            public static create(properties?: google.protobuf.IAny): google.protobuf.Any;

            /**
             * Encodes the specified Any message. Does not implicitly {@link google.protobuf.Any.verify|verify} messages.
             * @param message Any message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: google.protobuf.IAny, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Any message, length delimited. Does not implicitly {@link google.protobuf.Any.verify|verify} messages.
             * @param message Any message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: google.protobuf.IAny, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes an Any message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Any
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): google.protobuf.Any;

            /**
             * Decodes an Any message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Any
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): google.protobuf.Any;

            /**
             * Verifies an Any message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates an Any message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Any
             */
            public static fromObject(object: { [k: string]: any }): google.protobuf.Any;

            /**
             * Creates a plain object from an Any message. Also converts values to other types if specified.
             * @param message Any
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: google.protobuf.Any, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Any to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }
    }
}
