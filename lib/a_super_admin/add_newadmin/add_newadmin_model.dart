import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_newadmin_widget.dart' show AddNewadminWidget;
import 'package:flutter/material.dart';

class AddNewadminModel extends FlutterFlowModel<AddNewadminWidget> {
  ///  Local state fields for this page.

  bool lastSet = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for ContactName widget.
  FocusNode? contactNameFocusNode;
  TextEditingController? contactNameTextController;
  String? Function(BuildContext, String?)? contactNameTextControllerValidator;
  String? _contactNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Admin\'s Name * is required';
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
      return 'Admin\'s Phone Number * is required';
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
      return 'Admin\'s Username / email* is required';
    }

    if (!RegExp(
            '^(?:[a-zA-Z0-9]+|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,})\$')
        .hasMatch(val)) {
      return 'Please enter valid email';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (Create Account)] action in Send widget.
  ApiCallResponse? createaccount2;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  UsersRecord? user;
  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  SchoolRecord? school;
  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  UsersRecord? princi;
  // Stores action output result for [Backend Call - API (Send Mail )] action in Send widget.
  ApiCallResponse? seandmail;

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
