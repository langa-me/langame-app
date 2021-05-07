# Langame functions

For further information, see Firebase [documentation](https://firebase.google.com/docs/functions)

## Installation

```bash
npm install -g firebase-tools
firebase login
```

### Secrets

```bash
firebase functions:config:set agora.id="THE AGORA APP ID"
firebase functions:config:set agora.certificate="THE AGORA CERTIFICATE"
firebase functions:config:set github.token="THE GITHUB TOKEN"
firebase functions:config:set openai.key="OPENAI KEY"
firebase functions:config:set mailchimp.key="MAILCHIMP KEY"
firebase functions:config:set mailchimp.list="MAILCHIMP LIST ID"
firebase functions:config:get > .runtimeconfig.json
```

Then you need to re-deploy your functions

## Usage

### Emulator

```bash
npm run serve
```

### Production

```bash
npm run deploy
```

Single function
````bash
firebase deploy --only functions:addMessage,functions:makeUppercase
````

## Test

```bash
export GOOGLE_APPLICATION_CREDENTIALS="path/to/key.json"
```
