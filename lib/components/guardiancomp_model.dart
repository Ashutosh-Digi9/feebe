import '/flutter_flow/flutter_flow_util.dart';
import 'guardiancomp_widget.dart' show GuardiancompWidget;
import 'package:flutter/material.dart';

class GuardiancompModel extends FlutterFlowModel<GuardiancompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Gname widget.
  FocusNode? gnameFocusNode;
  TextEditingController? gnameTextController;
  String? Function(BuildContext, String?)? gnameTextControllerValidator;
  // State field(s) for Gnumber widget.
  FocusNode? gnumberFocusNode;
  TextEditingController? gnumberTextController;
  String? Function(BuildContext, String?)? gnumberTextControllerValidator;
  // State field(s) for Gemail widget.
  FocusNode? gemailFocusNode;
  TextEditingController? gemailTextController;
  String? Function(BuildContext, String?)? gemailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

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
