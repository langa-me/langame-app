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

            /** Meme tweet */
            tweet?: (boolean|null);

            /** Meme state */
            state?: (string|null);

            /** Meme error */
            error?: (string|null);

            /** Meme tags */
            tags?: (string[]|null);
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

            /** Meme tweet. */
            public tweet: boolean;

            /** Meme state. */
            public state: string;

            /** Meme error. */
            public error: string;

            /** Meme tags. */
            public tags: string[];

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

            /** User bot */
            bot?: (boolean|null);
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

            /** User bot. */
            public bot: boolean;

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

            /** UserPreference favoriteTopics */
            favoriteTopics?: (string[]|null);

            /** UserPreference topicSearchHistory */
            topicSearchHistory?: (string[]|null);

            /** UserPreference errors */
            errors?: (langame.protobuf.IError[]|null);

            /** UserPreference sawWhatsNew */
            sawWhatsNew?: (boolean|null);

            /** UserPreference notification */
            notification?: (langame.protobuf.UserPreference.INotification|null);

            /** UserPreference previewMode */
            previewMode?: (boolean|null);

            /** UserPreference goals */
            goals?: (langame.protobuf.UserPreference.IGoals|null);

            /** UserPreference langamesSubscriptionFrequency */
            langamesSubscriptionFrequency?: (string|null);
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

            /** UserPreference favoriteTopics. */
            public favoriteTopics: string[];

            /** UserPreference topicSearchHistory. */
            public topicSearchHistory: string[];

            /** UserPreference errors. */
            public errors: langame.protobuf.IError[];

            /** UserPreference sawWhatsNew. */
            public sawWhatsNew: boolean;

            /** UserPreference notification. */
            public notification?: (langame.protobuf.UserPreference.INotification|null);

            /** UserPreference previewMode. */
            public previewMode: boolean;

            /** UserPreference goals. */
            public goals?: (langame.protobuf.UserPreference.IGoals|null);

            /** UserPreference langamesSubscriptionFrequency. */
            public langamesSubscriptionFrequency: string;

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

                /** Notification invite */
                invite?: (langame.protobuf.UserPreference.Notification.IInvite|null);

                /** Notification message */
                message?: (langame.protobuf.UserPreference.Notification.IMessage|null);

                /** Notification newVersion */
                newVersion?: (langame.protobuf.UserPreference.Notification.INewVersion|null);
            }

            /** Represents a Notification. */
            class Notification implements INotification {

                /**
                 * Constructs a new Notification.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.UserPreference.INotification);

                /** Notification invite. */
                public invite?: (langame.protobuf.UserPreference.Notification.IInvite|null);

                /** Notification message. */
                public message?: (langame.protobuf.UserPreference.Notification.IMessage|null);

                /** Notification newVersion. */
                public newVersion?: (langame.protobuf.UserPreference.Notification.INewVersion|null);

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

            namespace Notification {

                /** Properties of an Invite. */
                interface IInvite {

                    /** Invite email */
                    email?: (boolean|null);

                    /** Invite push */
                    push?: (boolean|null);
                }

                /** Represents an Invite. */
                class Invite implements IInvite {

                    /**
                     * Constructs a new Invite.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.UserPreference.Notification.IInvite);

                    /** Invite email. */
                    public email: boolean;

                    /** Invite push. */
                    public push: boolean;

                    /**
                     * Creates a new Invite instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns Invite instance
                     */
                    public static create(properties?: langame.protobuf.UserPreference.Notification.IInvite): langame.protobuf.UserPreference.Notification.Invite;

                    /**
                     * Encodes the specified Invite message. Does not implicitly {@link langame.protobuf.UserPreference.Notification.Invite.verify|verify} messages.
                     * @param message Invite message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.UserPreference.Notification.IInvite, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified Invite message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.Notification.Invite.verify|verify} messages.
                     * @param message Invite message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.UserPreference.Notification.IInvite, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes an Invite message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns Invite
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.UserPreference.Notification.Invite;

                    /**
                     * Decodes an Invite message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns Invite
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.UserPreference.Notification.Invite;

                    /**
                     * Verifies an Invite message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates an Invite message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns Invite
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.UserPreference.Notification.Invite;

                    /**
                     * Creates a plain object from an Invite message. Also converts values to other types if specified.
                     * @param message Invite
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.UserPreference.Notification.Invite, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this Invite to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }

                /** Properties of a Message. */
                interface IMessage {

                    /** Message email */
                    email?: (boolean|null);

                    /** Message push */
                    push?: (boolean|null);
                }

                /** Represents a Message. */
                class Message implements IMessage {

                    /**
                     * Constructs a new Message.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.UserPreference.Notification.IMessage);

                    /** Message email. */
                    public email: boolean;

                    /** Message push. */
                    public push: boolean;

                    /**
                     * Creates a new Message instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns Message instance
                     */
                    public static create(properties?: langame.protobuf.UserPreference.Notification.IMessage): langame.protobuf.UserPreference.Notification.Message;

                    /**
                     * Encodes the specified Message message. Does not implicitly {@link langame.protobuf.UserPreference.Notification.Message.verify|verify} messages.
                     * @param message Message message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.UserPreference.Notification.IMessage, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified Message message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.Notification.Message.verify|verify} messages.
                     * @param message Message message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.UserPreference.Notification.IMessage, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes a Message message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns Message
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.UserPreference.Notification.Message;

                    /**
                     * Decodes a Message message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns Message
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.UserPreference.Notification.Message;

                    /**
                     * Verifies a Message message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates a Message message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns Message
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.UserPreference.Notification.Message;

                    /**
                     * Creates a plain object from a Message message. Also converts values to other types if specified.
                     * @param message Message
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.UserPreference.Notification.Message, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this Message to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }

                /** Properties of a NewVersion. */
                interface INewVersion {

                    /** NewVersion email */
                    email?: (boolean|null);

                    /** NewVersion push */
                    push?: (boolean|null);
                }

                /** Represents a NewVersion. */
                class NewVersion implements INewVersion {

                    /**
                     * Constructs a new NewVersion.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.UserPreference.Notification.INewVersion);

                    /** NewVersion email. */
                    public email: boolean;

                    /** NewVersion push. */
                    public push: boolean;

                    /**
                     * Creates a new NewVersion instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns NewVersion instance
                     */
                    public static create(properties?: langame.protobuf.UserPreference.Notification.INewVersion): langame.protobuf.UserPreference.Notification.NewVersion;

                    /**
                     * Encodes the specified NewVersion message. Does not implicitly {@link langame.protobuf.UserPreference.Notification.NewVersion.verify|verify} messages.
                     * @param message NewVersion message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.UserPreference.Notification.INewVersion, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified NewVersion message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.Notification.NewVersion.verify|verify} messages.
                     * @param message NewVersion message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.UserPreference.Notification.INewVersion, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes a NewVersion message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns NewVersion
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.UserPreference.Notification.NewVersion;

                    /**
                     * Decodes a NewVersion message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns NewVersion
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.UserPreference.Notification.NewVersion;

                    /**
                     * Verifies a NewVersion message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates a NewVersion message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns NewVersion
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.UserPreference.Notification.NewVersion;

                    /**
                     * Creates a plain object from a NewVersion message. Also converts values to other types if specified.
                     * @param message NewVersion
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.UserPreference.Notification.NewVersion, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this NewVersion to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }
            }

            /** Properties of a Goals. */
            interface IGoals {

                /** Goals growRelationships */
                growRelationships?: (boolean|null);

                /** Goals compoundRelationships */
                compoundRelationships?: (boolean|null);

                /** Goals learn */
                learn?: (boolean|null);
            }

            /** Represents a Goals. */
            class Goals implements IGoals {

                /**
                 * Constructs a new Goals.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.UserPreference.IGoals);

                /** Goals growRelationships. */
                public growRelationships: boolean;

                /** Goals compoundRelationships. */
                public compoundRelationships: boolean;

                /** Goals learn. */
                public learn: boolean;

                /**
                 * Creates a new Goals instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Goals instance
                 */
                public static create(properties?: langame.protobuf.UserPreference.IGoals): langame.protobuf.UserPreference.Goals;

                /**
                 * Encodes the specified Goals message. Does not implicitly {@link langame.protobuf.UserPreference.Goals.verify|verify} messages.
                 * @param message Goals message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.UserPreference.IGoals, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Goals message, length delimited. Does not implicitly {@link langame.protobuf.UserPreference.Goals.verify|verify} messages.
                 * @param message Goals message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.UserPreference.IGoals, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Goals message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Goals
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.UserPreference.Goals;

                /**
                 * Decodes a Goals message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Goals
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.UserPreference.Goals;

                /**
                 * Verifies a Goals message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Goals message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Goals
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.UserPreference.Goals;

                /**
                 * Creates a plain object from a Goals message. Also converts values to other types if specified.
                 * @param message Goals
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.UserPreference.Goals, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Goals to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }
        }

        /** Properties of a Langame. */
        interface ILangame {

            /** Langame id */
            id?: (string|null);

            /** Langame players */
            players?: (langame.protobuf.Langame.IPlayer[]|null);

            /** Langame topics */
            topics?: (string[]|null);

            /** Langame initiator */
            initiator?: (string|null);

            /** Langame done */
            done?: (google.protobuf.ITimestamp|null);

            /** Langame createdAt */
            createdAt?: (google.protobuf.ITimestamp|null);

            /** Langame errors */
            errors?: (langame.protobuf.IError[]|null);

            /** Langame reflections */
            reflections?: (langame.protobuf.Langame.IReflection[]|null);

            /** Langame tags */
            tags?: (string[]|null);
        }

        /** Represents a Langame. */
        class Langame implements ILangame {

            /**
             * Constructs a new Langame.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.ILangame);

            /** Langame id. */
            public id: string;

            /** Langame players. */
            public players: langame.protobuf.Langame.IPlayer[];

            /** Langame topics. */
            public topics: string[];

            /** Langame initiator. */
            public initiator: string;

            /** Langame done. */
            public done?: (google.protobuf.ITimestamp|null);

            /** Langame createdAt. */
            public createdAt?: (google.protobuf.ITimestamp|null);

            /** Langame errors. */
            public errors: langame.protobuf.IError[];

            /** Langame reflections. */
            public reflections: langame.protobuf.Langame.IReflection[];

            /** Langame tags. */
            public tags: string[];

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

        namespace Langame {

            /** Properties of a Player. */
            interface IPlayer {

                /** Player id */
                id?: (string|null);

                /** Player tag */
                tag?: (string|null);

                /** Player photoUrl */
                photoUrl?: (string|null);

                /** Player bot */
                bot?: (boolean|null);

                /** Player locale */
                locale?: (string|null);

                /** Player email */
                email?: (string|null);
            }

            /** Represents a Player. */
            class Player implements IPlayer {

                /**
                 * Constructs a new Player.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Langame.IPlayer);

                /** Player id. */
                public id: string;

                /** Player tag. */
                public tag: string;

                /** Player photoUrl. */
                public photoUrl: string;

                /** Player bot. */
                public bot: boolean;

                /** Player locale. */
                public locale: string;

                /** Player email. */
                public email: string;

                /**
                 * Creates a new Player instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Player instance
                 */
                public static create(properties?: langame.protobuf.Langame.IPlayer): langame.protobuf.Langame.Player;

                /**
                 * Encodes the specified Player message. Does not implicitly {@link langame.protobuf.Langame.Player.verify|verify} messages.
                 * @param message Player message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Langame.IPlayer, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Player message, length delimited. Does not implicitly {@link langame.protobuf.Langame.Player.verify|verify} messages.
                 * @param message Player message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Langame.IPlayer, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Player message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Player
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Langame.Player;

                /**
                 * Decodes a Player message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Player
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Langame.Player;

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
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Langame.Player;

                /**
                 * Creates a plain object from a Player message. Also converts values to other types if specified.
                 * @param message Player
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Langame.Player, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Player to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            /** Properties of a Reflection. */
            interface IReflection {

                /** Reflection userId */
                userId?: (string|null);

                /** Reflection lastMessageId */
                lastMessageId?: (string|null);

                /** Reflection alternatives */
                alternatives?: (string[]|null);

                /** Reflection createdAt */
                createdAt?: (google.protobuf.ITimestamp|null);

                /** Reflection contentFilter */
                contentFilter?: (langame.protobuf.ContentFilter|null);

                /** Reflection userFeedbacks */
                userFeedbacks?: ({ [k: string]: number }|null);
            }

            /** Represents a Reflection. */
            class Reflection implements IReflection {

                /**
                 * Constructs a new Reflection.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Langame.IReflection);

                /** Reflection userId. */
                public userId: string;

                /** Reflection lastMessageId. */
                public lastMessageId: string;

                /** Reflection alternatives. */
                public alternatives: string[];

                /** Reflection createdAt. */
                public createdAt?: (google.protobuf.ITimestamp|null);

                /** Reflection contentFilter. */
                public contentFilter: langame.protobuf.ContentFilter;

                /** Reflection userFeedbacks. */
                public userFeedbacks: { [k: string]: number };

                /**
                 * Creates a new Reflection instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Reflection instance
                 */
                public static create(properties?: langame.protobuf.Langame.IReflection): langame.protobuf.Langame.Reflection;

                /**
                 * Encodes the specified Reflection message. Does not implicitly {@link langame.protobuf.Langame.Reflection.verify|verify} messages.
                 * @param message Reflection message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Langame.IReflection, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Reflection message, length delimited. Does not implicitly {@link langame.protobuf.Langame.Reflection.verify|verify} messages.
                 * @param message Reflection message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Langame.IReflection, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Reflection message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Reflection
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Langame.Reflection;

                /**
                 * Decodes a Reflection message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Reflection
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Langame.Reflection;

                /**
                 * Verifies a Reflection message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Reflection message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Reflection
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Langame.Reflection;

                /**
                 * Creates a plain object from a Reflection message. Also converts values to other types if specified.
                 * @param message Reflection
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Langame.Reflection, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Reflection to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }
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

        /** Properties of a Message. */
        interface IMessage {

            /** Message createdAt */
            createdAt?: (google.protobuf.ITimestamp|null);

            /** Message author */
            author?: (langame.protobuf.Message.IAuthor|null);

            /** Message langameId */
            langameId?: (string|null);

            /** Message type */
            type?: (langame.protobuf.Message.Type|null);

            /** Message body */
            body?: (string|null);

            /** Message title */
            title?: (string|null);

            /** Message id */
            id?: (string|null);

            /** Message analysis */
            analysis?: (langame.protobuf.Message.IAnalysis|null);

            /** Message delivery */
            delivery?: (langame.protobuf.Message.IDelivery|null);

            /** Message components */
            components?: (langame.protobuf.Message.IComponent[]|null);
        }

        /** Represents a Message. */
        class Message implements IMessage {

            /**
             * Constructs a new Message.
             * @param [properties] Properties to set
             */
            constructor(properties?: langame.protobuf.IMessage);

            /** Message createdAt. */
            public createdAt?: (google.protobuf.ITimestamp|null);

            /** Message author. */
            public author?: (langame.protobuf.Message.IAuthor|null);

            /** Message langameId. */
            public langameId: string;

            /** Message type. */
            public type: langame.protobuf.Message.Type;

            /** Message body. */
            public body: string;

            /** Message title. */
            public title: string;

            /** Message id. */
            public id: string;

            /** Message analysis. */
            public analysis?: (langame.protobuf.Message.IAnalysis|null);

            /** Message delivery. */
            public delivery?: (langame.protobuf.Message.IDelivery|null);

            /** Message components. */
            public components: langame.protobuf.Message.IComponent[];

            /**
             * Creates a new Message instance using the specified properties.
             * @param [properties] Properties to set
             * @returns Message instance
             */
            public static create(properties?: langame.protobuf.IMessage): langame.protobuf.Message;

            /**
             * Encodes the specified Message message. Does not implicitly {@link langame.protobuf.Message.verify|verify} messages.
             * @param message Message message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encode(message: langame.protobuf.IMessage, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Encodes the specified Message message, length delimited. Does not implicitly {@link langame.protobuf.Message.verify|verify} messages.
             * @param message Message message or plain object to encode
             * @param [writer] Writer to encode to
             * @returns Writer
             */
            public static encodeDelimited(message: langame.protobuf.IMessage, writer?: $protobuf.Writer): $protobuf.Writer;

            /**
             * Decodes a Message message from the specified reader or buffer.
             * @param reader Reader or buffer to decode from
             * @param [length] Message length if known beforehand
             * @returns Message
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Message;

            /**
             * Decodes a Message message from the specified reader or buffer, length delimited.
             * @param reader Reader or buffer to decode from
             * @returns Message
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Message;

            /**
             * Verifies a Message message.
             * @param message Plain object to verify
             * @returns `null` if valid, otherwise the reason why it is not
             */
            public static verify(message: { [k: string]: any }): (string|null);

            /**
             * Creates a Message message from a plain object. Also converts values to their respective internal types.
             * @param object Plain object
             * @returns Message
             */
            public static fromObject(object: { [k: string]: any }): langame.protobuf.Message;

            /**
             * Creates a plain object from a Message message. Also converts values to other types if specified.
             * @param message Message
             * @param [options] Conversion options
             * @returns Plain object
             */
            public static toObject(message: langame.protobuf.Message, options?: $protobuf.IConversionOptions): { [k: string]: any };

            /**
             * Converts this Message to JSON.
             * @returns JSON object
             */
            public toJSON(): { [k: string]: any };
        }

        namespace Message {

            /** Properties of an Author. */
            interface IAuthor {

                /** Author id */
                id?: (string|null);

                /** Author tag */
                tag?: (string|null);

                /** Author photoUrl */
                photoUrl?: (string|null);

                /** Author bot */
                bot?: (boolean|null);

                /** Author locale */
                locale?: (string|null);

                /** Author email */
                email?: (string|null);
            }

            /** Represents an Author. */
            class Author implements IAuthor {

                /**
                 * Constructs a new Author.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Message.IAuthor);

                /** Author id. */
                public id: string;

                /** Author tag. */
                public tag: string;

                /** Author photoUrl. */
                public photoUrl: string;

                /** Author bot. */
                public bot: boolean;

                /** Author locale. */
                public locale: string;

                /** Author email. */
                public email: string;

                /**
                 * Creates a new Author instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Author instance
                 */
                public static create(properties?: langame.protobuf.Message.IAuthor): langame.protobuf.Message.Author;

                /**
                 * Encodes the specified Author message. Does not implicitly {@link langame.protobuf.Message.Author.verify|verify} messages.
                 * @param message Author message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Message.IAuthor, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Author message, length delimited. Does not implicitly {@link langame.protobuf.Message.Author.verify|verify} messages.
                 * @param message Author message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Message.IAuthor, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes an Author message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Author
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Message.Author;

                /**
                 * Decodes an Author message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Author
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Message.Author;

                /**
                 * Verifies an Author message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates an Author message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Author
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Message.Author;

                /**
                 * Creates a plain object from an Author message. Also converts values to other types if specified.
                 * @param message Author
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Message.Author, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Author to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            /** Properties of a Component. */
            interface IComponent {

                /** Component type */
                type?: (number|null);

                /** Component customId */
                customId?: (string|null);

                /** Component disabled */
                disabled?: (boolean|null);

                /** Component style */
                style?: (number|null);

                /** Component label */
                label?: (string|null);

                /** Component emoji */
                emoji?: (string|null);

                /** Component url */
                url?: (string|null);

                /** Component options */
                options?: (langame.protobuf.Message.Component.IOption[]|null);

                /** Component placeholder */
                placeholder?: (string|null);

                /** Component minValues */
                minValues?: (number|null);

                /** Component maxValues */
                maxValues?: (number|null);

                /** Component components */
                components?: (langame.protobuf.Message.IComponent[]|null);
            }

            /** Represents a Component. */
            class Component implements IComponent {

                /**
                 * Constructs a new Component.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Message.IComponent);

                /** Component type. */
                public type: number;

                /** Component customId. */
                public customId: string;

                /** Component disabled. */
                public disabled: boolean;

                /** Component style. */
                public style: number;

                /** Component label. */
                public label: string;

                /** Component emoji. */
                public emoji: string;

                /** Component url. */
                public url: string;

                /** Component options. */
                public options: langame.protobuf.Message.Component.IOption[];

                /** Component placeholder. */
                public placeholder: string;

                /** Component minValues. */
                public minValues: number;

                /** Component maxValues. */
                public maxValues: number;

                /** Component components. */
                public components: langame.protobuf.Message.IComponent[];

                /**
                 * Creates a new Component instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Component instance
                 */
                public static create(properties?: langame.protobuf.Message.IComponent): langame.protobuf.Message.Component;

                /**
                 * Encodes the specified Component message. Does not implicitly {@link langame.protobuf.Message.Component.verify|verify} messages.
                 * @param message Component message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Message.IComponent, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Component message, length delimited. Does not implicitly {@link langame.protobuf.Message.Component.verify|verify} messages.
                 * @param message Component message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Message.IComponent, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Component message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Component
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Message.Component;

                /**
                 * Decodes a Component message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Component
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Message.Component;

                /**
                 * Verifies a Component message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Component message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Component
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Message.Component;

                /**
                 * Creates a plain object from a Component message. Also converts values to other types if specified.
                 * @param message Component
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Message.Component, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Component to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            namespace Component {

                /** Properties of an Option. */
                interface IOption {

                    /** Option label */
                    label?: (string|null);

                    /** Option value */
                    value?: (string|null);

                    /** Option description */
                    description?: (string|null);

                    /** Option emoji */
                    emoji?: (string|null);

                    /** Option default */
                    "default"?: (boolean|null);
                }

                /** Represents an Option. */
                class Option implements IOption {

                    /**
                     * Constructs a new Option.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.Message.Component.IOption);

                    /** Option label. */
                    public label: string;

                    /** Option value. */
                    public value: string;

                    /** Option description. */
                    public description: string;

                    /** Option emoji. */
                    public emoji: string;

                    /** Option default. */
                    public default: boolean;

                    /**
                     * Creates a new Option instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns Option instance
                     */
                    public static create(properties?: langame.protobuf.Message.Component.IOption): langame.protobuf.Message.Component.Option;

                    /**
                     * Encodes the specified Option message. Does not implicitly {@link langame.protobuf.Message.Component.Option.verify|verify} messages.
                     * @param message Option message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.Message.Component.IOption, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified Option message, length delimited. Does not implicitly {@link langame.protobuf.Message.Component.Option.verify|verify} messages.
                     * @param message Option message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.Message.Component.IOption, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes an Option message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns Option
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Message.Component.Option;

                    /**
                     * Decodes an Option message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns Option
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Message.Component.Option;

                    /**
                     * Verifies an Option message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates an Option message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns Option
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.Message.Component.Option;

                    /**
                     * Creates a plain object from an Option message. Also converts values to other types if specified.
                     * @param message Option
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.Message.Component.Option, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this Option to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }
            }

            /** Properties of a Delivery. */
            interface IDelivery {

                /** Delivery attempts */
                attempts?: (number|null);

                /** Delivery endTime */
                endTime?: (google.protobuf.ITimestamp|null);

                /** Delivery error */
                error?: (string|null);

                /** Delivery status */
                status?: (string|null);
            }

            /** Represents a Delivery. */
            class Delivery implements IDelivery {

                /**
                 * Constructs a new Delivery.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Message.IDelivery);

                /** Delivery attempts. */
                public attempts: number;

                /** Delivery endTime. */
                public endTime?: (google.protobuf.ITimestamp|null);

                /** Delivery error. */
                public error: string;

                /** Delivery status. */
                public status: string;

                /**
                 * Creates a new Delivery instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Delivery instance
                 */
                public static create(properties?: langame.protobuf.Message.IDelivery): langame.protobuf.Message.Delivery;

                /**
                 * Encodes the specified Delivery message. Does not implicitly {@link langame.protobuf.Message.Delivery.verify|verify} messages.
                 * @param message Delivery message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Message.IDelivery, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Delivery message, length delimited. Does not implicitly {@link langame.protobuf.Message.Delivery.verify|verify} messages.
                 * @param message Delivery message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Message.IDelivery, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Delivery message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Delivery
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Message.Delivery;

                /**
                 * Decodes a Delivery message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Delivery
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Message.Delivery;

                /**
                 * Verifies a Delivery message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Delivery message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Delivery
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Message.Delivery;

                /**
                 * Creates a plain object from a Delivery message. Also converts values to other types if specified.
                 * @param message Delivery
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Message.Delivery, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Delivery to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            /** Type enum. */
            enum Type {
                INVITE = 0,
                MESSAGE = 1
            }

            /** Properties of an Analysis. */
            interface IAnalysis {

                /** Analysis topics */
                topics?: (string[]|null);

                /** Analysis sentiments */
                sentiments?: (langame.protobuf.Message.Analysis.ISentiment[]|null);

                /** Analysis error */
                error?: (langame.protobuf.Message.Analysis.IError|null);

                /** Analysis filter */
                filter?: (langame.protobuf.ContentFilter|null);

                /** Analysis token */
                token?: (langame.protobuf.Message.Analysis.IToken[]|null);
            }

            /** Represents an Analysis. */
            class Analysis implements IAnalysis {

                /**
                 * Constructs a new Analysis.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Message.IAnalysis);

                /** Analysis topics. */
                public topics: string[];

                /** Analysis sentiments. */
                public sentiments: langame.protobuf.Message.Analysis.ISentiment[];

                /** Analysis error. */
                public error?: (langame.protobuf.Message.Analysis.IError|null);

                /** Analysis filter. */
                public filter: langame.protobuf.ContentFilter;

                /** Analysis token. */
                public token: langame.protobuf.Message.Analysis.IToken[];

                /**
                 * Creates a new Analysis instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Analysis instance
                 */
                public static create(properties?: langame.protobuf.Message.IAnalysis): langame.protobuf.Message.Analysis;

                /**
                 * Encodes the specified Analysis message. Does not implicitly {@link langame.protobuf.Message.Analysis.verify|verify} messages.
                 * @param message Analysis message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Message.IAnalysis, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Analysis message, length delimited. Does not implicitly {@link langame.protobuf.Message.Analysis.verify|verify} messages.
                 * @param message Analysis message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Message.IAnalysis, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes an Analysis message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Analysis
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Message.Analysis;

                /**
                 * Decodes an Analysis message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Analysis
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Message.Analysis;

                /**
                 * Verifies an Analysis message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates an Analysis message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Analysis
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Message.Analysis;

                /**
                 * Creates a plain object from an Analysis message. Also converts values to other types if specified.
                 * @param message Analysis
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Message.Analysis, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Analysis to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }

            namespace Analysis {

                /** Properties of an Error. */
                interface IError {

                    /** Error developerMessage */
                    developerMessage?: (string|null);

                    /** Error tries */
                    tries?: (number|null);
                }

                /** Represents an Error. */
                class Error implements IError {

                    /**
                     * Constructs a new Error.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.Message.Analysis.IError);

                    /** Error developerMessage. */
                    public developerMessage: string;

                    /** Error tries. */
                    public tries: number;

                    /**
                     * Creates a new Error instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns Error instance
                     */
                    public static create(properties?: langame.protobuf.Message.Analysis.IError): langame.protobuf.Message.Analysis.Error;

                    /**
                     * Encodes the specified Error message. Does not implicitly {@link langame.protobuf.Message.Analysis.Error.verify|verify} messages.
                     * @param message Error message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.Message.Analysis.IError, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified Error message, length delimited. Does not implicitly {@link langame.protobuf.Message.Analysis.Error.verify|verify} messages.
                     * @param message Error message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.Message.Analysis.IError, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes an Error message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns Error
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Message.Analysis.Error;

                    /**
                     * Decodes an Error message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns Error
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Message.Analysis.Error;

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
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.Message.Analysis.Error;

                    /**
                     * Creates a plain object from an Error message. Also converts values to other types if specified.
                     * @param message Error
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.Message.Analysis.Error, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this Error to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }

                /** Properties of a Sentiment. */
                interface ISentiment {

                    /** Sentiment score */
                    score?: (number|null);

                    /** Sentiment label */
                    label?: (string|null);
                }

                /** Represents a Sentiment. */
                class Sentiment implements ISentiment {

                    /**
                     * Constructs a new Sentiment.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.Message.Analysis.ISentiment);

                    /** Sentiment score. */
                    public score: number;

                    /** Sentiment label. */
                    public label: string;

                    /**
                     * Creates a new Sentiment instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns Sentiment instance
                     */
                    public static create(properties?: langame.protobuf.Message.Analysis.ISentiment): langame.protobuf.Message.Analysis.Sentiment;

                    /**
                     * Encodes the specified Sentiment message. Does not implicitly {@link langame.protobuf.Message.Analysis.Sentiment.verify|verify} messages.
                     * @param message Sentiment message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.Message.Analysis.ISentiment, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified Sentiment message, length delimited. Does not implicitly {@link langame.protobuf.Message.Analysis.Sentiment.verify|verify} messages.
                     * @param message Sentiment message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.Message.Analysis.ISentiment, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes a Sentiment message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns Sentiment
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Message.Analysis.Sentiment;

                    /**
                     * Decodes a Sentiment message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns Sentiment
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Message.Analysis.Sentiment;

                    /**
                     * Verifies a Sentiment message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates a Sentiment message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns Sentiment
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.Message.Analysis.Sentiment;

                    /**
                     * Creates a plain object from a Sentiment message. Also converts values to other types if specified.
                     * @param message Sentiment
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.Message.Analysis.Sentiment, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this Sentiment to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }

                /** Properties of a Token. */
                interface IToken {

                    /** Token start */
                    start?: (number|null);

                    /** Token end */
                    end?: (number|null);

                    /** Token word */
                    word?: (string|null);

                    /** Token entityGroup */
                    entityGroup?: (string|null);

                    /** Token score */
                    score?: (number|null);
                }

                /** Represents a Token. */
                class Token implements IToken {

                    /**
                     * Constructs a new Token.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: langame.protobuf.Message.Analysis.IToken);

                    /** Token start. */
                    public start: number;

                    /** Token end. */
                    public end: number;

                    /** Token word. */
                    public word: string;

                    /** Token entityGroup. */
                    public entityGroup: string;

                    /** Token score. */
                    public score: number;

                    /**
                     * Creates a new Token instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns Token instance
                     */
                    public static create(properties?: langame.protobuf.Message.Analysis.IToken): langame.protobuf.Message.Analysis.Token;

                    /**
                     * Encodes the specified Token message. Does not implicitly {@link langame.protobuf.Message.Analysis.Token.verify|verify} messages.
                     * @param message Token message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: langame.protobuf.Message.Analysis.IToken, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified Token message, length delimited. Does not implicitly {@link langame.protobuf.Message.Analysis.Token.verify|verify} messages.
                     * @param message Token message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: langame.protobuf.Message.Analysis.IToken, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes a Token message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns Token
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Message.Analysis.Token;

                    /**
                     * Decodes a Token message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns Token
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Message.Analysis.Token;

                    /**
                     * Verifies a Token message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates a Token message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns Token
                     */
                    public static fromObject(object: { [k: string]: any }): langame.protobuf.Message.Analysis.Token;

                    /**
                     * Creates a plain object from a Token message. Also converts values to other types if specified.
                     * @param message Token
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: langame.protobuf.Message.Analysis.Token, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this Token to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }
            }
        }

        /** ContentFilter enum. */
        enum ContentFilter {
            Safe = 0,
            Sensitive = 1,
            Unsafe = 2
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
