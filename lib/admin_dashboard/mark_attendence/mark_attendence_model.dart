import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'mark_attendence_widget.dart' show MarkAttendenceWidget;
import 'package:flutter/material.dart';

class MarkAttendenceModel extends FlutterFlowModel<MarkAttendenceWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> presentStudents = [];
  void addToPresentStudents(DocumentReference item) =>
      presentStudents.add(item);
  void removeFromPresentStudents(DocumentReference item) =>
      presentStudents.remove(item);
  void removeAtIndexFromPresentStudents(int index) =>
      presentStudents.removeAt(index);
  void insertAtIndexInPresentStudents(int index, DocumentReference item) =>
      presentStudents.insert(index, item);
  void updatePresentStudentsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      presentStudents[index] = updateFn(presentStudents[index]);

  bool selectAll = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in submit widget.
  StudentsRecord? student;
  // Stores action output result for [Firestore Query - Query a collection] action in submit widget.
  List<StudentsRecord>? students123;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
