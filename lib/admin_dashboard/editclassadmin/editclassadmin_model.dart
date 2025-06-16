import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'editclassadmin_widget.dart' show EditclassadminWidget;
import 'package:flutter/material.dart';

class EditclassadminModel extends FlutterFlowModel<EditclassadminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  bool selectAllTeachers = false;

  bool selectAllStudents = false;

  DocumentReference? classteacher;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in editclassadmin widget.
  SchoolClassRecord? classSchool;
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
