importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp(firebaseConfig = {
  apiKey: "AIzaSyDxLmqscMfKF6FUd_rXcsJxH--w0PQhVWw",
  authDomain: "langame-86ac4.firebaseapp.com",
  projectId: "langame-86ac4",
  storageBucket: "langame-86ac4.appspot.com",
  messagingSenderId: "909899959016",
  appId: "1:909899959016:web:b2bd243695699c9dc0575d",
  measurementId: "G-EGYQC8EDSH"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  // console.log("onBackgroundMessage", m);
});