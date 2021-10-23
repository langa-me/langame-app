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
            userRecommendations?: (langame.protobuf.UserPreference.RecommendationType|null);

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

            /** UserPreference speechToTextLocale */
            speechToTextLocale?: (string|null);

            /** UserPreference sawWhatsNew */
            sawWhatsNew?: (boolean|null);

            /** UserPreference notification */
            notification?: (langame.protobuf.UserPreference.INotification|null);

            /** UserPreference previewMode */
            previewMode?: (boolean|null);
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
            public userRecommendations: langame.protobuf.UserPreference.RecommendationType;

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

            /** UserPreference speechToTextLocale. */
            public speechToTextLocale: string;

            /** UserPreference sawWhatsNew. */
            public sawWhatsNew: boolean;

            /** UserPreference notification. */
            public notification?: (langame.protobuf.UserPreference.INotification|null);

            /** UserPreference previewMode. */
            public previewMode: boolean;

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
            }

            /** RecommendationType enum. */
            enum RecommendationType {
                NONE = 0,
                NEW = 1,
                COMPOUND = 2,
                ALL = 3
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

            /** Langame isText */
            isText?: (boolean|null);

            /** Langame reflections */
            reflections?: (langame.protobuf.Langame.IReflection[]|null);

            /** Langame suggestions */
            suggestions?: (langame.protobuf.Langame.ISuggestion[]|null);
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

            /** Langame isText. */
            public isText: boolean;

            /** Langame reflections. */
            public reflections: langame.protobuf.Langame.IReflection[];

            /** Langame suggestions. */
            public suggestions: langame.protobuf.Langame.ISuggestion[];

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

            /** Properties of a Suggestion. */
            interface ISuggestion {

                /** Suggestion userId */
                userId?: (string|null);

                /** Suggestion lastMessageId */
                lastMessageId?: (string|null);

                /** Suggestion alternatives */
                alternatives?: (string[]|null);

                /** Suggestion createdAt */
                createdAt?: (google.protobuf.ITimestamp|null);

                /** Suggestion contentFilter */
                contentFilter?: (langame.protobuf.ContentFilter|null);
            }

            /** Represents a Suggestion. */
            class Suggestion implements ISuggestion {

                /**
                 * Constructs a new Suggestion.
                 * @param [properties] Properties to set
                 */
                constructor(properties?: langame.protobuf.Langame.ISuggestion);

                /** Suggestion userId. */
                public userId: string;

                /** Suggestion lastMessageId. */
                public lastMessageId: string;

                /** Suggestion alternatives. */
                public alternatives: string[];

                /** Suggestion createdAt. */
                public createdAt?: (google.protobuf.ITimestamp|null);

                /** Suggestion contentFilter. */
                public contentFilter: langame.protobuf.ContentFilter;

                /**
                 * Creates a new Suggestion instance using the specified properties.
                 * @param [properties] Properties to set
                 * @returns Suggestion instance
                 */
                public static create(properties?: langame.protobuf.Langame.ISuggestion): langame.protobuf.Langame.Suggestion;

                /**
                 * Encodes the specified Suggestion message. Does not implicitly {@link langame.protobuf.Langame.Suggestion.verify|verify} messages.
                 * @param message Suggestion message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encode(message: langame.protobuf.Langame.ISuggestion, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Encodes the specified Suggestion message, length delimited. Does not implicitly {@link langame.protobuf.Langame.Suggestion.verify|verify} messages.
                 * @param message Suggestion message or plain object to encode
                 * @param [writer] Writer to encode to
                 * @returns Writer
                 */
                public static encodeDelimited(message: langame.protobuf.Langame.ISuggestion, writer?: $protobuf.Writer): $protobuf.Writer;

                /**
                 * Decodes a Suggestion message from the specified reader or buffer.
                 * @param reader Reader or buffer to decode from
                 * @param [length] Message length if known beforehand
                 * @returns Suggestion
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): langame.protobuf.Langame.Suggestion;

                /**
                 * Decodes a Suggestion message from the specified reader or buffer, length delimited.
                 * @param reader Reader or buffer to decode from
                 * @returns Suggestion
                 * @throws {Error} If the payload is not a reader or valid buffer
                 * @throws {$protobuf.util.ProtocolError} If required fields are missing
                 */
                public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): langame.protobuf.Langame.Suggestion;

                /**
                 * Verifies a Suggestion message.
                 * @param message Plain object to verify
                 * @returns `null` if valid, otherwise the reason why it is not
                 */
                public static verify(message: { [k: string]: any }): (string|null);

                /**
                 * Creates a Suggestion message from a plain object. Also converts values to their respective internal types.
                 * @param object Plain object
                 * @returns Suggestion
                 */
                public static fromObject(object: { [k: string]: any }): langame.protobuf.Langame.Suggestion;

                /**
                 * Creates a plain object from a Suggestion message. Also converts values to other types if specified.
                 * @param message Suggestion
                 * @param [options] Conversion options
                 * @returns Plain object
                 */
                public static toObject(message: langame.protobuf.Langame.Suggestion, options?: $protobuf.IConversionOptions): { [k: string]: any };

                /**
                 * Converts this Suggestion to JSON.
                 * @returns JSON object
                 */
                public toJSON(): { [k: string]: any };
            }
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

            /** Prompt id */
            id?: (string|null);

            /** Prompt parameters */
            parameters?: (google.protobuf.IAny|null);
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

            /** Prompt id. */
            public id: string;

            /** Prompt parameters. */
            public parameters?: (google.protobuf.IAny|null);

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

        /** Properties of a Message. */
        interface IMessage {

            /** Message createdAt */
            createdAt?: (google.protobuf.ITimestamp|null);

            /** Message fromUid */
            fromUid?: (string|null);

            /** Message toUid */
            toUid?: (string|null);

            /** Message channelName */
            channelName?: (string|null);

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

            /** Message fromUid. */
            public fromUid: string;

            /** Message toUid. */
            public toUid: string;

            /** Message channelName. */
            public channelName: string;

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
