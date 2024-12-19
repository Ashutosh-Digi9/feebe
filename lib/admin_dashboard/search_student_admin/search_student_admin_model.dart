import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_student_admin_widget.dart' show SearchStudentAdminWidget;
import 'package:flutter/material.dart';

class SearchStudentAdminModel
    extends FlutterFlowModel<SearchStudentAdminWidget> {
  ///  Local state fields for this component.

  bool searchstudent = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for students widget.
  FocusNode? studentsFocusNode;
  TextEditingController? studentsTextController;
  String? Function(BuildContext, String?)? studentsTextControllerValidator;
  List<StudentsRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    studentsFocusNode?.dispose();
    studentsTextController?.dispose();
  }
}
