import '/backend/backend.dart';
import '/components/studentdetails_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'edit_parent_copy_widget.dart' show EditParentCopyWidget;
import 'package:flutter/material.dart';

class EditParentCopyModel extends FlutterFlowModel<EditParentCopyWidget> {
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

  ParentsDetailsStruct? parentdocu;
  void updateParentdocuStruct(Function(ParentsDetailsStruct) updateFn) {
    updateFn(parentdocu ??= ParentsDetailsStruct());
  }

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for Parentname widget.
  FocusNode? parentnameFocusNode;
  TextEditingController? parentnameTextController;
  String? Function(BuildContext, String?)? parentnameTextControllerValidator;
  String? _parentnameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the parent\'s name';
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
      return 'Plase enter the Parent number';
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
  // Models for studentdetails dynamic component.
  late FlutterFlowDynamicModels<StudentdetailsModel> studentdetailsModels;
  // Stores action output result for [Backend Call - Read Document] action in Next12 widget.
  StudentsRecord? students12;
  // Stores action output result for [Backend Call - Read Document] action in Next12 widget.
  StudentsRecord? student;
  // Stores action output result for [Backend Call - Read Document] action in Next12 widget.
  SchoolRecord? school;
  // Stores action output result for [Backend Call - Read Document] action in Next12 widget.
  SchoolClassRecord? classes;

  @override
  void initState(BuildContext context) {
    parentnameTextControllerValidator = _parentnameTextControllerValidator;
    numberfatherTextControllerValidator = _numberfatherTextControllerValidator;
    studentdetailsModels =
        FlutterFlowDynamicModels(() => StudentdetailsModel());
  }

  @override
  void dispose() {
    parentnameFocusNode?.dispose();
    parentnameTextController?.dispose();

    numberfatherFocusNode?.dispose();
    numberfatherTextController?.dispose();

    emailfatherFocusNode?.dispose();
    emailfatherTextController?.dispose();

    studentdetailsModels.dispose();
  }
}
