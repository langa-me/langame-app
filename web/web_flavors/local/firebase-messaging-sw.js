importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyBA_lBzVBjwkHx8X3PUl6Vz_sA__K8mCF0",
  authDomain: "langame-dev.firebaseapp.com",
  projectId: "langame-dev",
  storageBucket: "langame-dev.appspot.com",
  messagingSenderId: "388264600961",
  appId: "1:388264600961:web:1de4223ac5e7a3020cf480",
  measurementId: "G-MNLV4NH9PP"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  // console.log("onBackgroundMessage", m);
});