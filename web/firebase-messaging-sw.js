importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
      apiKey: "AIzaSyDTNwlxO_g0PCTiGj2lLDyyUrlHkjM-Qv8",
      authDomain: "justfood-f9f0c.firebaseapp.com",
      projectId: "justfood-f9f0c",
      storageBucket: "justfood-f9f0c.appspot.com",
      messagingSenderId: "969076753609",
      appId: "1:969076753609:web:90c72ff51fa5d2b4163918",
      measurementId: "G-FZP89LK9B9",
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});