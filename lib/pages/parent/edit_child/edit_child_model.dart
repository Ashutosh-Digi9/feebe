import '/flutter_flow/flutter_flow_util.dart';
import 'edit_child_widget.dart' show EditChildWidget;
import 'package:flutter/material.dart';

class EditChildModel extends FlutterFlowModel<EditChildWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Name widget.
  FocusNode? nameFocusNode1;
  TextEditingController? nameTextController1;
  String? Function(BuildContext, String?)? nameTextController1Validator;
  // State field(s) for dob widget.
  FocusNode? dobFocusNode1;
  TextEditingController? dobTextController1;
  String? Function(BuildContext, String?)? dobTextController1Validator;
  // State field(s) for bloodtype widget.
  FocusNode? bloodtypeFocusNode1;
  TextEditingController? bloodtypeTextController1;
  String? Function(BuildContext, String?)? bloodtypeTextController1Validator;
  // State field(s) for Allergies widget.
  FocusNode? allergiesFocusNode1;
  TextEditingController? allergiesTextController1;
  String? Function(BuildContext, String?)? allergiesTextController1Validator;
  // State field(s) for Name widget.
  FocusNode? nameFocusNode2;
  TextEditingController? nameTextController2;
  String? Function(BuildContext, String?)? nameTextController2Validator;
  // State field(s) for dob widget.
  FocusNode? dobFocusNode2;
  TextEditingController? dobTextController2;
  String? Function(BuildContext, String?)? dobTextController2Validator;
  // State field(s) for bloodtype widget.
  FocusNode? bloodtypeFocusNode2;
  TextEditingController? bloodtypeTextController2;
  String? Function(BuildContext, String?)? bloodtypeTextController2Validator;
  // State field(s) for Allergies widget.
  FocusNode? allergiesFocusNode2;
  TextEditingController? allergiesTextController2;
  String? Function(BuildContext, String?)? allergiesTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode1?.dispose();
    nameTextController1?.dispose();

    dobFocusNode1?.dispose();
    dobTextController1?.dispose();

    bloodtypeFocusNode1?.dispose();
    bloodtypeTextController1?.dispose();

    allergiesFocusNode1?.dispose();
    allergiesTextController1?.dispose();

    nameFocusNode2?.dispose();
    nameTextController2?.dispose();

    dobFocusNode2?.dispose();
    dobTextController2?.dispose();

    bloodtypeFocusNode2?.dispose();
    bloodtypeTextController2?.dispose();

    allergiesFocusNode2?.dispose();
    allergiesTextController2?.dispose();
  }
}
