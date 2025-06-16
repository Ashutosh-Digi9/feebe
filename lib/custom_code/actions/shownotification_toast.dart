// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/auth/firebase_auth/auth_util.dart';

StreamSubscription? _notificationSubscription;
int? _previousDocCount;

Future shownotificationToast() async {
  // Schedule the listener to attach after a short delay so that runApp() can finish.
  Timer(Duration(seconds: 1), () async {
    // Wait until the current user is available, but don't block indefinitely.
    int attempts = 0;
    while (currentUserReference == null && attempts < 20) {
      await Future.delayed(Duration(milliseconds: 500));
      attempts++;
    }
    if (currentUserReference == null) {
      print(
          "User is still not logged in after waiting; aborting notification listener.");
      return;
    }

    final userDocRef = currentUserReference!;
    print(
        "Starting notification listener for user reference: ${userDocRef.path}");

    _notificationSubscription = FirebaseFirestore.instance
        .collection('Notifications')
        .snapshots()
        .listen((querySnapshot) {
      int currentDocCount = querySnapshot.docs.length;
      print("Current document count: $currentDocCount");

      // For the first snapshot, store the count and don't show notifications.
      if (_previousDocCount == null) {
        _previousDocCount = currentDocCount;
        print("Initial document count stored: $_previousDocCount");
        return;
      }

      // Check if new documents have been added.
      if (currentDocCount > _previousDocCount!) {
        print(
            "Document count increased from $_previousDocCount to $currentDocCount");
        for (var change in querySnapshot.docChanges) {
          if (change.type == DocumentChangeType.added) {
            final docData = change.doc.data() as Map<String, dynamic>?;
            if (docData != null) {
              final userRefs = docData['userref'];
              print("New document added with useref: $userRefs");
              if (userRefs != null) {
                // Loop through the list and compare DocumentReference objects directly.
                for (final ref in userRefs) {
                  if (ref is DocumentReference) {
                    if (ref == userDocRef) {
                      print(
                          "User reference found in new document. Showing toast.");
                      Fluttertoast.showToast(
                        msg: "You Have A New Notification !!!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                      );
                      // Stop checking after showing the toast.
                      break;
                    }
                  }
                }
              }
            }
          }
        }
      } else {
        print("No increase in document count detected.");
      }

      _previousDocCount = currentDocCount;
    });
  });

  // Return immediately so that main() isn't blocked.
  return;
}

// Optional: Call this function to cancel the listener when it's no longer needed.
void cancelNotificationSubscription() {
  print("Cancelling notification subscription.");
  _notificationSubscription?.cancel();
  _notificationSubscription = null;
}
