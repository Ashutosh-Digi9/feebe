const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Ensure admin is initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();

// Cloud Function to delete notifications older than one month
exports.cleanupOldNotifications = functions.pubsub
  .schedule("every 24 hours")
  .onRun(async (context) => {
    const oneMonthAgo = new Date();
    oneMonthAgo.setMonth(oneMonthAgo.getMonth() - 1);

    try {
      const notificationsRef = db.collection("Notifications"); // Replace with your collection name
      const oldNotificationsQuery = await notificationsRef
        .where("timestamp", "<", oneMonthAgo) // Assuming 'timestamp' is the field storing notification creation time
        .get();

      if (oldNotificationsQuery.empty) {
        console.log("No notifications older than one month to delete.");
        return null;
      }

      const batch = db.batch();
      oldNotificationsQuery.forEach((doc) => {
        batch.delete(doc.ref);
      });

      await batch.commit();
      console.log(`Deleted ${oldNotificationsQuery.size} old notifications.`);
    } catch (error) {
      console.error("Error cleaning up old notifications:", error);
    }

    return null;
  });
