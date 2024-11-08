import '/flutter_flow/flutter_flow_util.dart';
import 'add_class_admin_widget.dart' show AddClassAdminWidget;
import 'package:flutter/material.dart';

class AddClassAdminModel extends FlutterFlowModel<AddClassAdminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for className widget.
  FocusNode? classNameFocusNode;
  TextEditingController? classNameTextController;
  String? Function(BuildContext, String?)? classNameTextControllerValidator;
  // State field(s) for Teachers widget.
  FocusNode? teachersFocusNode;
  TextEditingController? teachersTextController;
  String? Function(BuildContext, String?)? teachersTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    classNameFocusNode?.dispose();
    classNameTextController?.dispose();

    teachersFocusNode?.dispose();
    teachersTextController?.dispose();
  }
}
