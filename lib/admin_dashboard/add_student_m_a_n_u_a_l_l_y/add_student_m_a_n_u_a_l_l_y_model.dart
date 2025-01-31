import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_student_m_a_n_u_a_l_l_y_widget.dart' show AddStudentMANUALLYWidget;
import 'package:flutter/material.dart';

class AddStudentMANUALLYModel
    extends FlutterFlowModel<AddStudentMANUALLYWidget> {
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

  int? pageno = 0;

  ///  State fields for stateful widgets in this component.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
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

  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  // State field(s) for Parentname widget.
  FocusNode? parentnameFocusNode;
  TextEditingController? parentnameTextController;
  String? Function(BuildContext, String?)? parentnameTextControllerValidator;
  String? _parentnameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter father\'s name';
    }

    return null;
  }

  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  String? _numberTextControllerValidator(BuildContext context, String? val) {
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

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

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

  bool isDataUploading3 = false;
  FFUploadedFile uploadedLocalFile3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl3 = '';

  // State field(s) for GuardianName widget.
  FocusNode? guardianNameFocusNode;
  TextEditingController? guardianNameTextController;
  String? Function(BuildContext, String?)? guardianNameTextControllerValidator;
  String? _guardianNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the Guardian\'s name';
    }

    return null;
  }

  // State field(s) for GuardianNumber widget.
  FocusNode? guardianNumberFocusNode;
  TextEditingController? guardianNumberTextController;
  String? Function(BuildContext, String?)?
      guardianNumberTextControllerValidator;
  String? _guardianNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the number';
    }

    if (val.length > 10) {
      return 'Please enter the valid 10 digit number';
    }
    if (!RegExp('^[6-9]\\d{9}\$').hasMatch(val)) {
      return 'Please neter the valid number';
    }
    return null;
  }

  // State field(s) for GuardianEmail widget.
  FocusNode? guardianEmailFocusNode;
  TextEditingController? guardianEmailTextController;
  String? Function(BuildContext, String?)? guardianEmailTextControllerValidator;
  String? _guardianEmailTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the email';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Please enter the valid email';
    }
    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  List<UsersRecord>? userdocument1;
  // Stores action output result for [Backend Call - API (Create Account)] action in save widget.
  ApiCallResponse? parent1apiresult;
  // Stores action output result for [Custom Action - stringToUser] action in save widget.
  DocumentReference? parent1userref;
  // Stores action output result for [Backend Call - API (Send Mail )] action in save widget.
  ApiCallResponse? parentfather1;
  // Stores action output result for [Backend Call - Create Document] action in save widget.
  StudentsRecord? student1;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  UsersRecord? parent12;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  StudentsRecord? stundent2;
  // Stores action output result for [Backend Call - Create Document] action in save widget.
  StudentsRecord? child2;

  @override
  void initState(BuildContext context) {
    childnameTextControllerValidator = _childnameTextControllerValidator;
    addressTextControllerValidator = _addressTextControllerValidator;
    parentnameTextControllerValidator = _parentnameTextControllerValidator;
    numberTextControllerValidator = _numberTextControllerValidator;
    emailpTextControllerValidator = _emailpTextControllerValidator;
    parent2TextControllerValidator = _parent2TextControllerValidator;
    mothernumbeerTextControllerValidator =
        _mothernumbeerTextControllerValidator;
    email2TextControllerValidator = _email2TextControllerValidator;
    guardianNameTextControllerValidator = _guardianNameTextControllerValidator;
    guardianNumberTextControllerValidator =
        _guardianNumberTextControllerValidator;
    guardianEmailTextControllerValidator =
        _guardianEmailTextControllerValidator;
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

    numberFocusNode?.dispose();
    numberTextController?.dispose();

    emailpFocusNode?.dispose();
    emailpTextController?.dispose();

    parent2FocusNode?.dispose();
    parent2TextController?.dispose();

    mothernumbeerFocusNode?.dispose();
    mothernumbeerTextController?.dispose();

    email2FocusNode?.dispose();
    email2TextController?.dispose();

    guardianNameFocusNode?.dispose();
    guardianNameTextController?.dispose();

    guardianNumberFocusNode?.dispose();
    guardianNumberTextController?.dispose();

    guardianEmailFocusNode?.dispose();
    guardianEmailTextController?.dispose();
  }
}
