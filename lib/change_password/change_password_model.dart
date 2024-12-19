import '/flutter_flow/flutter_flow_util.dart';
import 'change_password_widget.dart' show ChangePasswordWidget;
import 'package:flutter/material.dart';

class ChangePasswordModel extends FlutterFlowModel<ChangePasswordWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for OldPassword widget.
  FocusNode? oldPasswordFocusNode;
  TextEditingController? oldPasswordTextController;
  late bool oldPasswordVisibility;
  String? Function(BuildContext, String?)? oldPasswordTextControllerValidator;
  String? _oldPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter old password ';
    }

    return null;
  }

  // State field(s) for NewPassword widget.
  FocusNode? newPasswordFocusNode;
  TextEditingController? newPasswordTextController;
  late bool newPasswordVisibility;
  String? Function(BuildContext, String?)? newPasswordTextControllerValidator;
  String? _newPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter new password ';
    }

    return null;
  }

  // State field(s) for ConfimPassword widget.
  FocusNode? confimPasswordFocusNode;
  TextEditingController? confimPasswordTextController;
  late bool confimPasswordVisibility;
  String? Function(BuildContext, String?)?
      confimPasswordTextControllerValidator;
  String? _confimPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter confirm password ';
    }

    return null;
  }

  // Stores action output result for [Custom Action - changePassword] action in Save widget.
  bool? changedpassword;

  @override
  void initState(BuildContext context) {
    oldPasswordVisibility = false;
    oldPasswordTextControllerValidator = _oldPasswordTextControllerValidator;
    newPasswordVisibility = false;
    newPasswordTextControllerValidator = _newPasswordTextControllerValidator;
    confimPasswordVisibility = false;
    confimPasswordTextControllerValidator =
        _confimPasswordTextControllerValidator;
  }

  @override
  void dispose() {
    oldPasswordFocusNode?.dispose();
    oldPasswordTextController?.dispose();

    newPasswordFocusNode?.dispose();
    newPasswordTextController?.dispose();

    confimPasswordFocusNode?.dispose();
    confimPasswordTextController?.dispose();
  }
}
