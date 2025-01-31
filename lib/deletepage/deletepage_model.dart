import '/flutter_flow/flutter_flow_util.dart';
import 'deletepage_widget.dart' show DeletepageWidget;
import 'package:flutter/material.dart';

class DeletepageModel extends FlutterFlowModel<DeletepageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Reason widget.
  FocusNode? reasonFocusNode;
  TextEditingController? reasonTextController;
  String? Function(BuildContext, String?)? reasonTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    reasonFocusNode?.dispose();
    reasonTextController?.dispose();
  }
}
