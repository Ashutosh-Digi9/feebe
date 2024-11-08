import '/flutter_flow/flutter_flow_util.dart';
import 'edit_class2_widget.dart' show EditClass2Widget;
import 'package:flutter/material.dart';

class EditClass2Model extends FlutterFlowModel<EditClass2Widget> {
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
