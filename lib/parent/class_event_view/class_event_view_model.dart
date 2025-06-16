import '/flutter_flow/flutter_flow_util.dart';
import 'class_event_view_widget.dart' show ClassEventViewWidget;
import 'package:flutter/material.dart';

class ClassEventViewModel extends FlutterFlowModel<ClassEventViewWidget> {
  ///  Local state fields for this component.

  bool viewpdf = false;

  bool viewdoc = false;

  bool viewmp3 = false;

  bool viewimg = false;

  bool viewppt = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Eventname widget.
  FocusNode? eventnameFocusNode;
  TextEditingController? eventnameTextController;
  String? Function(BuildContext, String?)? eventnameTextControllerValidator;
  // State field(s) for Description widget.
  FocusNode? descriptionFocusNode1;
  TextEditingController? descriptionTextController1;
  String? Function(BuildContext, String?)? descriptionTextController1Validator;
  // State field(s) for Description widget.
  FocusNode? descriptionFocusNode2;
  TextEditingController? descriptionTextController2;
  String? Function(BuildContext, String?)? descriptionTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    eventnameFocusNode?.dispose();
    eventnameTextController?.dispose();

    descriptionFocusNode1?.dispose();
    descriptionTextController1?.dispose();

    descriptionFocusNode2?.dispose();
    descriptionTextController2?.dispose();
  }
}
