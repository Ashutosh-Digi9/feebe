import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_profile_s_a_widget.dart' show EditProfileSAWidget;
import 'package:flutter/material.dart';

class EditProfileSAModel extends FlutterFlowModel<EditProfileSAWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Cloud Function - cleanupOldNotifications] action in EditProfile_SA widget.
  CleanupOldNotificationsCloudFunctionCallResponse? cloudFunction0w5;
  // State field(s) for UserName widget.
  FocusNode? userNameFocusNode;
  TextEditingController? userNameTextController;
  String? Function(BuildContext, String?)? userNameTextControllerValidator;
  String? _userNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please Enter User Name';
    }

    return null;
  }

  // State field(s) for PhoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  String? _phoneNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter Phone number';
    }

    if (val.length > 10) {
      return 'Please enter a valid 10-digit phone number.';
    }
    if (!RegExp('^[6-9]\\d{9}\$').hasMatch(val)) {
      return 'Please enter a valid 10-digit phone number.';
    }
    return null;
  }

  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Pleas enter  the Email';
    }

    if (!RegExp('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}\$')
        .hasMatch(val)) {
      return 'Please enter valid Email ';
    }
    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  TeachersRecord? teacher;
  // Stores action output result for [Firestore Query - Query a collection] action in SaveChanges widget.
  TeachersRecord? teacherProfile;

  @override
  void initState(BuildContext context) {
    userNameTextControllerValidator = _userNameTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
  }

  @override
  void dispose() {
    userNameFocusNode?.dispose();
    userNameTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
