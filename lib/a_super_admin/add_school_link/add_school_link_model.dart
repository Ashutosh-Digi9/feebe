import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_school_link_widget.dart' show AddSchoolLinkWidget;
import 'package:flutter/material.dart';

class AddSchoolLinkModel extends FlutterFlowModel<AddSchoolLinkWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Schoolname widget.
  FocusNode? schoolnameFocusNode;
  TextEditingController? schoolnameTextController;
  String? Function(BuildContext, String?)? schoolnameTextControllerValidator;
  String? _schoolnameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter school name ';
    }

    return null;
  }

  // State field(s) for SchoolAddress widget.
  FocusNode? schoolAddressFocusNode;
  TextEditingController? schoolAddressTextController;
  String? Function(BuildContext, String?)? schoolAddressTextControllerValidator;
  String? _schoolAddressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter school address';
    }

    return null;
  }

  // State field(s) for Noofstudents widget.
  FocusNode? noofstudentsFocusNode;
  TextEditingController? noofstudentsTextController;
  String? Function(BuildContext, String?)? noofstudentsTextControllerValidator;
  String? _noofstudentsTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter students count';
    }

    if (!RegExp('^[1-9]\\d*\$').hasMatch(val)) {
      return 'please enter a valid number ';
    }
    return null;
  }

  // State field(s) for Nooffaculties widget.
  FocusNode? nooffacultiesFocusNode;
  TextEditingController? nooffacultiesTextController;
  String? Function(BuildContext, String?)? nooffacultiesTextControllerValidator;
  String? _nooffacultiesTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please enter faculties count';
    }

    if (!RegExp('^[1-9]\\d*\$').hasMatch(val)) {
      return 'Please enter valid number ';
    }
    return null;
  }

  // State field(s) for Noofbranches widget.
  FocusNode? noofbranchesFocusNode;
  TextEditingController? noofbranchesTextController;
  String? Function(BuildContext, String?)? noofbranchesTextControllerValidator;
  String? _noofbranchesTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter count of branches';
    }

    if (!RegExp('^[0-9]\\d*\$').hasMatch(val)) {
      return 'Please enter a valid number ';
    }
    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<SchoolRecord>? countofschool;
  // Stores action output result for [Backend Call - Create Document] action in Send widget.
  SchoolRecord? schooldoc;

  @override
  void initState(BuildContext context) {
    schoolnameTextControllerValidator = _schoolnameTextControllerValidator;
    schoolAddressTextControllerValidator =
        _schoolAddressTextControllerValidator;
    noofstudentsTextControllerValidator = _noofstudentsTextControllerValidator;
    nooffacultiesTextControllerValidator =
        _nooffacultiesTextControllerValidator;
    noofbranchesTextControllerValidator = _noofbranchesTextControllerValidator;
  }

  @override
  void dispose() {
    schoolnameFocusNode?.dispose();
    schoolnameTextController?.dispose();

    schoolAddressFocusNode?.dispose();
    schoolAddressTextController?.dispose();

    noofstudentsFocusNode?.dispose();
    noofstudentsTextController?.dispose();

    nooffacultiesFocusNode?.dispose();
    nooffacultiesTextController?.dispose();

    noofbranchesFocusNode?.dispose();
    noofbranchesTextController?.dispose();
  }
}
