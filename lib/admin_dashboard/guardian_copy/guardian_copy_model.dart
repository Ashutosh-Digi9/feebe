import '/flutter_flow/flutter_flow_util.dart';
import 'guardian_copy_widget.dart' show GuardianCopyWidget;
import 'package:flutter/material.dart';

class GuardianCopyModel extends FlutterFlowModel<GuardianCopyWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Gname widget.
  FocusNode? gnameFocusNode;
  TextEditingController? gnameTextController;
  String? Function(BuildContext, String?)? gnameTextControllerValidator;
  String? _gnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the Guardian\'s name';
    }

    return null;
  }

  // State field(s) for Gnumber widget.
  FocusNode? gnumberFocusNode;
  TextEditingController? gnumberTextController;
  String? Function(BuildContext, String?)? gnumberTextControllerValidator;
  String? _gnumberTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the number';
    }

    if (val.length > 10) {
      return 'Please enter the 10 digit valid number';
    }
    if (!RegExp('^[6-9]\\d{9}\$').hasMatch(val)) {
      return 'Please enter the valid number';
    }
    return null;
  }

  // State field(s) for Gemail widget.
  FocusNode? gemailFocusNode;
  TextEditingController? gemailTextController;
  String? Function(BuildContext, String?)? gemailTextControllerValidator;
  String? _gemailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the Email / Username';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    gnameTextControllerValidator = _gnameTextControllerValidator;
    gnumberTextControllerValidator = _gnumberTextControllerValidator;
    gemailTextControllerValidator = _gemailTextControllerValidator;
  }

  @override
  void dispose() {
    gnameFocusNode?.dispose();
    gnameTextController?.dispose();

    gnumberFocusNode?.dispose();
    gnumberTextController?.dispose();

    gemailFocusNode?.dispose();
    gemailTextController?.dispose();
  }
}
