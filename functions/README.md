# Langame functions

For further information, see Firebase [documentation](https://firebase.google.com/docs/functions)

## Installation

```bash
npm install -g firebase-tools
firebase login
firebase init firestore
firebase init functions
firebase emulators:start
```

## Usage

Run this command to deploy your functions:
```bash
firebase deploy --only functions
```

After you run this command, the Firebase CLI outputs the URL for any HTTP function endpoints. 
In your terminal, you should see a line like the following:

>Function URL (function): https://REGION-MY_PROJECT.cloudfunctions.net/function
