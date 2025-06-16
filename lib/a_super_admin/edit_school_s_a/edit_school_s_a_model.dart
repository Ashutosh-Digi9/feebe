import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'edit_school_s_a_widget.dart' show EditSchoolSAWidget;
import 'package:flutter/material.dart';

class EditSchoolSAModel extends FlutterFlowModel<EditSchoolSAWidget> {
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
      return 'Please enter school name ';
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

  // State field(s) for pincode widget.
  FocusNode? pincodeFocusNode;
  TextEditingController? pincodeTextController;
  String? Function(BuildContext, String?)? pincodeTextControllerValidator;
  String? _pincodeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter  pincode ';
    }

    if (val.length < 6) {
      return 'Requires at least 6 characters.';
    }

    if (!RegExp('^\\d{6}\$').hasMatch(val)) {
      return 'Please enter valid code ';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (getcityandstate)] action in pincode widget.
  ApiCallResponse? apiResultjlv;
  // State field(s) for cityold widget.
  FocusNode? cityoldFocusNode;
  TextEditingController? cityoldTextController;
  String? Function(BuildContext, String?)? cityoldTextControllerValidator;
  // State field(s) for city widget.
  FocusNode? cityFocusNode;
  TextEditingController? cityTextController;
  String? Function(BuildContext, String?)? cityTextControllerValidator;
  // State field(s) for stateold widget.
  FocusNode? stateoldFocusNode;
  TextEditingController? stateoldTextController;
  String? Function(BuildContext, String?)? stateoldTextControllerValidator;
  // State field(s) for state widget.
  FocusNode? stateFocusNode;
  TextEditingController? stateTextController;
  String? Function(BuildContext, String?)? stateTextControllerValidator;
  // Stores action output result for [Custom Action - fetchlatlng] action in update widget.
  LatLng? latlng;
  // Stores action output result for [Custom Action - fetchlatlng] action in update widget.
  LatLng? latlng1;

  @override
  void initState(BuildContext context) {
    schoolnameTextControllerValidator = _schoolnameTextControllerValidator;
    noofbranchesTextControllerValidator = _noofbranchesTextControllerValidator;
    nooffacultiesTextControllerValidator =
        _nooffacultiesTextControllerValidator;
    schoolAddressTextControllerValidator =
        _schoolAddressTextControllerValidator;
    pincodeTextControllerValidator = _pincodeTextControllerValidator;
  }

  @override
  void dispose() {
    schoolnameFocusNode?.dispose();
    schoolnameTextController?.dispose();

    noofbranchesFocusNode?.dispose();
    noofbranchesTextController?.dispose();

    nooffacultiesFocusNode?.dispose();
    nooffacultiesTextController?.dispose();

    schoolAddressFocusNode?.dispose();
    schoolAddressTextController?.dispose();

    pincodeFocusNode?.dispose();
    pincodeTextController?.dispose();

    cityoldFocusNode?.dispose();
    cityoldTextController?.dispose();

    cityFocusNode?.dispose();
    cityTextController?.dispose();

    stateoldFocusNode?.dispose();
    stateoldTextController?.dispose();

    stateFocusNode?.dispose();
    stateTextController?.dispose();
  }
}
