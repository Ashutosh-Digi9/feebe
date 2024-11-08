import '/flutter_flow/flutter_flow_util.dart';
import 'add_class2_admin_widget.dart' show AddClass2AdminWidget;
import 'package:flutter/material.dart';

class AddClass2AdminModel extends FlutterFlowModel<AddClass2AdminWidget> {
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
