import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_student_bottomsheet_widget.dart' show AddStudentBottomsheetWidget;
import 'package:flutter/material.dart';

class AddStudentBottomsheetModel
    extends FlutterFlowModel<AddStudentBottomsheetWidget> {
  ///  Local state fields for this component.

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

  ///  State fields for stateful widgets in this component.

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
      return 'Please enter father\'s name';
    }

    return null;
  }

  // State field(s) for number widget.
  FocusNode? numberFocusNode1;
  TextEditingController? numberTextController1;
  String? Function(BuildContext, String?)? numberTextController1Validator;
  String? _numberTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter Father\'s  phone number';
    }

    if (val.length > 10) {
      return 'Please enter a valid 10-digit number.';
    }
    if (!RegExp('^[6-9]\\d{9}\$').hasMatch(val)) {
      return 'Please enter valid number';
    }
    return null;
  }

  // State field(s) for emailp widget.
  FocusNode? emailpFocusNode;
  TextEditingController? emailpTextController;
  String? Function(BuildContext, String?)? emailpTextControllerValidator;
  String? _emailpTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter email';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Please enter valid email ';
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
      return 'Please enter name ';
    }

    return null;
  }

  // State field(s) for mothernumbeer widget.
  FocusNode? mothernumbeerFocusNode;
  TextEditingController? mothernumbeerTextController;
  String? Function(BuildContext, String?)? mothernumbeerTextControllerValidator;
  String? _mothernumbeerTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter phone number ';
    }

    if (val.length > 10) {
      return 'Please enter a valid 10-digit number.';
    }
    if (!RegExp('^[6-9]\\d{9}\$').hasMatch(val)) {
      return 'please enter valid phone number';
    }
    return null;
  }

  // State field(s) for email2 widget.
  FocusNode? email2FocusNode;
  TextEditingController? email2TextController;
  String? Function(BuildContext, String?)? email2TextControllerValidator;
  String? _email2TextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please enter email ';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Please enter valid email';
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
  FocusNode? numberFocusNode2;
  TextEditingController? numberTextController2;
  String? Function(BuildContext, String?)? numberTextController2Validator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  List<UsersRecord>? userdoc;
  // Stores action output result for [Backend Call - API (Create Account)] action in save widget.
  ApiCallResponse? apiResultsparentdneww;
  // Stores action output result for [Custom Action - stringToUser] action in save widget.
  DocumentReference? parentUseref;
  // Stores action output result for [Backend Call - API (Send Mail )] action in save widget.
  ApiCallResponse? parentfather;
  // Stores action output result for [Backend Call - Create Document] action in save widget.
  StudentsRecord? createdstudent;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  UsersRecord? parent;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  StudentsRecord? studentdoc;
  // Stores action output result for [Backend Call - Create Document] action in save widget.
  StudentsRecord? createdstudent1;

  @override
  void initState(BuildContext context) {
    childnameTextControllerValidator = _childnameTextControllerValidator;
    addressTextControllerValidator = _addressTextControllerValidator;
    parentnameTextController1Validator = _parentnameTextController1Validator;
    numberTextController1Validator = _numberTextController1Validator;
    emailpTextControllerValidator = _emailpTextControllerValidator;
    parent2TextControllerValidator = _parent2TextControllerValidator;
    mothernumbeerTextControllerValidator =
        _mothernumbeerTextControllerValidator;
    email2TextControllerValidator = _email2TextControllerValidator;
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

    numberFocusNode1?.dispose();
    numberTextController1?.dispose();

    emailpFocusNode?.dispose();
    emailpTextController?.dispose();

    parent2FocusNode?.dispose();
    parent2TextController?.dispose();

    mothernumbeerFocusNode?.dispose();
    mothernumbeerTextController?.dispose();

    email2FocusNode?.dispose();
    email2TextController?.dispose();

    parentnameFocusNode2?.dispose();
    parentnameTextController2?.dispose();

    numberFocusNode2?.dispose();
    numberTextController2?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
