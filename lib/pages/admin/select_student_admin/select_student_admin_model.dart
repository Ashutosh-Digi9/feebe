import '/flutter_flow/flutter_flow_util.dart';
import 'select_student_admin_widget.dart' show SelectStudentAdminWidget;
import 'package:flutter/material.dart';

class SelectStudentAdminModel
    extends FlutterFlowModel<SelectStudentAdminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Students widget.
  FocusNode? studentsFocusNode;
  TextEditingController? studentsTextController;
  String? Function(BuildContext, String?)? studentsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    studentsFocusNode?.dispose();
    studentsTextController?.dispose();
  }
}
