import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
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

  int pageindex = 0;

  List<DocumentReference> checkoutstudentlist = [];
  void addToCheckoutstudentlist(DocumentReference item) =>
      checkoutstudentlist.add(item);
  void removeFromCheckoutstudentlist(DocumentReference item) =>
      checkoutstudentlist.remove(item);
  void removeAtIndexFromCheckoutstudentlist(int index) =>
      checkoutstudentlist.removeAt(index);
  void insertAtIndexInCheckoutstudentlist(int index, DocumentReference item) =>
      checkoutstudentlist.insert(index, item);
  void updateCheckoutstudentlistAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      checkoutstudentlist[index] = updateFn(checkoutstudentlist[index]);

  List<StudentAttendanceStruct> checkoutdata = [];
  void addToCheckoutdata(StudentAttendanceStruct item) =>
      checkoutdata.add(item);
  void removeFromCheckoutdata(StudentAttendanceStruct item) =>
      checkoutdata.remove(item);
  void removeAtIndexFromCheckoutdata(int index) => checkoutdata.removeAt(index);
  void insertAtIndexInCheckoutdata(int index, StudentAttendanceStruct item) =>
      checkoutdata.insert(index, item);
  void updateCheckoutdataAtIndex(
          int index, Function(StudentAttendanceStruct) updateFn) =>
      checkoutdata[index] = updateFn(checkoutdata[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in mark_attendence widget.
  SchoolClassRecord? classes;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Firestore Query - Query a collection] action in submit widget.
  List<StudentsRecord>? students123;
  // Stores action output result for [Backend Call - Read Document] action in submit widget.
  StudentsRecord? studentnoti;
  // Stores action output result for [Firestore Query - Query a collection] action in submit widget.
  List<StudentsRecord>? students1234;
  // Stores action output result for [Backend Call - Read Document] action in submit widget.
  StudentsRecord? studentnoti1;
  // Stores action output result for [Firestore Query - Query a collection] action in submit widget.
  List<StudentsRecord>? students123458;
  // Stores action output result for [Backend Call - Read Document] action in submit widget.
  StudentsRecord? studentnoti2;
  // Stores action output result for [Firestore Query - Query a collection] action in submit widget.
  List<StudentsRecord>? students12345;
  // Stores action output result for [Backend Call - Read Document] action in submit widget.
  StudentsRecord? studentnoti3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
