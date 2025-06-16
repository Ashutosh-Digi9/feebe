import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'selectedstudents_sadmin_widget.dart' show SelectedstudentsSadminWidget;
import 'package:flutter/material.dart';

class SelectedstudentsSadminModel
    extends FlutterFlowModel<SelectedstudentsSadminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  bool selectall = false;

  bool dontdisplay = true;

  List<DocumentReference> previousstudentsuserref = [];
  void addToPreviousstudentsuserref(DocumentReference item) =>
      previousstudentsuserref.add(item);
  void removeFromPreviousstudentsuserref(DocumentReference item) =>
      previousstudentsuserref.remove(item);
  void removeAtIndexFromPreviousstudentsuserref(int index) =>
      previousstudentsuserref.removeAt(index);
  void insertAtIndexInPreviousstudentsuserref(
          int index, DocumentReference item) =>
      previousstudentsuserref.insert(index, item);
  void updatePreviousstudentsuserrefAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      previousstudentsuserref[index] = updateFn(previousstudentsuserref[index]);

  List<StudentListStruct> previousstudentsdatatype = [];
  void addToPreviousstudentsdatatype(StudentListStruct item) =>
      previousstudentsdatatype.add(item);
  void removeFromPreviousstudentsdatatype(StudentListStruct item) =>
      previousstudentsdatatype.remove(item);
  void removeAtIndexFromPreviousstudentsdatatype(int index) =>
      previousstudentsdatatype.removeAt(index);
  void insertAtIndexInPreviousstudentsdatatype(
          int index, StudentListStruct item) =>
      previousstudentsdatatype.insert(index, item);
  void updatePreviousstudentsdatatypeAtIndex(
          int index, Function(StudentListStruct) updateFn) =>
      previousstudentsdatatype[index] =
          updateFn(previousstudentsdatatype[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in selectedstudents_sadmin widget.
  SchoolClassRecord? schoolclassDocument;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
