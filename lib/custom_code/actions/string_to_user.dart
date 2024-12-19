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

Future<DocumentReference> stringToUser(String stringToUserRef) async {
  if (stringToUserRef.isEmpty) {
    throw Exception("The userRef string is empty.");
  }

  try {
    // Convert the string into a DocumentReference
    DocumentReference userRef = FirebaseFirestore.instance.doc(stringToUserRef);

    // Return the DocumentReference
    return userRef;
  } catch (e) {
    throw Exception("Failed to convert string to DocumentReference: $e");
  }
  // Add your function code here!
}
