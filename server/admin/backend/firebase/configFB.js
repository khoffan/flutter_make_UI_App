const admin = require('firebase-admin');

const serviceAccount = require('../../key/flutter-app-41ed4-firebase-adminsdk-wy9oy-d7af54dacb.json'); // Replace with your actual path
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

export default {db}