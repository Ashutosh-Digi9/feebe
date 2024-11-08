import '/flutter_flow/flutter_flow_util.dart';
import 'add_parent_details_widget.dart' show AddParentDetailsWidget;
import 'package:flutter/material.dart';

class AddParentDetailsModel extends FlutterFlowModel<AddParentDetailsWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Parentname widget.
  FocusNode? parentnameFocusNode;
  TextEditingController? parentnameTextController;
  String? Function(BuildContext, String?)? parentnameTextControllerValidator;
  String? _parentnameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select parent\'s name';
    }

    return null;
  }

  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  String? _numberTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select number';
    }

    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode1;
  TextEditingController? emailTextController1;
  String? Function(BuildContext, String?)? emailTextController1Validator;
  String? _emailTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select email';
    }

    return null;
  }

  // State field(s) for guardianname widget.
  FocusNode? guardiannameFocusNode;
  TextEditingController? guardiannameTextController;
  String? Function(BuildContext, String?)? guardiannameTextControllerValidator;
  // State field(s) for guardiannumber widget.
  FocusNode? guardiannumberFocusNode;
  TextEditingController? guardiannumberTextController;
  String? Function(BuildContext, String?)?
      guardiannumberTextControllerValidator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode2;
  TextEditingController? emailTextController2;
  String? Function(BuildContext, String?)? emailTextController2Validator;

  @override
  void initState(BuildContext context) {
    parentnameTextControllerValidator = _parentnameTextControllerValidator;
    numberTextControllerValidator = _numberTextControllerValidator;
    emailTextController1Validator = _emailTextController1Validator;
  }

  @override
  void dispose() {
    parentnameFocusNode?.dispose();
    parentnameTextController?.dispose();

    numberFocusNode?.dispose();
    numberTextController?.dispose();

    emailFocusNode1?.dispose();
    emailTextController1?.dispose();

    guardiannameFocusNode?.dispose();
    guardiannameTextController?.dispose();

    guardiannumberFocusNode?.dispose();
    guardiannumberTextController?.dispose();

    emailFocusNode2?.dispose();
    emailTextController2?.dispose();
  }
}
