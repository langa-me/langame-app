# Langame functions

For further information, see Firebase [documentation](https://firebase.google.com/docs/functions)

## Installation

```bash
npm install -g firebase-tools
firebase login
```

### Secrets

```bash
firebase functions:config:set agora.app.id="THE AGORA APP ID" agora.app.certificate="THE AGORA CERTIFICATE"
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
