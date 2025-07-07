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

Future<List<StudentListStruct>> returnNewList(
  List<StudentListStruct> previusList,
  List<StudentListStruct> newList,
) async {
  // Add your function code here!
  final previousIds = previusList.map((e) => e.studentId).toSet();

  final result = newList
      .where((student) => !previousIds.contains(student.studentId))
      .toList();

  return result;
}
