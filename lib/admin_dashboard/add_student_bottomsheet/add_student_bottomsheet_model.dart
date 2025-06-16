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

  int? pageno = 0;

  bool isguardian = false;

  List<int> pagenumber = [];
  void addToPagenumber(int item) => pagenumber.add(item);
  void removeFromPagenumber(int item) => pagenumber.remove(item);
  void removeAtIndexFromPagenumber(int index) => pagenumber.removeAt(index);
  void insertAtIndexInPagenumber(int index, int item) =>
      pagenumber.insert(index, item);
  void updatePagenumberAtIndex(int index, Function(int) updateFn) =>
      pagenumber[index] = updateFn(pagenumber[index]);

  List<ParentsaddStruct> parentid = [];
  void addToParentid(ParentsaddStruct item) => parentid.add(item);
  void removeFromParentid(ParentsaddStruct item) => parentid.remove(item);
  void removeAtIndexFromParentid(int index) => parentid.removeAt(index);
  void insertAtIndexInParentid(int index, ParentsaddStruct item) =>
      parentid.insert(index, item);
  void updateParentidAtIndex(int index, Function(ParentsaddStruct) updateFn) =>
      parentid[index] = updateFn(parentid[index]);

  int guardiancount = 0;

  ///  State fields for stateful widgets in this component.

  final formKey2 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  StudentsRecord? studentdraftCopy;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  StudentsRecord? studentdraft1Copy;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  StudentsRecord? studentdraft2Copy;
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

  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  String? _numberTextControllerValidator(BuildContext context, String? val) {
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

  // State field(s) for emailp widget.
  FocusNode? emailpFocusNode;
  TextEditingController? emailpTextController;
  String? Function(BuildContext, String?)? emailpTextControllerValidator;
  String? _emailpTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter username / email';
    }

    if (!RegExp(
            '^(?:[a-zA-Z0-9]+|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,})\$')
        .hasMatch(val)) {
      return 'Please enter valid email ';
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

  // State field(s) for mothernumber widget.
  FocusNode? mothernumberFocusNode;
  TextEditingController? mothernumberTextController;
  String? Function(BuildContext, String?)? mothernumberTextControllerValidator;
  String? _mothernumberTextControllerValidator(
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

  // State field(s) for email2 widget.
  FocusNode? email2FocusNode;
  TextEditingController? email2TextController;
  String? Function(BuildContext, String?)? email2TextControllerValidator;
  String? _email2TextControllerValidator(BuildContext context, String? val) {
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

  // Stores action output result for [Firestore Query - Query a collection] action in Save widget.
  List<UsersRecord>? userdocument;
  // Stores action output result for [Backend Call - API (Create Account)] action in Save widget.
  ApiCallResponse? parentapi;
  // Stores action output result for [Custom Action - stringToUser] action in Save widget.
  DocumentReference? parentUseref1;
  // Stores action output result for [Backend Call - API (Send Mail )] action in Save widget.
  ApiCallResponse? parentfatherCopy;
  // Stores action output result for [Backend Call - API (sendsms)] action in Save widget.
  ApiCallResponse? sms;
  // Stores action output result for [Backend Call - Create Document] action in Save widget.
  StudentsRecord? createdstudent12;
  // Stores action output result for [Firestore Query - Query a collection] action in Save widget.
  UsersRecord? parent1;
  // Stores action output result for [Firestore Query - Query a collection] action in Save widget.
  StudentsRecord? studentdoc4;
  // Stores action output result for [Backend Call - Create Document] action in Save widget.
  StudentsRecord? createdstudent2;

  @override
  void initState(BuildContext context) {
    childnameTextControllerValidator = _childnameTextControllerValidator;
    addressTextControllerValidator = _addressTextControllerValidator;
    parentnameTextControllerValidator = _parentnameTextControllerValidator;
    numberTextControllerValidator = _numberTextControllerValidator;
    emailpTextControllerValidator = _emailpTextControllerValidator;
    parent2TextControllerValidator = _parent2TextControllerValidator;
    mothernumberTextControllerValidator = _mothernumberTextControllerValidator;
    email2TextControllerValidator = _email2TextControllerValidator;
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

    numberFocusNode?.dispose();
    numberTextController?.dispose();

    emailpFocusNode?.dispose();
    emailpTextController?.dispose();

    parent2FocusNode?.dispose();
    parent2TextController?.dispose();

    mothernumberFocusNode?.dispose();
    mothernumberTextController?.dispose();

    email2FocusNode?.dispose();
    email2TextController?.dispose();

    gnameFocusNode?.dispose();
    gnameTextController?.dispose();

    gnumberFocusNode?.dispose();
    gnumberTextController?.dispose();

    gemailFocusNode?.dispose();
    gemailTextController?.dispose();
  }
}
