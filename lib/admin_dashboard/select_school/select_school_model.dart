import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'select_school_widget.dart' show SelectSchoolWidget;
import 'package:flutter/material.dart';

class SelectSchoolModel extends FlutterFlowModel<SelectSchoolWidget> {
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

  Color color = const Color(0xffffffff);

  int everyone = 0;

  bool search = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<String> simpleSearchResults = [];
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
