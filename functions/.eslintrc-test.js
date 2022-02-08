module.exports = {
    extends: "eslintrc.js",
    ignorePatterns: [
        "/lib/**/*", // Ignore built files.
        "**/protobuf/**/*",
    ],
    parserOptions: {
        project: ["tsconfig-test.json"],
        sourceType: "module",
    },
}