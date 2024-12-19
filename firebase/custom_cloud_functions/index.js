const admin = require("firebase-admin/app");
admin.initializeApp();

const cleanupOldNotifications = require("./cleanup_old_notifications.js");
exports.cleanupOldNotifications =
  cleanupOldNotifications.cleanupOldNotifications;
