const admin = require("firebase-admin/app");
admin.initializeApp();

const cleanupOldNotifications = require("./cleanup_old_notifications.js");
exports.cleanupOldNotifications =
  cleanupOldNotifications.cleanupOldNotifications;
const sendNotification = require("./send_notification.js");
exports.sendNotification = sendNotification.sendNotification;
