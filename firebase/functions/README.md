# Langame functions

For further information, see Firebase [documentation](https://firebase.google.com/docs/functions)

## Installation

```bash
npm install -g firebase-tools
firebase login
firebase remoteconfig:get > remoteconfig.template.json
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
firebase functions:config:get > .runtimeconfig.json
```

Then you need to re-deploy your functions

#### Service account dev


```bash
zip service-account.zip langame-dev-8ac76897c7bc.json
gpg --symmetric --cipher-algo AES256 service-account.zip
rm -rf service-account.zip
```


```bash
gpg --output release.zip --decrypt release.zip.gpg && unzip release.zip && rm -rf release.zip
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
```
