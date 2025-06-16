import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'add_student_manually_widget.dart' show AddStudentManuallyWidget;
import 'package:flutter/material.dart';

class AddStudentManuallyModel
    extends FlutterFlowModel<AddStudentManuallyWidget> {
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

  List<DocumentReference> classRef = [];
  void addToClassRef(DocumentReference item) => classRef.add(item);
  void removeFromClassRef(DocumentReference item) => classRef.remove(item);
  void removeAtIndexFromClassRef(int index) => classRef.removeAt(index);
  void insertAtIndexInClassRef(int index, DocumentReference item) =>
      classRef.insert(index, item);
  void updateClassRefAtIndex(int index, Function(DocumentReference) updateFn) =>
      classRef[index] = updateFn(classRef[index]);

  int everyone = 0;

  List<String> classname = [];
  void addToClassname(String item) => classname.add(item);
  void removeFromClassname(String item) => classname.remove(item);
  void removeAtIndexFromClassname(int index) => classname.removeAt(index);
  void insertAtIndexInClassname(int index, String item) =>
      classname.insert(index, item);
  void updateClassnameAtIndex(int index, Function(String) updateFn) =>
      classname[index] = updateFn(classname[index]);

  int guardianCount = 0;

  bool isguardian = false;

  List<ParentsaddStruct> parentid = [];
  void addToParentid(ParentsaddStruct item) => parentid.add(item);
  void removeFromParentid(ParentsaddStruct item) => parentid.remove(item);
  void removeAtIndexFromParentid(int index) => parentid.removeAt(index);
  void insertAtIndexInParentid(int index, ParentsaddStruct item) =>
      parentid.insert(index, item);
  void updateParentidAtIndex(int index, Function(ParentsaddStruct) updateFn) =>
      parentid[index] = updateFn(parentid[index]);

  List<int> emptypage = [];
  void addToEmptypage(int item) => emptypage.add(item);
  void removeFromEmptypage(int item) => emptypage.remove(item);
  void removeAtIndexFromEmptypage(int index) => emptypage.removeAt(index);
  void insertAtIndexInEmptypage(int index, int item) =>
      emptypage.insert(index, item);
  void updateEmptypageAtIndex(int index, Function(int) updateFn) =>
      emptypage[index] = updateFn(emptypage[index]);

  ///  State fields for stateful widgets in this page.

  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Create Document] action in BackButtonOverrider widget.
  StudentsRecord? studentdraft12back;
  // Stores action output result for [Backend Call - Create Document] action in BackButtonOverrider widget.
  StudentsRecord? studentdraft123back;
  // Stores action output result for [Backend Call - Create Document] action in BackButtonOverrider widget.
  StudentsRecord? studentdraftParent1back;
  // Stores action output result for [Backend Call - Create Document] action in BackButtonOverrider widget.
  StudentsRecord? draftguardianback;
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
      return 'Please enter username / email';
    }

    if (!RegExp(
            '^(?:[a-zA-Z0-9]+|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,})\$')
        .hasMatch(val)) {
      return 'Please enter valid email';
    }
    return null;
  }

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
  String? _emailmotherTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter username / email';
    }

    if (!RegExp(
            '^(?:[a-zA-Z0-9]+|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,})\$')
        .hasMatch(val)) {
      return 'PLease enter a valid email';
    }
    return null;
  }

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
      return 'Please enter username / email';
    }

    if (!RegExp(
            '^(?:[a-zA-Z0-9]+|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,})\$')
        .hasMatch(val)) {
      return 'Please enter the valid email';
    }
    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  List<UsersRecord>? userdocument1;
  // Stores action output result for [Backend Call - API (Create Account)] action in save widget.
  ApiCallResponse? parentapi12;
  // Stores action output result for [Custom Action - stringToUser] action in save widget.
  DocumentReference? parentuserref;
  // Stores action output result for [Backend Call - API (Send Mail )] action in save widget.
  ApiCallResponse? parent1email;
  // Stores action output result for [Backend Call - API (sendsms)] action in save widget.
  ApiCallResponse? sms;
  // Stores action output result for [Backend Call - Create Document] action in save widget.
  StudentsRecord? student1;
  // Stores action output result for [Backend Call - Read Document] action in save widget.
  SchoolClassRecord? classes;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  UsersRecord? parent2;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  StudentsRecord? student2Copy;
  // Stores action output result for [Backend Call - Create Document] action in save widget.
  StudentsRecord? child2Copy;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  StudentsRecord? studentdraft12;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  StudentsRecord? studentdraft123;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  StudentsRecord? studentdraftParent1;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  StudentsRecord? draftguardian;
  // Stores action output result for [Backend Call - Create Document] action in Text widget.
  StudentsRecord? studentdraft;
  // Stores action output result for [Backend Call - Create Document] action in Text widget.
  StudentsRecord? studentdraft1;
  // Stores action output result for [Backend Call - Create Document] action in Text widget.
  StudentsRecord? studentdraftParent;
  // Stores action output result for [Backend Call - Create Document] action in Text widget.
  StudentsRecord? studentdraftgau;

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

    gnameFocusNode?.dispose();
    gnameTextController?.dispose();

    gnumberFocusNode?.dispose();
    gnumberTextController?.dispose();

    gemailFocusNode?.dispose();
    gemailTextController?.dispose();
  }
}
