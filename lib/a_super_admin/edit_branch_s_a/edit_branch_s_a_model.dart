import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_branch_s_a_widget.dart' show EditBranchSAWidget;
import 'package:flutter/material.dart';

class EditBranchSAModel extends FlutterFlowModel<EditBranchSAWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  String? city;

  String? state;

  bool pincodechange = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Schoolname widget.
  FocusNode? schoolnameFocusNode;
  TextEditingController? schoolnameTextController;
  String? Function(BuildContext, String?)? schoolnameTextControllerValidator;
  String? _schoolnameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter branch name ';
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

  // State field(s) for pincode widget.
  FocusNode? pincodeFocusNode;
  TextEditingController? pincodeTextController;
  String? Function(BuildContext, String?)? pincodeTextControllerValidator;
  String? _pincodeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter pincode ';
    }

    if (val.length < 6) {
      return 'Requires at least 6 characters.';
    }

    if (!RegExp('^\\d{6}\$').hasMatch(val)) {
      return 'Enter valid pincode ';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (getcityandstate)] action in pincode widget.
  ApiCallResponse? apiResultut5;
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

  // State field(s) for city widget.
  FocusNode? cityFocusNode1;
  TextEditingController? cityTextController1;
  String? Function(BuildContext, String?)? cityTextController1Validator;
  // State field(s) for city widget.
  FocusNode? cityFocusNode2;
  TextEditingController? cityTextController2;
  String? Function(BuildContext, String?)? cityTextController2Validator;
  // State field(s) for state widget.
  FocusNode? stateFocusNode1;
  TextEditingController? stateTextController1;
  String? Function(BuildContext, String?)? stateTextController1Validator;
  // State field(s) for state widget.
  FocusNode? stateFocusNode2;
  TextEditingController? stateTextController2;
  String? Function(BuildContext, String?)? stateTextController2Validator;
  // Stores action output result for [Custom Action - fetchlatlng] action in Add widget.
  LatLng? latlng;
  // Stores action output result for [Custom Action - fetchlatlng] action in Add widget.
  LatLng? latlng12;

  @override
  void initState(BuildContext context) {
    schoolnameTextControllerValidator = _schoolnameTextControllerValidator;
    nooffacultiesTextControllerValidator =
        _nooffacultiesTextControllerValidator;
    pincodeTextControllerValidator = _pincodeTextControllerValidator;
    schoolAddressTextControllerValidator =
        _schoolAddressTextControllerValidator;
  }

  @override
  void dispose() {
    schoolnameFocusNode?.dispose();
    schoolnameTextController?.dispose();

    nooffacultiesFocusNode?.dispose();
    nooffacultiesTextController?.dispose();

    pincodeFocusNode?.dispose();
    pincodeTextController?.dispose();

    schoolAddressFocusNode?.dispose();
    schoolAddressTextController?.dispose();

    cityFocusNode1?.dispose();
    cityTextController1?.dispose();

    cityFocusNode2?.dispose();
    cityTextController2?.dispose();

    stateFocusNode1?.dispose();
    stateTextController1?.dispose();

    stateFocusNode2?.dispose();
    stateTextController2?.dispose();
  }
}
