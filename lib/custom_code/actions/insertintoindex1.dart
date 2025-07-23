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

Future<List<ParentsDetailsStruct>> insertintoindex1(
  List<ParentsDetailsStruct>? parentListdetails,
  DocumentReference? useref,
) async {
  if (parentListdetails == null || useref == null) {
    return parentListdetails ?? [];
  }

  // Find the index of the item with the matching useref
  final index =
      parentListdetails.indexWhere((element) => element.userRef == useref);

  // If not found or already at index 1, return the original list
  if (index == -1 || index == 1) {
    return parentListdetails;
  }

  // Make a mutable copy of the list
  final updatedList = List<ParentsDetailsStruct>.from(parentListdetails);

  // Remove the item from its current position
  final matchedItem = updatedList.removeAt(index);

  // Insert the item at index 1
  updatedList.insert(1, matchedItem);

  return updatedList;
}
