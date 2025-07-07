import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'select_students_admin_widget.dart' show SelectStudentsAdminWidget;
import 'package:flutter/material.dart';

class SelectStudentsAdminModel
    extends FlutterFlowModel<SelectStudentsAdminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  bool selectall = false;

  bool dontdisplay = true;

  List<DocumentReference> previousstudents = [];
  void addToPreviousstudents(DocumentReference item) =>
      previousstudents.add(item);
  void removeFromPreviousstudents(DocumentReference item) =>
      previousstudents.remove(item);
  void removeAtIndexFromPreviousstudents(int index) =>
      previousstudents.removeAt(index);
  void insertAtIndexInPreviousstudents(int index, DocumentReference item) =>
      previousstudents.insert(index, item);
  void updatePreviousstudentsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      previousstudents[index] = updateFn(previousstudents[index]);

  List<StudentListStruct> previousstudentsdata = [];
  void addToPreviousstudentsdata(StudentListStruct item) =>
      previousstudentsdata.add(item);
  void removeFromPreviousstudentsdata(StudentListStruct item) =>
      previousstudentsdata.remove(item);
  void removeAtIndexFromPreviousstudentsdata(int index) =>
      previousstudentsdata.removeAt(index);
  void insertAtIndexInPreviousstudentsdata(int index, StudentListStruct item) =>
      previousstudentsdata.insert(index, item);
  void updatePreviousstudentsdataAtIndex(
          int index, Function(StudentListStruct) updateFn) =>
      previousstudentsdata[index] = updateFn(previousstudentsdata[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in SelectStudentsAdmin widget.
  SchoolClassRecord? schoolDocument;
  // Stores action output result for [Custom Action - returnNewList] action in Register widget.
  List<StudentListStruct>? newlist;
  // Stores action output result for [Backend Call - Read Document] action in Register widget.
  StudentsRecord? studentReading;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
