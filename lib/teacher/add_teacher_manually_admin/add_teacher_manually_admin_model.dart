import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_teacher_manually_admin_widget.dart'
    show AddTeacherManuallyAdminWidget;
import 'package:flutter/material.dart';

class AddTeacherManuallyAdminModel
    extends FlutterFlowModel<AddTeacherManuallyAdminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  bool lastfield = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  String currentPageLink = '';
  // State field(s) for ContactName widget.
  FocusNode? contactNameFocusNode;
  TextEditingController? contactNameTextController;
  String? Function(BuildContext, String?)? contactNameTextControllerValidator;
  String? _contactNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter name ';
    }

    return null;
  }

  // State field(s) for ContactPhonenumber widget.
  FocusNode? contactPhonenumberFocusNode;
  TextEditingController? contactPhonenumberTextController;
  String? Function(BuildContext, String?)?
      contactPhonenumberTextControllerValidator;
  String? _contactPhonenumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter phone number ';
    }

    if (val.length > 10) {
      return 'Please enter a valid 10-digit phone number.';
    }
    if (!RegExp('^[6-9]\\d{9}\$').hasMatch(val)) {
      return 'Please enter a valid phone number ';
    }
    return null;
  }

  // State field(s) for Contactemail widget.
  FocusNode? contactemailFocusNode;
  TextEditingController? contactemailTextController;
  String? Function(BuildContext, String?)? contactemailTextControllerValidator;
  String? _contactemailTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter email  / user name';
    }

    if (!RegExp(
            '^(?:[a-zA-Z0-9]+|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,})\$')
        .hasMatch(val)) {
      return 'Please enter valid email';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (Create Account)] action in Send widget.
  ApiCallResponse? teacherApi;
  // Stores action output result for [Custom Action - stringToUser] action in Send widget.
  DocumentReference? teacherref;
  // Stores action output result for [Backend Call - Create Document] action in Send widget.
  TeachersRecord? teacher;
  // Stores action output result for [Backend Call - API (Send Mail )] action in Send widget.
  ApiCallResponse? teacheremail;

  @override
  void initState(BuildContext context) {
    contactNameTextControllerValidator = _contactNameTextControllerValidator;
    contactPhonenumberTextControllerValidator =
        _contactPhonenumberTextControllerValidator;
    contactemailTextControllerValidator = _contactemailTextControllerValidator;
  }

  @override
  void dispose() {
    contactNameFocusNode?.dispose();
    contactNameTextController?.dispose();

    contactPhonenumberFocusNode?.dispose();
    contactPhonenumberTextController?.dispose();

    contactemailFocusNode?.dispose();
    contactemailTextController?.dispose();
  }
}
