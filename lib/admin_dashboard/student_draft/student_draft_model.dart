import '/admin_dashboard/guardian_copy/guardian_copy_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'student_draft_widget.dart' show StudentDraftWidget;
import 'package:flutter/material.dart';

class StudentDraftModel extends FlutterFlowModel<StudentDraftWidget> {
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

  List<ParentsDetailsStruct> parentsdetails = [];
  void addToParentsdetails(ParentsDetailsStruct item) =>
      parentsdetails.add(item);
  void removeFromParentsdetails(ParentsDetailsStruct item) =>
      parentsdetails.remove(item);
  void removeAtIndexFromParentsdetails(int index) =>
      parentsdetails.removeAt(index);
  void insertAtIndexInParentsdetails(int index, ParentsDetailsStruct item) =>
      parentsdetails.insert(index, item);
  void updateParentsdetailsAtIndex(
          int index, Function(ParentsDetailsStruct) updateFn) =>
      parentsdetails[index] = updateFn(parentsdetails[index]);

  int? pageno = 0;

  int? guardiancount = 0;

  List<int> emptypage = [];
  void addToEmptypage(int item) => emptypage.add(item);
  void removeFromEmptypage(int item) => emptypage.remove(item);
  void removeAtIndexFromEmptypage(int index) => emptypage.removeAt(index);
  void insertAtIndexInEmptypage(int index, int item) =>
      emptypage.insert(index, item);
  void updateEmptypageAtIndex(int index, Function(int) updateFn) =>
      emptypage[index] = updateFn(emptypage[index]);

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

  final formKey3 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in student_draft widget.
  SchoolRecord? school1;
  // Stores action output result for [Backend Call - Read Document] action in student_draft widget.
  StudentsRecord? studen;
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
      return 'Please enter the child name';
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
      return 'Please enter address';
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
  String? _emailfatherTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter  User name';
    }

    return null;
  }

  // State field(s) for Parent2 widget.
  FocusNode? parent2FocusNode;
  TextEditingController? parent2TextController;
  String? Function(BuildContext, String?)? parent2TextControllerValidator;
  String? _parent2TextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the parent\'s name';
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
      return 'Please enter the parents number';
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
  String? _emailmotherTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter Parent\'s Username';
    }

    return null;
  }

  // Models for guardianCopy dynamic component.
  late FlutterFlowDynamicModels<GuardianCopyModel> guardianCopyModels;
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
      return 'Please enter username/ email';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Read Document] action in Save widget.
  SchoolRecord? school;
  // Stores action output result for [Firestore Query - Query a collection] action in Save widget.
  List<UsersRecord>? userdocument1;
  // Stores action output result for [Backend Call - API (Create Account)] action in Save widget.
  ApiCallResponse? parentapi12;
  // Stores action output result for [Custom Action - stringToUser] action in Save widget.
  DocumentReference? parentuserref;
  // Stores action output result for [Backend Call - API (Send Mail )] action in Save widget.
  ApiCallResponse? parent1email;
  // Stores action output result for [Backend Call - API (sendsms)] action in Save widget.
  ApiCallResponse? sms;
  // Stores action output result for [Firestore Query - Query a collection] action in Save widget.
  UsersRecord? parent2;
  // Stores action output result for [Firestore Query - Query a collection] action in Save widget.
  StudentsRecord? student2Copy;

  @override
  void initState(BuildContext context) {
    childnameTextControllerValidator = _childnameTextControllerValidator;
    addressTextControllerValidator = _addressTextControllerValidator;
    parentnameTextControllerValidator = _parentnameTextControllerValidator;
    numberfatherTextControllerValidator = _numberfatherTextControllerValidator;
    emailfatherTextControllerValidator = _emailfatherTextControllerValidator;
    parent2TextControllerValidator = _parent2TextControllerValidator;
    numbermotherTextControllerValidator = _numbermotherTextControllerValidator;
    emailmotherTextControllerValidator = _emailmotherTextControllerValidator;
    guardianCopyModels = FlutterFlowDynamicModels(() => GuardianCopyModel());
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

    guardianCopyModels.dispose();
    gnameFocusNode?.dispose();
    gnameTextController?.dispose();

    gnumberFocusNode?.dispose();
    gnumberTextController?.dispose();

    gemailFocusNode?.dispose();
    gemailTextController?.dispose();
  }
}
