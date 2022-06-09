import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {MessagingPayload} from "firebase-admin/lib/messaging/messaging-api";

admin.initializeApp();

export const sendNotifications = functions.firestore
    .document("/notifications/{notificationId}")
    .onCreate(async (snap) => {
      const users: User[] = (await admin.firestore().collection("users").get())
          .docs.map((doc) => doc.data() as User);
      const notification: Notification = snap.data() as Notification;


      const tokens = [...new Set(users.map((user) => user.fcmToken))];

      const payload: MessagingPayload = {
        notification: {
          title: notification.title,
          body: notification.body,
        },
      };

      console.log("Sending notification to: ", tokens);

      admin.messaging().sendToDevice(tokens, payload);
    });

interface User{
    fcmToken: string;
    id: string;
}

interface Notification {
    title: string;
    body: string;
}
