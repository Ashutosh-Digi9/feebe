import '/flutter_flow/flutter_flow_util.dart';
import 'add_branch_s_a_widget.dart' show AddBranchSAWidget;
import 'package:flutter/material.dart';

class AddBranchSAModel extends FlutterFlowModel<AddBranchSAWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

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
