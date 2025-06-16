import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'select_teacher_notice_widget.dart' show SelectTeacherNoticeWidget;
import 'package:flutter/material.dart';

class SelectTeacherNoticeModel
    extends FlutterFlowModel<SelectTeacherNoticeWidget> {
  ///  Local state fields for this component.

  List<DocumentReference> schoolref = [];
  void addToSchoolref(DocumentReference item) => schoolref.add(item);
  void removeFromSchoolref(DocumentReference item) => schoolref.remove(item);
  void removeAtIndexFromSchoolref(int index) => schoolref.removeAt(index);
  void insertAtIndexInSchoolref(int index, DocumentReference item) =>
      schoolref.insert(index, item);
  void updateSchoolrefAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      schoolref[index] = updateFn(schoolref[index]);

  Color color = Color(4294967295);

  int everyone = 0;

  bool search = false;

  List<String> towhome = [];
  void addToTowhome(String item) => towhome.add(item);
  void removeFromTowhome(String item) => towhome.remove(item);
  void removeAtIndexFromTowhome(int index) => towhome.removeAt(index);
  void insertAtIndexInTowhome(int index, String item) =>
      towhome.insert(index, item);
  void updateTowhomeAtIndex(int index, Function(String) updateFn) =>
      towhome[index] = updateFn(towhome[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<TeachersRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
