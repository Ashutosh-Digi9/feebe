import '/admin_dashboard/editguardian/editguardian_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'edit_class_student_widget.dart' show EditClassStudentWidget;
import 'package:flutter/material.dart';

class EditClassStudentModel extends FlutterFlowModel<EditClassStudentWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> parentsRef = [];
  void addToParentsRef(DocumentReference item) => parentsRef.add(item);
  void removeFromParentsRef(DocumentReference item) => parentsRef.remove(item);
  void removeAtIndexFromParentsRef(int index) => parentsRef.removeAt(index);
  void insertAtIndexInParentsRef(int index, DocumentReference item) =>
      parentsRef.insert(index, item);
  void updateParentsRefAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      parentsRef[index] = updateFn(parentsRef[index]);

  int? pageno = 0;

  List<ParentsDetailsStruct> parentdetails = [];
  void addToParentdetails(ParentsDetailsStruct item) => parentdetails.add(item);
  void removeFromParentdetails(ParentsDetailsStruct item) =>
      parentdetails.remove(item);
  void removeAtIndexFromParentdetails(int index) =>
      parentdetails.removeAt(index);
  void insertAtIndexInParentdetails(int index, ParentsDetailsStruct item) =>
      parentdetails.insert(index, item);
  void updateParentdetailsAtIndex(
          int index, Function(ParentsDetailsStruct) updateFn) =>
      parentdetails[index] = updateFn(parentdetails[index]);

  List<ParentsDetailsStruct> newparentList = [];
  void addToNewparentList(ParentsDetailsStruct item) => newparentList.add(item);
  void removeFromNewparentList(ParentsDetailsStruct item) =>
      newparentList.remove(item);
  void removeAtIndexFromNewparentList(int index) =>
      newparentList.removeAt(index);
  void insertAtIndexInNewparentList(int index, ParentsDetailsStruct item) =>
      newparentList.insert(index, item);
  void updateNewparentListAtIndex(
          int index, Function(ParentsDetailsStruct) updateFn) =>
      newparentList[index] = updateFn(newparentList[index]);

  int? everyone;

  List<DocumentReference> classRef = [];
  void addToClassRef(DocumentReference item) => classRef.add(item);
  void removeFromClassRef(DocumentReference item) => classRef.remove(item);
  void removeAtIndexFromClassRef(int index) => classRef.removeAt(index);
  void insertAtIndexInClassRef(int index, DocumentReference item) =>
      classRef.insert(index, item);
  void updateClassRefAtIndex(int index, Function(DocumentReference) updateFn) =>
      classRef[index] = updateFn(classRef[index]);

  List<String> classname = [];
  void addToClassname(String item) => classname.add(item);
  void removeFromClassname(String item) => classname.remove(item);
  void removeAtIndexFromClassname(int index) => classname.removeAt(index);
  void insertAtIndexInClassname(int index, String item) =>
      classname.insert(index, item);
  void updateClassnameAtIndex(int index, Function(String) updateFn) =>
      classname[index] = updateFn(classname[index]);

  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in edit_class_student widget.
  StudentsRecord? studentDetails;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for childname widget.
  FocusNode? childnameFocusNode;
  TextEditingController? childnameTextController;
  String? Function(BuildContext, String?)? childnameTextControllerValidator;
  String? _childnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the name';
    }

    return null;
  }

  // State field(s) for gender widget.
  String? genderValue;
  FormFieldController<String>? genderValueController;
  // State field(s) for bloodtype widget.
  String? bloodtypeValue;
  FormFieldController<String>? bloodtypeValueController;
  // State field(s) for allergies widget.
  FocusNode? allergiesFocusNode;
  TextEditingController? allergiesTextController;
  String? Function(BuildContext, String?)? allergiesTextControllerValidator;
  // State field(s) for address widget.
  FocusNode? addressFocusNode;
  TextEditingController? addressTextController;
  String? Function(BuildContext, String?)? addressTextControllerValidator;
  String? _addressTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the address';
    }

    return null;
  }

  // State field(s) for Parentname widget.
  FocusNode? parentnameFocusNode;
  TextEditingController? parentnameTextController;
  String? Function(BuildContext, String?)? parentnameTextControllerValidator;
  String? _parentnameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the parent\'s name.';
    }

    return null;
  }

  // State field(s) for numberfather widget.
  FocusNode? numberfatherFocusNode;
  TextEditingController? numberfatherTextController;
  String? Function(BuildContext, String?)? numberfatherTextControllerValidator;
  String? _numberfatherTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the parent\'s phone number.';
    }

    if (val.length > 10) {
      return 'Please enter a valid 10-digit number.';
    }
    if (!RegExp('^[6-9]\\d{9}\$').hasMatch(val)) {
      return 'Please enter valid number';
    }
    return null;
  }

  // State field(s) for emailfather widget.
  FocusNode? emailfatherFocusNode;
  TextEditingController? emailfatherTextController;
  String? Function(BuildContext, String?)? emailfatherTextControllerValidator;
  // State field(s) for Parent2 widget.
  FocusNode? parent2FocusNode;
  TextEditingController? parent2TextController;
  String? Function(BuildContext, String?)? parent2TextControllerValidator;
  String? _parent2TextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the parent\'s name.';
    }

    return null;
  }

  // State field(s) for numbermother widget.
  FocusNode? numbermotherFocusNode;
  TextEditingController? numbermotherTextController;
  String? Function(BuildContext, String?)? numbermotherTextControllerValidator;
  String? _numbermotherTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the parent\'s phone number.';
    }

    if (val.length > 10) {
      return 'Please enter a valid 10-digit number.';
    }
    if (!RegExp('^[6-9]\\d{9}\$').hasMatch(val)) {
      return 'please enter valid phone number';
    }
    return null;
  }

  // State field(s) for emailmother widget.
  FocusNode? emailmotherFocusNode;
  TextEditingController? emailmotherTextController;
  String? Function(BuildContext, String?)? emailmotherTextControllerValidator;
  // Models for editguardian dynamic component.
  late FlutterFlowDynamicModels<EditguardianModel> editguardianModels;
  // State field(s) for Gname widget.
  FocusNode? gnameFocusNode;
  TextEditingController? gnameTextController;
  String? Function(BuildContext, String?)? gnameTextControllerValidator;
  String? _gnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the Guardian\'s name';
    }

    return null;
  }

  // State field(s) for Gnumber widget.
  FocusNode? gnumberFocusNode;
  TextEditingController? gnumberTextController;
  String? Function(BuildContext, String?)? gnumberTextControllerValidator;
  String? _gnumberTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the number';
    }

    if (val.length > 10) {
      return 'Please enter the 10 digit valid number';
    }
    if (!RegExp('^[6-9]\\d{9}\$').hasMatch(val)) {
      return 'Please enter the valid number';
    }
    return null;
  }

  // State field(s) for Gemail widget.
  FocusNode? gemailFocusNode;
  TextEditingController? gemailTextController;
  String? Function(BuildContext, String?)? gemailTextControllerValidator;
  String? _gemailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the Username';
    }

    if (!RegExp(
            '^(?:[a-zA-Z0-9]+|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,})\$')
        .hasMatch(val)) {
      return 'Please enter the valid email';
    }
    return null;
  }

  // Stores action output result for [Backend Call - Read Document] action in Update widget.
  SchoolRecord? school;
  // Stores action output result for [Backend Call - Read Document] action in Update widget.
  UsersRecord? parent1;
  // Stores action output result for [Backend Call - Read Document] action in Update widget.
  SchoolClassRecord? classes;
  // Stores action output result for [Backend Call - Read Document] action in Update widget.
  SchoolRecord? princui;

  @override
  void initState(BuildContext context) {
    childnameTextControllerValidator = _childnameTextControllerValidator;
    addressTextControllerValidator = _addressTextControllerValidator;
    parentnameTextControllerValidator = _parentnameTextControllerValidator;
    numberfatherTextControllerValidator = _numberfatherTextControllerValidator;
    parent2TextControllerValidator = _parent2TextControllerValidator;
    numbermotherTextControllerValidator = _numbermotherTextControllerValidator;
    editguardianModels = FlutterFlowDynamicModels(() => EditguardianModel());
    gnameTextControllerValidator = _gnameTextControllerValidator;
    gnumberTextControllerValidator = _gnumberTextControllerValidator;
    gemailTextControllerValidator = _gemailTextControllerValidator;
  }

  @override
  void dispose() {
    childnameFocusNode?.dispose();
    childnameTextController?.dispose();

    allergiesFocusNode?.dispose();
    allergiesTextController?.dispose();

    addressFocusNode?.dispose();
    addressTextController?.dispose();

    parentnameFocusNode?.dispose();
    parentnameTextController?.dispose();

    numberfatherFocusNode?.dispose();
    numberfatherTextController?.dispose();

    emailfatherFocusNode?.dispose();
    emailfatherTextController?.dispose();

    parent2FocusNode?.dispose();
    parent2TextController?.dispose();

    numbermotherFocusNode?.dispose();
    numbermotherTextController?.dispose();

    emailmotherFocusNode?.dispose();
    emailmotherTextController?.dispose();

    editguardianModels.dispose();
    gnameFocusNode?.dispose();
    gnameTextController?.dispose();

    gnumberFocusNode?.dispose();
    gnumberTextController?.dispose();

    gemailFocusNode?.dispose();
    gemailTextController?.dispose();
  }
}
