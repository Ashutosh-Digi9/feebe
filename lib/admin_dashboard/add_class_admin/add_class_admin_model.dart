import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_class_admin_widget.dart' show AddClassAdminWidget;
import 'package:flutter/material.dart';

class AddClassAdminModel extends FlutterFlowModel<AddClassAdminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  bool selectAllTeachers = false;

  bool selectAllStudents = false;

  String? classname = '';

  bool creatingclass = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for className widget.
  FocusNode? classNameFocusNode;
  TextEditingController? classNameTextController;
  String? Function(BuildContext, String?)? classNameTextControllerValidator;
  String? _classNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the class name';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Create Document] action in createclass widget.
  SchoolClassRecord? classcreated;
  // Stores action output result for [Backend Call - Read Document] action in createclass widget.
  StudentsRecord? studentsele;

  @override
  void initState(BuildContext context) {
    classNameTextControllerValidator = _classNameTextControllerValidator;
  }

  @override
  void dispose() {
    classNameFocusNode?.dispose();
    classNameTextController?.dispose();
  }
}
