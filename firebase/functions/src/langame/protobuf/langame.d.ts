import * as $protobuf from "protobufjs";
/** Namespace langame. */
export namespace langame {

    /** Namespace protobuf. */
    namespace protobuf {

        /** Properties of a Meme. */
        interface IMeme {

            /** Meme createdAt */
            createdAt?: (google.protobuf.ITimestamp|null);

            /** Meme content */
            content?: (string|null);

            /** Meme tags */
            tags?: (langame.protobuf.ITag[]|null);
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

            /** Meme tags. */
            public tags: langame.protobuf.ITag[];

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

            /** Tag origin */
            origin?: (langame.protobuf.Tag.IOrigin|null);

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

            /** Tag origin. */
            public origin?: (langame.protobuf.Tag.IOrigin|null);

            /** Tag feedback. */
            public feedback?: (langame.protobuf.Tag.IFeedback|null);

            /** Tag context. */
            public context?: (langame.protobuf.Tag.IContext|null);

            /** Tag aggregatedFeedback. */
            public aggregatedFeedback?: (langame.protobuf.Tag.IFeedback|null);

            /** Tag type. */
            public type?: ("topic"|"classification"|"origin"|"feedback"|"context"|"aggregatedFeedback");

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

            /** Properties of an Origin. */
            interface IOrigin {

                /** Origin openai */
                openai?: (langame.protobuf.Tag.Origin.IOpenAI|null);
            }

            /** Represents an Origin. */
            class Origin implements IOrigin {

                /**
                 * Constructs a new Origin.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Tag.IOrigin);

                /** Origin openai. */
                public openai?: (langame.protobuf.Tag.Origin.IOpenAI|null);

                /** Origin type. */
                public type?: "openai";

                /**
                 * Creates a new Origin instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Origin instance
                 */
                public static create(properties?: langame.protobuf.Tag.IOrigin): langame.protobuf.Tag.Origin;

                /**
                 * Encodes the specified Origin message. Does not implicitly {@link langame.protobuf.Tag.Origin.verify|verify} messages.
                 * @param message Origin message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Tag.IOrigin, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Origin message, length delimited. Does not implicitly {@link langame.protobuf.Tag.Origin.verify|verify} messages.
                 * @param message Origin message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Tag.IOrigin, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes an Origin message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Origin
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag.Origin;

                /**
                 * Decodes an Origin message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Origin
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag.Origin;

                /**
                 * Verifies an Origin message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates an Origin message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Origin
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag.Origin;

                /**
                 * Creates a plain object from an Origin message. Also converts values to other types if specified.
                 * @param message Origin
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Tag.Origin, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Origin to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            namespace Origin {

                /** Properties of an OpenAI. */
                interface IOpenAI {

                    /** OpenAI version */
                    version?: (number|null);
                }

                /** Represents an OpenAI. */
                class OpenAI implements IOpenAI {

                    /**
                     * Constructs a new OpenAI.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.Tag.Origin.IOpenAI);

                    /** OpenAI version. */
                    public version: number;

                    /**
                     * Creates a new OpenAI instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns OpenAI instance
                     */
                    public static create(properties?: langame.protobuf.Tag.Origin.IOpenAI): langame.protobuf.Tag.Origin.OpenAI;

                    /**
                     * Encodes the specified OpenAI message. Does not implicitly {@link langame.protobuf.Tag.Origin.OpenAI.verify|verify} messages.
                     * @param message OpenAI message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.Tag.Origin.IOpenAI, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified OpenAI message, length delimited. Does not implicitly {@link langame.protobuf.Tag.Origin.OpenAI.verify|verify} messages.
                     * @param message OpenAI message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.Tag.Origin.IOpenAI, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes an OpenAI message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns OpenAI
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Tag.Origin.OpenAI;

                    /**
                     * Decodes an OpenAI message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns OpenAI
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Tag.Origin.OpenAI;

                    /**
                     * Verifies an OpenAI message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates an OpenAI message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns OpenAI
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.Tag.Origin.OpenAI;

                    /**
                     * Creates a plain object from an OpenAI message. Also converts values to other types if specified.
                     * @param message OpenAI
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.Tag.Origin.OpenAI, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this OpenAI to JSON.
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

            /** Facebook account linked? */
            facebook?: (boolean|null);

            /** Apple account linked? */
            apple?: (boolean|null);

            /** Favourite topics the user has picked, should impact recommendations */
            favouriteTopics?: (string[]|null);

            /** Twitter-like [tag] i.e. @steveTheApple */
            tag?: (string|null);

            /** Device [tokens] used for Cloud Messaging */
            tokens?: (string[]|null);

            /** User latestInteractions */
            latestInteractions?: (string[]|null);

            /** User errors */
            errors?: (string[]|null);

            /** User lastLogin */
            lastLogin?: (google.protobuf.ITimestamp|null);

            /** User lastLogout */
            lastLogout?: (google.protobuf.ITimestamp|null);

            /** User creationTime */
            creationTime?: (google.protobuf.ITimestamp|null);

            /** User disabled */
            disabled?: (boolean|null);
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

            /** Facebook account linked? */
            public facebook: boolean;

            /** Apple account linked? */
            public apple: boolean;

            /** Favourite topics the user has picked, should impact recommendations */
            public favouriteTopics: string[];

            /** Twitter-like [tag] i.e. @steveTheApple */
            public tag: string;

            /** Device [tokens] used for Cloud Messaging */
            public tokens: string[];

            /** User latestInteractions. */
            public latestInteractions: string[];

            /** User errors. */
            public errors: string[];

            /** User lastLogin. */
            public lastLogin?: (google.protobuf.ITimestamp|null);

            /** User lastLogout. */
            public lastLogout?: (google.protobuf.ITimestamp|null);

            /** User creationTime. */
            public creationTime?: (google.protobuf.ITimestamp|null);

            /** User disabled. */
            public disabled: boolean;

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

            /** UserPreference unknownPeopleRecommendations */
            unknownPeopleRecommendations?: (boolean|null);

            /** UserPreference themeIndex */
            themeIndex?: (number|null);

            /** UserPreference hasDoneOnBoarding */
            hasDoneOnBoarding?: (boolean|null);

            /** UserPreference searchHistory */
            searchHistory?: (string[]|null);

            /** UserPreference shakeToFeedback */
            shakeToFeedback?: (boolean|null);
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

            /** UserPreference unknownPeopleRecommendations. */
            public unknownPeopleRecommendations: boolean;

            /** UserPreference themeIndex. */
            public themeIndex: number;

            /** UserPreference hasDoneOnBoarding. */
            public hasDoneOnBoarding: boolean;

            /** UserPreference searchHistory. */
            public searchHistory: string[];

            /** UserPreference shakeToFeedback. */
            public shakeToFeedback: boolean;

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

        /** Properties of a Langame. */
        interface ILangame {

            /** Langame channelName */
            channelName?: (string|null);

            /** Langame players */
            players?: (string[]|null);

            /** Langame topics */
            topics?: (string[]|null);

            /** Langame memes */
            memes?: (string[]|null);

            /** Langame initiator */
            initiator?: (string|null);

            /** Langame done */
            done?: (google.protobuf.ITimestamp|null);

            /** Langame currentMeme */
            currentMeme?: (number|null);

            /** Langame date */
            date?: (google.protobuf.ITimestamp|null);

            /** Langame errors */
            errors?: (string[]|null);

            /** Langame started */
            started?: (google.protobuf.ITimestamp|null);

            /** Langame nextMeme */
            nextMeme?: (google.protobuf.ITimestamp|null);

            /** Langame memesSeen */
            memesSeen?: (number|null);

            /** Langame memeChanged */
            memeChanged?: (google.protobuf.ITimestamp|null);
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
            public memes: string[];

            /** Langame initiator. */
            public initiator: string;

            /** Langame done. */
            public done?: (google.protobuf.ITimestamp|null);

            /** Langame currentMeme. */
            public currentMeme: number;

            /** Langame date. */
            public date?: (google.protobuf.ITimestamp|null);

            /** Langame errors. */
            public errors: string[];

            /** Langame started. */
            public started?: (google.protobuf.ITimestamp|null);

            /** Langame nextMeme. */
            public nextMeme?: (google.protobuf.ITimestamp|null);

            /** Langame memesSeen. */
            public memesSeen: number;

            /** Langame memeChanged. */
            public memeChanged?: (google.protobuf.ITimestamp|null);

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
    }
}
