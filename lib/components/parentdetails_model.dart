import '/flutter_flow/flutter_flow_util.dart';
import 'parentdetails_widget.dart' show ParentdetailsWidget;
import 'package:flutter/material.dart';

class ParentdetailsModel extends FlutterFlowModel<ParentdetailsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Parentname1 widget.
  FocusNode? parentname1FocusNode;
  TextEditingController? parentname1TextController;
  String? Function(BuildContext, String?)? parentname1TextControllerValidator;
  // State field(s) for number1 widget.
  FocusNode? number1FocusNode;
  TextEditingController? number1TextController;
  String? Function(BuildContext, String?)? number1TextControllerValidator;
  // State field(s) for email1 widget.
  FocusNode? email1FocusNode;
  TextEditingController? email1TextController;
  String? Function(BuildContext, String?)? email1TextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    parentname1FocusNode?.dispose();
    parentname1TextController?.dispose();

    number1FocusNode?.dispose();
    number1TextController?.dispose();

    email1FocusNode?.dispose();
    email1TextController?.dispose();
  }
}
