import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'edit_teacher_admin_widget.dart' show EditTeacherAdminWidget;
import 'package:flutter/material.dart';

class EditTeacherAdminModel extends FlutterFlowModel<EditTeacherAdminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  TeacherListStruct? teacherdata;
  void updateTeacherdataStruct(Function(TeacherListStruct) updateFn) {
    updateFn(teacherdata ??= TeacherListStruct());
  }

  TeacherListStruct? classteacherdata;
  void updateClassteacherdataStruct(Function(TeacherListStruct) updateFn) {
    updateFn(classteacherdata ??= TeacherListStruct());
  }

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in Edit_TeacherAdmin widget.
  SchoolRecord? schol;
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

    if (!RegExp('^\\d{10}\$').hasMatch(val)) {
      return 'Please enter a valid phone number ';
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
      return 'Please enter username / Email';
    }

    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<SchoolClassRecord>? classes;

  @override
  void initState(BuildContext context) {
    contactNameTextControllerValidator = _contactNameTextControllerValidator;
    contactPhonenumberTextControllerValidator =
        _contactPhonenumberTextControllerValidator;
    contactemailTextControllerValidator = _contactemailTextControllerValidator;
  }

  @override
  void dispose() {
    contactNameFocusNode?.dispose();
    contactNameTextController?.dispose();

    contactPhonenumberFocusNode?.dispose();
    contactPhonenumberTextController?.dispose();

    contactemailFocusNode?.dispose();
    contactemailTextController?.dispose();
  }
}
