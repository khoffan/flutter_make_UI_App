const express = require('express');
const admin = require('firebase-admin');
const serviceAccount = require('../key/flutter-app-41ed4-firebase-adminsdk-wy9oy-d7af54dacb.json'); // Replace with your actual path

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const app = express();
const db = admin.firestore();

// Define a route to retrieve data from Firestore
app.get('/getUser', (req, res) => {

  const userRef = db.collection('Users');

  userRef.get()
    .then((snapshot) => {
      const userData = []
      snapshot.forEach((doc) => {
        userData.push(doc.data());
      })
      res.status(200).json(userData)
    })
    .catch((error) => {
      res.status(500).json({ message: 'Error getting document', error });
    });
});

app.get('/getUserProfile', (req, res) => {

  const userRef = db.collection('userProfile');

  userRef.get()
    .then((snapshot) => {
      const userData = []
      snapshot.forEach((doc) => {
        userData.push(doc.data());
      })
      res.status(200).json(userData)
    })
    .catch((error) => {
      res.status(500).json({ message: 'Error getting document', error });
    });
});

app.get('/getContent', async (req, res) => {
    try{
        const contentSnapshot = await db.collection('contents').get();
        const contentsData = [];

        for(contentDoc of contentSnapshot.docs){
            const content = contentDoc.data();

            const subCollectionSmapshot = await contentDoc.ref.collection("contentUser").get();
            const subcollectionData = [];

            subCollectionSmapshot.forEach((subDoc) => {
                subcollectionData.push(subDoc.data());
            })

            content.contentUser = subcollectionData;
            contentsData.push(content);
        }
        res.status(200).json(contentsData);
        console.log(contentsData)
    }catch (e){
        res.status(500).json({ message: 'Error getting documents', e });
    }
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
