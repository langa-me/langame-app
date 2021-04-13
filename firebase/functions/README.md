# Langame functions

For further information, see Firebase [documentation](https://firebase.google.com/docs/functions)

## Installation

```bash
npm install -g firebase-tools
firebase login
```

### Secrets

```bash
firebase functions:config:set agora.id="THE AGORA APP ID" agora.certificate="THE AGORA CERTIFICATE" github.token="THE GITHUB TOKEN"
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

## Test

```bash
export GOOGLE_APPLICATION_CREDENTIALS="path/to/key.json"
```
