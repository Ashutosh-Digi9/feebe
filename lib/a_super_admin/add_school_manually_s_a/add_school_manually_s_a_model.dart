import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_school_manually_s_a_widget.dart' show AddSchoolManuallySAWidget;
import 'package:flutter/material.dart';

class AddSchoolManuallySAModel
    extends FlutterFlowModel<AddSchoolManuallySAWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  String? city;

  String? state;

  AddressStruct? addressdata;
  void updateAddressdataStruct(Function(AddressStruct) updateFn) {
    updateFn(addressdata ??= AddressStruct());
  }

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

  // State field(s) for Nooffaculties widget.
  FocusNode? nooffacultiesFocusNode;
  TextEditingController? nooffacultiesTextController;
  String? Function(BuildContext, String?)? nooffacultiesTextControllerValidator;
  String? _nooffacultiesTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the number of faculty members.';
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
      return 'Please enter the number of branches.';
    }

    if (!RegExp('^[1-9]\\d*\$').hasMatch(val)) {
      return 'Please enter valid number ';
    }
    return null;
  }

  // State field(s) for Pincode widget.
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
      return 'Please enter valid pin code ';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (getcityandstate)] action in Pincode widget.
  ApiCallResponse? apiResultkps;
  // State field(s) for City widget.
  FocusNode? cityFocusNode;
  TextEditingController? cityTextController;
  String? Function(BuildContext, String?)? cityTextControllerValidator;
  // State field(s) for State widget.
  FocusNode? stateFocusNode;
  TextEditingController? stateTextController;
  String? Function(BuildContext, String?)? stateTextControllerValidator;
  // State field(s) for ContactName widget.
  FocusNode? contactNameFocusNode;
  TextEditingController? contactNameTextController;
  String? Function(BuildContext, String?)? contactNameTextControllerValidator;
  String? _contactNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter name ';
    }

    return null;
  }

  // State field(s) for ContactPhonenumber widget.
  FocusNode? contactPhonenumberFocusNode;
  TextEditingController? contactPhonenumberTextController;
  String? Function(BuildContext, String?)?
      contactPhonenumberTextControllerValidator;
  String? _contactPhonenumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter phone number ';
    }

    if (!RegExp('^[6-9]\\d{9}\$').hasMatch(val)) {
      return 'Please enter a valid 10-digit phone number.';
    }
    return null;
  }

  // State field(s) for Contactemail widget.
  FocusNode? contactemailFocusNode;
  TextEditingController? contactemailTextController;
  String? Function(BuildContext, String?)? contactemailTextControllerValidator;
  String? _contactemailTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter email ';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Please enter valid email';
    }
    return null;
  }

  // Stores action output result for [Custom Action - fetchlatlng] action in Send widget.
  LatLng? address1;
  // Stores action output result for [Backend Call - API (Create Account)] action in Send widget.
  ApiCallResponse? createaccount2;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  UsersRecord? user;
  // Stores action output result for [Custom Action - fetchlatlng] action in Send widget.
  LatLng? address;
  // Stores action output result for [Backend Call - Create Document] action in Send widget.
  SchoolRecord? schooldoc;
  // Stores action output result for [Backend Call - API (Send Mail )] action in Send widget.
  ApiCallResponse? seandmail;

  @override
  void initState(BuildContext context) {
    schoolnameTextControllerValidator = _schoolnameTextControllerValidator;
    schoolAddressTextControllerValidator =
        _schoolAddressTextControllerValidator;
    nooffacultiesTextControllerValidator =
        _nooffacultiesTextControllerValidator;
    noofbranchesTextControllerValidator = _noofbranchesTextControllerValidator;
    pincodeTextControllerValidator = _pincodeTextControllerValidator;
    contactNameTextControllerValidator = _contactNameTextControllerValidator;
    contactPhonenumberTextControllerValidator =
        _contactPhonenumberTextControllerValidator;
    contactemailTextControllerValidator = _contactemailTextControllerValidator;
  }

  @override
  void dispose() {
    schoolnameFocusNode?.dispose();
    schoolnameTextController?.dispose();

    schoolAddressFocusNode?.dispose();
    schoolAddressTextController?.dispose();

    nooffacultiesFocusNode?.dispose();
    nooffacultiesTextController?.dispose();

    noofbranchesFocusNode?.dispose();
    noofbranchesTextController?.dispose();

    pincodeFocusNode?.dispose();
    pincodeTextController?.dispose();

    cityFocusNode?.dispose();
    cityTextController?.dispose();

    stateFocusNode?.dispose();
    stateTextController?.dispose();

    contactNameFocusNode?.dispose();
    contactNameTextController?.dispose();

    contactPhonenumberFocusNode?.dispose();
    contactPhonenumberTextController?.dispose();

    contactemailFocusNode?.dispose();
    contactemailTextController?.dispose();
  }
}
