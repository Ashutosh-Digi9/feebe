import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
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

  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

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

  DateTime? datePicked;
  // State field(s) for bloodtype widget.
  String? bloodtypeValue;
  FormFieldController<String>? bloodtypeValueController;
  // State field(s) for gender widget.
  String? genderValue;
  FormFieldController<String>? genderValueController;
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

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // State field(s) for Parentname widget.
  FocusNode? parentnameFocusNode1;
  TextEditingController? parentnameTextController1;
  String? Function(BuildContext, String?)? parentnameTextController1Validator;
  String? _parentnameTextController1Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please eneter the Father name';
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
      return 'Please enter Father\'s number';
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
      return 'Please enter email';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Please enter valid email';
    }
    return null;
  }

  bool isDataUploading3 = false;
  FFUploadedFile uploadedLocalFile3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl3 = '';

  // State field(s) for Parent2 widget.
  FocusNode? parent2FocusNode;
  TextEditingController? parent2TextController;
  String? Function(BuildContext, String?)? parent2TextControllerValidator;
  String? _parent2TextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter Mother name';
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
      return 'Please enter mother phone number';
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
      return 'Please enter email';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'PLease enter a alid email';
    }
    return null;
  }

  bool isDataUploading4 = false;
  FFUploadedFile uploadedLocalFile4 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl4 = '';

  // State field(s) for Parentname widget.
  FocusNode? parentnameFocusNode2;
  TextEditingController? parentnameTextController2;
  String? Function(BuildContext, String?)? parentnameTextController2Validator;
  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  List<UsersRecord>? userdocument;
  // Stores action output result for [Backend Call - API (Create Account)] action in save widget.
  ApiCallResponse? apiResultsparent;
  // Stores action output result for [Custom Action - stringToUser] action in save widget.
  DocumentReference? parentref;
  // Stores action output result for [Backend Call - API (Send Mail )] action in save widget.
  ApiCallResponse? parent1email;
  // Stores action output result for [Backend Call - Create Document] action in save widget.
  StudentsRecord? student;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  UsersRecord? parent;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  StudentsRecord? student2;
  // Stores action output result for [Backend Call - Create Document] action in save widget.
  StudentsRecord? child2;

  @override
  void initState(BuildContext context) {
    childnameTextControllerValidator = _childnameTextControllerValidator;
    addressTextControllerValidator = _addressTextControllerValidator;
    parentnameTextController1Validator = _parentnameTextController1Validator;
    numberfatherTextControllerValidator = _numberfatherTextControllerValidator;
    emailfatherTextControllerValidator = _emailfatherTextControllerValidator;
    parent2TextControllerValidator = _parent2TextControllerValidator;
    numbermotherTextControllerValidator = _numbermotherTextControllerValidator;
    emailmotherTextControllerValidator = _emailmotherTextControllerValidator;
  }

  @override
  void dispose() {
    childnameFocusNode?.dispose();
    childnameTextController?.dispose();

    allergiesFocusNode?.dispose();
    allergiesTextController?.dispose();

    addressFocusNode?.dispose();
    addressTextController?.dispose();

    parentnameFocusNode1?.dispose();
    parentnameTextController1?.dispose();

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

    parentnameFocusNode2?.dispose();
    parentnameTextController2?.dispose();

    numberFocusNode?.dispose();
    numberTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
