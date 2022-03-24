# Langame functions

For further information, see Firebase [documentation](https://firebase.google.com/docs/functions)

## Installation

```bash
npm install -g firebase-tools
firebase login
firebase remoteconfig:get > remoteconfig.template.json
```


### First time deployment of HTTP unauthenticated functions

```bash
gcloud functions add-iam-policy-binding FUNCTION_NAME  --member="allUsers"  --role="roles/cloudfunctions.invoker"
```

### Secrets

```bash
firebase functions:config:set agora.id="THE AGORA APP ID"
firebase functions:config:set agora.certificate="THE AGORA CERTIFICATE"
firebase functions:config:set github.token="THE GITHUB TOKEN"
firebase functions:config:set openai.key="OPENAI KEY"
firebase functions:config:set huggingface.key="HUGGINGFACE KEY"
firebase functions:config:set algolia.application.id="ALGOLIA APPLICATION ID"
firebase functions:config:set algolia.key="ALGOLIA KEY"
firebase functions:config:set mailchimp.key="MAILCHIMP KEY"
firebase functions:config:set mailchimp.list="MAILCHIMP LIST ID"
firebase functions:config:set stripe.account="ACCOUNT"
firebase functions:config:set stripe.key="SECRET_KEY"
# API Key and API Key Secret
firebase functions:config:set twitter.app_key="SECRET_KEY"
firebase functions:config:set twitter.app_secret="SECRET_KEY"
# Access Token and Secret
firebase functions:config:set twitter.access_token="SECRET_KEY"
firebase functions:config:set twitter.access_secret="SECRET_KEY"
# Ava
firebase functions:config:set ava.workers="0 or 1 or 2"
firebase functions:config:set discord.bot.token="DISCORD_BOT_TOKEN"
firebase functions:config:get > .runtimeconfig.json
```

Then you need to re-deploy your functions

### Firestore indexes

```bash
# Get indexes
firebase firestore:indexes > firestore.indexes.json
# Deploy indexes from json config
firebase deploy --only firestore:indexes
```


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
npm run compile
```

<https://github.com/stripe/stripe-mock>

```bash
go get -u github.com/stripe/stripe-mock
```

```bash
# Mock Stripe
stripe-mock
# Mock Firebase
npm run serve
```

```bash
export FIREBASE_AUTH_EMULATOR_HOST="localhost:9099"
export FIRESTORE_EMULATOR_HOST="localhost:8080"
export FIREBASE_STORAGE_EMULATOR_HOST="localhost:9199"
```
