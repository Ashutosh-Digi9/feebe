import '/flutter_flow/flutter_flow_util.dart';
import 'signup_s_a_widget.dart' show SignupSAWidget;
import 'package:flutter/material.dart';

class SignupSAModel extends FlutterFlowModel<SignupSAWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
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

    if (!RegExp('^\\d{10}\$').hasMatch(val)) {
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
      return 'Please enter email ';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Please enter valid email';
    }
    return null;
  }

  // State field(s) for Password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter Password';
    }

    if (!RegExp('^(?=.*[a-z])(?=.*[A-Z])[a-zA-Z]{8,50}\$').hasMatch(val)) {
      return 'Enter Valid password ';
    }
    return null;
  }

  // State field(s) for ConfirmPassword widget.
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordTextController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)?
      confirmPasswordTextControllerValidator;
  String? _confirmPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter confrim Password';
    }

    if (!RegExp('^(?=.*[a-z])(?=.*[A-Z])[a-zA-Z]{8,50}\$').hasMatch(val)) {
      return 'Enter Valid Password';
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    contactNameTextControllerValidator = _contactNameTextControllerValidator;
    contactPhonenumberTextControllerValidator =
        _contactPhonenumberTextControllerValidator;
    contactemailTextControllerValidator = _contactemailTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
    confirmPasswordVisibility = false;
    confirmPasswordTextControllerValidator =
        _confirmPasswordTextControllerValidator;
  }

  @override
  void dispose() {
    contactNameFocusNode?.dispose();
    contactNameTextController?.dispose();

    contactPhonenumberFocusNode?.dispose();
    contactPhonenumberTextController?.dispose();

    contactemailFocusNode?.dispose();
    contactemailTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    confirmPasswordFocusNode?.dispose();
    confirmPasswordTextController?.dispose();
  }
}
