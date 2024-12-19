import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'indi_edit_students_widget.dart' show IndiEditStudentsWidget;
import 'package:flutter/material.dart';

class IndiEditStudentsModel extends FlutterFlowModel<IndiEditStudentsWidget> {
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

  ///  State fields for stateful widgets in this page.

  // State field(s) for childname widget.
  FocusNode? childnameFocusNode;
  TextEditingController? childnameTextController;
  String? Function(BuildContext, String?)? childnameTextControllerValidator;
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
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  SchoolRecord? school;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  SchoolClassRecord? classes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    childnameFocusNode?.dispose();
    childnameTextController?.dispose();

    allergiesFocusNode?.dispose();
    allergiesTextController?.dispose();

    addressFocusNode?.dispose();
    addressTextController?.dispose();
  }
}
