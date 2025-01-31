const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.sendNotification = functions.https.onCall(async (data, context) => {
  const title = data.title;
  const description = data.description;
  const date = data.date;
  const useref = data.useref;

  if (!title || !description || !date || !useref) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields: title, description, date, or useref",
    );
  }

  // Calculate the previous date at 11 AM
  const targetDate = new Date(date);
  const notificationDate = new Date(targetDate);
  notificationDate.setDate(targetDate.getDate() - 1);
  notificationDate.setHours(13, 0, 0, 0);

  const now = new Date();
  if (notificationDate < now) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "The notification date is in the past",
    );
  }

  try {
    // Fetch the user document from Firestore
    const userDoc = await admin
      .firestore()
      .collection("users")
      .doc(useref)
      .get();

    if (!userDoc.exists || !userDoc.data().deviceToken) {
      throw new functions.https.HttpsError(
        "not-found",
        "No valid device token found for the user",
      );
    }

    const token = userDoc.data().deviceToken;

    // Create the notification payload
    const payload = {
      notification: {
        title: title,
        body: description,
      },
    };

    // Send the notification
    const response = await admin.messaging().sendToDevice(token, payload);

    console.log("Notification sent:", response);
    return {
      success: true,
      message: "Notification sent successfully",
      response,
    };
  } catch (error) {
    console.error("Error sending notification:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to send notification",
      error.message,
    );
  }
});
