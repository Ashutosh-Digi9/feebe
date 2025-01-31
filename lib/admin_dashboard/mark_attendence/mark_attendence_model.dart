import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'mark_attendence_widget.dart' show MarkAttendenceWidget;
import 'package:flutter/material.dart';

class MarkAttendenceModel extends FlutterFlowModel<MarkAttendenceWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> alreadypresentStudents = [];
  void addToAlreadypresentStudents(DocumentReference item) =>
      alreadypresentStudents.add(item);
  void removeFromAlreadypresentStudents(DocumentReference item) =>
      alreadypresentStudents.remove(item);
  void removeAtIndexFromAlreadypresentStudents(int index) =>
      alreadypresentStudents.removeAt(index);
  void insertAtIndexInAlreadypresentStudents(
          int index, DocumentReference item) =>
      alreadypresentStudents.insert(index, item);
  void updateAlreadypresentStudentsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      alreadypresentStudents[index] = updateFn(alreadypresentStudents[index]);

  bool selectAll = false;

  List<StudentAttendanceStruct> studentdatatattendance = [];
  void addToStudentdatatattendance(StudentAttendanceStruct item) =>
      studentdatatattendance.add(item);
  void removeFromStudentdatatattendance(StudentAttendanceStruct item) =>
      studentdatatattendance.remove(item);
  void removeAtIndexFromStudentdatatattendance(int index) =>
      studentdatatattendance.removeAt(index);
  void insertAtIndexInStudentdatatattendance(
          int index, StudentAttendanceStruct item) =>
      studentdatatattendance.insert(index, item);
  void updateStudentdatatattendanceAtIndex(
          int index, Function(StudentAttendanceStruct) updateFn) =>
      studentdatatattendance[index] = updateFn(studentdatatattendance[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in mark_attendence widget.
  SchoolClassRecord? classes;
  // Stores action output result for [Firestore Query - Query a collection] action in submit widget.
  List<StudentsRecord>? students123;
  // Stores action output result for [Firestore Query - Query a collection] action in submit widget.
  List<StudentsRecord>? students1234;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
