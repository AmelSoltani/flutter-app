
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();
export const sendToDevice = functions.firestore
  .document('temp/{tempId}')
  .onCreate(async snapshot => {

    const temp = snapshot.data().collection('temp').doc('documentID');
    const querySnapshot = await db
      .collection('users')
      .doc('documentID')
      .collection('tokens')
      .get();

    const tokens = querySnapshot.docs.map((snap: { id: any; }) => snap.id);

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: 'detection de temperature ',
        body: `La temperature detectée dans votre endroit :  ${temp.temperature} le ${temp.date}`,
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };

    return fcm.sendToDevice(tokens, payload);
  });